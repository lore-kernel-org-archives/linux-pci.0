Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0A33F584
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154096; cv=none; b=Pb9NiKy0BE8v/L1quzj1jdL4HZGaiPBU9EkJUFlG/RU+JspQME0LuBYn4+6WhjfwCriMXOkxpMN2gfy1l1CPdRQiog5R0hGyDdo37MwdtRbb24eZkKMJSJZwEmjybgVclKCe8GVl9KHwm0PDA3cfaItHTTh3f8IosTojYSSF1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154096; c=relaxed/simple;
	bh=VGl0XaPzmHl2YbP3zrUwWGv0rlhRWtM0oybix8dr6uM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q4CcgKYLxRwu2vAOWdB1z5vUdTq4MmYfAnU4T7aPk7KGwzZYviwWOXSabTaXT6AitUcMhQGZyIHHqroBozTg7aaa0LrR3fHAr/qDuR4yt1DwaWo1mTDBTIGUrrPZDvX/bZTL6FCEF+ZQ1Ak+TAd9hG15zwglGjhSPBQrxuy8kU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Sz38cR9L; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Sz38cR9L"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MIkACB2452333
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 11:48:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=MZzhHnQcwJtjC89UR3
	NcW8PlYZi6GaldhOMhJQAYFyc=; b=Sz38cR9LE3kGKsUbvTPAZkQdrjsEGvvYhz
	H0stnhx4vxp/2YCiForyT6MOcSN47JVB829lBwbjl2jVZnKAg9THKzOjXxHKFacO
	8XIa2sBfScAjNPIMZJTPa9lsxKRB92ewm91bzEuSbbkwBJk8i4i57knD7mnj/x9w
	lyP1nF608J7jR9Xevblft8z1thjroy/hjm4ZAjZilf1FaRdLq17EidhgVwITktAf
	h3knsbU206ti2Py11nw76XqUsTyM0qZJxjFfuxh9dbXCXddCn13TqdxwzpVMc7LF
	ZnvdnEQ6U8do65ahgwF/iinuja3jrhELZ+vZ2VjkEDsxYQfdTMPA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4excejh1yh-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 11:48:14 -0700 (PDT)
Received: from twshared3243.34.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 22 Jun 2026 18:48:10 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 0624B3FB8E2CC; Mon, 22 Jun 2026 11:42:11 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael
 Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson
	<alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v9 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Mon, 22 Jun 2026 11:41:33 -0700
Message-ID: <20260622184211.2229399-1-zhipingz@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4MiBTYWx0ZWRfX7tp5UiPQh6VA
 8u0pwbwMhaT0Fr4fI+4+ZA9uNiDNZ65e16f5i4aM3kFSq+tNR0oosAI5bJPMy5Dy4Ayzr3jVx1t
 Mqq8CGm7KP5/jXFuYyqdyEpey72dIL7grPcExx2iM26thXbLRlEgB7t7feKwdEvKrLpWEsE7ukU
 Bid1A1dLInzF0FyFMTAEMjvd44x4h3tjm0f3Ats9rBBxSusIRiplhAiDyhu5HTpKYuEmQuFHUu8
 DrgkbUjhvfR/hZ/7De9EEJltb1IbJTXFyJ2EaWJfFMOKJSKb8Ue4xgSP54A1aJH890Zbafmk+UY
 g/Si+Y1sthlDYeAYvLaqedviGb556bZ9c5WUUJtC1YMdRLvQo7fxVfo/beYi7eKBhWE1qdkODI6
 0pxFmFfAdD3YP696uFc2RXpETCNAGqHKG2ppQEug87dyyBAEsX6cHhGidH99GsSbQKbFpQQK4SS
 TjtGixNzERaCMU6M2rg==
X-Authority-Analysis: v=2.4 cv=T7u8ifKQ c=1 sm=1 tr=0 ts=6a39836e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=IrN9ioZU3SVRGu70jE0A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4MiBTYWx0ZWRfXxk8KgPcTG2Gy
 tbfHSWd+JjWgFpdc0rAXwSUeVxCs4PFPya/xf8XvC3u2QB4MnBayLNRXxOOp6dS7MlzFbndLpkG
 7cda8GJS4Je2RagmLtdKxJ4dOU31dV0=
X-Proofpoint-ORIG-GUID: GRZ0_nR-cuZIMLbfn7YBMk9RbEI3Iz9V
X-Proofpoint-GUID: GRZ0_nR-cuZIMLbfn7YBMk9RbEI3Iz9V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01

This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
export path, allowing importing drivers (e.g. mlx5) to use the
exporter's steering tag when performing peer-to-peer DMA into a
VFIO-owned device.

