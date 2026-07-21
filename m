Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F382403AFB
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655972; cv=none; b=BtidYBv3dfRN3XxKU2lAt3+hJlNKAsXjHqQTX/wCI5jhF+aySnUm9+f28L7K5aC2uPHZCmT0N+FVbsKZU9zU7hqm9YGAr8bJwM/EbSUjii7i6X2t3lSGUByndCj/tFR8k6sav+VF0CxEQmtHYiCGl00btMI4of3Vu4F/x1V99ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655972; c=relaxed/simple;
	bh=cD3SxDgYRV4P07YCyZ3D6dpRoOb3a5AG7H6z997kprs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcFr4jxmvv+ZEppJFT2MokXS92hZOEQMFljN1B5dSsK9oDRnOmjJ3t97ElwAchdacfxM42inuQ5KzezqLetvrpIlgJCY4o9lz4zEsvImDxDP/tgrfpb+pq92xLIfmqM6PxGnpAPyPl0TTKcV5h+DJs1gaVTxzgla1GJxJwbmK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=oUIFIvsB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="oUIFIvsB"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47db714766aso3029109f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655968; x=1785260768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWf575YMSf1W7NtVvbE0zlmvwqtjFzi0s/WGa1kQOeI=;
        b=oUIFIvsBg3mo3dDAlk47n4w5O0Cc3AJoV0IGlW9f+z1B/kGJvyG4I1Hw/QZ/nXXX+J
         q2aKBdDgrtO83PofGhUhWOvDjbW4R+YOwoBc2m6Q00HU/SpzdYEhI6YXSFmhDUhJZq1R
         M81sjSglpEZAb0JgqlOhxVFbuUIBXFxLijbvsebJG064/AFroA80Beuzcf/IUzYYPywr
         RBE88+0gxMagu80LRIepOWdR9XNFVLs4RFEQmmTg2sOo+hZNkOnqpDrqCnvIzFsw/1OH
         Srns4yMDUT20apg9S8/QtMhSr2hXVCtkT6p07X62clOjHgznrh0X8w6x3bCc5unicf4w
         zwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655968; x=1785260768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dWf575YMSf1W7NtVvbE0zlmvwqtjFzi0s/WGa1kQOeI=;
        b=bYRYPnuDu3Tdt7ZJD/p6gEXZgZTTNdtKpStEnS9YqZjmB9pq6xTrgQWdt5/Xqx3Vtr
         n0f30WJL0jh2q5GjMS/vqAJiSuww4s6M8BvCUXSB/jpxdHLRvEN3woHhgRovCgd9M0Ts
         oE8VWb+rGCCcvuiPU8BcggQz6GJ39hYw6vXeCblGBp3VJ9DtAR7QpguP9FYyJuOkZ4dS
         SmC11kWJQMIyzhrYsc2pOPWsdzf6n2YVwQ1XW/dXy1THKtnkgavjdK21ckFuVHlnkG9q
         1yh6bgUr9s+QoVrFsl6zvTh1u2fi6zqnjga9mcXoOzudFslwphXxskqMFSw+Ch0hll0m
         VjPA==
X-Forwarded-Encrypted: i=1; AHgh+Ro2PC8sVv2Y6ytTkRfZJWno0R78r5/8NmZ1QhxGzLDZUliy5ZrEno2GVmbP90aFfQKIoIrzJV8gAUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy06HZ4uSe4Itp4XOkrQXT93Q04+S55xnEtqSlpkaPJn3N57Sy7
	0XJ5hsTbOVGFLLns3fFNMrUMcs5mihxAnIgWvz3NAXsYAy/KHhMlbjkbWahjKvTrfQ==
X-Gm-Gg: AR+sD10BsBPE3VkGKCfSNMtyjAiDc3zc1Fq7MdnlPULzz7H4QfuPqmAKpfnfD00vi26
	JZOUWi7wIZ+/bbzpP9PWslbZA7ZO39SALqInS8Dxu8JIgIn6iyqyCoT9hPGH+TZWuhOfNswL2YJ
	9v8mldIdAFRja6VpPHK7TgfjGYarY3/qeZqgVmn27eqv4JbxY/+gH9hJN1sxQP402g3MGEDbM6Z
	jsozT2KsALt3tChFKHkXGqqkO15oz/bpojXmFXbYPHXfXsCWVBqBo7ctE06j6IsFaZQwO+wnwOr
	X6cDbcn8a9rq33mlU4kXaC0LTnX2kHojkZT4GNbxfFqG3NY1ae01hSHrROdtwtokIbllieQasvg
	qv+xtvqxgaGxtiSMUQqo/5HYCddW2SlWnrhBPTWar9tOSeX+LWXxBO2heBl9BX2caAO2b4Mhgu4
	GC4z2B5HviKKfye5egtmdVdAlgs8zXtffTTZG/pUsJgtMVUck=
X-Received: by 2002:a05:6000:2903:b0:47f:7864:1b7b with SMTP id ffacd0b85a97d-47f840c596amr727053f8f.24.1784655967970;
        Tue, 21 Jul 2026 10:46:07 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:07 -0700 (PDT)
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
Subject: [PATCH v3 4/8] md/raid1: don't use write-behind for P2PDMA bios
Date: Tue, 21 Jul 2026 19:44:58 +0200
Message-ID: <20260721174502.111503-5-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721174502.111503-1-mykola@meshstor.io>
References: <20260721174502.111503-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_behind_master_bio() copies the bio's data with bio_copy_data(),
a CPU copy. P2PDMA pages are peer device (BAR) memory; generic code
must not assume CPU load/store access to them is safe or fast on
every architecture, and bouncing peer memory through the CPU defeats
the point of a peer-to-peer transfer.

Skip write-behind for P2PDMA bios: they are written directly to all
members, including write-mostly ones.  Ordering against write-behind
I/O in flight to overlapping sectors is preserved: the non-behind
clone path serializes on CollisionCheck rdevs (see the preceding
fix), which covers these bios like any other write that bypasses
write-behind.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 997f79c05db7..7d769b6460ca 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1523,6 +1523,7 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 	bool write_behind = false;
 	bool nowait = bio->bi_opf & REQ_NOWAIT;
 	bool is_discard = op_is_discard(bio->bi_opf);
+	bool is_p2pdma = md_bio_is_p2pdma(bio);
 	sector_t sector = bio->bi_iter.bi_sector;
 
 	if (mddev_is_clustered(mddev) &&
@@ -1575,9 +1576,12 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 		/*
 		 * The write-behind io is only attempted on drives marked as
 		 * write-mostly, which means we could allocate write behind
-		 * bio later.
+		 * bio later. P2PDMA bios are excluded: write-behind copies
+		 * the data with bio_copy_data(), a CPU copy that cannot be
+		 * assumed safe or fast on P2PDMA (device BAR) pages.
 		 */
-		if (!is_discard && rdev && test_bit(WriteMostly, &rdev->flags))
+		if (!is_discard && !is_p2pdma && rdev &&
+		    test_bit(WriteMostly, &rdev->flags))
 			write_behind = true;
 
 		r1_bio->bios[i] = NULL;
-- 
2.52.0

