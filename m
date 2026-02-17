Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16750239E63
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327091; cv=none; b=jh8BnCvjx6eZUVfQOyVBTRc8TBfdODObKZ87y4YKQp1g+Y1MNUSp2S757TrOJb6vLgwd2lTrnjZx789jpXP273vf2AyhPdnkwC7BqWkNy3/J1n5zudGWNgpQZUQ3SU5FkxTxMQvgrcebh0V4i0aMhLETk29v2qOw4U7pRoT+GfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327091; c=relaxed/simple;
	bh=t9oh+Sa421FrI7gr/9zr3dr/y6MWYscKinpyhzwl1KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npSEQplsBduKL3TtdEV/tJge25lE0MmE99JpLTwz7ngai3MZ37tkoqGmJXUaxOTfzGotjGlVyLyamYac21ul7e0ilrGZYKVMD9UtnzByP/QDSKC0++ofFVVzyUAsY6VfcJ5O5RnaMtgH7qOD9MKFdZ9p00LNgojZMFUlv3LvMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jsBJMylz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LKi7SP4J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jsBJMylz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LKi7SP4J"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61H90lCP289398
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pIaS+hQLm7+y11f5MKTxeeaP/JI+qNjznY22YGxiYic=; b=jsBJMylzpnBPIIKe
	cq4jMWxcDY/KqifNInw4gg6VRISyJrBUCnRXG4QxhIN6GsjChLwHUIln3KhRdNub
	SsZdfZl4bpwzTvAa3BaVUyQ599TBqfYHrO+3oSbdsSPYtj+ujccbyT8M7hONRLfo
	2O8/xhN/rqQ/ZCpwfH+pDgNIcK0O9P5plR308IqmBhV4BeCMOUS6LcLG6pghniLv
	6/IFlaelIJq0BM3bpK9cFmLnEpSbZRbUOASaFztbwCOjpl6O5DDTWXZeGlrWoktK
	H2Rb5MOg2yqrX9WH39d6wIYYvqcJA1hmjZF4s9scKIIjJ47u4WFfkfjHaJ5OU2a5
	wbgEDQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6nrt1y1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 11:18:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so3384273a12.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 03:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771327087; x=1771931887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIaS+hQLm7+y11f5MKTxeeaP/JI+qNjznY22YGxiYic=;
        b=LKi7SP4JhuhyknRqHgouhJcbsjkJapPULgywqhuYzVXhQ2fCQ67j6dOJR45xrds9pv
         aHTsceALUZ6RHlKQT4jy6Sw94c3gisHPhU1c+3lFo4F50iHMSZ7dDojzh2R/EwUchqEa
         kNgKMpU/b6XAoG5jw4IC/Dv3eR2PfPVshrPK4uBsYBIRaIP5geOuObhMOcX6vnjfyKk7
         b3xHSHDGRzt9SNzOC1Lq052jUBk6SmL2UQMV+1Per5/+ebxHTgh2EVuYh1HH4SKtnJAo
         FlAxt4AsLK3RfklIr1h0XnwNqErXFa4BVRK8lkruFb4JWv317v1kEIa2a7fmhfOGZgAJ
         DHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771327087; x=1771931887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIaS+hQLm7+y11f5MKTxeeaP/JI+qNjznY22YGxiYic=;
        b=qx75eFBxlggPdxmwbU48GFVfB1Mg4B7Gix3Nf/5Jl/4U+HEg1mbwGVEcnowdEq54Q2
         5yuUUn3g3GGaliZs97CL5Zr4cMx6rkIOqnkLc0RrtdMSg3a3FTmExiaLxYcOH7gXgMAE
         5oxM3f2A7efJEVLIS7WClhRtFaRC/DYvsPFSioPIIPT0IJfNk1/Tdh2UJhd2Jr37fsmg
         Peo3+25ijebfQjzatKd0uPHC0ZsSZHl0fgNRVXmwqiBiXhSREq86jQoytk15PbSYBa2i
         DuHZu5weDFgJ2svtN54VXxVt3OWyiBqKFeWbgqkgObfIT2gnUF0iSTFOeimu3J6hhEFj
         U4Cg==
X-Gm-Message-State: AOJu0YySTpXDwvRFVrQfPkxV47PJejFSAZwALFAvftKuV8TdAziNfCEg
	g5ipA26m1knIgS3h0WHqsmChEWBdQo8cNC2pC1ejZOLgGtNlE5x4n5GED9qYH2/ZAoDzGhWsYls
	V2gDok+qY2w4J6LG9NuzWF9+up7pffdxJlWc+SlUxjDrfJcvuB+CB1d+naXMkoo7BPvB9Cj0=
