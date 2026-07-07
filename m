Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF3C3859EB
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 05:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402912; cv=none; b=MFXWwfS8D2NEvE5jW63B8jW2OO2aXYX4ILFh+8UuxWtk6+A3fWRpJQmKkMEVhW72PRK65RIahQ2cEf1Ty7/3te9xCt8kq9kRZGgeor/r3ScKjhQKyov8oHXFII6GaziKZowf6k/c0FGKGHS3xG/3JX2CaVPMBay0AyYvlAODVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402912; c=relaxed/simple;
	bh=l5COQz7+rKfKHFX3vjfY9rDdWBq8Vjg4dSzVshOnYuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3mLjWVn6Rw0TZdYBKWvdKWThZVcBm3Jf8x/ghTMeVQMpoOJFu3o0K6BNzPskfMFlkaWntRjFuByXeLjZhswjnH3LGxvEaJPovvYqrK3gpxkJl0jhlbZe7BLciaSJRInc3S6utbzChiAOUOUH9nnBFiT59tdqT0noa/+vbYga1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZHhxHNv3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IxG0epPv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZHhxHNv3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IxG0epPv"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748V6M2514280
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 05:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ow/eYL8dueLqt/B+l/aviyIZSIeIrdYbf3Z3NhMMHok=; b=ZHhxHNv3oNKYdllQ
	HccPBJl83ODUJG7oL7Kx2LsFfGE5GuDSMP6LgfHNgnxLzfUtVuj1V32G7gHx1pAk
	y0TKnf6j7RkHtdxQVal94OSBWhHZc9llnTlrkltz0+dE7GcY+Gv9yfsrYXY0uuCo
	uC/T+eZ5yDlQHgquP6cTsihcMV2VQo+IOPLgYlr/ISrEJwNsYouQRZFnFr9Hy0pC
	Jqzyr5jwN+pBbnb8ZRorxlOktNjIH7bD5lgMVUsUGJF4CDnhgOZfxV27jo6zBkh6
	0Yaw6nUkwSANqapnogCMEdFFKVzefTjl7lZlq/4KchuaEbRz89/M9R0+e9R5IFCU
	1vl4oQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8gchh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:41:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84622d6102dso5384870b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 22:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783402910; x=1784007710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ow/eYL8dueLqt/B+l/aviyIZSIeIrdYbf3Z3NhMMHok=;
        b=IxG0epPvdaVVTDq8VL8zamQYBX4j4bcknJddBPuNjfZvsxegbIb/JSCnDHwJHEDefV
         7piNRtNCqFV0trAtcyFN+qghkhFxfSglJ6wbHnWUYTcB2UmKZRTOd0b0VhwjizKGvVSw
         sXDCXHpVp/BkutqgDdVbBy5VoEVi/R5lxZnGOLrPO1Od6kjtKlANOxS7Wp21PGR3SpkB
         3pZFubKEEvrJPCHkwgXG0XLrGcgiWs3ibm2paRBZBTpIZvqTImY8GykrkhJtfyOxNzr+
         2fwMzhDpv4ihI394tk5oXAFu5m5esslSrUS25vU1tnxfKdbqpF7AfCLLaV7If2UzEAVG
         w5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783402910; x=1784007710;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ow/eYL8dueLqt/B+l/aviyIZSIeIrdYbf3Z3NhMMHok=;
        b=LuEzzKUzNbHDBeZx86sbbHmcXlxpTG1Us3HOc8QDCF2QMCkTMX4pwOqdBQNZAc2ISA
         gyvPb5KAN81CMnvEnagwITh1rt7uACe4ReLfX/LF+mmPITlaN8BnfcWb9G5PkQpGGTd8
         VKRg4IX6XUWbOxyNvvkR0Z8QDosExBgrYpj//sw1ba/vVPQeEgjSPt4abvp02Jw6WKb/
         7HeKXe59l0P2/ZDg6dmgi8e/RfDHkD1YWEF9ixlXQL2AP8xPZ2l7JV92MLEssoHCOjtX
         M05nHY9GpngpmC43suBdGiFACKu19oKrICxTUGEIA37BLwU9RlSwxRYJEZHz9NIfprhp
         Vvqw==
