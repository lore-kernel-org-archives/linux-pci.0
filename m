Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF64384CC2
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 05:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402159; cv=none; b=iY7Jcdn8nkhlf/tB64IYQFmuWMTH/FMWXG7kEHayD+YcY224pvcwzO5clyzfMzNX1itPss0/X2835Gw9tGCkjCZVUJag7MJSF+OoJcqn8oIFdxQhuwiZgn+T97FQF9BbypiTCe2hRvtmxOpsa7FPG3Z80LtcnujPlANoJ0UIeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402159; c=relaxed/simple;
	bh=r2Qoj38C8xdqySKKZYjVn472V29s5lUT57W4KgmR0Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6x5Xl4QeskekbuvVZExtM51t4cmbwhrUbRX48nv/NOLipL4RkMNvgX3arMMFf7DGR1T3dtjY2omhKTo+8v+iCbFRtmAqj+rdl1QaJm/yr6MYKFDYPgKKz6TCIZaT+qciboaLxEpOKMJ1GUaQJ9uqZNVfysMc1k7E5o/rewSjUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dEfxmN9C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ERXaHJXA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dEfxmN9C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ERXaHJXA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667495Re2498892
	for <linux-pci@vger.kernel.org>; Tue, 7 Jul 2026 05:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qSXgz44N/WMvteS7u/WYSdLO9UdWbYIO4z2GI2oG19Y=; b=dEfxmN9Cbmv54USE
	ywSrvt9W0ReGbJ+ymdVKuLj2r0IdTFaIP3KedI6YAPPSfGu+RDw1Jki2Rsw3TsCf
	q/XQTkDuEJsznxGBuvrr+NG/enZb9g4RVRChSK8friFDC1Vr7VuebTWfCP07wE9e
	oK6Qe0yg0duLP8jkZwa/58XpmBlCzcpsL1dSn4++muNjFjVqrCsqOsKuWj0AkPxy
	swd6EBpFlTAZHzfmVQ0P578GcDjNv0MVw0sp7UQtGkOG2BgqtUXMlDok2i4swHLx
	+4hr0m34sEUxy5lilKZVv+rHuqmcoNgZM7q+nOXMu289cfyDCwephq2IDNUpg1CH
	eemdyw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hscr54-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 05:29:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccb6f6a3f4so5457405ad.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 22:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783402156; x=1784006956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSXgz44N/WMvteS7u/WYSdLO9UdWbYIO4z2GI2oG19Y=;
        b=ERXaHJXA+9lOO9k7v0KvhiX0Ymdmvy5Nazq1/chvXkE61gh01/2JnLhuqzX8jfZpxy
         PXLUCV1kjPaP7Yz+Ncea7Xn9z+91y4J4lqTbx6t2NFAFUFApHk58o37CYLojzROO9/C8
         OW3jWLqIR45jcftbSDqO1BRuDlyrBFmUaMOdo+IsZcTvQfhjnkqYDhCOg8hyK3Zgu25/
         O8ZrLMmD+YQzulOlwamoFa5jr16Yt/+VUlkY52XgJI9lvj078EThYYaQrev8iXd0beWR
         6FzOog0Y3AGDPXWS8OrsM+kAN4im+ye0fmxYjDbyjJuOJ1CLCcJ3JdpbvZOC5SNG0pbr
         0X5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783402156; x=1784006956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSXgz44N/WMvteS7u/WYSdLO9UdWbYIO4z2GI2oG19Y=;
        b=cbU7Evh94V3MKgjwyOh5A8O5EUtQb7nyfIIGBSm6O8NtrhgNBcncN0RN+xU/G15inw
         oqIWgKk3fT+Q6mbR2EztDrK1wdT8AUGob0sEy+WiwdQCMw4j28zrp66eHdMN1n26LgWh
         D/Rn5Gcsw135xyGrDt9mfnymBmqFJ7falOmYk1HY6/zpzjWFqjG15tGZdnHwmAq3dvFE
         fdrNPH25uDvx2xJbMJP95o0NNetqVQv8/fapL24SBIPXy+QKuAxli7D6Eg6x5EfxfT2i
         qhAzHnEzd2GznMWge620i4s5UxNCb7GUxddiuk2LjxOwHMn+DKHVpJdAzZHG1tdQz/mO
         r4+w==