There is no separate in-tree vendor kernel driver for the target device:
vfio-pci is the in-tree driver and the targeted device is managed
from userspace via VFIO passthrough. That is why the ST has to flow
through a uAPI: userspace owns the device and its ST table, so it is the
entity that can publish a meaningful value for a given dma-buf. The
kernel-visible participants are still in-tree: vfio-pci exports the
dma-buf and mlx5 imports it.

On the effect: the endpoint's PCIe ingress block uses the ST as
an in-band instruction for the incoming P2P TLP -- selecting a target
cache partition and, on writes, an in-flight operation on the data
before it lands. The dma-buf callback keeps this opaque to the
framework -- only the producer (userspace owner of the VFIO device)
and the consumer (endpoint block) need to interpret the value. The
dma-buf get_pci_tph callback itself is optional for workloads that depend
on the endpoint's in-flight operation that fallback does not produce
the same result.

The dma-buf hook is intentionally generic and discoverable rather than
a private side channel. The exporter owns the completing address
space for the dma-buf and decides whether it can provide a meaningful
ST/PH tuple for that completer; the dma-buf core keeps the tuple opaque,
and importers merely request the namespace they support and place the
returned value on generated TLPs. Exporters that cannot derive a
meaningful tuple simply return -EOPNOTSUPP.

Patch 1 adds small PCI/TPH type helpers so drivers can query the enabled
TPH requester mode and the device's TPH Completer Supported field
without reaching into pci_dev internals (and so callers in
CONFIG_PCIE_TPH=3Dn builds get a clean fallback).
Patch 2 adds the optional dma_buf_ops::get_pci_tph callback plus the
dma_buf_get_pci_tph() importer wrapper so importers can fetch TPH
metadata from an exporter under dmabuf->resv.
Patch 3 implements get_pci_tph in vfio-pci and adds the new uAPI
(VFIO_DEVICE_FEATURE_DMA_BUF_TPH) for userspace to attach the metadata.
Patch 4 wires up the mlx5 RDMA driver as a consumer.

Build-tested with both CONFIG_PCIE_TPH=3Dy and CONFIG_PCIE_TPH=3Dn.
Functional validation on the target topology: PCIe analyzer captures
on the P2P TLPs confirm the ST emitted by mlx5 matches the value
published through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, and the end-to-end
P2P workload only produces results consistent with the endpoint's
ST-selected in-flight operation. For example, with userspace
publishing 8-bit ST=3D0xf0 and PH=3D2, an analyzer capture of a peer-to-
peer MWr64 shows "STP MWr64 TC=3D0 OHC=3D2 ..." followed by "OHC-B
ST=3DF0h PH=3D2 HV=3D1":
(TLP Captures)
08000260 -> STP MWr64 TC=3D0 OHC=3D2 TS=3D0 Attr=3D0 L=3D8
F0000004 -> RID=3D4h:0h.0h EP- Tag=3DF0h
E0200000 -> AddrH=3D000020E0h
00080006 -> AddrL=3D06000800h
90F00000 -> OHC-B ST=3DF0h PH=3D2 HV=3D1 AMA=3D0 AV-

Depends on (submitted separately):
  net/mlx5: free mlx5_st_idx_data on final dealloc
    https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhipingz@=
meta.com

Previous link:
v8: https://lore.kernel.org/dri-devel/20260615065912.2177918-1-zhipingz@m=
eta.com/
v7: https://lore.kernel.org/dri-devel/20260611161546.4075580-1-zhipingz@m=
eta.com/
v6: https://lore.kernel.org/dri-devel/20260608185646.4085127-1-zhipingz@m=
eta.com/
v5: https://lore.kernel.org/dri-devel/20260526144401.1485788-1-zhipingz@m=
eta.com/
v4: https://lore.kernel.org/linux-pci/20260519201401.1558410-1-zhipingz@m=
eta.com/
v3: https://lore.kernel.org/linux-pci/20260512184755.4137227-1-zhipingz@m=
eta.com/
v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipingz@me=
ta.com/

Zhiping Zhang (4):
  PCI/TPH: Add requester/completer type helpers
  dma-buf: add optional get_pci_tph() callback
  vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/dma-buf/dma-buf.c                     |  25 +++++
 drivers/infiniband/hw/mlx5/main.c             |   1 +
 drivers/infiniband/hw/mlx5/mr.c               | 103 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 +++++++--
 drivers/pci/tph.c                             |  45 ++++++++
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c            |  97 ++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h              |  12 ++
 include/linux/dma-buf.h                       |  22 ++++
 include/linux/mlx5/driver.h                   |  13 ++
 include/linux/pci-tph.h                       |   8 ++
 include/uapi/linux/vfio.h                     |  37 +++++++
 12 files changed, 405 insertions(+), 10 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
--
2.53.0-Meta
