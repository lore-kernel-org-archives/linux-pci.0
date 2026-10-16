Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054DE4718DE
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 11:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148935; cv=none; b=MTdtPeaFQI1bRRFHZq66a/t3nVMRpAl8jIegIJA7uRarkvb44PvBJLX/9mI6SQivprKRql6h4/ygYlgD53IgRcPxfCfARZOoYCRRxQpnNpvOpZRRYOu2cKHP4TYJEBsb5Fx0nhIkyMFbKwiTw7xl7bp1RsHYQxXnglFZWkHRXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148935; c=relaxed/simple;
	bh=y85f78TgSjT0XnmCEDnH1jkwMUayZbWAlHwYkA4ybn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HB1al0DW8fZoYSe8dzLFgjio9warbS+Y8E5pQbOZTOkSeHPP2TJtrV6oCFH7YQkp6bPc/iK7wXv5o4d/+uN58G3B5itYSoEYdX5gVHX/GoiqfAwg51spS42vcTLdW2d7krspjzqAkSdNC8oSCZJafwoP4Gf7sDRP0cgIIWc/Dxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aVq3S9xw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LpoReTvz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aVq3S9xw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LpoReTvz"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAARVK488928
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 11:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y85f78TgSjT0XnmCEDnH1jkwMUayZbWAlHwYkA4ybn4=; b=aVq3S9xwVRhgkngV
	GEQ3HnB5hLOnLkI/QE37QK7eY7cSc16Pt+EN0GdcN00ypuriBUtvf36RSHBMWLLl
	punsNI7XsJv6SGGkr3lq87PA21ZdPX8XuiuFhpZggf0h1j7OsvcQbuVxCQ/fiwho
	FRIJ/HG6n2Sq3EmJwihsh0og2g6P8RDQwpTaG40imSbQC1EsYFLYRs98th9pBiZc
	qVoaG9LaoMdgq0uXTQINCyf4bdsw0kwZ9kQMkjZLn1n3PPLzLhipvpYAj1GV5aBx
	mN+7PyY1xDTnHoz8Ad6+pnEInc8UTJbnlPq01IrBpMGWN/438hUYqZPGdMOz0vIt
	ZJaK0Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbcjt9j2k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 11:08:51 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so17573643eec.1
        for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 04:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792148931; x=1792753731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y85f78TgSjT0XnmCEDnH1jkwMUayZbWAlHwYkA4ybn4=;
        b=LpoReTvzF95mkCbtrLEeT9gAQ1qb+SB9PNEddTJc+86RcGmHhY57ioWZcMcq8jyzzp
         PXR7SDNJPexkif1zCp3bR9tnnxxL5UTiTiA2drbhPhctrrk178P8EWURlAIMRA9jaNVy
         iAN/3Z8Y6X8TgG67LuRVvbY0bHFRCM78kSxaosHOFS4Xxd3J5Djskz1piHhMr7qXLcdK
         llPdl3G19BpuFOKWAxS9+NZoC6sYCTwBs4xSSMrBFA6L5lkuPWYjugG6jFSvCMotvt4l
         d2+kL8oKUHaJQCjgaawpXMNCqaXXAvi/Nq3GxdpT3lPCcIC2h8PEfGrCMMX2HdgCUdNy
         o7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792148931; x=1792753731;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y85f78TgSjT0XnmCEDnH1jkwMUayZbWAlHwYkA4ybn4=;
        b=MIUCylrKDzYtWgso462Tj6nKzNJTJEg6ycoMhxjeQQmnzdmJBOVIL+BR/t1EUeCA40
         B7MNCA9hfgyCyU3/DmTbyEc82o3dG5S8fDx5LcuYOXybNNoqxsFwDGBJ+qadEPY3Yg1W
         MTjkgn3iJcFwDuB+69ndPcGIuchsIKKJNpWOuN6NX8yrGHR93ut7xCtmog8BX6j1hsvO
         dWSm41MJjjMhPdV2PLDfPni1S/h+TqoJ7FV5R0mWYTkqBoQIxTd+syVNbLICeqQkQKo2
         XuqZnhSpvyBr2M428x0CF6eoI9f3cvw5+sTvpEGFRpWMpgaSI3/zxudaHut/7d4Syk/X
         sMxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVcqkkaYSz+jGoD9wwiXcP17DICIKzuo1H8EL1EovkXht2EZK6iHfyVx7zVh6apUwtscA8/5C2tSY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDw+HUZpRXBqa+7Ponto0nru7qxXRRkcYtjHtaaNVI/pVDrhBb
	d/ErqCZpg7xOc36Hcj98jQs2GajPFTruOd+fs+EV9CcBpuKw1P1/bLHc+g8Yk+eimInZx8ATnDc
	GYNbo6/T+spUUQn0iskNnUvqz2jGk0IP6C/LSmk7nUaSAaPC1oJmEsiB+k7h3aGs=
X-Gm-Gg: AYBFou3K/nUNZVa5mc5y2PJb0pHb/3MCa0RN+JZ7ezZOZ6brh72gdN1DMSSVnNvtUyC
	xtSI/PjLqhcnBornMWEV1bcnFTgo1g0WVp1CwzRqS5pQSknR7BIWVhkiCrrSrmHajWfH26D8MLe
	Z5/8OEyno+RZh0DaiszdXwGfrgl64Ad4fKERPEBZdnkLOLNVY99uSqQdd/MRE6qq44V7nJIMCFB
	VizO++NEV31LNR+aDTA3D74g5BPUEzWYLZDAwsEVnqvVGO9ktVdkS8uKEkucvefkLGXeT3ETO91
	t8IYqx2hi99AcancJ1GKL9zdketNsqEUAWDUECqRCfXEsIWxctDa1aEH6q5yrMmEU0lZ9Vsz7JE
	HB4bRYfi+CyCGSBqqs7ApXCb+7vZxyMYDaQ==
