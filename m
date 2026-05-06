Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200CF43D514
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778067640; cv=none; b=KbsC1luPmVkt3L5nnASPbQLSyFWNzPX4cMmVzklfcd0ITGnyDpMBrQ5TsYzftx5QXJevayWnYny/hqCzBErQKSoJewXxtfZ6rYfcMXK2fN1D6K30jUTM4BeSH3+1CzKqYk7bxKIy/l1gB8YyQ5QCUdCx/YOKxlC5OhNjQRBbjEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778067640; c=relaxed/simple;
	bh=YwHnAea+ZNdBKSZ+FdKL95GqYoOJftrvBMYNNriODHk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eZXiV0wERrW+mmqXh0UrhrkL3SFlWJl+wl41jR/zAlrlyWRPJHg6GlJeVlTDa80KwC1GlU8zEqtCiRsmHpJA2BjrZ1anRa8vGCEiY3lWNAJVXGrUkgDAtfG/91BSeA+EaTtKzsz7CcgoTEL024CmT9O8WYWP0AlUMWyQ8ySg7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDkpRUnK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LMl44Tea; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDkpRUnK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LMl44Tea"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646BVe0o2581348
	for <linux-pci@vger.kernel.org>; Wed, 6 May 2026 11:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0oPLdXXouDVkhJv0oKpMf1eGEE226oo0STDXOOYuHJQ=; b=pDkpRUnKxfGFLMT5
	IN9zzXR7jhmgMF1GVsF3zijISdON48bJVwWva/q0u0GihR5r1vz1O+2J7MsBo43P
	cqZVAU11HbGoawH34omEc3A++vGylnf9Kb25BsYi1w1dTWZov8Srucv3oMR5sb1W
	LNoWgFdQKjKrekMnMgjHRT4egouTlr60rtxBzR0T1v1RmzC2BIdrbd8VCCGLyVK6
	AjRB8+3XLAFpEGJcSCzIxHBaWmL/MvWYb39ydI1kDGjODtj1ktEE96R6GOmnFQsI
	w66NyMy9WFDMvwwXf1tsubzcjgHn2DVJLyq8nMJRsft5JWnYUG6sBbWtlI6wZ+sm
	mALumA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyyvw1a9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 11:40:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so468033a12.0
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778067638; x=1778672438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oPLdXXouDVkhJv0oKpMf1eGEE226oo0STDXOOYuHJQ=;
        b=LMl44TeahkBn+WjXngUJ58wv4oSrnu1VcuMocRcRc13WASTiT31qmIRUW7bdhHJjdy
         U2lNJnZc8OpIbVuaef6IpX932IWqlKpSCTn+Bd1eXA5BEm7JU9s610gumM+pX++6n8JA
         CoP+Q9hbpksrGCxCp6wjuSwRBY7Z5bxiX2ubQpdzCB4JJ0815A+XGz/QHFaXAPqSytOJ
         B9y7qc00cHFaz7Qcldv92ti30nQdi1BTwugQjgR1sWnA52Lxg/ZOf9lfnVi8dkZoDRWw
         CQzaGbja0m7do+c5nMZUR4nSh6wrtowDjuCoSpSoN/aLIJN/PAEPs2dOlLijSq7NvVJ5
         ti1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778067638; x=1778672438;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0oPLdXXouDVkhJv0oKpMf1eGEE226oo0STDXOOYuHJQ=;
        b=VLrTr4y/X7YshyrkUPEkA749+gQUCNnqroNfG1VqcKfEkKaG3aTnMDBdbU8RDWvgSX
         O/xc0Z6pv5xhmsbphENsQAy0BQ0VLDEjoOPuSYbr0zrND1wFI4xurDolrCmdVwzCzuLy
         R6nKcJ7hz5OOfE+0evb649GUP3IUygJtGEYC53QRBcD23sVB9n+PNbsOPgN+G31+POTV
         e4tnvHSEExGAD1EmoZooP4De2QVXyWB+ti6ZS7OrvUnmBduaVsLRsLdJOysjOfHW3NrT
         ra8XyP0498z5zmh6klFZ6md6qjTjut+Hr9ekNLwkeEn3qJhpuf6KQdIl4dDLaeUK16S+
         ialw==