X-Gm-Gg: AZuq6aIZ8dBGc6JF0YQkkxqQn2muRRELi7gVNPFuNU36QquPRI3kTs0qdp73AiEZS9g
	sA3+GJ1UfguiRRs5QUSYt/geUhLH+Buz7Rf/m+fsdzhJS2GWU/8tsu6YuM/AO4Fq3p3iEjOsako
	OwMdmmNfZo3cf1FFCXkwB7rArIFGqn2w3a9uI6ESy/mW0iMV5wpJo/C8o6719ARxhf6YotQjU0o
	GoTqGchOxyDZ7LEN1W9l/BOKuFCipBk8Uwuil3pbleA75La2JzRqBKCt3Vdn1dacz++IGOODYwg
	qSI4rXPHLw8AhGZPhFHKgEkENiE4AAWvrVQgs1FGiZjdnoUXXoB7LMUYlimB5KDlsdBIqzsn15e
	rBgA1iPbPAYiv9pzl2f5IOm0WEBq3EOOkyNfjHkCRy13E0MCWtmYniw==
X-Received: by 2002:a17:903:187:b0:2a0:fb1c:144e with SMTP id d9443c01a7336-2ac97431043mr126508625ad.7.1771327087264;
        Tue, 17 Feb 2026 03:18:07 -0800 (PST)
X-Received: by 2002:a17:903:187:b0:2a0:fb1c:144e with SMTP id d9443c01a7336-2ac97431043mr126508355ad.7.1771327086758;
        Tue, 17 Feb 2026 03:18:06 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a743570sm100967905ad.41.2026.02.17.03.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:18:06 -0800 (PST)
Message-ID: <16a5b370-3f73-40ec-9311-1bc04ecd0825@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 16:48:02 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] PCI/pwrctrl: Only create pwrctrl device if the device
 node is of type "pci"
To: manivannan.sadhasivam@oss.qualcomm.com,
        Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
References: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com>
 <20260217-pwrctrl-fixes-7-0-v1-2-b5671e58934f@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20260217-pwrctrl-fixes-7-0-v1-2-b5671e58934f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XKo9iAhE c=1 sm=1 tr=0 ts=69944e70 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=OOr1FIuhMF5WfzrawtgA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA5NCBTYWx0ZWRfX/H4Zwa0adq1x
 yWfHgTyfYVhqvHiMeb6Yyy5OvafcNEcGMrNRHn3t3ILi17TGMdHUFDTltL0VlMBsgTRTMW0YexG
 OshgVZts4zrlKT4U9f7zwkiJiDAdKvztzaUsFrFzIuxPtwLYLzUPdD4c6Jy45374tzc6uBctEvj
 KpOU2zYsKo84YcAfdSiy47VEWC7CbZTzLUZpGTqpFlgFE+PJAfiF1bqDyTtlZfinEts6b6OfYJB
 vIdVRUO1OE4YEpVnCQcwWXVDiA/6Y7Z38ddFWh8qLsLnpG+TAbbLeaW2cw4rWgYKC1PiSqLvgz/
 OlFBSRCGUF1Ho2aK9jfAbqIlWWGkF/HTlUuss2Qmz68BB2hT5VNrCkMQVZhxJ1NEJ0O3ddwrgYa
 LjbTE7cIKEk9/RNGNCdc9ebZENuVTh3eatNXNc4XEeidHI9FGtntXd8+4/gEai/wMMUQ3u2/9QG
 EP0Waf+WXQJlnD6xu3Q==
X-Proofpoint-ORIG-GUID: Y_4Pwht6svauY8jJvhW-uIGInJ5_DLIt
X-Proofpoint-GUID: Y_4Pwht6svauY8jJvhW-uIGInJ5_DLIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170094



On 2/17/2026 3:48 PM, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> The PCI host bridge node can have non-PCI child nodes as well, like OPP
> tables, USB controller node etc... So the pwrctrl core must check for the
> presence of 'device_type' property with value of "pci" to ensure that the
> pwrctrl device is only created for PCI device nodes.
>
> Fixes: 4c4132489201 ("PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices")
> Reported-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> Closes: https://lore.kernel.org/all/20260212-rb3gen2-upd-gl3590-v1-1-18fb04bb32b0@oss.qualcomm.com
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Krishna Chaitanya Chundru<krishna.chundru@oss.qualcomm.com>

- Krishna Chaitanya.
> ---
>   drivers/pci/pwrctrl/core.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 8325858cc379..7404d48427ce 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -272,8 +272,9 @@ EXPORT_SYMBOL_GPL(pci_pwrctrl_power_on_devices);
>    * Check whether the pwrctrl device really needs to be created or not. The
>    * pwrctrl device will only be created if the node satisfies below requirements:
>    *
> - * 1. Presence of compatible property to match against the pwrctrl driver (AND)
> - * 2. At least one of the power supplies defined in the devicetree node of the
> + * 1. Presence of 'device_type = "pci"' property to identify PCI node (AND)
> + * 2. Presence of compatible property to match against the pwrctrl driver (AND)
> + * 3. At least one of the power supplies defined in the devicetree node of the
>    *    device (OR) in the remote endpoint parent node to indicate pwrctrl
>    *    requirement.
>    */
> @@ -281,6 +282,9 @@ static bool pci_pwrctrl_is_required(struct device_node *np)
>   {
>   	struct device_node *endpoint;
>   
> +	if (!of_node_is_type(np, "pci"))
> +		return false;
> +
>   	if (!of_property_present(np, "compatible"))
>   		return false;
>   
>

