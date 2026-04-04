Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2108826CE11
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775323700; cv=none; b=Ga1HXFzICN1R+6r2qGCX8c+Lrr0B5mgIszxWRddJLmcfQ4C7SQ1+L+tRkMP/c3zo08sVWCCj1cYJK36us08jXcMYxf5u2I4HgMCMQ4vhNiEP+v/UiGcf2osTlPXInK1dBpwGPHYUqvobLqoSZqiXtRBo6DpaE0C4N9PexlH/vSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775323700; c=relaxed/simple;
	bh=rYb3g0HNdaN+ajoZ/qbMioYf1F769zooOYTT2Qkc3zI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pKoygKcUwsPc/qBtEQzzNnAs8PpHsb8xnxaV2bwqRj6HLSb67O1tr81qOASuoY/7Z193B9OZPVIfEkgzXMhnvIlx6GW1AlhyoVXEMfzNJ8eL9YmhYxDFwN+EsuEgcPbXysHKfybdwmysGdaQWbGQy0FKeagxJ1DOLKXxkjnwXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cHRBhglz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MCwRe1yW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cHRBhglz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MCwRe1yW"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6342qqRE2199939
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 17:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c/QXWawy9pDiajDlW6JHHlpDmRXYO7NQkRo9RSK7+u4=; b=cHRBhglz4BNSQqqD
	pifPQqtI+1Lgq0EXo3ctzAEwqXXUWsoefQkrJCHzvmBkEP6ilLZA8yJMZRsS3whj
	qCtXd9kIkg7JbWCV+amDEx1BVmXGcVjzByd5myC271i/u/P/XgiK0/2UyIgBr1Iz
	YQIB9nNAiD0l1HnnZAG2hf0jai4TmCCrZv3x4/m5J6ovv9yTSZzLNp++GI2SspJK
	suWsVsDe9keD/mUfTXoz46dln7OmDGdBXiAkNwc/NnA/f0QJ5OUPHj8tTCpJ1Ku/
	Iq4dppD/RW+VKMYPGAQv9OVZQwbcD2l/18yyfIcukAnyc3xmdZcvMHRarD7aTUH2
	PWB7Cg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dat7u98rg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 17:28:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82ce1c395ccso4290993b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775323697; x=1775928497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/QXWawy9pDiajDlW6JHHlpDmRXYO7NQkRo9RSK7+u4=;
        b=MCwRe1yWzsEah5fetGNqOOAYHGggfG3fKk1XDb8x3EPVr4YnkALB6aeoxfmF1t2u0I
         TbQu9Jt78TkmpnaHm6Mz4LYb3kJnkVh42jL+EzJW7VhjRvKKAvTB9lBL0IJNL65MzblN
         J8yq49J/pRzf3hzo+i+b0c2QJ1Y7Y5ZOQ4Nh87f1iST13OG56gMUUZ0xEN1lzeR8TX2m
         moBQCLM/0pZnVBjYTHDzTj1tQh1VvT/cqBwKxLonsMBXx10xQtpK5Zma9mF6P92xS2i8
         8FTdgYBk4rIiBjQkn466oiFmyPpw80L7zp1HspdZWEW+QTqWfR6OEfXZcOF7vNLzZAAS
         xsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775323697; x=1775928497;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c/QXWawy9pDiajDlW6JHHlpDmRXYO7NQkRo9RSK7+u4=;
        b=fouHXl6ppgA4llP7u0NFBV9JvO0dO6brff7MtxVnYWZBkX9mSYNd57FUr6CrIYuP6+
         PKf8hOB3i/LyIoPmdl6QOxpEOLzNyM1nfPt6ofE0M6a04vhnz5juS4UiO1nWeBHdhaR0
         xobXzA7bopNeZMHghRCww0iiAXIdviwuLHWgUXEqA2hQHAbO119P0LgC6dnt09+4q18E
         XxZ7+8imjC3t4ELnzY9Nwrl81jRcsa4ZLq97JT8MqfNKDZ29arFBMiMRPt//t1Gej/c5
         PacCEf//9mjApNwQ3DYw22MOTHRE3SO1LeNeQAn6G2qlyH9zjUbhiOngXwbIM8giQHma
         ySgg==
X-Gm-Message-State: AOJu0YzEL4S8BWXHJBRiuYS3aorLtTDN4QXJ9YrgO+TDO6b9ezu/g/SR
	EFVtF7FaP2zZdLbbS6c0TweqMzM7HipS8bNl8z3Y5v3b63iAFQOA2PshSRX/YwlQLSXrg2OFSwr
	96br1jH3v41kIw8N+HH8JqA+QwcIi+Yl80kx/IpfABZSJ6IntEJqZBiwsrwPocgc=
