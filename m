Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3610C4418F2
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511853; cv=none; b=auYb2Dbj9/IR1BLLpMn+AJWCWv8QfwbuGXq2ZS33afiogev9zqZxsFrWVzclDce/A2EAWAOW0BXo3QHyXTnv06ZIeyI4cYS8bXvggfqPQe/17Ka0L4O+OPZV8PtrdKa2712en8lEuCS30gM/8nhwwifaBD8wlNTIwFeH+nfRY2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511853; c=relaxed/simple;
	bh=fz4msogSnakmeQKSqrQ7d4iwY+ZxUx3s4/WKfGlla1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIK9q+2CE5MUVG4+vY819k5zS1EaRiPa7LJLlTA0CN2WRc59ZkFzRm4Wi7lwsFXQbxDcyjOUCTg0g65Ye9JAhVeSF08snMEtmQe1wLMGfAsX8AY6S5TA/Yn9DkeyJ2HU8ixheZKIthENk6/+HYooS8+umkffH3BAQpnvmdabHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jTcCk3nW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Li7OhnMx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jTcCk3nW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Li7OhnMx"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOA9c3879461
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 15:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xNunTRXsqpTsk4gUldkupbFQmBRLlsHQmR+eXlL+D8U=; b=jTcCk3nWFwj3zqCZ
	HXK2aGTGQfkjUJiQhdjXPIe4d8GKmzHhhMX9mzSyJHH/gwHNQ9/pnZx8s/5SMTt5
	v/fwpQArD7ZzOpRSEV+3KbksS87eaAWLemhnGSiarKI2b2lkr5+QDNkIIJsEaGt+
	jexTIEMx29ZbZFc6mVKnfkTBRncsD/OhOWtJuTs5Y55rkMn/o2yyTtNYzCWzJiuz
	NcnUtqDOrISRhOIAMssv8VQ0x62QtNkRO6YbL+vnNVNUsZLBXJ6w1fImEzO8VrSS
	ies22v2lCBSzxA+YTfZ7zvaGx1u+Xi9H80HfgpcmtaoljJ08RzGO1cm+H1xOfHwd
	m6mQAQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru0y0yaf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 15:30:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so883890a12.0
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785511845; x=1786116645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNunTRXsqpTsk4gUldkupbFQmBRLlsHQmR+eXlL+D8U=;
        b=Li7OhnMxg/+t0TD4C5BpWzcoCBJaRVhX9hhcRhmfe9lYEKHynraFxXyJnRXXskG8Uw
         mQxC4XyzpZkEZamfSlgK7So1s7Z+LXcyx6IDcriuKnJ/ND1UbXM3naPRk7T163FAOdHc
         SK8B4sADaigDZt2AVG3BqceklBG0nH/X+1r0ISYF+L47eyY2tKMGv5YT1uS+vUHNabmb
         +IiXYBqIse6fz1lmK3/9rxmMVgxHz7X83pnVq3cSKKKhhUB6zHdqzgMfwaDORTFMwOXJ
         AWxVVqlY4uSI70m20b4ltU8ruZnEXSpFIBQAZcw/4i+qqOdqKOuGkIsX1V/nbtiVap9H
         vLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511845; x=1786116645;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xNunTRXsqpTsk4gUldkupbFQmBRLlsHQmR+eXlL+D8U=;
        b=lhixhzecoi2rETtSI//5KbfTD1Eo6tcF9THf6Nj5Ij9wbBBk1fxU83/bFV170fWExp
         1fDu4WAYD6aNoPWOtwguhzSSDYxqujD72zU6qReODxhj1cKRO9iGsDwHVJ3SVs+K+ujn
         qM2hLQG9tbcaetFZrtRqxHKWttDElwtUk1biox9Ke9pFeJu/JodHe9iDg6mNoWDq3FrB
         /krQlxltPsZQPdUC4VhZJ/ZdFxjkAF2UdccC0AmbOATmDx1stTayRl+JraZLeS4v01tP
         zMeR/wRwfXVqy5SRacIhJNj+uf3VWmYjVpHpwiJQvE17QFfQjEJ2NidZZqw//YAzLxMV
         U5ig==
X-Forwarded-Encrypted: i=1; AHgh+RolR6QciBED7qo+oOP6LUG47dfeYZREJvn4y73pWdF3O6brTGq8oRL5E3Sznh6iXj8Xd88qFNIkhx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWZZMadPKwW1lbPibuqNguRutvSyHT6Cs066NOUnn5QpN5pwN
	qnPQRBfLJJHDa/dRyypLFh79JlK4F4e4bXxgUt9RpaSxr4KM+9C4lLPJTCayF/Z2bWDPexeIoPG
	uMeAb+Sq2LtEEACB8JZbMPxGNhsSBZKUCCc1+0jXjXgdtaYSWvJBFXCm1veq4SJE=
