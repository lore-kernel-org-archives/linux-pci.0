Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7C8285060
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720515; cv=none; b=qHwzu3Y0IbhCvl1E9Rv9gJiK7aSTKd8XA9MeFda51DRr6cZoM2CrX6bkMskzqfB30YLjjFq8n+c2IG8ZVUdnqB+hXMB9wIE6M3hagopYDWeA/W6CqxjmQjXU0cYVMdJnHzfW4Z5ADCIcoEVdte6D+GqrucXgFcbMnjWElJ4u18M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720515; c=relaxed/simple;
	bh=xG4/SxEC34rknNloqTw1hcXWjLKpM8QxfSsRNYo9uIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgovZqcnmaiMdZA1QU4Zb3jciADLK9QuVKMqkkeZ9gctTY0wlO8guEmyRQRhw/gSrBUTs4jrEb1WyDzbR37BmjHrnf2Q4Fkf7OHTh84HNUotYPV/OSNyjsizzze4gjNoGrMZPoEBiu23J9dkGqIqqa+TzmaWOBa3cwh3KGz1UFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mz7n/mnl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gC2IrVlQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mz7n/mnl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gC2IrVlQ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DNOVlP2887912
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 01:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UIvIqlYU5YtZO06/NW9nfub6oEJrZxLfFXqAqJQVG/M=; b=mz7n/mnlDdNNs/n+
	2OT591Nfd6mvfDqrFHcXCKg/xyw37/HQiPCeSR/SQfpSxxUETmUdA4K+JtPo50w2
	3ItRwf4TzxJNVUPzP+eUOUqHUod28PzyhHinRJ71NJByJjoXx2wQmaeEUrdYe9ly
	aeK0Pjv3eqDyZ7aWtJjL6uGa04x91qtR9OU/tqcQF7V4P5jHWWY+qT/+3LqRq/Z5
	QzTmnM/OYJ846efXiA2kZtBOio+ZSK05fGs7gVoTWMBmUU4Z25VwhTWbK7CCjn0J
	oMm3pXfMvI87I4u335iqX0nYyiFrBM3jCi4vyp/mybGpd7qftVZymVyAp5n4JsUv
	RExfnw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p4gkgpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 01:01:53 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-132c3280e03so273684c88.1
        for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 18:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778720513; x=1779325313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIvIqlYU5YtZO06/NW9nfub6oEJrZxLfFXqAqJQVG/M=;
        b=gC2IrVlQGdiOJTczZcvh62VaDnMGVhJqCOQup94wo6K9Jv7k16hISBKH+b39wNbdCI
         sntFXVhGdHnOS/kma9MEyyIuFincDD35qpnE8B6rjg5evEeEpRBOyktw/DiovCDm+Tuf
         Icqrha4NtgOAlSrit3YNbnn+cNRraGtbKPan//oKoZgNP7UF1VsgDsu6iZlsMvEKJTJD
         Q24rf3Lpk/Kd0zWgx2aUcgUQoGvEb3kYRFiqfdIfjxitWQUh58NQ1GQUTAkP5wdopTHU
         MPyafGH8lE39GGMx2on4tViT8zEta6NtbHd2mCwdgw3I33b4G5jgV19LwuCthyXXMCpz
         2iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778720513; x=1779325313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIvIqlYU5YtZO06/NW9nfub6oEJrZxLfFXqAqJQVG/M=;
        b=AgNcTs5ILzkgmu0EOk61qTdG+DP8j0i7w0ju6N/qYA99vtaUJtyO6on/92j5ruUpYY
         YuA0sV030yMPBVQZ5ruro8Euv3ttIUzfUpQKwVJGpMM4DElro+e4AFsDGfb2prmF+dkR
         8Yx0V2i4ULvdmD+9JCQDFebmGDrrvLuGMVbIz/996km1jqWOoUhkI0Or6GDHYOWJnM5d
         MydupBIetkuk7NCv/MoivxKOM2iRhyOkjK7YI1rbW9F2uLDwQpIksl0JBwTGoNnnRwby
         3n7KNqFTHO8AMAbI438GMf1n0/IE7pbfY4b8gsMTgF0iGm7orIAWz9LOPmmV0nsVfGvj
         US2g==
