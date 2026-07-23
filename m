Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7AC377A8E
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839382; cv=none; b=bm0wnxTA3O2ss2Hkn/MBipuUL/o8JUR13r95SSSNJokwvRr5l1eurzNo4p2LRojglbKenDhx6dxiDahCaAp78gVir+e7IFhCkszqZvZlhYTnBm/H9p2vqd5fO/+IywRAEthWaJGBxAO+RTe2nunz4zMtpYLIm4sWD+03eq93XaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839382; c=relaxed/simple;
	bh=duiRRHdzIykrisUAseIhJOxQn/X2Aiz678fZQ0WGdro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLphszeyAIGmY71P6ECzEDtR3pWePXu5YvgFIwSOoKdB3mpBOewYu3HfnkMCuqTUUQB36zmB7ikMYtJzfc8m0VGY/6D7Jd7jFh8ZAB9QK1DZLqYOuUYucpT4u2ptrMC3QiE5MxklPojJoqVybC7eZIganMsfxW3QyQfCcxCIUx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=GRRp3Z9O; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="GRRp3Z9O"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1015546f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839373; x=1785444173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E5idRe2CDp786J3ag0YcRdkJhpW3jRwxGiXDWMRNXt4=;
        b=GRRp3Z9OchYW9aYVO2Z5s4bG+ngjTlLw9V/1GOLi/ER7ZRSMR1kDntz2NBmZW6UdsX
         A423uxBjPyl5vs8fDoa3yGtnSmrTO2LPBDV3GYHtDwOzSowGDBbMl56bY+yLeuc3L4+a
         N83TaUE92jVEeDeHQE2vmzszgdY2pXLvM81SCH0KqhE5QdnLZmlMcxugU/96mFYgcuKE
         k3E5ZeBQltBrS0HVv0Q299axZhbfr21TF8stCmc7a1n2e2CtRK5dUDAP2+tidTk0iDgJ
         SQBkUEjHEwSuWPr/lrAcbCRy/8LSHn4Leya87/Ayt/4ZnVEECxuu/wkzsRy6FyF6kCbR
         D2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839373; x=1785444173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E5idRe2CDp786J3ag0YcRdkJhpW3jRwxGiXDWMRNXt4=;
        b=md9TXpGGCx9HAVDVOGlFI0SY5MgHb/Xeg1ryycB6ai5zleUUWBBvI1+Xy6FxXCBb56
         69bQhj6yxUA8ouor9vZfY8TLtpsBIEEU+N2QS1KCTppnShwV2aIA979QEiVoXLJ5KQ70
         ++aM1l8W0H9yiAGubhWaJ35yg5eHYLm/0PzDRqK5biA/lAgaeQqdHsZrKMl+i9eGZVC2
         pcNh2d19M+kbJOZZ80WnadFjblpJh/GQsgbT2WXOj2zYbE6fCsF8cGfBYN7t2b00trRP
         E7+EDR0X/c6+sLbR2XkE0vRcEoFqOn/JGa/+1laxo53SQ+Pb6UF70HwHsqmM2uSV6rph
         wYvg==
X-Forwarded-Encrypted: i=1; AHgh+Rok2orrmCxN5+NPwekM0pPmCXZ3XPJdSRfjUoWzmpF9s9PeXPDRgSnSvXdio368F4djXl0ngPaglFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxskbjCGS5sxszk+HwKJsKdutCg5YoK1Ka8arnbQONDTYFEIQK6
	hQoK+/oZbF9C4DC9TeuEPHzVte5xFaaEsSNe7Dcr/G53kSRyYxFpg4jMN8xTC2xQXA==
X-Gm-Gg: AR+sD12rzk8YjarE2HBlMooXYoZ3yFFSxHxegjAU1TSjBbR8hxM+abbWE935e4xdab4
	Dro1cfeG1oJN+SioCXxECmIVP62wexd6sfM6zXvYHT4eTv26axLT4UuLRL8ZIxwiRHsCSVxMHVX
	noOim1kxkzfzU/LEkhA4EmoqprUe3A2Mou7ZzVtTqadPfsri3dn5xEAYcOvZAZ7c2ypuwY6QS90
	j7FrZtrN5EjMNUUde4aDzl8PzkSH+zh/dN5QlBTHASQfEhGtwiy162ljukCUPw7Me6M2CeEHrof
	ysizkV7YNLeeQDy27lEBKloV8O2/Hpg+yzM3Ye6nUDRZGWjXTjCIwJe18Iqe5XZNvRW0CZLvJVH
	oN1EdKtgXnTSOhdYXxNnbHra5NwYRXRtCYtoiyM53PUt50049sNc/IuB0BZIujIwpBygWDMmg8z
	K6LJ0qaTG82QAWxXaa7QoJKnq3oQZSYM35KNmwtwhB0GsjMYT9WENvZPXoRSkHx6Oi+vtWiZk4N
	O+agS9fgcrBL1DFwxmCYyy6x4Dj6g85BiFhrLeIhQ==
X-Received: by 2002:a05:6000:46d4:b0:47f:93b9:b76c with SMTP id ffacd0b85a97d-47f93b9b770mr1881409f8f.56.1784839373145;
        Thu, 23 Jul 2026 13:42:53 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:42:52 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 00/10] block,md,nvme: correct handling of unsupported P2PDMA transfers
