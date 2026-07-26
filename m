Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11F3A5E64
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065567; cv=none; b=Xn4q4GeMj/kwFIlG9+iprD8SgXONKlaIMgp4kCmNn64cU1SDUvaA/6Q+KFuOs4lHAKCzON6DHztSpnDUMF9gk5x9k7IpjLyxVb91nRny6z7WbXGSaSVQU7l9L6Tb6o1ZFAB4QHOaIHDtT5MjdTfXtRg9hCyKzj35BboezW153as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065567; c=relaxed/simple;
	bh=tb87IS5YwxWP0/pdiRmCvUCzVsNHu9wl18O2iixHy6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Txlnth7wSjCdv7Z6IQDEKeRwE2oLookQ81J2bC+K8TwA0fLv54PAedqTwC/qcf5GR14EyA4t9PKwRm76V1DXeFGlGo5uN1+QgOwTOUGhV+g8FcqKcSC2J9VwpfN6P6XnmfjkJTcSb/qAR6rljmY5ylDvFsYwkP2PR2Sv/pTwJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=TpwcYxJe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="TpwcYxJe"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso891454f8f.3
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 04:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065564; x=1785670364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=;
        b=TpwcYxJesQJVNdh6uV4Kf05tdGbQJynu4uVnOM3oe8LfYWTjTXJqOYc8pEsAnzBk0l
         ofaSF2MIyiQh5duF8J2woPOMeof9YRL0KVhVosfa/Jq28u+dQdDykuAN9cKIo1/wahDQ
         uvlWNuJAo9frPMUOJE7lLgPMvO2YygsXROJxY66bSBKk9RVSbN7tEqRp+Jy0JbWQl69c
         +C0yXSwQ26ROF1YuvMG1EOkFvz8alOfnJLIuwyLYFNYrEqbedHNm4DtjoTWrVem+528e
         4/S0QRhv55lv2WqaeqSyonkIFPvWTAqgvW+w3R9CqWe2bksynNvNv5krBgydt0IgYdOZ
         NZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065564; x=1785670364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jvUC0Lia0it+LgLYsOXSPjeMnXEhLq3Hqn52LEDkVn4=;
        b=dsbxhYh0BVukZR78UcK9zbxEbNTxSxADo16b0UJ+3djSE7Qms9V7cVxij8orBkkWtO
         pRl6Oinsx2udMp4WzCLKECEPp91UeXCrXbRulJMVvW6BFRNMtc+UjDa1zdDN8XOboCBJ
         bHa+4H3pTlwEHEXNmLVWO0jntWrn2tWF4nyMXMu4uo6mPN+2W9U952CbT/Y/vg+Hj1V6
         +Ix4wjzgxQVss2YEY/PX/IrwR7zWPWa/8g8kbEv0XIvzubShQXP4Q+7nF2wxWDn24MNe
         nk4lX7LWbO+YQyeTyo8qg0sAb3dSnx0nyi7ACBQgz/TMQSIEFdqq/hNi9hsB51jLFDqF
         3+1A==
X-Forwarded-Encrypted: i=1; AHgh+RqXlnm2B9aiDv9PavlJr7pxVxi43WMiv+r+hH95ZnQYijHSh5vVLCW8WFKHx/ml4em3ExOy5T+RakU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnNig096PMoHVNev4JljewHqEitCkpEffs/zcWgj2jSxABTPOU
	hKueQRfmLhRwA/5PpsxK8Yz/Ub5C9NbUHmKvCw3AW2ec/um9EnBOp8Mdeh7GfKISTA==
X-Gm-Gg: AR+sD12pK9LzDa35Y5kTaKPaPGQ00pcCO5U3fiVqvNV2FKPVMLgcUxSJP+Ah3hyMN1Y
	DsM9UoqgGzRuA3sjY+y+i2S7oISxeNUAfoH0Ts66leclt1VaGfNCSPtHyZAiTL/3urkHxDBZxFN
	V9mb/e5moeP1v7+3ccm4gEFudyN6cGM1ssQ+BBYuLAHW7QqLOUx42VnDN6UOwkj8yG00NkJasAb
	Psv9tRzgTGEX6RP3B1ASJKWvujW7wkyHnL8kFg1YOHQ42268axIf4WMFicHTRhaAgjRe7HJRqA6
	2taLs0HbwDfxSyU6Kg6yy2GsYPhYKXSAxRPan5GGiQhHFV5yn7foGRvUGmrbrg/AdZjJKbmfdp/
	qeBMoGVTjiGUz43Enq1QzDizWiX+CCAWfS0Fd6Sx8xisEiU3aFezvnpzMqI/Y9P4clCNktbHhZf
	pIdjO7RpAyi87PSUIkf/hQJPJHNnHKpbECmgsuyFt43FP42Ad3PiAsUpCARZJJyCMWMZAPvwZJh
	krS06wCkdeylE7M3YLVrVPacgyMGN+NIeF0SKDO/g==
X-Received: by 2002:a05:6000:40cf:b0:47f:77dc:b072 with SMTP id ffacd0b85a97d-47f9fc8fc9fmr7735691f8f.18.1785065563917;
        Sun, 26 Jul 2026 04:32:43 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:43 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 04/12] md/raid1: don't use write-behind for P2PDMA bios
Date: Sun, 26 Jul 2026 13:32:21 +0200
Message-ID: <20260726113229.2154269-5-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
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

