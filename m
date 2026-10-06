Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91937F739
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 23:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329578; cv=none; b=IYFlOvxUi8bmUZITf/8x66nT4yvGdZb+f1BLK/EkPhoLOqlnj7Tji9pk/d/2uTsJZUYkAPv6xeAja4xK3ZK2JuO2aB2PO6/INmTONQoxSJM9hfxkNFDkx+v+RmkAdF0V7zZ/eddCf+4WxgKFxMg/cXl4y9EadeMhwz/pe0IVZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329578; c=relaxed/simple;
	bh=4xwuNzls6NknB+x3Ga8Zt/2DnX1UDxLV3pBZhiMx8tE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RxOHRJRSkyeeMbKuCyES2AHft6trR1yvIbufFY0UcY0UoXXLaGmJU4AH8ozbM8FUpFomR2GLTqRFxC79pYeELv0tq/cSxsiXTzHNRJAzFofCP2gHDXXV1JF0atObZQyTd8RxlZo7pKwcdvybTqsBfBw35QdgSJwa7va1yXT731E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+exC42d; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+exC42d"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso3573258a91.2
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 16:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791329575; x=1791934375; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=63o+ETk0hEx3rHZzZwUiie6Jpi00EzurOJzH/KYltNI=;
        b=o+exC42dAGQSJfeGEsGGDWCQtvk4cMEcfIiMyNBnzorYrj8ZRHjPegp73cbPdOqHzH
         LvmW6K1aHnhsGAtkk/7ZW3DFgxB7mwCKjQG2TS6mr4rOPFTk8GXMmilUWWaBc1Sl94M2
         5BXMRQ+gCuBBJimCCeo8KZ1OAzcqRy4NtB5ACXj2OUjw6FPVPcIoWXkTKlg+uFkDV/gQ
         IbH9kiSP4p/hxZ02BsxzsBfqb56j0uMbw5xb8AUlebKRvz/qj16sA2frkl8i9J4wF4mz
         qxOkOLSk47DNfgTM0aHRRBXLzRC5YnXZ5HhTquDGQ+7HVbRJuPlJ1LafFwWLALhhrYbj
         N8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791329575; x=1791934375;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63o+ETk0hEx3rHZzZwUiie6Jpi00EzurOJzH/KYltNI=;
        b=ge7a1qj2TNmahCdhqFrQXz21mdiopD5QS5kScMMJUhQUtUIiVJcSXYfVAUy9WqbhQl
         cnonbBv5GaF1aH3nij6LRxd6ivq5WyNpPzWhdZOAQB/zln4nRYcdhtMpmSSsshtvp+uD
         tXN1U8ZAHQGi0axc5QSaXoA+WjNzcUM+hjQg72iJpqJx7SCl3MyU95JIsObMCLAKKfNe
         4rMD7uorMX+uc8W32vAXDcXYaGvysUYwvk94tvOwLK6wPXT4XTnzDJV0uabhpmK1IUeo
         YPq4+pv3w7Wo2SQzCsMLmmlQuQu6fsWZXSDD8gMbSSpbTO8aAsIFJQsel5Jv3OKhUAkj
         dZQg==
X-Forwarded-Encrypted: i=1; AKwUvBzBc2tN8v07zaUhhlvgTxiT9ITYGJmOrYvTfASXoeJGOSEpOhS0nIpk5bOeHsQ6GMNAxlAMefA6y8M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEak9Z6zWyGC2Llp+4VwPJ7MoxLYqF1iVimFNytqgrTLF5QTWi
	ZJHJ7XZIGXHeJo1gVOLKwcIVN1wmHnwxzVugDiHNApa34vlm9HCC3K4qS6fWphpsQLtipktyS6X
	7Rg==
X-Received: from pgbcq11.prod.google.com ([2002:a05:6a02:408b:b0:cc7:f591:caa5])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:44:b0:3a6:e149:f17
 with SMTP id 98e67ed59e1d1-3a8a1b8e280mr501054a91.41.1791329574905; Tue, 06
 Oct 2026 16:32:54 -0700 (PDT)
