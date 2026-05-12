Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C7357CF9
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778612395; cv=none; b=PFpMSMcUu+mwh8hBeBm+sByZTLDGHif4hAIEUOUF6jacEVI0iY1UkPx7Ov+/1At5vU8sKGe9hzey8OiVxotC0rbbxniJkq73PJu46yQSYeScUjN4i3V/Qqgl+xgLZuBVL9uXXAPVrUsCYCmKrTD97jsK2KFy1ad9wir4hU9k3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778612395; c=relaxed/simple;
	bh=3TV/8sjMg41uVSyjTcoKqLqBXHun1ZRIa8Yr6xMYYA8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fn+ZCBpe2LWx/whMJYIJVTpk+0vgXlNHp5hZP5I9zf7hzV1ux28055kLxDXh2i9Wh1cOxYzaO2UUPRg9YrIzQ/Po/hvdWpNCJCWdplo6wzQ1kwwxglDXPdPk5TjDgTgki9glYkavcQ14q64NyoYwNg+lf1V6l4HBOYH/CYoRwQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OZ6Gka7F; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OZ6Gka7F"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CGAQj1508833
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:59:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=z/T90J2VcCXM9MrxBJ
	/CnLMXPOreCP72V21n7qFI9lU=; b=OZ6Gka7FDAXsQJ0u6oXQsKuWd85z85ag1R
	PT+/1D5B1vYX9KsrEMprX7KpupZjm4cKv4ekfO1OB8ujBzPqj1Ye7t5CFftuy3Fi
	Iqto8iB83mWsy29a2wG9Okjz9pPBRecyUP/ALDSgrfGOunNv1iQgRkK07ZQwvnpj
	HfKWPd7fl8BmrUusKr18+j5sqO/P+TlEsVD5hHxnCRGEAoC/UfRGNVLQ4qzBpQEs
	Btq2ux6URiA0n6EvhR3qInBn2hxtPW6HeHW6R/YGMTee/AJ0/zagQagKSv9LtXWN
	t2HWTU67OTSzr6L6bRgg8lvx5uHX3aO4GXTpN9SPGqmlEaqum0KQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvqb39y-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 11:59:53 -0700 (PDT)
Received: from twshared2072.03.snb3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 12 May 2026 18:59:49 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 0C5682923916A; Tue, 12 May 2026 11:47:55 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon
 Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>, Zhiping Zhang <zhipingz@meta.com>
Subject: [PATCH v3 0/2] vfio/dma-buf: add TPH support for peer-to-peer access
Date: Tue, 12 May 2026 11:47:47 -0700
Message-ID: <20260512184755.4137227-1-zhipingz@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE5NiBTYWx0ZWRfXw26odXdE5Gr2
 BmSrg71u4Ts0FvY+Fv9dbn1XhoNTG3VzcKZduOmfIh8j4JHamjwpqeKNkpdvr14phPNxg64SUHf
 b6oRol3ngJnGCHAamx1ld8ttOuuhcaL3lGCbqwpanMYiagkjse/voaHKdZEgqv1qTNpZ8VduMYv
 NAWP05UmGdkOuwx+XLUqiA94yrnw3L+8sVcdOTKZ2t4HhQy7WCYZYYHGukG50+s92ISWpV3xA3f
 Z+cRYrD91Asj8HitIb+nzGGX3FRQsSdTBv0o21Qi5yCMr6xuTcjhlVGVXTOIZHKavW9vUp6u2ae
 Axd27rJGPYxYMLHAaPV8isfXmIgCn4//5duwuSrH3bDNbxwPNxtypvCrOt/xlrA+SWrs997IgLl
 Wy93Z8yk/9Z+/Mh2vSrCjnDMqdaaP7FDf3s+9ekMXgCaF7gbSrpMmbdMYLaI/QlVEPKpf1aSflz
 HkWZJlpCZO+eVabPBEg==
X-Proofpoint-GUID: hFBqEo1tJaDVQhLriH-tjVK3_VOKQqDQ
X-Proofpoint-ORIG-GUID: hFBqEo1tJaDVQhLriH-tjVK3_VOKQqDQ
X-Authority-Analysis: v=2.4 cv=TfKmcxQh c=1 sm=1 tr=0 ts=6a0378a9 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=AwavuCtjv7QaUXewFCYA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01

This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
export path, allowing importing drivers (e.g. mlx5) to use the exporter's
steering tag when performing peer-to-peer DMA into a VFIO-owned device.

Patch 1 adds the dma-buf get_tph callback and the new vfio uAPI.
Patch 2 wires up the mlx5 RDMA driver as a consumer.

Changes since v2:
  - uAPI now carries both the 8-bit ST and 16-bit Extended ST values,
    gated by a flags field, because the two are distinct namespaces in
    the PCIe TPH ST table and a numeric range check on a single value
    cannot pick the right one.=20
  - Add pcie_tph_get_st_width() in <linux/pci-tph.h> so mlx5 doesn't
    dereference pci_dev::tph_req_type directly.
  - Validate that the TLP Processing Hint fits in the 2-bit spec field
    in VFIO_DEVICE_FEATURE_DMA_BUF_TPH; previously an out-of-range
    userspace value would be stored unchecked.
  - Publish/consume ordering for the TPH metadata: writers store the
    flags last with smp_store_release() under memory_lock; readers run
    lockless with smp_load_acquire() on the flags. This avoids an
    unprotected read in get_tph() and removes the AB-BA risk that
    would appear if the reader took memory_lock while an importer held
    dma_resv_lock.
  - Convert vfio_pci_dma_buf::revoked from a bitfield to bool to
    eliminate the cross-lock RMW on a shared bitfield byte (revoked is
    written under dma_resv_lock; the new TPH fields are written under
    memory_lock).
  - mlx5 reuses the dma_buf pointer that the umem already resolved
    instead of calling dma_buf_get(fd) a second time, closing a TOCTOU
    where a concurrent dup2() could substitute a different dma_buf
    between umem creation and the TPH lookup.
  - mlx5 now tracks per-MR ownership of the allocated steering-tag
    index (dmabuf_st_index / dmabuf_st_owned on mlx5_ib_mr) and frees
    it both when the firmware mkey is destroyed and when the MR is
    revoked-and-recycled into the FRMR pool.=20

Previous link:
v2: https://lore.kernel.org/linux-pci/20260430200704.352228-1-zhipingz@me=
ta.com/

Zhiping Zhang (2):
  vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature
  RDMA/mlx5: get tph for p2p access when registering dma-buf mr

 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   6 +
 drivers/infiniband/hw/mlx5/mr.c               |  72 ++++++++++-
 .../net/ethernet/mellanox/mlx5/core/lib/st.c  |  27 +++--
 drivers/pci/tph.c                             |  20 ++++
 drivers/vfio/pci/vfio_pci_core.c              |   3 +
 drivers/vfio/pci/vfio_pci_dmabuf.c            | 113 +++++++++++++++++-
 drivers/vfio/pci/vfio_pci_priv.h              |  11 ++
 include/linux/dma-buf.h                       |  21 ++++
 include/linux/mlx5/driver.h                   |   7 ++
 include/linux/pci-tph.h                       |   2 +
 include/uapi/linux/vfio.h                     |  35 ++++++
 11 files changed, 306 insertions(+), 11 deletions(-)

--=20
2.52.0

