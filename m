Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C93DC4B8
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583792; cv=none; b=mPPZiNKJ69XBT0WWVBdWayi9yfT6RuMMTfOhv3ZyYJ8RgGkF+SaVIaQuG2fP1DTCDyOSNWhqFL5uKeB0p0ScPOE5bZqcOtetNz5A3ANDYIhip4q26rAo3ObK4FDBQwCgjHNfovrpUC8gDylPb4ZVtIe3D7e6Vcsr8P5pFudz97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583792; c=relaxed/simple;
	bh=DrsO9+/TcsBnB6GcVVjgzMY7RlrO4vA2zjm03UqMC6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeGIuXLnKdSCXc4F8u6yi3JlNQL4asN0a+1GOoc7rO4oRV/w+XYF8Y6qEqNyeCf0qX9naofY5FiZYQLNby87OwVUaG34Z7muedvMWlPFK1kc4Yqi7rdg2NS3CCSAe5Cf/JM7ZDwu8N43pOgCyVWYUpVX7QDlC6I6YnnMCuNQE40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zfj+Ek1g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PB2f2j86; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zfj+Ek1g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PB2f2j86"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66961JDh892630
	for <linux-pci@vger.kernel.org>; Thu, 9 Jul 2026 07:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tZzhSBXFUjefGXREmfHjGo5T
	SfL/nszPC7B8+7oKefo=; b=Zfj+Ek1gABNN/Gh5yAb3fIBha4HsGYuVpu2u51z7
	pXo8lOWhtZq9/pC+S95fWzlR0Sz1VSCLi+bS9GGHGz95//ISs3FRncWdIRjxkONn
	zC8T07vLI70Hkfq4pH7abbk/H6R+M6wWQsP8J8uODjvrBpJFEBD30Wnf776E7/dH
	wDG5Lxn1+f+ez/t5RWob2F0MGXMwW9f+85kyAIgxoYncPmsBDYPkwn1qSyx6VKWF
	WU+3GiLFVHCc4Adn8xMtSGyno/TD+4fGxLW1haKfQekyf0GJvH+qtb3E8x9aUn7g
	4o8U+XQAblrlXsU+VID/1QsyROrxyQtTtRBFHdz4gXT/Vg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9urvtfk4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 07:56:28 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6751db2792dso255962137.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783583788; x=1784188588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tZzhSBXFUjefGXREmfHjGo5TSfL/nszPC7B8+7oKefo=;
        b=PB2f2j86pOtBR33s+m8eFyFY20aiueKoxbk97p8Xs2Kd44X6RRNKuuBFIAxnf3yGPU
         FJCTNJIRtb9jOD8hCnRQQK3bxt2P5X1Om/lvsNS1Psdlazitv4CQnZQlvP+zZIbl1Yxl
         Zkoqq7xkXI/tufdvLd49/D8llqvVJwMCevjbGl0KCtJrRlxcSTUct9XvV9vSDbtEQHjd
         VJJXg6Rd30EqSQTXeWbKvF6ugvrlFnwUHcPIPdKBPuEACzmR37azcETlmmxTy3hUMpYm
         g3zYO5VJiHZB1YS1rXFAGxJ2e+neV1uu1sRSXRuBsQc+9u5bSjndrJTUGhGuFHNBJpm8
         BGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783583788; x=1784188588;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZzhSBXFUjefGXREmfHjGo5TSfL/nszPC7B8+7oKefo=;
        b=VYFvHYNFZvojdmRgq/HbUGh9C98Ih9GmxvPRv+XJYMF2cyLAYaPqzL0dwN8Shzko1T
         TxqaoiMcnieYFNZruJ8x9pgEr2MCa3+/jyhGiL9eRFc/B51WRmtFRqsvg3j/jQYTdDsd
         ZUqkGDaAjNFVXjNCgmQORGUUKw9LtaAZgRVBpb4CXa0w9Wh+I1DC9ZCx4VKKStUubunK
         1booSiQ5/eJ6jjx8LE0Ky1SqffNmUmWwoAvoYJ6B5Vmek95y52GNRdq6qOpr7yML4bYH
         eus72e1kXIsukg8cgVmx8Q4Y6HegaXEPkwZfGE7tw9lPztz2RY7U6ISovcMm9Y/U6dEj
         Iaxg==
X-Forwarded-Encrypted: i=1; AHgh+Rp09v9No5hh9hrXLyHfjNPU0FH4E36rj8zl6SAApMzXeiHbKe3+OzMEVKGsjsfnAWJd+l7dAjP4RWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylPYvnzH8QC+eh0mMUXI1y2QnyB6V5n8uW/rixt1qFXcXlPT29
	59COTOhbhqauogpPwnz0+BXO1ZybZzqwyr05bFAKR8R0WOz063wtF6R5sXFq4ee+3PcL1QSNMDI
	WEv3rZTGURgv3tBj8vBzGVIaQQA3kYIZIAFmdynd305GOmNkmWBA5tTA+MhUJGOo=
