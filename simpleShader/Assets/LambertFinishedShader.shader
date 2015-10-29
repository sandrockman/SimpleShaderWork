Shader "LambertFinishedShader" 
{
	Properties //Interface btwn shaders & unity/the inspector
	{
		//Name("Display name", Type) = Default()
		_Color ("The Nonsense", Color) = (1.0,1.0,1.0,1.0)
	}
	SubShader //Start of our shader
	{
		Pass //Layering effects on top of each other
		{
			Tags{"LightMode" = "ForwardBase"}
			CGPROGRAM
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction
			
			//user defined variables
			uniform float4 _Color;
			
			//Unity Defined Variables
			uniform float3 _LightColor0;
			
			//structs
			struct inputInformation //typical convention for name is "vertexInput"
			{
				float4 vertexPos: POSITION;
				float3 vertexNormal: NORMAL;
			};
			
			struct passToFragment //typical convention for name is "vertexOutput"
			{
				float4 position: SV_POSITION;
				float4 colour: Color;
			};
			//vertex function
			passToFragment vertexFunction (inputInformation input)
			{
				passToFragment output;
				float3 lightDirection;
				float attenuation = 1.0; //not working with this (yet.)
										 //Falloff of light as the light gets further away
										 
				float3 ambientLight = UNITY_LIGHTMODEL_AMBIENT.rgb;
				
				//Get the direction of the light from Unity, and normalize it.
				lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				
				//grab normal from the input
				float3 tempNorm = input.vertexNormal;
				
				//Convert normal from World to Normal Space
				//float4 objNorm = normalize(mul(float4(tempNorm, 1.0), _World2Object)); 
				float4 objNorm = mul(float4(tempNorm, 1.0), _World2Object); 
				//Convert out normal from world to object space
					//float4(float3, alpha) --How to caste in a shader
				float3 normalizedNormal = normalize(objNorm).xyz;
				
				//combine the 3 previous lines into one
				//float3 normalDirection = normalize(mul(float4(input.vertexNormal, 1.0), _World2Object).xyz);
				
				//dot product between light direction and teh normal
				//float3 diffuseReflection = dot(normalizedNormal, lightDirection);
				//float3 diffuseReflection = attenuation * _LightColor0.xyz * max(0.0, dot(normalizedNormal, lightDirection));
				float3 diffuseReflection = attenuation * _LightColor0.xyz * _Color.rgb * max(0.0, dot(normalizedNormal, lightDirection));
				
				//calculate final light
				float3 finalLight = diffuseReflection + ambientLight;
				
				output.colour = float4(finalLight, 1.0);
				
				output.position = mul(UNITY_MATRIX_MVP, input.vertexPos);
				
				return output;
			}
			
			//fragment function
			float4 fragmentFunction(passToFragment input) : COLOR
			{
				return input.colour;
			}
			
			ENDCG
		}
	} 
	//FallBack "Diffuse"
}