X-Forwarded-Encrypted: i=1; AHgh+RqIWTBjMVpyXDF1c/PA5vGEHFJcyhk04siToIx3vpuNM6wOXoRmjYkKbXalsvrujnhxQhxe0+oYg2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO7KdfqKDPT4qUxEviccEhBclfH2P9v9MFbn+7S6wXxZeYji1E
	GogBOOz2za3Ck2uCrgE0G13iaCV6n+Li0vMOrhVf7BY2cZ7uuL7wIeQSRFtX7HyR6p+N8Hsc0hB
	9TCcrm8BqdfwqyJzbV8cTUzuYKGUQXZsPzNADiHcyzRGJnTtoYpw4+jsDOgk4dDc=
X-Gm-Gg: AfdE7clSp/UN1JDm+LUgitxIAn3mUZ9GOfO7/V6uLAjL/kixBSvEY1beIAsbkO3vniq
	qJu5/6mbtISJMLcW431iwIHox5l6Q0YafwILGdEaT/0aDgF1MRu7ikhWeXqbp8cux1qz+w3a7vU
	lFH13Vs/PRt+nlbQytrqo1/T+QiTvSFnMikPTAnux+WIMsRtAnHmHoXZlqZqkcA/Kt1/SGJCsHu
	YBR+kXQ1sGvBJ2pJ0d0DJLO9CRy8E8WsRsVglfpclkmV1nweWEDr+h/Kv8C8jz9OA/28qoaEo6X
	cTJPJVKulbWIY1R0bqnv/KO4EhPZRyhY+WJbFLwvRgeNRgtUy5L1YfWD5p9UDKHaX9RsGbhG8Dy
	TSigMtMJNEGPDxmaoLTTyEHkv5HcTNwZyhgCDgRln+g2Nn/QRROS01e0Ykd16It0Dmf+/dwVwY2
	ysLnF6
X-Received: by 2002:a05:6a00:4fc1:b0:847:9c06:2bef with SMTP id d2e1a72fcca58-84826d3e5fbmr3666414b3a.29.1783402909994;
        Mon, 06 Jul 2026 22:41:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fc1:b0:847:9c06:2bef with SMTP id d2e1a72fcca58-84826d3e5fbmr3666389b3a.29.1783402909456;
        Mon, 06 Jul 2026 22:41:49 -0700 (PDT)
Received: from ?IPV6:2405:201:c409:b03f:6d0b:bb83:7a67:4093? ([2405:201:c409:b03f:6d0b:bb83:7a67:4093])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a96fsm4763011b3a.46.2026.07.06.22.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:41:49 -0700 (PDT)
Message-ID: <eafba447-1b25-4c78-be17-d0a90fafc8fb@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 11:11:42 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: PCI: qcom: Document the Shikra PCIe
 Controller
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>, linux-pci@vger.kernel.org,
        Bartosz Golaszewski <brgl@kernel.org>
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
 <20260701-shikra-upstream-v1-2-e1a721eb8943@oss.qualcomm.com>
 <178285172593.288348.3890129606237873483.robh@kernel.org>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <178285172593.288348.3890129606237873483.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1MSBTYWx0ZWRfX4UD+v8FP0qGl
 HgenEVsxb3ZoVdmLX3Yck3OjvrV/IEfM+8btX4LbZK64m3pVuajpBrvDXwecFxC1Vnx54UE5x2z
 YIFCR4MrrTdT9L4TBq2+DKlGyzZ9olur0ZGyV7PBsVlV+vAYDtKU083qUWicSx4TAfGsfLT14W8
 2UhFZdaai69LJEP3rbC3c4+9L8avoscLE4PlxUs7o+CKFk5EFS32E20LAbnNsYS3j374EJ7K/Fv
 C8UBL67koTgzHJNEdMHj27Tchmw0ARlr++TIVpfIVgh0ncXEaRYD1RVQxd+rr3VEoMMrmT0ueDm
 hZRlos9SgKLsREZkCNJcrvKmJbDlgvR2W/ITCspgUc3speCWnK8tZBBCLvQ6MlUZg/Sr2yum1d5
 vPHUdjGavjyXYwQ9NueE9Op1sAeh+jnJ/WQQiZjTQP0koZ52JgIe0dsSo9va7IZMyhPvVOAMUcI
 139/6WbVPEIyIeycwXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1MSBTYWx0ZWRfXzyq+oS2S9Vhe
 Sr+517shM9Dj+mxRvs+7sUQbE16JUM+72LoiXSJ4kKSkQnQneUWDHns/7jGhZZ02u4fgj2t95Cn
 BPvF8O5N8c3HE+xmEoDzC2nkfWCkcJM=