X-Forwarded-Encrypted: i=1; AFNElJ9x76LTbZowCIni5qS/VmWy9L50Kv3ewDWAcFCk1rNZh8W5EC5YZekqCGReRMdLX97ivI0Hpuh2CiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2k3nZSDMFYCHm6O+SRsGERYZHe7n2GugiYZYuhrnnYbw3LoT
	ZSeMoqEbe4Y+IsU+tx+ybCVPRNy4tuZabB6wP7H7Exgx4HsgDtGFF/21GICf5FG2kAFe4n6JpDg
	zTw1eJUocros4o1mxocPkkzY5PIiHnp+TBWExee3XKPmtxKoo8k3j9XkMJTuqv8I=
X-Gm-Gg: Acq92OH9OAWY+9wmKNVQs6JY8b6oYdW/0YtUUuVGuuLCS/nZZP3wfAPRyNxKabJSh8S
	5IFVB8fO0C4jKt4eRCcSOtNUsP/tnZvGLKSKXb7+eHo2cRcI36mMgLPastIdXzeWj8JsWQ1hsjo
	xsIF/+IorcN92QWtPA4rTTivit+Nyt+jnY1guyQbgSsM0KlIUmzffeK8Eq9YAot2vMmdp8sR19g
	KhEzEuRdLxbDEcVShHQSWG0zcyMay87zVvVCfyjD8JANzHQXiEwgXJff4klo/2FsoCESwOy1KMW
	OjH37IJeNwxw+ZtMesoWDL36sCy363rceusBoSXql2/3bfRxQnjIkbzWSo4CSBUF2pFSc3wjm1u
	oLwXDa/CxJB8I5n+pqqUANQzv6hJK4q+IUePWZWQIumEHIuEyrLVRFbi2LdWxEh4McCRX8DgARN
	npCyjDW2AFWDV8KZs=
X-Received: by 2002:a05:7022:1b05:b0:130:73ed:208 with SMTP id a92af1059eb24-1342ef3d127mr3280776c88.9.1778720512419;
        Wed, 13 May 2026 18:01:52 -0700 (PDT)
X-Received: by 2002:a05:7022:1b05:b0:130:73ed:208 with SMTP id a92af1059eb24-1342ef3d127mr3280751c88.9.1778720511686;
        Wed, 13 May 2026 18:01:51 -0700 (PDT)
Received: from [10.71.177.160] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbed2232sm1875244c88.7.2026.05.13.18.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 18:01:51 -0700 (PDT)
Message-ID: <84ee61f7-c761-47cc-bcd2-c2be7d76f9ee@oss.qualcomm.com>
Date: Wed, 13 May 2026 18:01:49 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom: Document the Hawi PCIe
 Controller
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260508-hawi-pcie-v1-0-0c910906f7e5@oss.qualcomm.com>
 <20260508-hawi-pcie-v1-1-0c910906f7e5@oss.qualcomm.com>
 <20260513225632.GB2251300-robh@kernel.org>
Content-Language: en-US
From: Matthew Leung <matthew.leung@oss.qualcomm.com>
In-Reply-To: <20260513225632.GB2251300-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: admI5EnhYOOIfBXFTMFCkjmI-b2B6Pkv
X-Authority-Analysis: v=2.4 cv=DOS/JSNb c=1 sm=1 tr=0 ts=6a051f01 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=ioGwiDVH1dOl2fmqjLkA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: admI5EnhYOOIfBXFTMFCkjmI-b2B6Pkv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAwNyBTYWx0ZWRfX2lEXobz8V3Hb
 uGzXN9CYxBXQ4lmwOd8y752dJmO2Kgp90eCg3SDnZdAc9R+vJMParray5emWvY44nOXX4sxedH1
 GLrlxist10iEkLrPvRzYhL2VIGIxpBcYnzk+XcwrN1jVvYsVPp/VG7wWdSCtGTHkQMlfnGX65mf
 C6pKfhfpMV+1e0jKqJH1vQVf+t9lkm8MVvulunAm6/W4Ml44qd6KBQApAVzTiL+asSDGfcSjPQw
 T8wQ8oQrSPZVrzUW1URZsEY1Dq/0Jo36fajDDkAEXhK5+HipuTV1oSjpHP7hBDeLqUY7m3kprHd
 DwDtHHmLOI9+ZhAgF72timj8LbbO1yxjMEruMcb9dXpfny4nYAqJZOpWFNNZ3sg1gQhs4qJ34by
 8ra4dNNFAq6WD906oIRPCWb7hnBXYzUYm1k2sXoJ+JRrWdVL3/i9dctDZ+1uJ3Xt/rZ1uUnJILc
 vEK97vnJ33Ns6zYotVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140007



