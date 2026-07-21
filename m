Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E385946AA69
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655963; cv=none; b=rPosEs454gstvO6hm+c3UKrIhvicLkF0rK46kJPBikprm7o11oJFj+y0fh5MrXEFktzsoyH8i1N9IBNK1UW/FWRbVb4E8MMNJ5hrdJ+p7liMRnRqkFjAXh78SnQChgN/QmHuwq2oKNu7vH14S9gZdrWQbSrASk4e0qUyjDnPC9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655963; c=relaxed/simple;
	bh=XMC2OxGMjuOKz6yFeSQFkguUImDlcJHi2a0qlioi6Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBkLtMuCT89G+8M65kt81/UH0RK6KYjuVMTEZ0pTVQFRmjde0etcB2SAkUBtTeoXT3rIOMfaOHuHP7zR8m+3+7jTWqCPfpw6fz3PYxH83m2eG7tlpgP+XL+VhedV5M6uAiyy5SSJ7saXiA4aNIAYuy1Cv4+QnldZab+mCyr0ctk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=SFrkG1p4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="SFrkG1p4"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4798bea72f9so6155964f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655960; x=1785260760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mB3slTFc7/RpdI3ntKG5jE11k93RlIl1l9dzcdZkbtA=;
        b=SFrkG1p4Hv8b7oJ6bnmZ/+clv/VnQNvJ8ML0SSvy3wwnjv9rEuUV6xu2cB5yDks5eK
         lb+mv0EOJ2HURRIY4zaOmV94zOYjkZhywVykYlkkIFOncAxEcPb7fivy8alznfrcL+wP
         Zs5dXryyhy+dclVuKPXxb4VrqKQ8zWa2zBkReI/xqEQ3s4hwwbJ0UxbC0T9qW/MI67zY
         /ZvK8ySR7vnVihivNPQh0etVpjxkcvFMIaZ/NM5mdX104dEZXXV7/BQJrDTzrkwXOtES
         /QWrAMJQNjE++ENM9IRdLzwjIBR6aU6z9014cC56c/YMo9wo5OcJ4uoWZ5Q2xUKYIkjY
         dIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655960; x=1785260760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mB3slTFc7/RpdI3ntKG5jE11k93RlIl1l9dzcdZkbtA=;
        b=cclWUy8dgOKeyRTnhTKYsB9JyQAFIUPHmuLhm1pLd0fOY1D9ltDfdCurBWPrrkVsQY
         9RQhnbZjlwnLQHwXkGRgEnFtGtItTWU8154Uqb+TLXktIF7ypL7NIYmwMcfNRIzGkVM/
         gA8DwvJce7c1SjWAM6F6kUgXhZn3d7L7w+6BwWYs1xwIozqnevbkrBoG5LaMMOfH1d4s
         CNzB8GHcl3+h6bRbAknodYRNXqBEPqcUqc/uJ5GmjqWrFJ7afHEiRmm7naZY9PfLCqwO
         iMSBmFj6g5a3vtZzsGfb7ODhLvon/ajVxCSlsEpNfuR4GYjQ2s/OrWkrTZnrr2cNLH0m
         W+gg==
X-Forwarded-Encrypted: i=1; AHgh+RoHg1jCa0DwAy0lQLL1KCf5cHqDb5tGRnWwGzLpXpwvfJWGVWIlxg06IxFTuojD76bk4mNyhJmiIsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1vCsrXG9voO9yd8cYlANgr6FYqqS6dPkhiU3Lsl1FPjdF4eiq
	4kHqnvHjEy9a7C+4dYVMgnEUtAzix20rUQ7pN2lCgmybBadx9eeC7bR7CiG+ImpS2g==
X-Gm-Gg: AR+sD13eAqzhOaP6boS7DukGrKPCNqNbjL82kvx/we+Yj8kNK9/qx1GXlASn0HVTGEn
	wh61NXuZDFERnL4fZD/xrEj2A+8efW3Nm64/xr6+Mfzo1cBzqhRsPuD70IkVGToeFAvv/J3we7B
	li2raRWEN7m6l35vnSqQ5MryIgQ8cM2Yd7s0cJoxuNr4F/OZSxo2mplpcs2g234DPVY7ohUR51x
	Z/8ZsVolSED0PX5NyWBJg+YYl9M9UjFjdbp+QP4CMzO/fjt+RPsH4ZuzNlkOVHCbuk5qNP1PEiS
	0US7q1pamZus2pkXHA3tWoc7NunsjJmB5x0pT+VGnB7wRsvT5ZogmrVuaDuPtkPUGhRi6sx3of7
	WV4SfoVXdJ/TcsuTQ9nzqArjmvEKzVN+Wj9mOuuRkir3clsH+rE0OrYAiKaN9lMZ7rnp/GnsVdM
	F0hssMKWfjMUjGO9+93ZUILbfvNlm6RYLdX69J8uFCZYk0KDo=
