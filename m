Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2B332612
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859759; cv=none; b=hup9Qm2t0G3mHCje7qgqR1u1kC3Ky05OCAv8aLqatxA4XzQtWgWlkmZ98ttwiR7nhSM32CMFr7FqNUgBgrbDlFhpY6s/YWXtPM/ouAynQ/81HoEfuVAk646nyHWfRKqRQ5riaqy9xN1nul0H3SJMHnc/+pt/SbSr3dAv1/HxAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859759; c=relaxed/simple;
	bh=ZJVJqb3Yo0MHgvlbgt8s8dCpM7o4SC8ZBwQe+WZ698U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E9BmaidBOBPQTLGgm6+uZ3xtoTs1yrmz8Ai4Gt4FrM9s1fW2ezBFRlEu1lEa4eQ8/iM7fZZZ9w3ngkSF44/kcDyEf80E8YP+4rO6DvWAUnhdUkPoYBVOMfGr26qVlX2BEaQsJjL+ZL4dQmf09uG5+2UaCVntZjJeUpTOkhbo3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OzvODk5r; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OzvODk5r"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ULITeR2215618
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:49:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=6OrjIrC5Z9XwADb+3/
	H8a73w2yuKvxXPQY5UJBTxeJQ=; b=OzvODk5rPOy6+q2KzhtYWsYWTnU++12qtO
	/nSwmU8Oa+KVGHhw8YsRh6vR6jxL6kKtYk+Zz2p4NiT3ak0OioSMD4JIemudTD33
	cC3X69/C0S0NhecRoir0S+VzROIYLeu2GhvDxK+YfaXQnycp7Kf5w2kNgVviFQQV
	XEjP0t59XxbyylvOyiP6sgZbrRmWm7fMTMu/Kj3VZ4tqT6kuYu1AUT5oPMKjT1Pw
	nVRbAIKU545hAYuxT+D6qCjJjEsa2ywYQDjsh1xqyIjMS5DcEppY4byTmM6cIU5s
	lmJnIl7uOPIBp4qXVmCN94K23VB7jbto7lIW0OlS6++QbPO9MIiA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f4f1svd9r-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:49:17 -0700 (PDT)
Received: from twshared6916.34.frc3.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 30 Jun 2026 22:49:15 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 9869C40C59BFF; Tue, 30 Jun 2026 15:43:28 -0700 (PDT)
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
Subject: [PATCH v10 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Tue, 30 Jun 2026 15:42:22 -0700
Message-ID: <20260630224328.3218796-1-zhipingz@meta.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIyMiBTYWx0ZWRfX3AhMmqxxt5NQ
 s+RTik2tr0zAYAo6uARkRR5DgD3UdsbWtb8Ox2AA79qnNpc5xwq5o3KmCwjZjwjplnXvo85Yjxt
 gsGxEl2wv+pRi1apX7Ta3FOkta2Lpag=
X-Authority-Analysis: v=2.4 cv=OYCoyBTY c=1 sm=1 tr=0 ts=6a4447ed cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=hqgnMBnoZRKjftXIFiYA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: IbNmIzywQpoEju3dNSVspuZUaMWC0GR7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIyMiBTYWx0ZWRfXyUJ4yPckr3Kv
 cxY6etdq1vpuDSqIpO0g/eNgl4RGEsY+lpeBuHUy1RclPhAP3wvgSV4bIWyMMlmJnEOmGMsgqMx
 7t6SHk5sm5QNBWaE4m6OTPY0Kek1yJewU0/srKs8fQCc7oTXBd4B/qL5J1b+2x+23Ago9FJXQhi
 Rk8koUlk0VBdraRXyUWeXuQfDQvW2OLYy0OAuE0K3ozfBJ5ywnhQ1GzBbdvG0vfMUDtMhwTM+mr
 DxtBBjBsBlN+kb4HDBzF7QwG2hUDFOJZQfu8DvA3kMjLb/VzOUeanr2eIv1IymSrkQrLWh/2lII
 SpdYqYkr1IWfvHAqndFn0w4ONgRPTyhwYULzLZvM9r1vAa3lFgxhDzRce7UtKhI5hQWiMZoVaG2
 t8xE6ue6NQWa/PiVM2mGY3iAg4vrTB+QSVX4AG0jSM6aIIFu9xCzDomFGdRwPBphx3Jxj9OlhjS
 ke4YJePnZ547Gr12Thg==
X-Proofpoint-ORIG-GUID: IbNmIzywQpoEju3dNSVspuZUaMWC0GR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01

This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
export path, allowing importing drivers (e.g. mlx5) to use the
exporter's steering tag when performing peer-to-peer DMA into a
VFIO-owned device.

There is no separate in-tree vendor kernel driver for the target device:
vfio-pci is the in-tree driver and the targeted device is managed
from userspace via VFIO passthrough. That is why the ST has to flow
through a uAPI: userspace owns the device and its ST table, so it is the
entity that can configure a meaningful value for a given dma-buf. The
kernel-visible participants are still in-tree: vfio-pci exports the
dma-buf and mlx5 imports it.

On the effect: the endpoint's PCIe ingress block uses the ST as
an in-band instruction for the incoming P2P TLP -- selecting a target
cache partition and, on writes, an in-flight operation on the data
before it lands. The dma-buf callback keeps this opaque to the
framework -- only the producer (userspace owner of the VFIO device)
and the consumer (endpoint block) need to interpret the value. The
dma-buf get_pci_tph callback itself is optional, but workloads that
depend on the endpoint's in-flight operation need it because fallback
does not produce the same result.

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
configured through VFIO_DEVICE_FEATURE_DMA_BUF_TPH, and the end-to-end
P2P workload only produces results consistent with the endpoint's
ST-selected in-flight operation. For example, with userspace
configuring 8-bit ST=3D0xf0 and PH=3D2, an analyzer capture of a peer-to-
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

Changes since v9:
  Patch 3 (vfio/pci): Address Alex Williamson's comments by annotating
  the existing unlocked @revoked read with READ_ONCE() and rewriting
  the DMA_BUF_TPH uAPI text around @flags, future-query semantics,
  @ph, and undefined bits. No behavior change.

  Patch 4 (RDMA/mlx5): Address Michael Gur's comments by renaming the
  per-MR ST ref helpers to drop the misleading "frmr" infix and by
  preventing mlx5r_build_frmr_key() from propagating user-provided
  kernel_vendor_key. Also fix PH encoding consistency between FRMR and
  reg_create() and balance the MR-scoped ST ref across both creation
  paths and failures.

Previous link:
v9: https://lore.kernel.org/dri-devel/20260622184211.2229399-1-zhipingz@m=
eta.com/
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

 drivers/dma-buf/dma-buf.c                     |  25 ++++
 drivers/infiniband/hw/mlx5/main.c             |   1 +
 drivers/infiniband/hw/mlx5/mr.c               | 116 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  49 ++++++--
 drivers/pci/tph.c                             |  45 +++++++
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c            |  99 ++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h              |  12 ++
 include/linux/dma-buf.h                       |  22 ++++
 include/linux/mlx5/driver.h                   |  15 +++
 include/linux/pci-tph.h                       |   8 ++
 include/uapi/linux/vfio.h                     |  43 +++++++
 12 files changed, 422 insertions(+), 16 deletions(-)


base-commit: 97d2a397efe7752ebf9204a1cfd365afd80c3b28
--=20
2.53.0-Meta