Date: Thu, 23 Jul 2026 22:41:56 +0200
Message-ID: <20260723204206.76930-1-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

md treats an unsupported P2PDMA transfer to a member as success, and
nvme-rdma retries one forever.  Whether peer memory can be DMA-mapped
depends on the PCIe topology between the two devices, and since v6.17
the failure completes as BLK_STS_INVAL: retryable for multipath and
deliberately ignored by md for member failures, so mirrors silently
diverge.

v1-v3 restored BLK_STS_TARGET for these failures and tagged P2PDMA
bios in md.  Logan Gunthorpe proposed a dedicated BLK_STS_P2PDMA
instead, so no consumer needs to know whether an I/O was P2P, and
wrote the core patches; v5 is built on them.  Patches 1 and 5 are
his and keep his authorship.

  1  block: add BLK_STS_P2PDMA (stable, v6.17)
  2  md: ensure REQ_NOMERGE is set on P2PDMA bios
  3  md/raid1: serialize non-write-behind writes on CollisionCheck
     rdevs (pre-existing bug patch 4 would widen; stable)
  4  md/raid1: no write-behind for P2PDMA bios
  5  md/raid1,raid10: factor out raid1_write_error() helper
  6  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error()
     retry clones
  7  md/raid1,raid10: skip futile retries on P2PDMA mapping
     failures
  8  md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
  9  nvme-rdma: use ib_dma_map_sgtable_attrs() (stable, v7.1;
     dependency of patch 10)
 10  nvme-rdma: return BLK_STS_P2PDMA (stable, v7.1; needs patches
     1 and 9)

Routing: patch 1 block, 2-8 md, 9-10 nvme; 7, 8 and 10 use the new
status.  Patch 1 alone stops the divergence and the dm-multipath
requeue loop; the nvme-rdma loop also needs 9-10; everything else
refines the fallout, so the series bisects safely.  The md patches
fix a v7.2-rc1 regression (02666132403a), except 3 (older bug,
stable) and 5 (refactor).

Tested with the QEMU raid1/raid10 error matrix and a ConnectX-4 Lx.
After patch 1, block-layer error injection accepts status=P2PDMA, so
the md completion paths can be exercised on any member with no P2P
hardware.  The patches were developed with AI assistance (see the
Assisted-by trailers); all code was human-reviewed and tested.

Against v7.2-rc4 (Logan's base).

Changes in v5:
 - patches 7, 8: From: is now Mykola (Logan's request)
   Logan keeps Signed-off-by on both, Co-developed-by on 8
 - patch 8: raid10 declares bio up front and bi_status sits in a
   blk_status_t local in both files.
 - old patch 9 split: 9 is the mechanical sgtable conversion,
   10 the -EREMOTEIO -> BLK_STS_P2PDMA translation; both stable
   since 10 needs 9

Changes in v4:
 - new BLK_STS_P2PDMA (Logan) replaces restoring BLK_STS_TARGET; the
   R1BIO_P2PDMA/R10BIO_P2PDMA state bits are gone and the md changes
   shrink to completion-time status tests
 - blk_dma_map_iter_start() gets the explicit
   PCI_P2PDMA_MAP_NOT_SUPPORTED case (Logan's patch; v3 kept
   default: only)
 - write completions record the whole failed range as bad blocks
   instead of narrow_write_error()'s per-block retries; v3's coarse
   retry is gone -- the new status is deterministic, nothing to
   re-attempt
 - read path: bi_status is evaluated before bio_put()

Link: https://lore.kernel.org/linux-raid/20260718162547.448892-1-mykola@meshstor.io/ [v1]
Link: https://lore.kernel.org/linux-raid/20260719105327.864949-1-mykola@meshstor.io/ [v2]
Link: https://lore.kernel.org/linux-raid/20260721174502.111503-1-mykola@meshstor.io/ [v3]
Link: https://lore.kernel.org/linux-raid/20260722185841.449934-1-mykola@meshstor.io/ [v4]
Link: https://lore.kernel.org/linux-raid/9f846c85-f427-433a-b87d-8e9e3a4406e7@deltatee.com/ [Logan's proposal]

Logan Gunthorpe (2):
  block: add BLK_STS_P2PDMA for unsupported peer-to-peer transfers
  md/raid1,raid10: factor out raid1_write_error() helper

Mykola Marzhan (8):
  md: ensure REQ_NOMERGE is set on P2PDMA bios
  md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
  md/raid1: don't use write-behind for P2PDMA bios
  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
  md/raid1,raid10: skip futile retries on P2PDMA mapping failures
  md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
  nvme-rdma: use ib_dma_map_sgtable_attrs()
  nvme-rdma: return BLK_STS_P2PDMA for unsupported P2P transfers

 block/blk-core.c          |  3 +++
 block/blk-mq-dma.c        |  3 ++-
 drivers/md/md.c           | 10 +++++++--
 drivers/md/md.h           | 15 +++++++++++++
 drivers/md/raid1-10.c     | 16 +++++++++++++
 drivers/md/raid1.c        | 47 +++++++++++++++++++++++----------------
 drivers/md/raid10.c       | 27 +++++++++++-----------
 drivers/nvme/host/rdma.c  | 38 ++++++++++++++++++-------------
 include/linux/blk_types.h | 10 +++++++++
 9 files changed, 118 insertions(+), 51 deletions(-)


base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
-- 
2.52.0