On 5/13/2026 3:56 PM, Rob Herring wrote:
> On Fri, May 08, 2026 at 01:02:14AM +0000, Matthew Leung wrote:
>> Add a dedicated schema for the PCIe controllers found on the Hawi
>> platform.
>>
>> Signed-off-by: Matthew Leung <matthew.leung@oss.qualcomm.com>
>> ---
>>  .../devicetree/bindings/pci/qcom,hawi-pcie.yaml    | 188 +++++++++++++++++++++
>>  1 file changed, 188 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
>> new file mode 100644
>> index 000000000000..154bc88e5969
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/qcom,hawi-pcie.yaml
>> @@ -0,0 +1,188 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pci/qcom,hawi-pcie.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Hawi PCI Express Root Complex
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +  - Manivannan Sadhasivam <mani@kernel.org>
>> +
>> +description:
>> +  Qualcomm Hawi SoC (and compatible) PCIe root complex controller is based on
>> +  the Synopsys DesignWare PCIe IP.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,hawi-pcie
>> +
>> +  reg:
>> +    minItems: 5
>> +    maxItems: 6
>> +
>> +  reg-names:
>> +    minItems: 5
>> +    items:
>> +      - const: parf # Qualcomm specific registers
>> +      - const: dbi # DesignWare PCIe registers
>> +      - const: elbi # External local bus interface registers
>> +      - const: atu # ATU address space
>> +      - const: config # PCIe configuration space
>> +      - const: mhi # MHI registers
>> +
>> +  clocks:
> 
> minItems: 6
> 

Will update.

>> +    maxItems: 7
>> +
>> +  clock-names:
>> +    minItems: 6
>> +    items:
>> +      - const: aux # Auxiliary clock
>> +      - const: cfg # Configuration clock
>> +      - const: bus_master # Master AXI clock
>> +      - const: bus_slave # Slave AXI clock
>> +      - const: slave_q2a # Slave Q2A clock
>> +      - const: noc_aggr # Aggre NoC PCIe AXI clock
>> +      - const: cnoc_sf_axi # Config NoC PCIe0 AXI clock
> 
> Move all these description comments to 'description' entries under 
> 'clocks'. Same comment for 'reg-names'.
> 

Thank you for the feedback. I will migrate the all of the description
comments into 'description' entries.

