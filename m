Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224635838B
	for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776710682; cv=none; b=p3PtrnqZjFLVywL9lhodHNC/j8munns39/8m2DE81dS9m81FJX/BOPg028BXTyuBgcRpuRJG+n6ShroCu8pavAXxbPWGChWlwn/l4yLwGrmNO+LujstL9PUnp/A7jd0ITOM/XY4XVYGzjlNAjMFcc4GvwN23hIVeDmW+oJ1K16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776710682; c=relaxed/simple;
	bh=r50orGBhNi8QT5mU3Y2eQHTwkyereZyiuejiji9RbTA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pEURk48dHErK6h2wxCLN46k46HRDIJaDelwduY9pbNuaCwqZLp6R0+Mir6/TdxWQ2sLSdoTdf/sgvd1jTc0tBviTJD9hvREW6qoQUv4i3WQyUmeC18e/yRMZTTKcOYQ77gl2PQ0vdYPRdzYtgXzLvdfRiHCOnoyNGMfd59OTCqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lmTLwZTJ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lmTLwZTJ"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K2A6Lp2516512
	for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 11:44:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=v1B/weXcqQ1lWLTVVV
	0vhTvXO65+/046zoF1VJqryV4=; b=lmTLwZTJjAs6lgOoHWNSrsl3aPUh3AG54U
	dTO4XGquprYR6q/ph4MhY0BSFDVGQkVWURiqlnvll08oow6VhceG+As1lhSU+j3D
	04nQCEfN2Nd+5ZnNAs//DCJFMIomdywVDMzZXujLuNBlYZM5uOMlWNUXrobAz4H5
	ImqMUODQ8YCv7+toj7lYSfAkqLdwgwbD50VP/SZEGkhOImzlaApHtJ7/TUaHSW2J
	RKZ22WLJniIdHy1TFWxJvzWcEMltloQqiGQB3AGpaigUKdQsxWE61Gt2uX+b6h5i
	95+fUbdAIH+J+wpTcNY4hr52T10FTqvgaZJLe7c/unPp5d7+3WNQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dm58ybaj7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 20 Apr 2026 11:44:40 -0700 (PDT)
Received: from twshared22734.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Mon, 20 Apr 2026 18:44:39 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 7C0B6113AA911; Mon, 20 Apr 2026 11:39:20 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Stanislav Fomichev <sdf@meta.com>, Keith Busch <kbusch@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai
 Hadas <yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v1 0/2] Retrieve TPH from dma-buf for PCIe P2P memory access
Date: Mon, 20 Apr 2026 11:39:14 -0700
Message-ID: <20260420183920.3626389-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=AvHeGu9P c=1 sm=1 tr=0 ts=69e67418 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=XtSdSgJ7MZthVsN6br0A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: QdfBhvHh-YXuNzUokTTnjy7SCYVCLKiy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDE4MiBTYWx0ZWRfX/YC3Z/aeYnic
 c1GOp8rl3b1F5ljT+YFhmGni53Qe3/GZXtrVOEqrNWIXVWM+T9PayfLTRZN2GSs/2z1Tyj6aRl8
 57g7QgmgHQqeJDxBazDQFmMBd1UDEL7l4knSeyC1+bqZFQ/wC1dN3My0K6w38W+SIlo8ncRpWBG
 Z1KM8JqzDz4b1jznPXdr+Udzir5dN+lvcvdpUwTaDJQ7HtzolXMLeKnjweltDg2YCfToyDKnmrr
 SOpOzb7uIGc/8QQaEZB+Jr0IsFJAhDTXgWJwfC0jlznyGYwxja9SgekZhdQqE6pOcgdauLOMTi2
 hjlgrlIrQV5aMFM5QcdoYn3WC2BgFOzsQ7QPHrCVzQnJzaf/2EPm5owSptTQwYWonhrEXY2w6Vo
 zo47NFSvSk4iq2rR9UzadCNwCbmFFHJLOnybt0Omof/1il36OGzQ/+RX+OWRxns8SCTDitn4WTV
 S4pka8CRMR1DCAYJjaw==
X-Proofpoint-ORIG-GUID: QdfBhvHh-YXuNzUokTTnjy7SCYVCLKiy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_03,2026-04-20_02,2025-10-01_01

Currently, TPH steering tags are derived for CPUs via ACPI. This series
extends the VFIO dma-buf path so a vfio-based accelerator can attach TPH
metadata to an exported dma-buf, and lets mlx5 consume that metadata
when registering a dma-buf MR for PCIe peer-to-peer access.

Patch 1 adds a dma-buf callback to retrieve raw TPH metadata and updates
VFIO_DEVICE_FEATURE_DMA_BUF to carry the optional steering tag and
processing hint in one extra trailing entries[] object without changing
the base uAPI layout. Patch 2 consumes the exported TPH metadata in mlx5
and converts the raw steering tag into an mlx5 steering-tag index.

Previous RFC link:
https://lore.kernel.org/linux-pci/20260324234615.3731237-1-zhipingz@meta.=
com/T/#u

Zhiping Zhang (2):
  vfio: add callback to get tph info for dma-buf
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/infiniband/hw/mlx5/mr.c               | 38 ++++++++++++
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 25 +++++---
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 62 ++++++++++++++-----
 include/linux/dma-buf.h                       | 17 +++++
 include/linux/mlx5/driver.h                   |  7 +++
 include/uapi/linux/vfio.h                     | 28 +++++++--
 6 files changed, 151 insertions(+), 26 deletions(-)

--=20
2.52.0