X-Proofpoint-GUID: tSPBTLp4tU463zPy29-DFPGE3yXnnpJy
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4c919e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=g4xDkRcHy8dAf5eKVigA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: tSPBTLp4tU463zPy29-DFPGE3yXnnpJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070051


On 7/1/2026 2:05 AM, Rob Herring (Arm) wrote:
> On Wed, 01 Jul 2026 00:32:44 +0530, Sushrut Shree Trivedi wrote:
>> Add a dedicated schema for the PCIe controller found on the Shikra
>> platform.
>>
>> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,shikra-pcie.yaml  | 211 +++++++++++++++++++++
>>   1 file changed, 211 insertions(+)
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:57.29-36 Unexpected 'GIC_SPI'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:57.41-60 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:58.29-36 Unexpected 'GIC_SPI'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:58.41-60 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:59.29-36 Unexpected 'GIC_SPI'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:59.41-60 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:60.29-36 Unexpected 'GIC_SPI'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:60.41-60 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:61.29-36 Unexpected 'GIC_SPI'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:61.41-60 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:62.29-36 Unexpected 'GIC_SPI'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:62.41-60 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:63.29-36 Unexpected 'GIC_SPI'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:63.41-60 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:64.29-36 Unexpected 'GIC_SPI'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:64.41-60 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:65.29-36 Unexpected 'GIC_SPI'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:65.41-60 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:76.56-75 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:77.56-75 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:78.56-75 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:79.56-75 Unexpected 'IRQ_TYPE_LEVEL_HIGH'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:83.30-46 Unexpected 'GCC_PCIE_AUX_CLK'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:84.30-50 Unexpected 'GCC_PCIE_CFG_AHB_CLK'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:85.30-51 Unexpected 'GCC_PCIE_MSTR_AXI_CLK'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:86.30-50 Unexpected 'GCC_PCIE_SLV_AXI_CLK'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:87.30-54 Unexpected 'GCC_PCIE_SLV_Q2A_AXI_CLK'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:88.30-58 Unexpected 'GCC_DDRSS_MEMNOC_PCIE_SF_CLK'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:89.30-59 Unexpected 'GCC_PCIE_TILE_AXI_SYS_NOC_CLK'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:90.30-55 Unexpected 'GCC_QMIP_PCIE_CFG_AHB_CLK'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:100.39-55 Unexpected 'GCC_PCIE_AUX_CLK'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:103.44-58 Unexpected 'MASTER_PCIE2_0'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:103.59-73 Unexpected 'RPM_ALWAYS_TAG'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:104.40-53 Unexpected 'SLAVE_EBI_CH0'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:104.54-68 Unexpected 'RPM_ALWAYS_TAG'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:105.41-56 Unexpected 'MASTER_AMPSS_M0'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:105.57-71 Unexpected 'RPM_ACTIVE_TAG'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:106.43-56 Unexpected 'SLAVE_PCIE2_0'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:106.57-71 Unexpected 'RPM_ACTIVE_TAG'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:114.30-42 Unexpected 'GCC_PCIE_BCR'
> Lexical error: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dts:117.37-50 Unexpected 'GCC_PCIE_GDSC'
> FATAL ERROR: Syntax error parsing input tree
> make[2]: *** [scripts/Makefile.dtbs:140: Documentation/devicetree/bindings/pci/qcom,shikra-pcie.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1669: dt_binding_check] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.kernel.org/project/devicetree/patch/20260701-shikra-upstream-v1-2-e1a721eb8943@oss.qualcomm.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.

ACK'd.

Sushrut

>