X-Forwarded-Encrypted: i=1; AHgh+Rqcg1AupaMrceLzNFreFD28K78JPZBcQ6eckgY5DGh3emnC42391xCp9fo6xwoicWUwd+/rO9wWBIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysubOPv3jcKcZ3J4EpkXNXf5+N7IWqlJ5EpWrVZidzDzuEL5GY
	bLPIuwOZzhkGdN1Uffa80TIriQp6MW4yXgx14XLY8njGTZfk3i+0p8UqCvjc5oJrKM+IAhBh/x3
	gozhvi4qtRR8vOkZv/1vrmuyN/Nw8bRVTWs1X080pdMmqYIPZIQ/ni0uM+hdIFZI=
X-Gm-Gg: AfdE7cmsYIgbcXWKMJgqGzR39Trb0T379CQ+h81GHnqtA2SQ9o0QY6yRmJV8T3Ks4Ug
	dVYX87Pr++ViiIDCuQkDuPxcnke458rWZ7HXZN+mLdh9makNke+ua50wbRvbyKHdxudPsb46oNj
	yKh/5pHBOD55vSi9RXDVF1h3nGHLXMnkNC845gRzeYbEhFLiOLBo7X1eth7W5QlJOEHwIMFFn9C
	BoW8RuSgMF543Uy+UgBFwGfMWMX76gXfUL8wAANN3KHtNzJBFrbl1FoaHIiWGd6Wtv+eOmk0AlT
	myg8patvLKKypzUWTLTixXeq4dqDvnAjGVR1cf/sdHdit/WYRSwJSXcw9ZPg3Ljl0vg1lT8uxnz
	SskdLkpOfIxWqF9iYncGXwsa7fIXnX+kg0sDyjV/aqrANwLqujdztIfVGZgTZjix/qoTkixzSx5
	jQ8d5u
X-Received: by 2002:a17:903:2a90:b0:2ca:12aa:a390 with SMTP id d9443c01a7336-2ccca5a26a9mr13454595ad.0.1783402156385;
        Mon, 06 Jul 2026 22:29:16 -0700 (PDT)
X-Received: by 2002:a17:903:2a90:b0:2ca:12aa:a390 with SMTP id d9443c01a7336-2ccca5a26a9mr13454215ad.0.1783402155879;
        Mon, 06 Jul 2026 22:29:15 -0700 (PDT)
Received: from ?IPV6:2405:201:c409:b03f:6d0b:bb83:7a67:4093? ([2405:201:c409:b03f:6d0b:bb83:7a67:4093])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bc2asm5077475ad.69.2026.07.06.22.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 22:29:15 -0700 (PDT)
Message-ID: <5e941fd8-e40e-454e-bc54-2c9a2bce0d19@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:59:08 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] dt-bindings: PCI: qcom: Document the Shikra PCIe
 Controller
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com>
 <20260701-shikra-upstream-v1-2-e1a721eb8943@oss.qualcomm.com>
 <dd9e68f3-c33d-47d1-871f-f085550b88b1@kernel.org>
