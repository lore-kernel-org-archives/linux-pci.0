Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD242F1FC7
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696454; cv=none; b=PuAvguGJL9gngO0f7HUXtTNREuMjBTLu7UjY1w8ZIXJYUm7AqPnHmZoSbH3m10JmzyO0FrpG9cVn9jKjsRTR7G8NIXhWtQUwuQoYEaYuXXK9Ft6j31x26A7DlCdVDToSuBjkjMSSMSIwur1dq4WFeUf5n2MVqy2XHeqbgf7dMic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696454; c=relaxed/simple;
	bh=S+o07CGsB2yXVWZKEPHm972ZzUJuCHHo/Rajn4YiYaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuenbQmJsdgetJnOS1noFzSF2wVzzl0AUjSlOwTeWh24QlKz0FCkypGuOJFMvXuMTwJ9JBhvunXobRUzQD+6i2Gtz9VXA/3penLZwyZHJqrNIFE/VQCE+LdB6xlAKp0NUM638RLHme02/PtNtdrXtPG5f4XqnS5ToAl8s1AScu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mic7hgd7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IXpsmtP1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mic7hgd7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IXpsmtP1"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEcoQK1123975
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 15:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t8xr+988QWqirlSbwRDuuvdc9FU1IuRlxyIRd32MgSo=; b=mic7hgd7riKWXIAc
	wMuL6FGfh3OXLD6c/GqL7XqyF1RwctfV8f+m0AipsFiqQT4+VhqpwcCinuswIkrW
	LSDd9WPEwPqRH7jB1eoxGRCMktB7ChUKQw2g2rV+OE5j+R3JBM3XnD7mK4+A3fZg
	8g0iTK7x6jIyhd3CfV1/ad+nZ8f6ShFC0aROp7oTBvQk62TnSPSsAScVvPzocsJX
	P64FEqhxPdBNP6pEdVmQeSUfQrGXEJ1FwzcibVm4MqsOUQfZiQjob4P/58fzhJsQ
	637dZyBgcoC2tIJI6KgvSDw/LbK9e/td6T9628/epwN3HhnOfMcQrUlhmgU4m2nw
	rxPBYg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n2fd1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 15:14:11 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfa45b280so2842501cf.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783696451; x=1784301251; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t8xr+988QWqirlSbwRDuuvdc9FU1IuRlxyIRd32MgSo=;
        b=IXpsmtP16AFnDPs+kGGnaR8xRwSkeZUiRjc1L/04+5shdyWt1pxZZFg0/ZytS3Sikg
         GRJjcB3OBzQqNuresVcNeBlmpnDoEP0HbEgo6q611mClAOJOeDDecyVnF8iszUwcuJHi
         FG/nDRPWPH7QN1PXvdq1K1Kvvzx3CsJb4teAzwOExEOi2iVamSsFLsr+7VwKmNcAkgqd
         PNB9f2oam+OjfGAbWrPO0+zf0K1ksQx7+7HaW8R7VIhNDOibOdJXsR87fiqDvjD/ePwc
         0Z7mcpNLe3v/it/MyAdlVdOgVys6d4oODoi1bpTFwuieH8EBGvtreU8q8QQjX3h8n+Jx
         iINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696451; x=1784301251;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t8xr+988QWqirlSbwRDuuvdc9FU1IuRlxyIRd32MgSo=;
        b=oiVH+AQGPTXGT9QyJG6VpT5R4erhU3A67Fa1+apHCg/g/sRP1A5Qem6uRXkbiAoAYZ
         7o8dA9US5GFH26tsxX9gYdNZL61JN8KSelsUBmcvMEWid3zVnM9h9HHNoQcjgti6w+42
         cIYe1TO7YrimM/tGfOmBW5jp6wvuYhI1SFEg9raYEOoUJnU/5a/yPwB6B0VYJ8MnRmOt
         dddDcwW+jRkppPvNdGmTrirMe5c9pokWGGrPZNNhUMO2P4lxvxwGCpKXBVLZJAhkI/ci
         8Z8plv/BFml3wjdC/dWr90IEOjPhi2Lk5VgcHUBpEP/2Q2xifnpuHsk7GUx0pZ/jxAb7
         eZjg==
X-Gm-Message-State: AOJu0YxSgGS2MmGyURLGs4L+MNZqMySor356l8pHQ5CFx9ZjZ5AwEjyx
	guN1etK74fThPrE8X64bWE8OKeXMspqcxcHFU1x4taDYXnICEAytrKA2cXqXTuQuh0nqCU2sEo8
	8OQFyrDa9Vy8wvksCYFcF5XD2uszNVKqaXVdcmcDlkqoWgm8LnyaLi76rV3jznGM=