X-Gm-Message-State: AOJu0YwhUzJF9TvDjdY6m6iUqUAgytGkvQHd74pfBDhxcxTOPtlPj+Tf
	R3IrMVt85XwCFl10N2Tj+qLmqkJ1QjS44TcPRTkD3Yk9VnD1NAMwJalYrtNAPCQi8l/YBaInks2
	llS7MR+eVtois4r0Qs0I/YpXdo9J0JWKRZJhBwiF9qmjpi6nBQrJ4Z3VHzt1/xAw=
X-Gm-Gg: AeBDietAAnSYKVfINi5ysyAaNAgjKJAP3rJdPCQzSjyp1FcA7bEi7ZFzUpJoWbsgSb3
	Hx3TeWZ136mR9JaZPyvTdW0Z5SyAmxdJoQEAFq929O8WX8F06bRur6ZWgN73VB/nzfkSWrzbjnm
	cWnpnxj9CLBOBeJ4FL+W/6K0WgEdqDL7UMeJNHCfE635qHXojJRoxgmNdufrizrfhz6sC4Qfw4R
	ORrQFwD1wn1kbFDQVhhF3yGBehQCfNwRKCU6q1DH63rhORptDX6J7P2zhFEVjDFo/CqCgrjWgi8
	PDaALaFMXN6/bX59MNI/55uc3u5p6h/FPlqCUmSrFVb5A3QPmeqzwZ5jJFwkfs10SW2EzVzLeci
	XzPVckbVraWS3M6nkfJ/88ojin2U7UHE=
X-Received: by 2002:a05:6a20:3d85:b0:35d:cc9a:8bc1 with SMTP id adf61e73a8af0-3aa5a315ec9mr2589470637.27.1778067636437;
        Wed, 06 May 2026 04:40:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d85:b0:35d:cc9a:8bc1 with SMTP id adf61e73a8af0-3aa5a315ec9mr2589412637.27.1778067635781;
        Wed, 06 May 2026 04:40:35 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.67.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm7058783b3a.16.2026.05.06.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 04:40:35 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260319090844.444987-1-hongxing.zhu@nxp.com>
References: <20260319090844.444987-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v2] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN
 handling
Message-Id: <177806763016.14331.14072129675795042605.b4-ty@b4>
Date: Wed, 06 May 2026 17:10:30 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=YYCNIQRf c=1 sm=1 tr=0 ts=69fb28b6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=SQtj7D3ryojUavkWoQJ0Rg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=VlnV4lHhP5wV_tSmghEA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDExNCBTYWx0ZWRfXxX+oJqQdEitE
 swIu3jP7dUN77SFWaTvO0NWakKfgeBj3hpKlBC7yFWRr70wIJIAMFAwpvHo++nXqP2qw8xj0lNA
 //b37FBLkvrfNqxzYGWYqBPeJrzxiP3GWwhhde0bBR4l4klw2lji6HE/xMYwViIaWStK5iImZqD
 WT1GYXS5PBG46gUTYJKJOSo4thvdo1DQTiPHBC1T74Nuefx/3K4lxH507KzoJiiwBCKW1R685nF
 YSqrU5BFg4Q83bAdFSLnQFbKy7w8JCU7MTLlQLvs4fP+Vp6XLq279MvCBfG829NCUfs8wHgl27b
 M1XqAy+47FwL1iQAxsnsqbfVShNS89/DGJP0nhxkhQVCthR3yoGG1sPmUudALkxv7pKPQHZ1KWD
 o8pq/T0d/EZJF3x2fEoAAHdABKIvbqjiTzt4DZYeXiRR7yFHqSYMaS46cfvYrgO+kVM/rFTa4NJ
 kG5ghc9YViy+VKwJ/AQ==
X-Proofpoint-ORIG-GUID: Mj8eBSY9_SSiceBkVgz7uGyvwaDBkkum
X-Proofpoint-GUID: Mj8eBSY9_SSiceBkVgz7uGyvwaDBkkum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060114


On Thu, 19 Mar 2026 17:08:44 +0800, Richard Zhu wrote:
> The IMX6SX_GPR12_PCIE_TEST_POWERDOWN bit does not control the PCIe
> reference clock on i.MX6SX. Instead, it is part of i.MX6SX PCIe core
> reset sequence.
> 
> Move the IMX6SX_GPR12_PCIE_TEST_POWERDOWN assertion/deassertion into
> the core reset functions to properly reflect its purpose. Remove the
> .enable_ref_clk callback for i.MX6SX since it was incorrectly
> manipulating this bit.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Fix IMX6SX_GPR12_PCIE_TEST_POWERDOWN handling
      commit: 5a8c573879379eed867d279f7437dd4e3aebbb7f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