X-Received: by 2002:a05:7022:297:20b0:14a:8df8:56b1 with SMTP id a92af1059eb24-16a5ef28a5bmr27085908c88.22.1792148930979;
        Fri, 16 Oct 2026 04:08:50 -0700 (PDT)
X-Received: by 2002:a05:7022:297:20b0:14a:8df8:56b1 with SMTP id a92af1059eb24-16a5ef28a5bmr27085829c88.22.1792148929254;
        Fri, 16 Oct 2026 04:08:49 -0700 (PDT)
Received: from [10.218.42.145] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c4d4675sm5101862c88.21.2026.10.16.04.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 04:08:48 -0700 (PDT)
Message-ID: <1ae8d4f0-1c32-4dbd-a18e-7a2ce2627efc@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 16:38:44 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Advertise hotplug with no command completion
 support
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260314-hotplug-v1-1-96ac87d93867@oss.qualcomm.com>
 <d709693e-b9ad-4d53-a368-67fbb0cbd601@linaro.org>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <d709693e-b9ad-4d53-a368-67fbb0cbd601@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0NCBTYWx0ZWRfXxDuOf1NvRP8+
 LhcMajDaR4un6agoA0grtk99EM3kxGjWQ+P16fpg48isb8nYLcErx0LxEKDdK4GoFFGNvG9sxtE
 EColIItetIw0PWJ3OF1DNEWCPePVYwA+J06ozKZvE393b88gfy/qH5TbvOIKzgQQK5Hzr3LCfNo
 LVLKWB6G0825mUKrq1lx0nqATB4HHFzyW6W3EB4kQ38KsfitwdyXPCy6oRVeL/uvT/YvqLaD5fu
 x71KTNRhX3gTzavqw7P6zLiULr0W5gPzMKZw57A24XUKY48lNT38mN37OixMU9YiK1wsZ9cx+PN
 qptVndxgadFnitPBbrkE0prIfOdQyHDsR2QOqtoL5hQUzo5Hl+5IM/lFZuJ8cf/Ym1HJZ2ulsCB
 PvIsXhdBpxSxzgwuXU4VJJEu72g4th3zgWht8OSFDwNLr36CJm+xODxi0SsVtvsNffZB7QrhwzA
 EHpCOFdOXhJZOqQcelQ==
X-Proofpoint-ORIG-GUID: x8ifme-nRY6l7bmoDHLb-YNjdei0IRH6
X-Proofpoint-GUID: x8ifme-nRY6l7bmoDHLb-YNjdei0IRH6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0NCBTYWx0ZWRfX60VCCagnfJW4
 xVuhpImor2PdZsjCMNFTYZUe8A0zNHJzh5cmeAsJLVUVUYqOexWaKNuDXDhY1Rf8+xo/F80kEnZ
 xZGV3pFxYu3JWn0hYbz7XdaJODOanOo=
X-Authority-Analysis: v=2.4 cv=VpS2kO2n c=1 sm=1 tr=0 ts=6ad205c3 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=ShDbLQTyCWfcQnIfrFwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160044



On 10/16/2026 3:54 PM, Neil Armstrong wrote:
> Hi,
>
> On 3/14/26 02:56, Krishna Chaitanya Chundru wrote:
>> QCOM PCIe controller advertise hotplug capability in hardware but do not
>> support hotplug command completion. As a result, the PCI core registers
>> the pciehp service and issues hotplug commands that never gets completions,
>> leading to repeated timeout warnings and multi-second delays during boot
>> and suspend/resume.
>>
>> Commit a54db86ddc153 ("PCI: qcom: Do not advertise hotplug capability for
>> IPs v2.7.0 and v1.9.0") avoided these timeouts by clearing the Hot-Plug
>> Capability bit entirely, which also disabled all hotplug functionality.
>>
>> Instead of disabling hotplug, mark these controllers as not supporting
>> command completion by setting the No Command Completed Support (NCCS) bit
>> in the Slot Capabilities register. This prevents the PCI hotplug driver
>> from waiting for commands completion while still allowing hotplug-related
>> functionality such as Data Link Layer state change events.
>
> I'm a little late to the party, but marking the RC as Hotplus means the bridge
> is marked as is_pciehp and pci_bridge_d3_possible() returns false.
>
> This means this breaks D3Cold support completely since in
> __pci_host_common_d3cold_possible()
> we now check all PCI devices, including bridges, and the RC is not set in
> D3Hot anymore.
>
> The only way to enable D3Cold is to pass pcie_port_pm=force to allow D3 on all
> Hotplug bridges. Which may be wrong on TB bridges.
>
Hi Neil,
can you enable hotplug driver and use this patch [1], that should solve the issue.

[1]
https://patch.msgid.link/20260729165005.896725-1-manivannan.sadhasivam@oss.qualcomm.com

> Neil
>
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c
>> b/drivers/pci/controller/dwc/pcie-qcom.c
>> index
>> 67a16af69ddc75fca1b123e70715e692a91a9135..a2924610f3625f2456a491473c135840e31bafb9
>> 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -358,7 +358,7 @@ static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>>       dw_pcie_dbi_ro_wr_en(pci);
>>         val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
>> -    val &= ~PCI_EXP_SLTCAP_HPC;
>> +    val |= PCI_EXP_SLTCAP_NCCS;
>>       writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
>>         dw_pcie_dbi_ro_wr_dis(pci);
>>
>> ---
>> base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
>> change-id: 20260313-hotplug-4c296595b5b8
>>
>> Best regards,
>