X-Gm-Gg: AeBDietd+GwjmVgH6lpo45s3CYS4DbG7/WDebU5Nh/ohry1V3XorkBuTHDLIsfZvlBh
	6+0sdux8h97+eybNQ02QnXoP67AN7689pBhZBrAxT5ejtaxbMvTnWQohwKulQa9GrIgt4lzOFSs
	1u4PVVIlmy1mZiwWo7RjnfWoXUd5Y7bgaGJFmtI4QK8PAgvOSwGxhXKGq6BPG5A4lVr3zVnOqMv
	nB0jJktvZCNEA1J9r5hjKuWwPaexioRuOPPwbNg49V/JGggRPqYNUSaDX4az9Ep7i4C+p0+nP1I
	yGPk2V8vUhAEPrAG2KEA50ACGPgvDK0iFIgrD/bBKpFwtw0wZj7qwcvAILK/aLPqut6FgdizAnl
	4gFgAqgYGZTjdCjil1F/nte0k
X-Received: by 2002:a05:6a00:1745:b0:82c:f085:50a3 with SMTP id d2e1a72fcca58-82d0db6c29emr6608193b3a.32.1775323697053;
        Sat, 04 Apr 2026 10:28:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:1745:b0:82c:f085:50a3 with SMTP id d2e1a72fcca58-82d0db6c29emr6608172b3a.32.1775323696552;
        Sat, 04 Apr 2026 10:28:16 -0700 (PDT)
Received: from [192.168.31.133] ([2409:4091:a0f4:6806:b530:cb:a537:434d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c747fdsm9311571b3a.50.2026.04.04.10.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 10:28:16 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, 18255117159@163.com, Aksh Garg <a-garg7@ti.com>
Cc: linux-kernel@vger.kernel.org, robh@kernel.org, mpillai@cadence.com,
        unicorn_wang@outlook.com, s-vadapalli@ti.com, danishanwar@ti.com
In-Reply-To: <20260402085545.284457-1-a-garg7@ti.com>
References: <20260402085545.284457-1-a-garg7@ti.com>
Subject: Re: [PATCH] PCI: cadence: Use cdns_pcie_read_sz() for byte or word
 read access
Message-Id: <177532369190.32405.4551053455262557653.b4-ty@b4>
Date: Sat, 04 Apr 2026 22:58:11 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDE2NSBTYWx0ZWRfX/+rBfMRmfWD8
 wrs1unm05LxfY7IhW0o7fZVAhKN+GK52wL7KE45ONyZzq5E3nId9D+Cv7crq/hMrlZ0jKoJhuAd
 S8R4nPBQJe0ZBLymm5JquoYEgQroyCiuMEOeAVFpmErVVOYxu2gs9Zkye3K+Yr9Viy9yPrppSFr
 XMAOzNn7i8foVm3N4drSjMZpOVXbygPN5dXrCTdQr1Kxu/vb0E5/qmPKZZ9Imbu9cKhiWSO4Nmq
 I8LRuB0nAF5hMFLnGHx/2fFawwpCibvE7XexRbsVhy3nR7DRa5poXcm26kcoAE6S51yuz3px7Qy
 ntyCclNlahMIlhYD1jXi//Ah8HMB+UcOPjr2B2vEHGGz0jTPBXLh4KRVxFA7E7Ojau46kf09f75
 5b3+LOt3P4X3Qe0e3smi6hGnnQ3lPiZ3r1REwiKDkuzwnsm+SGaFQ7KrOo5IKT1yKhsoyCLGG8o
 8A3rKdUpBYM2hAe8gbg==
X-Proofpoint-GUID: ZM2UobOy5t5XweLZuxgjHYzjfWPDvv8P
X-Authority-Analysis: v=2.4 cv=RJ2+3oi+ c=1 sm=1 tr=0 ts=69d14a31 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=z1kjiwMdVCp9WsdMANAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: ZM2UobOy5t5XweLZuxgjHYzjfWPDvv8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604040165


On Thu, 02 Apr 2026 14:25:45 +0530, Aksh Garg wrote:
> The commit 18ac51ae9df9 ("PCI: cadence: Implement capability search
> using PCI core APIs") assumes all the platforms using Cadence PCIe
> controller support byte and word register accesses. This is not true
> for all platforms (e.g., TI J721E SoC, which only supports dword
> register accesses).
> 
> This causes capability searches via cdns_pcie_find_capability() to fail
> on such platforms.
> 
> [...]

Applied, thanks!

[1/1] PCI: cadence: Use cdns_pcie_read_sz() for byte or word read access
      commit: d9cf7154deed71a4f23e81101571c79cdc77be00

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

