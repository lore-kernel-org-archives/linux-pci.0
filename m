Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3CD495509
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004857; cv=none; b=biEmp0LlcQwQM36neDuJ1ualfsqd6xOKr9ys29+YNk4uBxYxR4RjMCHsGmrATHlY8XrSYh9w6TZSM87+g0zJ9mZYwVYbOcYNEssfNOW9oDrmf4E/OcdnbbDCXUsNR9utGaFMU/WACMu8OZSYVjmuYwLNuUXIpeyV2YHlsrSstuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004857; c=relaxed/simple;
	bh=q0fBbqC1lbnaPueddtSSEPtxsEX6pzxQUNVbldVUSpE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cXosDMTojVWs+/AMIPRgCf7rpQeGr8C/ltRPvq3P93G5+l1V8/dEyU/k4r5VhXHqP1O9ZQGMUxJniYJAi/NUH7sBx8M7hP20tEdcVvFls1EOSkVlliT914gRRZuobF4KL/EXFDGTTy2JHltqTF31bQxh4XfFCBDG3x5SpFAiVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ffXlKtRH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JiqbY30i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ffXlKtRH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JiqbY30i"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L9paOr2452383
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 14:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yP2VL2kUHFu1gvmMP6xNY6PiN0/DSUVyM5Nuo31w/QI=; b=ffXlKtRHGH4anQ9y
	iCRpRJMfipwQDgx0gVZvafaPlMzAB68wubTBuuTbv2+oVQbWfuUQDmX+WnB6AG3G
	NIGmkzmDN0i85/+3g4k5CCdkzOMoXc7vJHHOPtmeu6DxlLdFdB3qTQVaUc9mbxje
	h4pEzvkAHWP3hWd+v6G6sBtRkspPkUTr3wcqGPAES7dH3nRpNynvgaanHsCuTbph
	LlRIHPid5Qe0RH8ei0Gm8m2fMu0YNWARL1s0bU8UZ0C/3e7bORCpQowvqfgxYyFS
	57tZ2On5YXyv7UCffaaxiUX5N+08ZQzbhKD9Qp0Ii4TQwXZD22L9OHPGo+Vv8Aap
	B3M6Ow==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btvhqgrv2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 14:14:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a77040ede0so16160445ad.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Jan 2026 06:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769004853; x=1769609653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP2VL2kUHFu1gvmMP6xNY6PiN0/DSUVyM5Nuo31w/QI=;
        b=JiqbY30iTxVtzzSYfe6N4IFIG2348X2f/4EvpZBx5kE11fuwn/px6kEAx42WBlKzG7
         8I6HDLlUKxcpcJjA0QhvjAxBWcwqtB5FtcXgUfPo4tGKZdKSSYE8gSlQxasuJloVK33k
         TTtkjzh2pqR2UxY0znQNQi3CeLlZW73bOFxiiT8bLHNEeObmLuh9iDZAJeF/Dehwn3+z
         AqoPJ5ozRSHRAAyX/v6VDXPzNC5BQxZxzhYRsdfdOOlRyQDPH3HoXzngX7DOeJPPXuYv
         p+aOCgZQcptjoNlzcjlf+IJtOwQlFKiwLKCg8xFjysdu2HMfgpdnGE47q6O6Q9N9ZCBF
         Z5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769004853; x=1769609653;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yP2VL2kUHFu1gvmMP6xNY6PiN0/DSUVyM5Nuo31w/QI=;
        b=jTECG8Czup+pDkTHpKYo2b3IKZ4tAlW/p3Y2gn7WMwuvhnnq3KKNcAGc2iy1kvgSIS
         ELDSRB3edYqDUM8OMC/J+J/ks7grboSfrLJgXzH+sDZP8cSiqGN467gj8dH4XZpeiycV
         Zmwe7ZC85Bm5sYS5w8Qi5g9lOPJmO/Rz3i1Wo+P69R0+PdaJ144nlWHwM+3wYzmdSkJH
         ZzP8mIDg46PfH7f6K9jEwvcQp45nbUPz6+m1yJhwoijt8uarwygCggybOfysrA6Myx9o
         xlv+iWWka5+ze6DVXAIFE4xtLnuzJru9LESoaF02CqRic2nIpvyQ19VOmsxeci4CTnX+
         e3Dw==
X-Gm-Message-State: AOJu0YxBlZBq0yk2x6LvrT9hWq5sE9wieNwRo7TuOoPTgMH4GVK6Frnm
	4crr/ys2ErfT+8dDw27TKNodBL9ed48BBclLPi6FXpjJAmO/HB2buHdlya2+tu8aKwCSq/Mxlp+
	vqjpIQ+NM9t3PBvWaGgqT0HoaciX99xoUFRYnbR4QRvMYIPSxmFcsoAnFZS4OGmVFsfp6mp8=
X-Gm-Gg: AZuq6aIpq1Ok01RgUC9KL94s3Tto+OFDK6/iYu9Lz/EmJod7zNh6Hrbe35zJ68VY7gM
	bklwaMlTjKwIKlK6Y0YKF6OJiCyJZ5rkwrqHWasPINWpL0uUhaN+blrF0e2H4zoNN6rNCnM7ptW
	C0XFddlDy9iHOsuYaM2qscJumpHowukUUeEo234JKGDjOPuJpVUHAM5oMAgPWs30hXvyW62hC1k
	epEO4Q15PJe5x9Znfe9rqdcGcWABN5mGMzFXP7BNM5BgijZB0u4utT0W37mpoftTTSQw0Cz502R
	Ndc/1wzFt2XVrcemuz2yvXwuRmt1JbUq/MZNf6VAwpt9XcB3QRdnsDx53xm5iVwviyr6TX9lmik
	YwEPY3cpA