Date: Tue,  6 Oct 2026 23:32:40 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006233248.705086-1-praan@google.com>
Subject: [RFC PATCH v1 0/8] nfs: PCI P2PDMA for O_DIRECT over RDMA
From: Pranjal Shrivastava <praan@google.com>
To: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Shivaji Kant <shivajikant@google.com>, Tom Talpey <tom@talpey.com>, 
	Leon Romanovsky <leon@kernel.org>, Unnati Sachan <unnatisachan@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable NFS O_DIRECT to and from PCI peer-to-peer DMA (P2PDMA) memory
on RDMA mounts. This replaces the initial RFC [1] and builds on the
Direct I/O modernization series [2].

P2PDMA memory can be an NVMe Controller Memory Buffer, or the BAR of a
vfio-pci device exported as a ZONE_DEVICE-backed DMABUF, as proposed
in [3]. Today, NFS O_DIRECT fails with -EREMOTEIO when the user buffer
is such memory, since iov_iter_extract_pages() refuses P2PDMA pages
unless the caller passes ITER_ALLOW_P2PDMA. Buffered I/O is not
affected, as the CPU copies the data into the page cache.

P2PDMA memory may not be safe to access with the CPU. Thus, the series
follows one rule: a P2PDMA payload moves only by DMA between the device
memory and the NIC (or the local disk with LOCALIO). Any path that
would touch the payload via CPU accesses refuses the I/O instead of
copying it.

Design
======

  O_DIRECT, user buffer in P2PDMA memory
      |
  nfs_direct_extract_pages()  ITER_ALLOW_P2PDMA on RDMA, !pNFS mounts
      |                       (other mounts: -EREMOTEIO, as today)
  nfs_generic_pgio()          is_pci_p2pdma_page() -> args.p2pdma
      |
      +-- LOCALIO: disk lacks BLK_FEAT_PCI_P2PDMA  -> regular RPC
      |            not one DIO-aligned segment     -> -EINVAL
      |
      +-- RPC: krb5i / krb5p                       -> -EREMOTEIO
               encoders set XDRBUF_P2PDMA
                 |
                 +-- xprtsock                      -> -EREMOTEIO
                 +-- xprtrdma: NIC can't do P2P    -> -EREMOTEIO
                               NIC can't reach it  -> -EREMOTEIO
                               otherwise: Read/Write chunks only

1. Per-RPC decision
ITER_ALLOW_P2PDMA at extraction is only a hint. NFS tags each READ and
WRITE whose pages are P2PDMA memory with XDRBUF_P2PDMA, and the
transport serving that RPC decides whether it can move them. With
nconnect, reconnects and migration, the transport and its device can
change between extraction and transmission, so a mount-time capability
cannot be trusted. LOCALIO does not use the NIC at all.

2. Socket transports
TCP (including TLS), UDP and AF_LOCAL move data via CPU accesses, so
they return -EREMOTEIO for a tagged RPC before touching the socket.
xprt_transmit() now fails only the refused RPC and keeps draining the
transmit queue.

3. RPC-over-RDMA
The inline paths copy the payload via CPU accesses or DMA-map it with
calls that do not handle P2PDMA pages. Thus, xprtrdma always sends a
P2PDMA WRITE payload in a Read chunk and receives a P2PDMA READ payload
in a Write chunk, whatever its size. It returns -EREMOTEIO when:
 - the NIC cannot DMA to PCI peer-to-peer memory (e.g. rxe, siw),
 - the NIC cannot reach the P2PDMA memory (DMA mapping fails),
 - the GSS service forbids direct data placement (krb5i, krb5p), or
 - the rest of the READ reply does not fit inline.
If a server returns READ data inline despite the Write chunk, which
RFC 8166 forbids, the RPC fails instead of copying into the pages.
Small P2PDMA I/O therefore always pays for memory registration.

4. GSS
krb5i checksums and krb5p encrypts the payload via CPU accesses while
the RPC is encoded, before the transport sees it. nfs_pgio_prepare()
fails such READs and WRITEs with -EREMOTEIO before encoding.

5. LOCALIO
LOCALIO is used for P2PDMA pages only if the filesystem's block device
supports P2PDMA. Otherwise, the I/O goes out as a regular RPC. I/O that
is not a single DIO-aligned segment would fall back to buffered I/O,
so it fails with -EINVAL instead.