Content-Language: en-US
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
In-Reply-To: <dd9e68f3-c33d-47d1-871f-f085550b88b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 79htvw53FgfGQE0aZf_qtx-dyJeqU3Si
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA0OSBTYWx0ZWRfXw6yCoNz1s0Ay
 4u7ftYUXSiURqKFz8SvZxuE1l/Ut+7NevNstc/UeNpxKOithebsyT1U4U8oVL06IzDdt+62hCsl
 hXCUma+jDuOXyLCCnoHs6TX0DQqbWFSLVJVYYvqmWY9Fn3XMz7vFtuQH8gCx1btXfN3hYT8Au2e
 IPOV3lHB6fITz0fQyF24fklAl52br+sd1PxzlPO48JROmPsn51xX97zfdEbJJkchlXs6YevbxU8
 5HZFKGskET2nWvRKl5kLrjY3obBSgHmTXAlcbpciKI6/idfROSrJC3ZmI6xhF+TVJAzDo8uoKd7
 dvKCbxCaasJeKt0ROBSma7blz48Pi5o39kvRsG1r4xIKZmJBYIDFZh6+buvQwlee5MmNnkOChAM
 IrzjE1xHEeA2hkRgFZA9ms6bGPy0x/2tDSXODLwbHBDPl4c2x/hLlb88FlsuVsEcL/uLzl/cpOx
 8G63FeHPju4PgDMQWRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA0OSBTYWx0ZWRfXy43l8F3tjNXG
 xHOAg5LViUzQ9wGV5K/rgm5O0YDTYs8Tw2I9e1JzW7RceWH/btSRb2oZwQ8YcTXYSde2iQiGOHH
 T4rkggwBazxnrhBNU1+oecz2izFdhTU=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c8ead cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=m11qq-JmO6Yq1UjM5qYA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 79htvw53FgfGQE0aZf_qtx-dyJeqU3Si
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070049


On 7/1/2026 11:56 AM, Krzysztof Kozlowski wrote:
> On 30/06/2026 21:02, Sushrut Shree Trivedi wrote:
>> Add a dedicated schema for the PCIe controller found on the Shikra
>> platform.
>>
>> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,shikra-pcie.yaml  | 211 +++++++++++++++++++++
>>   1 file changed, 211 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,shikra-pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,shikra-pcie.yaml
>> new file mode 100644
>> index 000000000000..f9d1dba9dd2e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/qcom,shikra-pcie.yaml
>> @@ -0,0 +1,211 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/qcom,shikra-pcie.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Shikra PCI Express Root Complex
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> +
>> +description:
>> +  Qualcomm Shikra SoC (and compatible) PCIe root complex controller is based on
>> +  the Synopsys DesignWare PCIe IP.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,shikra-pcie
>> +
>> +  reg:
>> +    minItems: 5
>> +    maxItems: 6
> Same comments as other recent Qualcomm bindings. Don't invent stuff,
> take what was reviewed from the list so we won't have to repeat.
>
> ...
ACK'd. Will use latest binding patches as reference in v2.
>
>
>> +          power-domains = <&gcc GCC_PCIE_GDSC>;
>> +
>> +          max-link-speed = <2>;
>> +
>> +          operating-points-v2 = <&pcie_opp_table>;
>> +
>> +          status = "disabled";
> Drop, you never tested the binding in such case.
ACK'd.
>
>> +
>> +          pcie_opp_table: opp-table {
>> +                  compatible = "operating-points-v2";
> Broken indent.
ACK'd.
>
>> +
>> +                  /* GEN 1 x1 */
>> +                  opp-2500000 {
>> +                          opp-hz = /bits/ 64 <2500000>;
>> +                          required-opps = <&rpmpd_opp_nom>;
>> +                          opp-peak-kBps = <250000 1>;
>> +                          opp-level = <1>;
>> +                  };
>> +
>> +                  /* GEN 2 x1 */
>> +                  opp-5000000 {
>> +                          opp-hz = /bits/ 64 <5000000>;
>> +                          required-opps = <&rpmpd_opp_nom>;
>> +                          opp-peak-kBps = <500000 1>;
>> +                          opp-level = <2>;
>> +                  };
>> +          };
>> +        };
>> +    };
>>
>
> Best regards,
> Krzysztof
Sushrut
