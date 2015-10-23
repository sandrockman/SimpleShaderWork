Shader "SimpleShader"
{
	Properties
	{
		//Actual name of property, Name that user will see in inspector, Type = Value
		_Color("Flibberty Ghibbets", Color = (0.0,0.0,0.0,1.0)
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
				//pragmas
				
				//user defined variables
				uniform float4 _Color;
				
				//float, float2, float3, float4
				//half, half2, half3, half4
				//fixed, fixed2, fixed3, fixed4
				//ex. a float3 will hold 3 floats
				
				//structs
				struct vertexInput
				{
					float4 vertexPosition : POSITION;
				}
				
				//SEMANTICS
					//COLOR - the color of the vertex (float4)
					//POSITION - the position of the vertex (float4)
					//SV_POSITION - output position of vertex, dx11, output ONLY (float4)
					//NORMAL - normal of the vertex (float4)
					//TANGENT - tangent direction (float4)
					//TEXCOORD0 - the first UV map (float4)
					//TEXCOORD1 - the second UV map (float4)
					//TEXCOORD2-??? - Empty semantics for data transfer
					
				struct vertOutput
				{
					float4 position : SV_POSITION;
				}
				
				//vertex function
				
				//fragment function
				
			ENDCG
		}
	}
	
	//Fallback
}
