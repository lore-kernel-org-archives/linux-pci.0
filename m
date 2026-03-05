Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD41D54FA
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 05:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772687087; cv=none; b=TQoVcZimwdKMtZH1hOzAJzPTtCvbsW3ZUS0NI7XTPaMe689n7X3XZ+5qzULQM220XFNYwn/MRrkBlcASaTkopusAkpdkA+vTCPgMqtc284r0ise1j4Ib6cDQMx+fYnrFsyhXIqXR29nKaNh+2rMPPcVT3SoseXuzeyzWFzSGr9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772687087; c=relaxed/simple;
	bh=Uwx7ADfJ2/DiZ/2ZeRG1toC4sGY3OwW+dYQWtxKNyHk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f5rVWzY6Ccx7CJ4jXWZykVvEXTDzzUElGaOyDrtNR/OWF4m0a4f2mJZGZK1XQRt6QXlj3LKRzhD4Jc3QSQ0ZoCVkd8m/kr23AgPSIW8MJLqIbSU/QLU/AtvuC/+phBwEbFLNI84ayvVRtkA8T49ljhyGKbzzlI0qYH9H82NuXLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GUz9l6Zr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aYmweed7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GUz9l6Zr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aYmweed7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6254ta7V218449
	for <linux-pci@vger.kernel.org>; Thu, 5 Mar 2026 05:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8gZWE+atvFXpTnhvtKC6bwqtio8Oq9VcX6+G3wxKOzE=; b=GUz9l6ZrA+zhDALY
	8JSldxqfFU0bkaTHrS60zq3bRL4MehWQvLPgWuK1wVwj6VUVQiJqtDgYBFZAk/ov
	D1SvcqLxGhGD8obd5+L7RKEXQ/xr+dgnZlYfgy84ZkLRcfmbF+y3m6sQ8OL7AmaU
	61ya5BUft5ga3117NwxPBZ1gmckzB3/wQ4OtCkPzAhvpBUaLYeHPMSEBBAAGMhLt
	Eeo9HqY9j1n53al2VxTlVVaxo/LzmhgVphrTHHFFzAOWTuslU9OQUFs2qZEwsDzn
	oMUULvsqFfHItiuXZPOqLEsEn0mBX1JpAq0LsthMe/4AAN3lzbSjlHeAr+SZu6ou
	cORXUg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq380r0qb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Mar 2026 05:04:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8298150caddso453472b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 21:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772687084; x=1773291884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gZWE+atvFXpTnhvtKC6bwqtio8Oq9VcX6+G3wxKOzE=;
        b=aYmweed7vtm9Df24LssxMflrX3g80DHuEd701uZ487Dh67jTtiLlYVS2N0/68X3aIT
         1s+3yGslK7ZzaFzN8fp354qbtZAeZrWxreaGmoEyeJLu+m45QHGr5N893nDeBzT+4E0n
         bkbwaVre7mBL0PX2gpxhRhiROHngXdIHejy5Q64gdi2C3Q8FfOV6NQXI6l4FPedOQf/D
         ylPukRRr8R89XPUfQpd2NwVX5WrF/JFt2L1jvYYpTBHRbnr8X957iocdY37JpBVDEJdG
         s6ZXYr2FqmsOY2sC5GuZ8M3ncjjZ56DY7K6O63rPaXqZClUo0PZ9QyAdco//ygzrDErT
         wGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772687084; x=1773291884;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8gZWE+atvFXpTnhvtKC6bwqtio8Oq9VcX6+G3wxKOzE=;
        b=URZAstCBVpOKiduwbIx+MRZLsByUzdinSHZGcEqiDwJdhqdjx+FUYHVvV3mHMmdKvf
         Echop/ZZ49ozmQ7s9N77WW7ByqQnYWm9MuvjWBA2S0AuQubeLSMGA0SbRh0wyJ2TYu4g
         D/ebYdVbTMxpdMi4kUjvkIAR/go+SxtbICWgBQG8RPB2z6vhqGVZGiPhbRNKQpbd/RnK
         uklg6HrpeM9EpFwwpid+Y/YZS7Ik1R+tEEwRvdflmnpfpe0p8rg5e2biQNP13nZZtasJ
         IpxJYzsxsmYFbn00/LVgGsd6miz2C9DCtLsO1OyJm5PNpCbS8oTjpThGSAirDl+35WbJ
         V7lw==
X-Gm-Message-State: AOJu0Yx6wXK1Sj/i9tsGKbDnCBN/mQ8L7JLDlQgpdLbtlbEjiw0Ms8F9
	tvOsMnttkXR9cGr8iG/p9SYTOnbDPS/kCF4CP6biIGrmqTgXqM0Re8qYdDnMk2EddVB/MOg5mPk
	/l4v5d+sylJHkqwy1xanKCnR7tVARRm5AvL2iMyedMtwWbOgpcvdPAczD4rMBU78=