X-Gm-Gg: AfdE7ckAEzDUid1zTJY95GGiiyfhDXlx+0d2x8eqxydweuSlzqLNZboafYs13TtUYJr
	ekrg0/cPI9fVTjKA2pb5zo8BvbZTttBAVoI77t1YQOhict7NQJZajL97d/2UhaQ3XM55e3bIl7Z
	c716MdLTTAmqSVMJXuYTfgGrnQzWJEoehyag1QWU0CSXQLt1eHQTCHMkI3nMRs5++TBXhkAlGJF
	upd/O0lpLqogGha8w8H3kq2xzhv23G63lEwIgawKJus41QGAJbvpk4Zfp2TkvAllZDnsII0YUhv
	Q0Xzi7AGLktjJKRASfbt0KAEFEv8vZe+SL1GRgYDDYF4dgj//oqKu0Q2uXjWkkm9KQ9YfwURXK0
	IQmjk815zJ+trDKdz4Q6Gu+VA855k17f9WMI=
X-Received: by 2002:a05:622a:101:b0:517:8999:6c50 with SMTP id d75a77b69052e-51c8b512840mr100771131cf.8.1783696450999;
        Fri, 10 Jul 2026 08:14:10 -0700 (PDT)
X-Received: by 2002:a05:622a:101:b0:517:8999:6c50 with SMTP id d75a77b69052e-51c8b512840mr100770831cf.8.1783696450567;
        Fri, 10 Jul 2026 08:14:10 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d78a08sm12347815a12.18.2026.07.10.08.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:14:09 -0700 (PDT)
Message-ID: <865cd059-49ed-4922-806c-4c59eb37f5db@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 17:14:07 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: qcom: Clear Attention Button Present in Slot
 Capabilities
To: Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260710-clear_abp_0710-v1-1-efd63ebdaa09@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260710-clear_abp_0710-v1-1-efd63ebdaa09@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE1MiBTYWx0ZWRfX6vPq9jQaUoOF
 k2dO9bI1H5FRuUKp388WSvVBHUfJCkPZwOH6/FaZ9NPE2RJ5pj1mluZc7KAjc+iqshP+SnBwPip
 6mg0SvOXyJnRdXzadWBenaTAi62CltQ=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a510c43 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Exl5BUTtluaCrdyZuN8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: I0HjbRgF2aJwGUSk7wPfJBmM_5v_R4mB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE1MiBTYWx0ZWRfXyDsQ+WsSZV2a
 LYkguhor2YKnJZsheaf2/mqAfbkuYLp5SFRByELkQO/UDLnlt4MQwIUGG5uD+XwJeVLQYW5sjR/
 Q2Z5RxzH1/RL3vRyRmD9m9ap3xtA1nDs5xH37fgPqt6zBngbaW6umCP+9L6g40KRwdvhjjXyUs2
 f3HLFKhjXJUdAYE7RQu0C6H5jDePHEbVT5fqj35Ok5FrnfvNMhZ81d1OI09IiyQtisNJa44Zimj
 Sw4qiWaf5Z53kqw/y216GucpBxp8UGH3hWT5bhkNZhsjZn1MBA0M1966QvrWmXxsnFbbTg0KLN/
 1xzo1OMs4zQrHU9GLKaoADxeWk1Hi/jZhA88NuS/pR+mtXzqD9hsCJasEkz/KpV7JD7Wl4qQPqW
 990PkZdSfuWwaIF9jjZ7bxIwYjnmSQDS2TSLiU4wjXbyHmbPyCE7QUDfm8DWw6bGwW/5x7Zo/bZ
 0bRtZIyl//M5V8K4Xig==
X-Proofpoint-GUID: I0HjbRgF2aJwGUSk7wPfJBmM_5v_R4mB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100152

On 7/10/26 3:20 PM, Qiang Yu wrote:
> Qcom PCIe Root Ports advertise the Attention Button Present (ABP) bit in
> the Slot Capabilities register, but the slots have no attention button.
> 
> When ABP is set, pcie_enable_notification() in the pciehp driver enables
> the Attention Button Pressed interrupt (ABPE) and leaves the Presence
> Detect Changed interrupt (PDCE) disabled. As a result, presence detect
> changes are never reported and surprise hot-plug detection that relies on
> Presence Detect Changed events does not work.
> 
> While at it, rename qcom_pcie_set_slot_nccs() to qcom_pcie_set_slot_cap()
> since it now programs more than just the NCCS field.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> # X1E80100 CRD

Konrad