X-Gm-Gg: AfdE7cmbU94KFenwzoETvcY4ZU6Al/JZllwPjb7PkeTSmixIWvrC6PZwzJz9YchMoMx
	KB9TXkrIeeaYXSIpIWtBS9Ogbu1el05PVAR3utjgxEltazgCZ+TE6VV8l4nYo/EECdw7vdCqPaY
	nKgGbCV0UWNwCjxrxT2GPH6c3jsbrNji8Djf3F56dWGdd9PnZPdmH6Iqf4yaCFoerPImohBJ9SN
	TdcIX3ljmx8rKnFLGfNc/wVfVDedmJUC54zzLiyyJtWPtxEUT+/a2ddasfI4sALrAfRkVQkOL76
	aNMowCOD23p+hDbx5iMa3yvXgt8191PePGiLO8OyYWSE5jSG0Ia6v+RrFtbRtGskhwvnRVHBoDf
	G4qaZRPjlau41ui6nAb/aq5sgzp7d+WoAUnYeffEpbuHO0Hap8xQf2Dzem+H764D/XmQ5m+wc/Q
	FKC4gBKoZISX8EBD77lRgtiH2u
X-Received: by 2002:a05:6102:418e:b0:728:68cf:c76 with SMTP id ada2fe7eead31-744dfed2a9fmr3555131137.23.1783583788126;
        Thu, 09 Jul 2026 00:56:28 -0700 (PDT)
X-Received: by 2002:a05:6102:418e:b0:728:68cf:c76 with SMTP id ada2fe7eead31-744dfed2a9fmr3555108137.23.1783583787538;
        Thu, 09 Jul 2026 00:56:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed1370110sm5020603e87.9.2026.07.09.00.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 00:56:26 -0700 (PDT)
Date: Thu, 9 Jul 2026 10:56:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 3/3] power: sequencing: pcie-m2: Deassert W_DISABLE2#
 when no UART serdev is created
Message-ID: <gatls7n4xes7mrnhgxwsjof7owpocdmjrvuxazedznwa3zeb22@q3mtufc5dzkv>
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
 <20260709-fix-hamoa-m2-w-disable2-v1-3-5e725091266a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-3-5e725091266a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3NCBTYWx0ZWRfX2JHiDOdi2FmD
 rblY42CeJ+q6OVKqox5vP3zCsBxGnIKZUdi1A6eW4vlTLQ3MHKJKtCafxGbgHq/aAcCvvs5EDvL
 vq1JLOO4PmdvKE0qEyUZj0HoRLXO/6M=
X-Proofpoint-GUID: hFhVne8p9eYbcU7MI4zbPFyk7k9kfg-l
X-Proofpoint-ORIG-GUID: hFhVne8p9eYbcU7MI4zbPFyk7k9kfg-l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3NCBTYWx0ZWRfX0u3fm/j6EI3g
 Ufg3619weufB7S+PcIbQ3zHxDSOmu2oxKQZyghAYwPjeDeO8QKrwSreiuX7RJUdjIU5nxWPYDxk
 aPfOJVg8iBgfF3H6JzHduewFCZEOuLvSMn+ZRWXZn0hEhaYaW3P4SzB8v7E8Rb99xU3Pe0EHzC7
 HV4z+DAPXeX7YUFhXzGrLHKVFwxv5Sbadzf065Lm0Lvfn8weg9sOfFJcmjNbpgqsRMLlQG0vQb8
 7x3dXxa2ZfRGaIQBU4ECaC6KTasnQKDOgwu15TsguycZBBV3q2gVyO+YLgG70h3/XbL9rtbmZVI
 GrIGbD5rLhHrFfgj88HAo+RnqH1QHT69fB2/Q8q4HrtlxpbtyjhKQlii5cpkJaMQsZumKnoirY4
 Hwu1aoYXyQtrhkTSZovkyIGajyf4eyvNyplFYkzoLrsEF+IStmtZ6s6z2zSxxv+qqdr3Q2FhzY5
 WVBo+mRHIPnycmw4EsA==
X-Authority-Analysis: v=2.4 cv=H43rBeYi c=1 sm=1 tr=0 ts=6a4f542d cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=lIAhulC54n7EYnaILX0A:9 a=CjuIK1q_8ugA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090074

On Thu, Jul 09, 2026 at 12:59:42PM +0530, Wei Deng wrote:
> The pwrseq_m2_pci_ids[] table lists PCIe BT devices that use UART as the
> BT transport and need a UART serdev created by the driver. When a PCIe
> device under the M.2 connector does not match any entry in this table,
> no UART serdev is created.
> 
> However, the BT subsystem of such a device may still require W_DISABLE2#
> to be deasserted to power up. Rather than adding every possible non-UART
> BT device ID to the table, add an else branch that deasserts W_DISABLE2#
> whenever a PCIe device is detected under the connector but does not match
> a UART BT entry. This allows any BT interface on the card (USB or other)
> to enumerate without requiring explicit knowledge of its device ID.
> 
> The primary use case is USB BT variants of combo chips that share the
> same PCIe device ID as their UART counterpart (e.g. WCN7851 NCM865 USB,
> sub 0x3378, vs NCM865A UART, sub 0x337c): no UART serdev is needed, but
> W_DISABLE2# must be deasserted so the USB BT device can enumerate.

Instead of forcibly toggling it, would it be more sensible to tie pwrseq
into the USB too? The onboard-usb-dev implements the same idea (of
powering up the USB device), but it predates pwrseq.

> Reassert W_DISABLE2# symmetrically when the PCIe device is removed.
> 
> Validated on Hamoa EVK (IQ-X7181-EVK) with WCN7851 NCM865 USB card
> (sub 0x3378): without this change GPIO116 (W_DISABLE2#) stays low and
> no BT interface appears; with this change GPIO116 is driven high and the
> USB BT device enumerates and comes up via btusb.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 33 +++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 

-- 
With best wishes
Dmitry