X-Gm-Gg: AR+sD11CnrzewdREfvu0LAG1y8m8R6x4BrHZzCBnekC5UN1J4VANX9z+vCbPhrDSgTI
	XiIhYFBAX1H1fwmXtFaPyfGoe+2xnIua7mjIYTKJyg0wdbuRfLkkNWiOmPwIGA6R5IKW1Tq9Wpp
	/nXeTBz0GeyJPyTs2uJL+fIxNMrgU4K1piogLtEqgZ5g6W42QsLfPldVJrCqMCR3+Q312gNMLGa
	Kh21blxcdfcq4jmuTAJ70fQvG9bXWbLI2orkvac7FinULHs4CP+Pk9xBvIF+QbQB7C7ytP+sA3E
	2pX4K9p/Kafhy5uicXoencE6iKBmqF8df1hiEXv4r9g0BMp5sn9+wPp/1ZesfhgWHZ74sZqD/6E
	XVTkB/EuUf4yM2TpQ2NlOmuqQpc9xmgpG
X-Received: by 2002:a05:6a20:9f09:b0:3bf:8de9:c647 with SMTP id adf61e73a8af0-3c92a2a9efemr292250637.0.1785511844958;
        Fri, 31 Jul 2026 08:30:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f09:b0:3bf:8de9:c647 with SMTP id adf61e73a8af0-3c92a2a9efemr292197637.0.1785511844540;
        Fri, 31 Jul 2026 08:30:44 -0700 (PDT)
Received: from [192.168.1.10] ([122.177.247.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe3963daa7sm716655a12.5.2026.07.31.08.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 08:30:44 -0700 (PDT)
Message-ID: <acb2dfcd-f024-4a70-88dc-8d2482c1e20f@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 21:00:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: qcs6490-rb3gen2: label BT PMU
 and M.2 PCI node
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-4-2d100f30e202@oss.qualcomm.com>
Content-Language: en-US
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-4-2d100f30e202@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNyBTYWx0ZWRfX8YkCM0YiL4H7
 yInR7DwGfqfwOizMl4HTYOJJMiEGddnTygWRxdJ7/ZPto7FLhUEhzbSIbnzwU06f0uwgg2/EWHn
 4VqfZOjTNYxxg4uOIPVxVLdMcHWgUZE=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a6cbfa5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=wVA5pQU3D6HtJETKl3oCcQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=B7p1tibXOPgUgj-QF2sA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNyBTYWx0ZWRfX78DAUgOOzWJW
 27i2YG3VTInyHe4dUp8zgTgjIvI/78mNAIbJA4Ich+AMazXNvYjVgBbyhL4QtP6a5v237ROw98i
 +2Ya806xv9bb0gvNR9MitrvcEF4MdbRbWQpHO4lgmIITRrgo2qeWhLdnIAWggzbkjF8llY/c4EU
 BS8Dc0SRqjmUB5cn87QX84gQLjrLp8TIxkXl29FFeDCaAEX/yG40amm6CNbXIF7AsxAnYAYt1uB
 FfTQq7uD0rAxOXlIDSoATWgkFgN4bS00eIZqsZMMxI+gdRPRafWeJJ+yKXEi8oq838BiVKYWkHW
 a9GkwhBymFnL2sgnu9cC+H58TGleQuBsLb4+tqwM/Uxs5hSC8/nwYbtK4+vC4Pr6390R+/pSOAD
 QYrq2CQuXIkobnim8U6UID8v639o2akacOaEsT+cO5zvG7gkvjjs7pC8LQIpT6DqVOSdJlVfcL5
 hh0STEgjNEn5KH41VGg==
X-Proofpoint-ORIG-GUID: V7gFDgcDHKY2b3BFzUgYFaM6zNM1ZMZk
X-Proofpoint-GUID: V7gFDgcDHKY2b3BFzUgYFaM6zNM1ZMZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310117



On 27-07-2026 21:15, Rahul Samana wrote:
> The reworked RB3 Gen 2 Industrial BT UART overlay needs to disable the
> on-board WCN6750 PMU and add a graph endpoint to the M.2 PCI node.
> 
> Label the exact WCN6750 PMU node and PCI child node connected to the M.2
> E-key slot so the overlay can patch them directly instead of using a full
> path or reconstructing the nested PCI hierarchy.
> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 37a3b51323ce..b2b6fd29880f 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -325,7 +325,7 @@ vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
>  		regulator-enable-ramp-delay = <10000>;
>  	};
>  
> -	wcn6750-pmu {
> +	wcn6750_pmu: wcn6750-pmu {
>  		compatible = "qcom,wcn6750-pmu";
>  		pinctrl-0 = <&bt_en>;
>  		pinctrl-names = "default";
> @@ -901,7 +901,7 @@ pcie1_switch0_dsp1: pcie@1,0 {
>  			bus-range = <0x3 0xff>;
>  		};
>  
> -		pcie@2,0 {
> +		pcie0_m2_e: pcie@2,0 {
>  			reg = <0x21000 0x0 0x0 0x0 0x0>;
>  			#address-cells = <3>;
>  			#size-cells = <2>;
> 

One correction for this patch:

After re-checking the composed devicetree and the device enumeration, the
QCC2072-facing PCIe path is behind the Industrial mezzanine PCIe0 switch:

    /soc@0/pcie@1c00000/pcie@0/pcie@0,0/pcie@2,0

The pcie@2,0 node labelled in qcs6490-rb3gen2.dts by this patch is under
the base RB3 PCIe1 topology, so it is not the right endpoint for the BT UART
variant.

I will fix this in v3 once the endpoint modelling approach is clarified.

Regards,
Rahul
