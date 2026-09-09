Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21D45476FF
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954585; cv=none; b=NWX6zueNTrAsH78Cv+pnlLso4mLhhmzQkNSxYqjUbLTGAPPwrPlqiga/Gs/xTR92f3D5F4xtyiXwbrHnq4I3EzoBOubgSTa+VWHc2lL4tB7nOjLMJ6BbhmKSfEU68GiJ7E3u1w7oJ4Z4GlSATRHNpQ1hkP0IojZCGffw8EicEJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954585; c=relaxed/simple;
	bh=11sQXof3ue6JP3cwDjHHz3P9mnE9zJKkzWdPrS+G4lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQ0VqDVhHl2AWp4JO2FfkDGYpnJnA5u0EySldE+OtsD6b9937nNfETHIWy7rYVzVVkd3NBGSyz3WaffnOCJAQiqHCJVUDqKAgu+nWZ5KciStp6fC/yOrM/C29yvA3+HQvdLBEU+28UaSyFLPHOfU37d0TKL2UmcYsGdtx6AqTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K8elMYXB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RflDsTq6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K8elMYXB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RflDsTq6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689BU1Te1723057
	for <linux-pci@vger.kernel.org>; Wed, 9 Sep 2026 11:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G+i5sN0oSRQdQrTAbL76h6+fmDfqPx5G35ipOQhrdr0=; b=K8elMYXBjUE4eFDc
	2my94nIq5pEnB/ZL+RE9/a8MdmTl60CPh8geoQ2hZrYdNUSl9qbDMJDx/pLDwgb5
	n48LRCRpZp+OA19It7MeChwmazwr6iGpdmnxTF7L3iSe5gxkH92PjDMjatg0XOr7
	otJNtyDskp7+cqGNtxEbXLmIp8pzJsk4BL2iEjnWWZFkVm8yh1YljOCiSV8h97oh
	dWkO5Nl54ZXiMRlz7s6htSsVz8vhjsiKOvTgv3gtC/xG8bLFPeIW/gT+BxcNqWCw
	x5GjEnsXZlQhd2jiff9WcG00LiG9juV/RtLVAnNm5XYG2wA4y7Gd5yHmroJkYxGU
	sUd21w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5cnrctj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 11:49:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-395543dc382so1359716a91.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 04:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788954581; x=1789559381; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G+i5sN0oSRQdQrTAbL76h6+fmDfqPx5G35ipOQhrdr0=;
        b=RflDsTq6SWSoGhg72cObJDsw1Hd5HTQaDXSE0U92dZ8xcNv4zEeVGqvanhOHxF+Dkg
         sy0NUcFRlLBBskCSe6ijcficJcbC8WT31uVIbG96NcVlbk+kk20oGxxuKUWK2Qi9gOcE
         Iev8A5ofSxG759OngbXjZQshsRwuv9PhhArVdotvPNtbE45OseLRL8t5d0jtVXIW6b0Q
         LdWooUxmz4Hc+smqkE8XYGvUQM44AIFNNX1dCddiiOywKaRBkUShMFHlx2wLetAWry+S
         wHe9i/0fKFBqkGaspFUxWAbXZAVhFDSTtvI3MnvIjz1Ku+W6BA271JCmgh4TT4va9bVa
         jZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788954581; x=1789559381;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+i5sN0oSRQdQrTAbL76h6+fmDfqPx5G35ipOQhrdr0=;
        b=T1e2P08ghxxGb6QnJq6hNW0opUlfg9Nb7BA8vERx0ab90vXG6xqtwsOks2bHa5ZUxN
         LicTIxrOFRsVj7jFVrGFZFb4UwhnE8waLzLNI/iIqpLj/SZYd5XiSqSVyReDV7DVsPeJ
         Uw7gZojEQmGb0wj0OEAOqCnuqdjBtzssxV8b3O+UbfOv53it7lxcVxsiYj+2+dCzGrUg
         1XeUaaeCrxuOJivW0i8znv4TMZP1KXgMsmfWKYDmUEg0P2RH8tedE6sB3KyUB9e8uQO0
         4bOGdY8td5LQFFa3BI/RQpVAWDwTOwZcN/SBFPdq5Z0USvlWSYgj442RBpm5jx2n66JK
         eH9w==
X-Gm-Message-State: AFuF++mi6qOX+0b6AXIxOVHtqUPK5o7RWczO+XdEKFrepTbZXUtyYXyA
	pmG5N0mZilN1xrxlrIEY+nj9VLPnZRFEw/DnAa5SSRiwGNnJdwzi1JN9kEWo/pa6TS2LPK0maAp
	TQkxuJ8kluQka2HqmJS07K9FVH35ZJMVko8FQV6mSNRtiau8PGc29KTzsZIGn2X0=
X-Gm-Gg: AYBFou28XxDWZPo0WT9JheAelDHZYcsOxXignFFQ0vHUUU1ghZrXg1N36wox/PhwTgc
	2cLE2PEqXGMydMDZ80MDXKeJ9POPnSJk9hymfE+/mbLByhc3c8V3DSG4cNAiGSsI93t7+REKFM2
	wWf+LY31wbW3jsuMjIe2xJinOVcxij4Uv6ECNKBCHaEfXoWmJbUOWK78tp3SQhsnTeM+eyO/cya
	8MKHhbVYNGpQzqYLsnWAKDU7lWH1sCIqknn+SpGNQ2ZsctOWzmisv4s1s7UQhx3ylVRXsk1DtdE
	lybmrbOg3rSLZbOfB59yWB6zclxvaY12SPWAmUppFHQUcjf/moPGzhBg6Cow4Fi2NKKG1o5e/FF
	fqCPvF3Zfe8BKL2DjQx7VmrUhZ2W22qPV