6. READ_PLUS
READ_PLUS decoding moves data and zero-fills holes via CPU accesses, so
it is never used for P2PDMA pages. RDMA mounts already disable it.

All refusals return -EREMOTEIO, the error iov_iter_extract_pages()
returns today, except misaligned LOCALIO I/O, which returns -EINVAL.
Refused I/O fails at once, even on hard mounts.

Call for review
===============
Feedback is appreciated on:

1. Layering: "RDMA transport, !pNFS" is only a hint, and each RPC
   re-checks its transport. Should the transport advertise P2PDMA
   capability up front instead? That would also allow LOCALIO on TCP
   mounts, which this series refuses.
2. nconnect: fail an RPC on a transport without P2PDMA, or pick a
   capable transport?
3. Migration / reconnect: the path can move to a NIC without P2PDMA,
   and I/O that worked starts failing with -EREMOTEIO. Acceptable?
4. Hard mounts: refused I/O fails at once instead of retrying.
   Acceptable?
5. LOCALIO: the check uses sb->s_bdev, which misses multi-device
   filesystems. Is there a better way to ask whether a file can do
   P2PDMA? Should misaligned I/O fall back to an RPC instead of
   failing with -EINVAL?
6. pNFS: excluded for now. Route P2PDMA I/O through the MDS, or let
   each layout driver opt in?

Known issue: the pNFS check happens at extraction. If a mount gains
pNFS afterwards (e.g. after migration), a rescheduled WRITE could reach
a layout driver. I plan to decide once per O_DIRECT call and force the
MDS path when P2PDMA pages are allowed.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260401194501.2269200-1-praan@google.com/
[2] https://lore.kernel.org/all/20260814143255.861084-1-praan@google.com/
[3] https://lore.kernel.org/all/20260804185050.2053672-1-praan@google.com/

Changes since the initial RFC [1]:
 - Split the Direct I/O modernization into its own series [2].
 - Drop NFS_CAP_P2PDMA, the 64-bit caps expansion and the
   ->supports_p2pdma xprt op. Decide per RPC instead, as Chuck
   suggested.
 - Refuse P2PDMA pages in the socket transports, and fail only the
   refused RPC.
 - Move P2PDMA payloads only via chunks in xprtrdma, and return
   -EREMOTEIO when the NIC cannot reach the memory.
 - Refuse krb5i and krb5p, and allow LOCALIO only as aligned direct
   I/O to a P2PDMA-capable disk.

Pranjal Shrivastava (8):
  sunrpc: introduce XDRBUF_P2PDMA flag
  sunrpc: fail only the RPC a transport refuses
  xprtrdma: move P2PDMA payloads only via chunks
  xprtrdma: return -EREMOTEIO on P2PDMA map failure
  nfs: tag READ/WRITE RPCs carrying P2PDMA pages
  nfs: refuse P2PDMA pages with krb5i and krb5p
  nfs: allow LOCALIO for P2PDMA pages only as aligned direct I/O
  nfs: allow P2PDMA pages for O_DIRECT on RDMA mounts

 fs/nfs/direct.c                | 10 ++++++++-
 fs/nfs/internal.h              |  8 +++++++
 fs/nfs/localio.c               | 40 ++++++++++++++++++++++++++++++++++
 fs/nfs/nfs2xdr.c               |  4 ++++
 fs/nfs/nfs3xdr.c               |  4 ++++
 fs/nfs/nfs4proc.c              |  3 +++
 fs/nfs/nfs4xdr.c               |  4 ++++
 fs/nfs/pagelist.c              | 13 +++++++++++
 include/linux/nfs_xdr.h        |  1 +
 include/linux/sunrpc/xdr.h     |  1 +
 include/linux/sunrpc/xprt.h    |  5 +++++
 net/sunrpc/xprt.c              |  9 ++++++++
 net/sunrpc/xprtrdma/frwr_ops.c | 15 ++++++++-----
 net/sunrpc/xprtrdma/rpc_rdma.c | 40 ++++++++++++++++++++++++++++++++--
 net/sunrpc/xprtsock.c          | 12 ++++++++++
 15 files changed, 161 insertions(+), 8 deletions(-)

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

