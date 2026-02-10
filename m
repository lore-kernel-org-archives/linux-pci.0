Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50A23EA87
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 19:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752857; cv=none; b=dXQ3bDjQfzDWrYycKtOpgDtcNWjFSznipHXHqTxI81mRbCuMu3atYzUsmEYU3NItx8GfgN+G0GSd7aF2rsa5AxdHqyiO9rAqBv0lo854cgtAx9qlIQAtIqFQ37yotnmv0CgTj24LUZlN1iaRpKrq8/XAjUhQ+3sFK276SNSMpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752857; c=relaxed/simple;
	bh=EfVHrbdF8/yG09IBQ20HHyfnxAzay8Gf5YSnWq6tV7k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c5am0qTPTQBJV1X8TZUMyrK+xNB9CJFubVL/tFM4u3Dxdzjm7gjAVqZ5/l9uOPcWRjXYCNLW5gzsxRxltlgKP7Vk3zkwzQwVRS0q4YoRNP5G/rqoDe/vEFB4zr/BjV5WdLcTFaFO1l/X3irWvIOyfLsRSljwYoyRyiz9PMd2aR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DO9mt+Uy; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DO9mt+Uy"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AH2Jvi3309800
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 11:47:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=EfVHrbdF8/yG09IBQ2
	0HHyfnxAzay8Gf5YSnWq6tV7k=; b=DO9mt+Uy0AavnJKPFVpdQFeFx7wmTdy+q4
	9Zd4SKKQmT5Vxv/2WmpU1HS840cw6ba7ngN9cPfRzgPKdITOFHsdorYD8x6x+E4m
	1JXQPhMDSMeQz1TiJo6rLGQBRGPcwf2G6EZvZ/rF8Mb470XJw1z4qXOf3WytmD8o
	2v6WbvmjIRztxj9f2688BRhkKu6wbvK91YJAxi/+SvtOl9qZ9RloccAoR5iNuFfz
	OqmYtB9XrvDMETixsQRtZAvOAw0mIGENvnNHToGezVLrFU6uZx/fZg4Xiu1uXGYY
	9vhVznJJFygEAulULtYOW5eOVYweFnOQor9hPvNVDgKyDc3wOxIQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c88qnjd9p-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 10 Feb 2026 11:47:35 -0800 (PST)
Received: from twshared41309.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 10 Feb 2026 19:47:34 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id DCAA7102666AF; Tue, 10 Feb 2026 11:40:15 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>,
        Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC 0/2] Retrieve tph from dmabuf for PCIe P2P memory access
Date: Tue, 10 Feb 2026 11:39:53 -0800
Message-ID: <20260210194014.2147481-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE2MyBTYWx0ZWRfX6MWXPWu8HDSC
 NtxV2/CFMdbaPQPhdNA2lMnjzpvjyL+njPH3BjXxyt1Cm5GA212kHWijIXJPOD3dhaF5UhLQHhD
 IjYeTXDpDoe13U0j6Rc+20i6ftQLmcSUeczBPVvPo1RlBHqcl0oFWFleGRUT7r0XoE0Vgy/S6BI
 uL1BW/f6rKmPyj1whkAP2KawgHzN9a5eivUmva5s76Z9AsWLficwNGs1gjusUd8671w8lQXmV7l
 BRRqJGORn2OMXB/kAN9quPeJnfn/UvwBiSi+4VRdKlZ/0dd3wWBm/AC7/zm0AeOukl1w2YpYZtY
 QXz45v5Enz/XR6Wru2zgFTovtaHPRAfZWo5ZimZgciin9bNA5u5W2/LaVXPJIu1bbfrjfLqKjns
 Tc87HDNBIUyEZlr3Gl8OIAofQlZ3F/WVhFlMe0Mlg3Y4zQ3I3CQHOc6ULl1q4+KY5YXg9mmQrvd
 9YApwPWgl121KH6x55A==
X-Authority-Analysis: v=2.4 cv=POkCOPqC c=1 sm=1 tr=0 ts=698b8b57 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VabnemYjAAAA:8 a=yWaUcmrBNUFKcz5DFYsA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: dk0XhbpL3MjQDloj1HHkXIbe66t_DotB
X-Proofpoint-GUID: dk0XhbpL3MjQDloj1HHkXIbe66t_DotB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01

Currently, the steering tag can be used for a CPU on the motherboard; the
ACPI check is in place to query and obtain the supported tph settings. He=
re
we intend to use the tph info to improve RDMA NIC memory access on a vfio=
-based
accelerator device via PCIe peer-to-peer. When an applicantion register a
RDMA memory region with DMABUF for the RDMA NIC to access the device memo=
ry,
the tph associated with the memory region can be retrieved and used to se=
t the
steering tag / process hint (ph). The tph contains additional instruction=
s
or hints to the GPU or accelerator device for advanced memory operations,
such as, read cache selection.

Note this RFC is for the discussion on the direction and is not intended =
to be
a complete implementation. Once the direction is agreed on, we will work =
on the
implementation or a real patch set.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

[RFC 1/2] Vfio: add callback to get tph info for dmabuf
[RFC 2/2] RMDA MLX5: get tph for p2p access when registering dmabuf