X-Received: by 2002:a17:90a:d406:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-39d70b4e3bfmr523741a91.16.1788954581367;
        Wed, 09 Sep 2026 04:49:41 -0700 (PDT)
X-Received: by 2002:a17:90a:d406:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-39d70b4e3bfmr523647a91.16.1788954580694;
        Wed, 09 Sep 2026 04:49:40 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm69001290eec.15.2026.09.09.04.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 04:49:40 -0700 (PDT)
Message-ID: <d888903e-7482-46ef-82db-c35c39d5bd6a@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 17:19:35 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] PCI: qcom: Implement shutdown() callback
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260905-shutdown-v5-0-f0c6bafa1d4f@oss.qualcomm.com>
 <20260905-shutdown-v5-3-f0c6bafa1d4f@oss.qualcomm.com>
 <ca45caec-01a8-438d-a91b-98a2ef411576@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <ca45caec-01a8-438d-a91b-98a2ef411576@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -84fKCdUWWxAsoN5fUD_HyRsRFDyrggJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEzMSBTYWx0ZWRfX4KWp5dUZSeCL
 Dby/UyFSWxqtajoY6+m7pvF9Cz5GI40m/zNTNnYUptrG4+So3FmVqonKptSWKBKf4nhdpdB65F8
 B3bmiZgyB0qLu8pr9gGlgVm7nUllqP0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEzMSBTYWx0ZWRfX0mLbbZgjItJ0
 8pXekhAF7G1PQ8Cvt2rDS0sqMdxjp/GqiUY8AUJPTVlSIBtoNwRXtY/LhFBgseFqboPWceYGRmp
 WApwGLzY4sSHvqvVCioG7HaVRZAZttpjFyxFxw8bnYGedWz8DDw8E54AfVlCPyvbUw6OLOmSC24
 gWyhP3ZlmxyOA+UTUDtrwVvPNX54VzDPIyAs2ZZaKi9mULH60hB680synerPY38p8slay6kfnKC
 F2vfN7vmP3VbaZ40zdL+i2BTQd4/zZje+wibd9TwD0PAN2KFd3Q76sN2VEpn/JwSpmy7Yh1RdXv
 B/01JzsFCEWGMmR2I42TpCtp3mDCNHmg17NbJ1F1PkszS1ZRxRTXaPzY3u1kLDhb7zH75kqBjFJ
 iLtdOxYUQ4xRrxXLWuYWaLJdntgqp+6kEuuRiUEM5YmbED0FIqakc2kR2XtAR6cd32He8apcKXg
 GN53srzEMeL4EuhMcDA==
X-Authority-Analysis: v=2.4 cv=S+jpBosP c=1 sm=1 tr=0 ts=6aa147d6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=DzEHcH8_ZUqq09089R8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: -84fKCdUWWxAsoN5fUD_HyRsRFDyrggJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090131



On 9/9/2026 4:26 PM, Konrad Dybcio wrote:
> On 9/5/26 2:48 AM, Krishna Chaitanya Chundru wrote:
>> From: Manivannan Sadhasivam <mani@kernel.org>
>>
>> PCIe host controllers should bring the link down cleanly before system
>> shutdown/reboot proceeds to remove power/clocks from the controller.
>> Without this, the link may still be up and endpoints still have
>> transactions in flight when power/clocks are cut, which can trip SMMU
>> translation faults or NoC protocol errors.
> [...]
>
>> +static void qcom_pcie_shutdown(struct platform_device *pdev)
>> +{
>> +	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(&pdev->dev);
>> +	struct qcom_pcie *pcie;
>> +
>> +	if (pcie_cfg && pcie_cfg->firmware_managed) {
>> +		/*
>> +		 * Firmware owns the link teardown and clock/PHY shutdown in
>> +		 * this mode; Linux only owns the chained MSI IRQ(s), which
>> +		 * still need to be masked off before shutdown proceeds.
>> +		 */
>> +		struct dw_pcie *pci = platform_get_drvdata(pdev);
>> +
>> +		if (pci->pp.use_imsi_rx)
>> +			dw_pcie_free_msi(&pci->pp);
>> +		return;
>> +	}
>> +
>> +	pcie = platform_get_drvdata(pdev);
>> +	if (pcie) {
>> +		if (pcie->pci->pp.use_imsi_rx)
>> +			dw_pcie_free_msi(&pcie->pci->pp);
>> +
>> +		if (pcie->global_irq)
>> +			disable_irq(pcie->global_irq);
>> +
>> +		pcie->pci->pp.force_d3cold = true;
>> +		dw_pcie_suspend_noirq(pcie->pci);
>> +	}
>> +
> if (!pcie)
> 	return/warn (should it be possible?)
>
> if (pci->pp.use_imsi_rx)
> 	dw_pcie_free_msi(&pci->pp);
>
> /* abc xyz */
> if (firwmare_managed)
> 	return;
>
> will save you indentation and de-duplicate the free_msi() call
Ack.

- Krishna Chaitanya.
>
> Konrad

