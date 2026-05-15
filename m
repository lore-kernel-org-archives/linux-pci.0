Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAB2F7EE9
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865234; cv=none; b=upEWFTOkPlegfO5Fjn+P1YxidMmBvMhZnzWu/64vd6jAHasrHtxnuuvr+wIeKT9exRsbOyBgO1T1m6SwTj0hZoJeJYZwemVypnIQdJtt8S5cCBWV4o3/qoENoUkBlUztJyQ8OolaDAuAzQH4ExozzZYbwjuChR46SLLoRMXuS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865234; c=relaxed/simple;
	bh=m/X+A2neovB+Cc/QerzVKw+D3ZK/eWQ7URsAYfYEw+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tfu5Q4z1KlNZ81kGqPs3pgzZZ3J7Xgi+RrG4Yol48yn4UJZLYYMrP09pdr4pamiTQmRkmheQAVjzvRIIlMUqgpOpnvW2ETBBrYJpvuyKuh+Xs3ZEbWlEdy1hzmbznWq9Dfkg3EsEKpjZBVkxhK3bBxVfVwg1i231rLTw8QKe8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lmFGDpIX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d7tx/H/4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lmFGDpIX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d7tx/H/4"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBY3ka4020904
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 17:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q8BCitUVkdvMXM0a6r17itsJQ4GIdBcbJATa3B2kI1A=; b=lmFGDpIXPdFMftj1
	qEaiRwemA2hX6HEPAF9f1hZpdn49olPYtrKlejMhw3jZR+wHW/VSH9vBXo/VQ+/L
	0/d+JlkGLLJo5+S18hjUJjhi9+vBKoXAF+ylsaMB7VX545FH3BjFKFxXU4R18hI2
	RcgHF8LTWzqRIpK3ANCuPmqkJ7jDdebQqgDuGpte1UJasq2QyVWytZ350enbRtQk
	+bH17YSjPe20iJxrn5d8ybYDcBphzCWX+8W8mJyNAO0L7jsN1qzUq7O52DE4bfPu
	31PfVJ7RxKwmm7eSHcVcWsnnRhxVkoTtgxA9ECZ1/mVyHfi0JHYk1fDHU21lYtsl
	yC3iHA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1rv5vr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 17:13:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-369467ab5bfso1695077a91.0
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778865232; x=1779470032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8BCitUVkdvMXM0a6r17itsJQ4GIdBcbJATa3B2kI1A=;
        b=d7tx/H/4A7wJMdTiHticPHWi84unk5WXfTph76L/RCLgqcxMCZHdlelB/tRRr7V9kH
         pWB6ZnTd84NKHs0n+kP5X2+I54Y/KfYyLUGGyMpVw3doCOEIcHhtptwdhlHDL2UfSuiv
         1uG6nkjwabpBb0DRHrC9GhOQJGZIqCWDlJE5EoT2kN57mCwGmctMMeMTtLpu/sgUxa6y
         BGFSl95gGQKq9ziEy6AeQ/O1MgypsQZOxtx2Nr2Lpc054EBHcSS3QIpJCnDZfkV+yA7h
         3M9q1CBvif22pp0CcFKOOJJHv4cnOxAU0bT/AF7p1Ud+pGEbBGfNXepzOJ/GGY8GsIts
         vpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778865232; x=1779470032;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q8BCitUVkdvMXM0a6r17itsJQ4GIdBcbJATa3B2kI1A=;
        b=TnTBu0ysMXkWrxWSueJAgoZNJJRtmdrTpgekeJt1kZXvqUBbiHiGlO50+EM3NjcKyp
         92QhunROsyEIaPTf9tdr99YUfDNYZqsGyg0rBJaNqbEJ14jA1wYtUKZUotyAng4kK6XV
         6cN/cxinboF0+ZjbC1MEDosBjML0w9hXONHGbNcyI4VVNgZkIeijpzSDS6txn8zFASj1
         epbJ3nK4Rj5k9jA2eLRUPj+Sz+ks9M8/sz5jZZOmr3x20kdGKBZEoSufq/3KXwGnMtaG
         jbtsss8v9Jyz1Sc2ULAGCBCCQZNC6DwSragp64WYZu0d7DqwRg1NY+thaZ/2oSlwEOpI
         JEKw==
X-Forwarded-Encrypted: i=1; AFNElJ+kGxFYCBLB1j6aw0wfx6eP2n4q79SrnlPgwJAzfmMf/ajjwDIKjJaGxt8BQ3NV/3jt8I0EQn1i9Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoDu5cVSteorlpwNXkPBDfVAQjjvvbA09/4zCOoXAn0a8FsDRs
	oFOUbPmd2eGUW6TV5eaEaa4sPZ8RYe9ZNzsMbi1ETPlvY2rzbVuXcjOu1faeUejW8mTsfW9Epp4
	/z1bH897ku3nYWJK4d3sxk9Dt3YyoolIF6jYEyH1tQW8KTTNMkSwN5sT3oO1Tj8s=