X-Gm-Gg: ATEYQzwcdbNH3JNjnVC7kJVtzB0I3Rn6XDOOfJXiMIQ4LY2bb5KCCg4WzrLrTT8Z88z
	IEjinpWLZQLUTtw6Mk7GcxLOjBeGYX2bCyAT2vKpNIpvgmh/+uB+ANTjHBJ4S+URnh/+/M0FA1h
	p73kMlr9O3A4L92KXccmGkaPIdGUlfEaJ8V5Z9MqKEPFyszg00VL83525r2x4lArjSW+IGviKvS
	RwEj2HtAxDnUOTB/wqn/of8Vb/07AvcIY5M10hztIy1lB7WfiI/D+9klqvOA0GrfiBgAouoVB8f
	ky5039fkmRz+STLprJbv2dFQzfmEXTTu4ZrJiPwC7wFZxvQBASu66MCY71o9G4yGkOfuTRnYUKW
	B1dF07znKFMvZV5F0W247OKg=
X-Received: by 2002:a05:6a00:6f06:b0:829:803e:6798 with SMTP id d2e1a72fcca58-829803e69eemr1749378b3a.56.1772687084084;
        Wed, 04 Mar 2026 21:04:44 -0800 (PST)
X-Received: by 2002:a05:6a00:6f06:b0:829:803e:6798 with SMTP id d2e1a72fcca58-829803e69eemr1749348b3a.56.1772687083551;
        Wed, 04 Mar 2026 21:04:43 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:88da:227d:1b86:2ae4:5dce:122e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829793ae135sm2281477b3a.32.2026.03.04.21.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 21:04:43 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        yoshihiro.shimoda.uh@renesas.com, fancer.lancer@gmail.com,
        Zhiqiang.Hou@nxp.com, gustavo.pimentel@synopsys.com, cassel@kernel.org,
        Aksh Garg <a-garg7@ti.com>
Cc: linux-kernel@vger.kernel.org, s-vadapalli@ti.com, danishanwar@ti.com
In-Reply-To: <20260224083817.916782-1-a-garg7@ti.com>
References: <20260224083817.916782-1-a-garg7@ti.com>
Subject: Re: [PATCH v3 0/2] PCI: dwc: ep: Multi-function endpoint
 configuration fixes
Message-Id: <177268707813.10950.5882308214372501843.b4-ty@kernel.org>
Date: Thu, 05 Mar 2026 10:34:38 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=I5Johdgg c=1 sm=1 tr=0 ts=69a90eed cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=q6dUR7TzBMLVSvV-0VcA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: xEDIvNotwV6h6mgX3spJXdv1k_N7y__z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDAzNiBTYWx0ZWRfX4o72XmQNYklF
 T2O5f6zqiDPQp0pVEhnPVFEcclZA+gDiKrUpvf8o0KNvC7VmVd1nF3JmJmnnxdPK70Z2NRuhEy+
 ouewRCMOUZ9ZQNlzzrHudns0M5FjhUtaBn0Na8+NQzrbJNyHCb5R5Zzwh1URRie/0gg5ILvdrWs
 vIDQva8+2XZgWbYGvNvqLZvDYiYW9x8aHyxIodxpdF4SE6Drrq47GpfYvvwekLRjOWhzRmkQcSM
 OP5M73w5EdlQ8CFCmGwt7aISbIMMqCJ3GJ4lL136Qz7f36UxwGzn46sQG4nZz29DY5VjFgebA3g
 dAppSj6Rrph1hmeABGLip/r+lwh9rsQf2BGPyrMDbu6BkzBLe1YHV7FgnJipEb/ps4fsCxOq3Ep
 AERG0XP56qgn5dsZKK/RUNClJ2GaZV9Ll09LOyg5nRMdCsXGWSA6tDjvR4B6KwiXMTc7/ufoA2T
 JRGrzhsyVMfV+ECYipA==
X-Proofpoint-GUID: xEDIvNotwV6h6mgX3spJXdv1k_N7y__z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050036


On Tue, 24 Feb 2026 14:08:15 +0530, Aksh Garg wrote:
> This series addresses multi-function endpoint configuration issues in
> the DWC PCIe controller driver. The changes enable proper operations
> for physical functions and enhance the multi-function endpoint support.
> 
> This patch series can be seen as an extension of the patch series:
> https://lore.kernel.org/all/20260130115516.515082-1-a-garg7@ti.com/
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: ep: Fix MSI-X configuration to write to correct physical function
      commit: 63ec1248387818f6190569b36d9815699ab5f10e
[2/2] PCI: dwc: ep: Mirror the max link width and speed fields to all functions
      commit: 05d013c151d858cc96baa9aa0d19539237435246

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

