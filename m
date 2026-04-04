Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A72FD665
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775298948; cv=none; b=VSMpKjJAZR/NNpRUSP+5vrP4cAwcH5JCpMacLFbzgQxSTYnLB7X177/t9kWT1fi30TQhrsmSpdPthUFObYnjBD3bTAnE/zwmwFsQH6yECOiZrz3+gK99cUMTWDtOr68DzpO6IuhkM70eCqVByy/dgl/v9AyvWX0klxXMWGnSjLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775298948; c=relaxed/simple;
	bh=LiwcJVmn/c9PM45QLfQL9K2MNAizdTVRnzCVsY8m1DE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iBQeXBnzs8il4WExl0qlB3dHPjTegVZWxbqM3Qjies9zrD17sIwWMg2a4g5IXvlVHbnYNHcJYbr9Vyh8lKt3BfBZtLKHrVUzV6DEeWRH8EboCWVIx1LMy0txcKt9sYzVG1W/FvzK9BjpTdHlc1LninnZm50Lr4eL4Z2eGg2TpWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zwtf+2JI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V6cw8ijd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zwtf+2JI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V6cw8ijd"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63428hsB2408390
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 10:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1bO120ElN5GMnWdl/iLo9s25UFJEb0/bZvzF/MWV+gs=; b=Zwtf+2JIvBHyCEHt
	TOCl2X0UthuJLuf6IMMf3PRzMt4tFGc5sxt2xDq0clX9P0WkI89LsO4cSpawImjJ
	DtH0x/i3SR7npq8BOynIfD9dae6rHb31NrfmAIDoKrxdePIc/FlEDK5XWclpLiy8
	MzFamo6PfeaoM3DQH9Kkn8K4SEdf/E3WYRqnZVsDdd9yus0hB37s2i6i9hcoS/Fv
	MWZRyh0JYTrgmoyH/5H+z9d6jhwCPjWs/DgoNqxm+Ev9HR3NuDpm5J/oNYQ79U88
	xpRGQOx7ZCSbVQxhLm+MvZtHrmbHARVaQ3Gg0jJZAK8DAON99V3YROyQlz4ubtF3
	8pHOSg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4daskrgs3q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 10:35:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35d92f8408cso2832544a91.3
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775298946; x=1775903746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bO120ElN5GMnWdl/iLo9s25UFJEb0/bZvzF/MWV+gs=;
        b=V6cw8ijdYfJNcMKHcHnAL5VvTzoFidhbyGToYebQi5F8CO3lHPNjNvhuBrWCJPIv3k
         2sM5ih5QC0P7yFKUUU5kcqPNM/eJdSLUTgkbChQGf5I8uE44s1cvw03z7nxiXQqo0Icr
         PG9EgaQZpXynqLkO8/YBpwp/4Tp1HI0f1L4QMq87XrN9vay1zmZKulrh+omikprdWSx5
         o2Z13FoLE+R4qsPX26nBtR3wLCvISc5uVE2IpeF3klhVJr1umENW8Oljsh9S0g6coJvO
         47QI+LXuSkvC4Jp0s5nEhKulkVqlZw2QydiBvUpKj8rdXM+XjmPnYMr0Qb5/x+KsDQjm
         U5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775298946; x=1775903746;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1bO120ElN5GMnWdl/iLo9s25UFJEb0/bZvzF/MWV+gs=;
        b=V1ABeQkjnJrdgfDTRyfbs2kaTPlgwQsg0xubjjCh8n1/UgTG/nIV+HDZUkz2fSPtwU
         zElJ1Z2iynGKTnDBBhtRJW/BFYPq1iBt48BV7hTcZScN0GgQqwbpzoVlq9fVGeasXqcm
         bRdHjegrwABXuHTrOaUX3DNJvrlCNoepgMc/64iW4IbFA3UANAISN4dp5hCuibf9XEVF
         i3+fGJbJ/KX0MUD7YYmYgZf8RYnuSVuoOEkVI3azKPv0e0P4/lOROO9iP6N2Nb5AkPqp
         Hg7TCuFLDWBb5Lak4Pa6j2Z0pVJ6fyIR+tx/U2qd/JjedxAMo9tqGZisCvBNYy9ZOJbl
         x4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCW+qIndupeggvWxyPBUNkyjH5+ZHJo0kNM8BUluWHbJtMDj8b/D582e6VpP8m2feXqWm11Qgi3m47w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcSi0EH8bQt8m/axt+vsMAxDG18kCwVEDq4LEsdGXhUQQNbIOf
	LcA7UneezvOY+P2/wEUVmxp0bJ4pP/i5FRerEe8hvmBnDkR8rFmZti7ihpqbT+lYnL1sz8qsJlr
	7JB2RRymmtKSe2MvwgpMshVfxTm1wGsZFF3ATP+kDhQB1m9fr72hE6pCjitT6M6Y=