X-Gm-Gg: Acq92OHNkSHQri7iMRM8g+wN9cX9g+NsogIJ5SoLb2SX89F8uMzCBlZ3Kc6lBo9hq8i
	d+FURJm5DKGRQWCNURg65Mnn18pTRrQA4nEYeF2bpQpqqAyRWuJLiXoQxMozMPKDVBjWwpHct2h
	nWvHxTlXxRJrbz63q0zKPJ0W6lpXF0Plgglg/eKs1aM+hHJHxPaz13mblslPqcYr3u89JtdIRAt
	OZQ3DQWr0Gv/uiq62/+OSfNd5CsyO06SK1HH/E6NgL0ESYfwxd0HSPO4e0C4V9N3JTAp7xK9fea
	tXDZjL8L5qFklYamUQYavp5PBe+VJLzVgKfxXql6vszGXHjh3kVUSunbLCpilbcCoVsMF8Lr2qL
	D/jYLc2PuW8NK2et2Xds+
X-Received: by 2002:a17:90b:4ec8:b0:364:a173:2d61 with SMTP id 98e67ed59e1d1-369519e40b0mr5368567a91.11.1778865232274;
        Fri, 15 May 2026 10:13:52 -0700 (PDT)
X-Received: by 2002:a17:90b:4ec8:b0:364:a173:2d61 with SMTP id 98e67ed59e1d1-369519e40b0mr5368499a91.11.1778865231752;
        Fri, 15 May 2026 10:13:51 -0700 (PDT)
Received: from [192.168.1.11] ([120.60.141.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm3344895a91.15.2026.05.15.10.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:13:51 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, vigneshr@ti.com,
        Hans Zhang <18255117159@163.com>
Cc: xrobh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260501161010.71688-1-18255117159@163.com>
References: <20260501161010.71688-1-18255117159@163.com>
Subject: Re: [PATCH 0/4] PCI: dwc: designware-plat: Use common mode field
 in struct dw_pcie
Message-Id: <177886522840.11213.1532617783883550718.b4-ty@kernel.org>
Date: Fri, 15 May 2026 22:43:48 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: s5zGXdxmSFhG3VUeYlcDHRAfERnPlgLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3NSBTYWx0ZWRfXy660GtHujwF9
 BipBaTe7uTzv5shk2YEKvk2YTdpkbX+6aqw7ntv85jXd8WrmZFvG9d3vAO5RZsXU3TpaHIkEAgX
 Gdt+x+BH8TjwEDM3BdT106F6hDli4AewHvjVgOUrPgVwGDHS9FFjLfzM7bvF87DjjYBPHFv6QRS
 Ruf4ZM/OjO/X/0OoqQyE+dBbSkCML5Iy4qHEkiJv/Tku6ROkrnz7AJgolELvk1PD4uIeWbrV0MI
 Cndlw5+VrM2dEMDppZtrEAWjas8tbECwIwLfTPhVlCX8zCu8aWfSUtJPdlZB1PX8bAaEad3gYI8
 W/D9t1iFHvXZItNjT8s6/vQTw0mRdPcJEE3dn9t5hfSd+iG98k84DUkHNZKwbvl6nvcWpGJDmhq
 CbbjhZwiS6rfscHrN6lJSGa78h3t9tgt+ouU8TvDJ50VdtteyQPaui3K+QSsfrRv4an1UN6/pa+
 NZpxYOwjsOOFe32dGvQ==
X-Proofpoint-ORIG-GUID: s5zGXdxmSFhG3VUeYlcDHRAfERnPlgLV
X-Authority-Analysis: v=2.4 cv=JPELdcKb c=1 sm=1 tr=0 ts=6a075451 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=8TBCxnFsifAbGBbxUCxq8g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=o8dt90ZyUBgypWHtjZkA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150175


On Sat, 02 May 2026 00:10:06 +0800, Hans Zhang wrote:
> Several DesignWare PCIe controller drivers (dra7xx, artpec6,
> designware-plat, and keembay) duplicated the device mode field
> in their private structures, while struct dw_pcie already contains
> this field. This led to:
> 1. Data redundancy and potential inconsistencies
> 2. Increased maintenance complexity
> 3. Error-prone device type checks
> 
> [...]

Applied, thanks!

[1/4] PCI: dra7xx: Use common mode field in struct dw_pcie
      commit: 3718315f58f8ad663cc9c0225e3a9f3fc365dc8c
[2/4] PCI: artpec6: Use common mode field in struct dw_pcie
      commit: 5d47f6aeffdf55524fb1130666057266a741e97e
[3/4] PCI: dwc: Use common mode field in struct dw_pcie
      commit: a8bf471f87f4c5c180641a2c6f7d82b1aa0f61fd
[4/4] PCI: keembay: Use common mode field in struct dw_pcie
      commit: f02459d0342f94fbbc6296fca0f221783d3a37de

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

