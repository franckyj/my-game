//********************************************************* 
// 
// Copyright (c) Microsoft. All rights reserved. 
// This code is licensed under the MIT License (MIT). 
// THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF 
// ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY 
// IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR 
// PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT. 
// 
//*********************************************************

#include "ConstantBuffers.hlsli"

//PixelShaderInput main(VertextShaderInput input)
//{
//    PixelShaderInput output = (PixelShaderInput)0;

//    output.position = mul(mul(mul(input.position, world), view), projection);
//    output.textureUV = input.textureUV;

//    // compute view space normal
//    output.normal = normalize (mul(mul(input.normal.xyz, (float3x3)world), (float3x3)view));

//    // Vertex pos in view space (normalize in pixel shader)
//    output.vertexToEye = -mul(mul(input.position, world), view).xyz;

//    // Compute view space vertex to light vectors (normalized)
//    output.vertexToLight0 = normalize(mul(lightPosition[0], view ).xyz + output.vertexToEye);
//    output.vertexToLight1 = normalize(mul(lightPosition[1], view ).xyz + output.vertexToEye);
//    output.vertexToLight2 = normalize(mul(lightPosition[2], view ).xyz + output.vertexToEye);
//    output.vertexToLight3 = normalize(mul(lightPosition[3], view ).xyz + output.vertexToEye);

//    return output;
//}

PixelShaderInput main(VertextShaderInput input)
{
    PixelShaderInput output = (PixelShaderInput) 0;

    float4x4 wvp = mul(mul(projection, view), world);
    output.position = mul(wvp, input.position);
    output.textureUV = input.textureUV;

    // compute view space normal
    float3x3 vw3 = mul((float3x3)view, (float3x3)world);
    output.normal = normalize(mul(vw3, input.normal.xyz));

    // Vertex pos in view space (normalize in pixel shader)
    float4x4 vw = mul(view, world);
    output.vertexToEye = -mul(vw, input.position).xyz;

    // Compute view space vertex to light vectors (normalized)
    output.vertexToLight0 = normalize(mul(view, lightPosition[0]).xyz + output.vertexToEye);
    output.vertexToLight1 = normalize(mul(view, lightPosition[1]).xyz + output.vertexToEye);
    output.vertexToLight2 = normalize(mul(view, lightPosition[2]).xyz + output.vertexToEye);
    output.vertexToLight3 = normalize(mul(view, lightPosition[3]).xyz + output.vertexToEye);

    return output;
}