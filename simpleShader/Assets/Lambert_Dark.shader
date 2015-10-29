Shader "Lambert_Dark" 
{
	Properties //Interface btwn shaders & unity/the inspector
	{
		//Name("Display name", Type) = Default()
		_Color ("Argle Fargle Blargle", Color) = (1.0,1.0,1.0,1.0)
	}
	SubShader //Start of our shader
	{
		Pass //Layering effects on top of each other
		{
			CGPROGRAM
			#pragma vertex vertexFunction
			#pragma fragment fragmentFunction
			
			//user defined variables
			uniform float4 _Color;
			
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
				
								//flaot4(x, y, z, w)
								//float4(xyz, w)
				output.colour = float4(input.vertexNormal, 1.0);
				
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