X-Gm-Gg: AeBDietaqwKze/MmeR9Z3WXu/r4QRkzS1MUwBnqzd8ulCsfSv3begfueMWQyoTQ87rg
	7WHXAiHhyvTpgAIlEeBwSDOcB/g5JdQma45tyXmUlmLE0qzAB8x12RxddT78JEVw061efPGLg3R
	2V/Q9MWIqWzwI6KFdB2RzwIhT3OiQA/GplGvGT9a+DLErs9YDHN1g6EnO+mxIJCKqvNxCwO5nW2
	w4wC9WJChLLcW7YdySDpCYwZgiUda7r5zFpAY+RcJsXV8omSPsSO4NG4kkUq45BKx8IUKdXCS5M
	mutji1uo7x4ONPkSD4OAlhOQwAoTb295wgUgfeQ3geU0zslSLsqyyNhs8igBtN5r+ipiY/ZSdqt
	ytFY5/Vb9UTueIvc=
X-Received: by 2002:a17:90a:d2c7:b0:35c:cba:344f with SMTP id 98e67ed59e1d1-35de68414eemr5858987a91.13.1775298945792;
        Sat, 04 Apr 2026 03:35:45 -0700 (PDT)
X-Received: by 2002:a17:90a:d2c7:b0:35c:cba:344f with SMTP id 98e67ed59e1d1-35de68414eemr5858970a91.13.1775298945252;
        Sat, 04 Apr 2026 03:35:45 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:d6bf:182:1f3d:df20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de680b5c4sm2154469a91.5.2026.04.04.03.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 03:35:44 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Felix Gu <ustc.gu@gmail.com>
Cc: linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260324-aspeed-v1-1-354181624c00@gmail.com>
References: <20260324-aspeed-v1-1-354181624c00@gmail.com>
Subject: Re: [PATCH] PCI: aspeed: Fix IRQ domain leak on platform_get_irq()
 failure
Message-Id: <177529894081.11406.7307362893690177391.b4-ty@b4>
Date: Sat, 04 Apr 2026 16:05:40 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=Xpv3+FF9 c=1 sm=1 tr=0 ts=69d0e982 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=xCZdhqmVAa86G4UcJK0A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: v-50AD0AvvTEljQp5iSTp-qBEOsSvJfm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA5NiBTYWx0ZWRfX0TXkWWsrAe21
 j0Q0cXXJSdoUxVrq8mEVR4oVRtATr3vrvviUyY4NWP9Bo1wqVV9u8g8LOh8YvzfRO2G70m/YS+K
 bxjClzTs/XV5PzitSFT58H3hIvwLrdl38uk8uQMRqZo9/1jpxCRKT+wUR91hwh/cUeJg9fSbS7d
 YJR3Jz5scTPl8eO/6I50rsScNgRsp4MH+EARzXhvW/hd8lxd99ybaDumm1RIae8osLfzZHNXhAg
 7Lzt/Z4T3Xl9GlS3JpqO/iL6jxTZPtThdQFdqRiyCE6av5FaknxzkEG9riROnqMUrYGcWyFwUFD
 dW1/sCiXVrTvTaaKkWNlknHrp9Wt/zLmLFoBRp31nF9dG5a+RlBvXvaCHO1GSfm/yg5MySi5Gls
 bPOuoTrKX2XpQTKs7RqGOdVZtUpGTXLuxLrj9a6B4auHiWyj1P0ljsUwm9tS6BmNdxv3OI96vRC
 +RomyZydL1maeJEvZxw==
X-Proofpoint-GUID: v-50AD0AvvTEljQp5iSTp-qBEOsSvJfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040096


On Tue, 24 Mar 2026 01:57:59 +0800, Felix Gu wrote:
> The aspeed_pcie_probe() function calls aspeed_pcie_init_irq_domain()
> which allocates pcie->intx_domain and initializes MSI. However, if
> platform_get_irq() fails afterwards, the cleanup action was not yet
> registered via devm_add_action_or_reset(), causing the IRQ domain
> resources to leak.
> 
> Fix this by registering the devm cleanup action immediately after
> aspeed_pcie_init_irq_domain() succeeds, before calling
> platform_get_irq(). This ensures proper cleanup on any subsequent
> failure.
> 
> [...]

Applied, thanks!

[1/1] PCI: aspeed: Fix IRQ domain leak on platform_get_irq() failure
      commit: c54d5f5b33990f2649c20f35407f340bcadb8a53

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