X-Received: by 2002:a5d:5d82:0:b0:472:aaba:faed with SMTP id ffacd0b85a97d-47f6232c345mr23371068f8f.31.1784655959771;
        Tue, 21 Jul 2026 10:45:59 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:45:59 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 0/8] block,md,nvme: correct handling of unsupported P2PDMA transfers
Date: Tue, 21 Jul 2026 19:44:54 +0200
Message-ID: <20260721174502.111503-1-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

md treats an unsupported P2PDMA transfer to a member as success, and
nvme-rdma retries one forever.  Restore BLK_STS_TARGET for these
failures (lost in the blk_rq_dma_map conversion, v6.17) and fix what
md and nvme-rdma do around it.

Whether peer memory can be DMA-mapped depends on the PCIe topology
between the two devices: the same buffer may map fine for one
array member or nvme path and fail for another.  Since v6.17 that
failure completes as BLK_STS_INVAL.

md deliberately ignores INVAL member failures (commit
f7b24c7b41f2) and accepts P2PDMA bios since v7.2-rc1.  So a peer
write to an unreachable member simply counts as written: mirrors
silently diverge, and with no member reachable the write still
reports success.  nvme-rdma never even sees the errno --
ib_dma_map_sg() returns 0 -- and reports a path error, which
default multipath requeues forever.

  1  blk-mq-dma: restore BLK_STS_TARGET (block; stable, v6.17)
  2  md: keep REQ_NOMERGE on P2PDMA bios
  3  md/raid1: serialize non-write-behind writes on CollisionCheck
     rdevs (pre-existing bug patch 4 would widen; stable)
  4  md/raid1: no write-behind for P2PDMA bios
  5  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error()
     retry clones
  6  md/raid1: skip futile retries on P2PDMA mapping failures
  7  md/raid10: same
  8  nvme-rdma: preserve the DMA errno, return BLK_STS_TARGET
     (stable, v7.1)

Routing: patch 1 block, 2-7 md, 8 nvme; independently applicable
(patch 8 takes the errno from dma_map_sgtable() in rdma.c, not
from patch 1).

The patches were developed with AI assistance (see the Assisted-by
trailers); all code was human-reviewed and tested (result tables in
the v2 cover, linked below).

Against v7.2-rc2; merges clean onto current master.

Changes in v3:
 - split the raid1,raid10 mapping-failure patch per personality and
   folded its completion-path checks into one branch (Logan)
 - much shorter commit messages, comments and cover (Christoph,
   Keith, Leon); repro description added (Christoph)
 - picked up Logan's Reviewed-by on 1, 2, 4 and 5; since his review
   only a code comment in 1 and 2 was shortened (no code change)

Changes in v2: new serialization fix (patch 3), submission-time
state bit, metadata scatterlist, WantReplacement dropped for
mapping failures -- details in the v2 cover.

Link: https://lore.kernel.org/linux-raid/20260718162547.448892-1-mykola@meshstor.io/ [v1]
Link: https://lore.kernel.org/linux-raid/20260719105327.864949-1-mykola@meshstor.io/ [v2]

Mykola Marzhan (8):
  blk-mq-dma: restore BLK_STS_TARGET for unsupported P2P transfers
  md: ensure REQ_NOMERGE is set on P2PDMA bios
  md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
  md/raid1: don't use write-behind for P2PDMA bios
  md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
  md/raid1: skip futile retries on P2PDMA mapping failures
  md/raid10: skip futile retries on P2PDMA mapping failures
  nvme-rdma: return BLK_STS_TARGET for unsupported P2P transfers

 block/blk-mq-dma.c       |  6 +++-
 drivers/md/md.c          | 10 ++++--
 drivers/md/md.h          | 15 +++++++++
 drivers/md/raid1.c       | 73 ++++++++++++++++++++++++++++++----------
 drivers/md/raid1.h       |  2 ++
 drivers/md/raid10.c      | 66 +++++++++++++++++++++++++++---------
 drivers/md/raid10.h      |  2 ++
 drivers/nvme/host/rdma.c | 38 ++++++++++++---------
 8 files changed, 160 insertions(+), 52 deletions(-)


base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.52.0