X-Received: by 2002:a17:903:41d2:b0:2a1:243:94a8 with SMTP id d9443c01a7336-2a76b1693ddmr49893845ad.49.1769004853145;
        Wed, 21 Jan 2026 06:14:13 -0800 (PST)
X-Received: by 2002:a17:903:41d2:b0:2a1:243:94a8 with SMTP id d9443c01a7336-2a76b1693ddmr49893445ad.49.1769004852488;
        Wed, 21 Jan 2026 06:14:12 -0800 (PST)
Received: from [192.168.1.102] ([120.56.201.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a76cd5080dsm50151505ad.100.2026.01.21.06.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:14:12 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        lpieralisi@kernel.org, vidyas@nvidia.com,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260108062747.1870669-1-mmaddireddy@nvidia.com>
References: <20260108062747.1870669-1-mmaddireddy@nvidia.com>
Subject: Re: [PATCH 1/1] PCI: endpoint: Fix swapped parameters in
 primary/secondary unlink callbacks
Message-Id: <176900484983.343708.11597976996714445231.b4-ty@kernel.org>
Date: Wed, 21 Jan 2026 19:44:09 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDExOCBTYWx0ZWRfX/qwLQ/iXyP9k
 nzu0q90zphTbXSet19rgQKhHDqaGr/E3/G1j9L7U2clNiyH8pulN06UobGFUep/zXNk+YRWTsgH
 d2vtPgkOl2m7i5Ti+mZ2GUMV+caqMXEd7eB9OUcuicHLoLsXIeb5KzVb3vobmEuWUWzhPTlBCA4
 BHqNOv1cwuotyS3dwsZpvRfI88ZeDKSj8+hTWqUvmtj5yVM9l2KjQXvLCxsviQrgK7DQZNwMhce
 Jp0ByCMvx9YDjCuPDm1DGqaeynt19UuNeXAEEkVT3OFyDu+0JvIivBNE4cSAha1q5oWnWXGWt90
 LrRDZkt+6dTk/HKu9i6Y+gSWKElC7duwSDVbGGVgNWzEyzi4Mi0piWq3HU0e8NHJYCdwG6qDhRL
 K6B3ofhC1+xQJghY8kJLAxl/1NollyCdABPeQ+yi1/Q9qlPUygV1xgmkLchYKIZ/TRq3lEVlERl
 rEbMdYU3wnl3oZMeXVw==
X-Authority-Analysis: v=2.4 cv=S5bUAYsP c=1 sm=1 tr=0 ts=6970df36 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=o3iIPP6MwdQAWb28Nvg98Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QpXDbZOZQpz-AI9VGLgA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: zDA0859lVL4KNMeVyGKHNbunvAEUDvf2
X-Proofpoint-GUID: zDA0859lVL4KNMeVyGKHNbunvAEUDvf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_02,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210118


On Thu, 08 Jan 2026 11:57:47 +0530, Manikanta Maddireddy wrote:
> When using the primary/secondary EPC linking method via configfs, unlinking
> the symlink causes a kernel crash with NULL pointer dereference. The crash
> occurs in pci_epf_unbind() with a corrupted pointer (e.g., 0x0000000300000857),
> and WARN_ON_ONCE(epc_group->start) triggers even when the EPC was properly
> stopped before unlinking.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1774 at drivers/pci/endpoint/pci-ep-cfs.c:143 pci_primary_epc_epf_unlink+0x6c/0x74
> CPU: 1 PID: 1774 Comm: unlink Tainted:
> Hardware name: NVIDIA Jetson
> pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> pc : pci_primary_epc_epf_unlink+0x6c/0x74
> lr : configfs_unlink+0xe0/0x208
> sp : ffff8000854fbcc0
> x29: ffff8000854fbcc0 x28: ffff00008fd0ddc0 x27: 0000000000000000
> x26: 0000000000000000 x25: ffff00008b756220 x24: ffffc46154d53248
> x23: ffff000095368088 x22: ffffc461568bdd18 x21: ffff00008afb3f00
> x20: ffff00008068ec00 x19: ffff000095368088 x18: 0000000000000000
> x17: 0000000000000000 x16: ffffc46153e6f32c x15: 0000000000000000
> x14: 0000000000000000 x13: ffff00008eec2043 x12: ffff8000854fbc64
> x11: 00000007ec988e71 x10: 0000000000000002 x9 : 0000000000000007
> x8 : ffff0000824c3540 x7 : e0fee0d0d0d0a0b5 x6 : 0000000000000002
> x5 : 0000000000000064 x4 : 0000000200000000 x3 : 0000000200000000
> x2 : ffffc46153e6f32c x1 : ffff000088009c00 x0 : 0000000000000073
> Call trace:
>  pci_primary_epc_epf_unlink+0x6c/0x74
>  configfs_unlink+0xe0/0x208
>  vfs_unlink+0x120/0x29c
>  do_unlinkat+0x25c/0x2c4
>  __arm64_sys_unlinkat+0x3c/0x90
>  invoke_syscall+0x48/0x134
>  el0_svc_common.constprop.0+0xd0/0xf0
>  do_el0_svc+0x1c/0x30
>  el0t_64_sync_handler+0x130/0x13c
>  el0t_64_sync+0x194/0x198
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: Fix swapped parameters in primary/secondary unlink callbacks
      commit: 8201145aca3d188485a5810baf6504618e5df550

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

