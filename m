Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEA22D792
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 20:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579940; cv=none; b=JV44oljOXWdrI65QkEewsAdq11EAoMUmTInJvAC8SIQAmgklQEd7NpZCoalZJ0IKTwh4L77mZ+Un5GAHIlD+x/c/Ym9ZT4k/K9neIACfRNf5Wuf5IWx5yd8DoC9ElELxkxUnwjwobFdgnrAUSmIXkwGSRLCFylpVgYCmHJIZULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579940; c=relaxed/simple;
	bh=jzqU0r1iXDyszfjki8AsxC67ASPO/PvjTdiLkSByPFU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HfdhxkhCfy08ljO0MAV77h9e64iF3bx2e4bv5zZhke0z/UnePqubczsfJ/wD2PS8obP3Q5kWX+7H3AonevH2gge2pmupUy9Njihk3A8sftI6YxjKj3jZM3npGSLqlO+CDLGNQH9Enn73gyd9omQv4ymwueVzUmgAK1G0QXVVwl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HQo+XzrX; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HQo+XzrX"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UDAsa74182001
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 13:12:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=sInQ2EyrWhVx820/ik
	KwwXHwtxBsZT0OSVOIPwT0byA=; b=HQo+XzrXlbX8/6iOvE/YN8Zko6ss3hysN6
	Y/mWtEnP3GhvwA1IdF9zC5EjvLkwn6Qq/X1nZrrguds2GE/W7pFtwQCZsUdQyp3o
	xTa25oHLS8pkDwIwDGAh0bTTzSshMz1oBJ3ga44sHPx9fvYpX8feEZBwYXQmZqm8
	mpZU3RLcFlnIFbHloCMyIcTIXhFn2siUBzsLxBAjdp5erWA3iDBDhUmyG6X5oJfa
	08UYYL2b+JGwMccKN1QFNK6OMFYHdQfmhLiQelwMK0RjWNEs7hehhVBA3KArfAk/
	3luUPzgI4WqaG3tOKXO1yBMTAYuEmBnaRTfcCP4jXXYOC7yVqViQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4drsn3ctd9-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2026 13:12:18 -0700 (PDT)
Received: from twshared98058.15.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 30 Apr 2026 20:12:15 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id A7F5C1B9B4FB6; Thu, 30 Apr 2026 13:07:04 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>,
        Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v2 0/2] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Thu, 30 Apr 2026 13:06:55 -0700
Message-ID: <20260430200704.352228-1-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIwOCBTYWx0ZWRfX64gPoCTIYNtE
 UpgNAxIADXLKxdTFdRoVbeFiw1mrxdyOyzU557bw1CQGiNwjj7Eavy/HKRLXCtVmnFvRLE0w4SW
 SLZ1wtopENn1EaB6b2gcKZMAaNvjs/gODvm0C9NgBrLMLHoVfD1XJOs27jZnhE0uCarfRzOoy8g
 8xSHB1H++bzXahUcbpWPa/TyMeS38Zz2zkezAh0t9QC/gQU5tregWyMq/JStm+t+Lx7ZV6gI8tt
 svi9Nan4FDy2f8L4h0jqxT0h5VDyReG5ba6XUOhrr5sPYObC34JATcww53tjbB0/o/Ko72ghIdW
 8Lbja32o6SikRmGQuDmXILuoyntMLfuC4aHChtV6xfTHzk+4sVpaQhwDp6Y0JQzRWm9r5efCx3t
 MkQtpLRXNJ7PZjHpGzU/QozykKFx3jsU0AOWL8b98r/+b/jUXj9GQO0Yfu0AmHNMMc/ywoTKNfB
 uQcWRnthAVq0th9JU5A==
X-Authority-Analysis: v=2.4 cv=NoDhtcdJ c=1 sm=1 tr=0 ts=69f3b7a2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=NbcebPYJtCDKC3IOK8sA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: uQNYinGjMTMSWjqixtsM7rQOoETtHfGL
X-Proofpoint-ORIG-GUID: uQNYinGjMTMSWjqixtsM7rQOoETtHfGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_05,2026-04-30_02,2025-10-01_01

This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
export path, allowing importing drivers (e.g. mlx5) to use the exporter's
steering tag when performing peer-to-peer DMA into a VFIO-owned device.

Changes since v1:
  - VFIO_DEVICE_FEATURE_DMA_BUF is now unchanged =E2=80=94 dma_ranges[],
    __counted_by(nr_ranges), and flags=3D=3D0 are all preserved
  - Added a new VFIO_DEVICE_FEATURE_DMA_BUF_TPH (feature 13) as a separat=
e
    SET ioctl that takes a dmabuf fd, validates it belongs to this vfio
    device, and stores the steering tag + processing hint under memory_lo=
ck
  - Kept the dma_buf_ops.get_tph callback as the general exporter-side
    interface for importing drivers

Patch 1 adds the dma-buf get_tph callback and the new vfio uAPI.
Patch 2 wires up the mlx5 RDMA driver as a consumer.

Previous links:
https://lore.kernel.org/linux-pci/20260324234615.3731237-1-zhipingz@meta.=
com/
https://lore.kernel.org/dri-devel/20260420183920.3626389-1-zhipingz@meta.=
com/

Zhiping Zhang (2):
  vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/infiniband/hw/mlx5/mr.c                   |  38 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c  |  25 +++--
 drivers/vfio/pci/vfio_pci_core.c                  |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c                |  65 ++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h                  |  11 ++
 include/linux/dma-buf.h                           |  17 +++
 include/linux/mlx5/driver.h                       |   7 ++
 include/uapi/linux/vfio.h                         |  22 ++++
 8 files changed, 180 insertions(+), 8 deletions(-)

--
2.47.1