>> +
>> +  interrupts:
>> +    minItems: 8
>> +    maxItems: 9
>> +
>> +  interrupt-names:
>> +    minItems: 8
>> +    items:
>> +      - const: msi0
>> +      - const: msi1
>> +      - const: msi2
>> +      - const: msi3
>> +      - const: msi4
>> +      - const: msi5
>> +      - const: msi6
>> +      - const: msi7
>> +      - const: global
>> +
>> +  resets:
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  reset-names:
>> +    minItems: 1
>> +    items:
>> +      - const: pci # PCIe core reset
>> +      - const: link_down # PCIe link down reset
> 
> Same comment here.
> 
>> +
>> +required:
>> +  - power-domains
>> +  - resets
>> +  - reset-names
>> +
>> +allOf:
>> +  - $ref: qcom,pcie-common.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,hawi-gcc.h>
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    #include <dt-bindings/interconnect/qcom,icc.h>
>> +    #include <dt-bindings/interconnect/qcom,hawi-rpmh.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        pcie@1c00000 {
>> +            compatible = "qcom,hawi-pcie";
>> +            reg = <0 0x01c00000 0 0x3000>,
>> +                  <0 0x40000000 0 0xf1d>,
>> +                  <0 0x40000f20 0 0xa8>,
>> +                  <0 0x40001000 0 0x1000>,
>> +                  <0 0x40100000 0 0x100000>;
>> +            reg-names = "parf", "dbi", "elbi", "atu", "config";
>> +            ranges = <0x01000000 0x0 0x00000000 0x0 0x40200000 0x0 0x100000>,
>> +                     <0x02000000 0x0 0x40300000 0x0 0x40300000 0x0 0x3d00000>;
>> +
>> +            bus-range = <0x00 0xff>;
>> +            device_type = "pci";
>> +            linux,pci-domain = <0>;
>> +            num-lanes = <2>;
>> +
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +
>> +            clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>> +                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
>> +                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
>> +                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
>> +                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
>> +                     <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>,
>> +                     <&gcc GCC_CNOC_PCIE_SF_AXI_CLK>;
>> +            clock-names = "aux",
>> +                          "cfg",
>> +                          "bus_master",
>> +                          "bus_slave",
>> +                          "slave_q2a",
>> +                          "noc_aggr",
>> +                          "cnoc_sf_axi";
>> +
>> +            dma-coherent;
>> +
>> +            interrupts = <GIC_ESPI 205 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_ESPI 206 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_ESPI 207 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_ESPI 208 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_ESPI 209 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_ESPI 210 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_ESPI 211 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_ESPI 212 IRQ_TYPE_LEVEL_HIGH>,
>> +                         <GIC_ESPI 204 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "msi0", "msi1", "msi2", "msi3",
>> +                              "msi4", "msi5", "msi6", "msi7", "global";
>> +            #interrupt-cells = <1>;
>> +            interrupt-map-mask = <0 0 0 0x7>;
>> +            interrupt-map = <0 0 0 1 &intc 0 0 GIC_ESPI 213 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +                            <0 0 0 2 &intc 0 0 GIC_ESPI 214 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +                            <0 0 0 3 &intc 0 0 GIC_ESPI 215 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +                            <0 0 0 4 &intc 0 0 GIC_ESPI 216 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
>> +            interconnects = <&pcie_anoc MASTER_PCIE_0 QCOM_ICC_TAG_ALWAYS
>> +                             &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>> +                            <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
>> +                             &cnoc_main SLAVE_PCIE_0 QCOM_ICC_TAG_ACTIVE_ONLY>;
>> +            interconnect-names = "pcie-mem", "cpu-pcie";
>> +
>> +            iommu-map = <0x0 &apps_smmu 0x1000 0x1>,
>> +                        <0x100 &apps_smmu 0x1001 0x1>;
>> +
>> +            pinctrl-0 = <&pcie0_default_state>;
>> +            pinctrl-names = "default";
>> +
>> +            power-domains = <&gcc GCC_PCIE_0_PHY_GDSC>;
>> +
>> +            resets = <&gcc GCC_PCIE_0_BCR>,
>> +                     <&gcc GCC_PCIE_0_LINK_DOWN_BCR>;
>> +            reset-names = "pci", "link_down";
>> +
>> +            msi-map = <0x0 &gic_its 0x1000 0x1>,
>> +                      <0x100 &gic_its 0x1001 0x1>;
>> +            msi-map-mask = <0xff00>;
>> +
>> +            pcie@0 {
>> +                device_type = "pci";
>> +                reg = <0x0 0x0 0x0 0x0 0x0>;
>> +                bus-range = <0x01 0xff>;
>> +
>> +                #address-cells = <3>;
>> +                #size-cells = <2>;
>> +                ranges;
>> +
>> +                phys = <&pcie0_phy>;
>> +                wake-gpios = <&tlmm 104 GPIO_ACTIVE_HIGH>;
>> +                reset-gpios = <&tlmm 102 GPIO_ACTIVE_LOW>;
>> +            };
>> +        };
>> +    };
>>
>> -- 
>> 2.34.1
>>

