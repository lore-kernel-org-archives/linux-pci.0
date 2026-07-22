Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9B39524B
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746760; cv=none; b=S1Vt7h6kBVzcnJpSIHfG019Jk5J1LSykgL5+Cunm3iUItVMiAUO9n/ynYf5xyHJMZsPzmk8wHM5o4g2XIqnXryO14xeC02uVH7b8TjL+lMwufRBuvtxariKYKZJUPgWZPZ0yEd9Y2BRb9tY+1FzzrFzhTidSX+E//UROPogNWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746760; c=relaxed/simple;
	bh=txEBr1MoU1y1mkJ/HHXFbnluQk+VRueyunkBGuSqgtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsDuUg6L0Rc+0JQUxqC5OuIJ/Lz6LzlFPvoNjRDdv3IvVVo1eJaoxjZ3Gtn9vosNTkngYJMyZBjE4gQlRnfn/66WLO08kB77F+31jr8+vYp9ncS+ob+sND3xl5IpisM7cXechB858R1DU/XYHZqJmFEflQlABrq/VhXWX9kZla0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=H1wkgX05; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="H1wkgX05"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4720f3bf164so3680468f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746754; x=1785351554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XGlz7sxVhffzS6r4ROT44BH0oh58kUxNrwba0cAE+h4=;
        b=H1wkgX05RHJTUWYprRsuGf3VDGrnWdopU+EKgLmswxyGXuyAtX/JXr2Yuh5N2t/JOX
         Yh0EiRSzmOI3gHd3cQSaQLV4wPbLXSMrUo6vOhcssWWslM3ZDyZ1hGSA0kl7iRZpHciE
         +It5bRwc0temO8hUL1zEx9DO8Xq9U/LuG2bJFf1g3aI1PvTOOmamJeDG6WDSK9qarsa1
         4X43Tmrn6PTMlZ6pRckVGJ+DyfLyU9DVNtTgFFMEZ3ol3K5RJAtTOxOV8K8PxW8kXID+
         KARFNKDueTbGrLuXCiQl+vHl4HwyLNw8FyO8YBJRE8cY03Jz0ixbLwVZsByBskLVGcAN
         Pf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746754; x=1785351554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XGlz7sxVhffzS6r4ROT44BH0oh58kUxNrwba0cAE+h4=;
        b=qwB9sQ8Hc/1TVGjAjl60N3fA15FDSkTWjpdAnBWc+anRIZc8Sq/mS/2w4Tf3q+yGcU
         JHoDq4jtx0Gf2WqRLv8V6sz54MPhXD0Rhud3kU1w5JFui6uv6ZSCNIoslJVNYUzt/Uqs
         UD+ZTorrAx8B0UqJIRP7L/onqpA/PVp1EjBQrhqiUhJ0P2p98CczRiKxeAQPpXBlkuNd
         DjOASJQjyfKnFiQxfsgDLZhNXiOhLUycSEJllSKpeR0fpBQ4qY4UnFWg+C/VQYMQN2N4
         UaHzZG0PDOL6BLzDmn3wxwcfeNUpR2OXehwqC0RYJS3RNqsRUdWcPS+TMBEQYg3XSQoj
         UQGA==
X-Forwarded-Encrypted: i=1; AHgh+RoQ9MgcH49gPFpy4wVhG+9fyZwnSZT7S3fFOq5WuhZvUaO4ZqvjDLg4j8Ot/vbiE7BSh4x6lAaJ/Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ob1sti6dA4fBhA0r7q1EEFwcA4m7m1Ju5NYqv/tTY/YnrnmG
	+ipOv03jKaQQ64LF37R0vjKUCxXx3XoLNqXz9vHMoHqUQrixLCRT2Gu64SmyR3kTdw==
X-Gm-Gg: AR+sD10pDTcDj0/5I0IoF+jOZ+2WdgVzcRobgalTDZKZqgcKsAb1xmWeRQKqeokMSCV
	So+hHc0py1+4+Vj0Owz4/Uc2Igd7NsOWom581FYF5Z8siCjkQxzkDr5Denpv5jtinNnRNdJw0ZI
	445Un4P+G+opaPTrPIy29WY/wPkzp3HqJn0dXlEfXKHED7k/nBpWkfhoqHt3wijjEbjiQxlTdMk
	N4FkFETevvGPkjb1pvz4twUkXCpS5ybCQS4LVxpixl3JN5xGbmUCYA4ju5bME7PcRouBBzCBBFQ
	OwAkfhCqSytI6cxFLlo0S9VNUbvbedXtAJg1F9AiuDZLCAeFN+3BwjuCqOAGGqh+RuZ/rFm6Iet
	iLrFVIU4ST4TyRywLv7JwxQbOL0HGuN7pBYFCLDX7XljROuXiyjB8DqDLtR2Q6B5X8etPXV/g3u
	R0LgZ7NG/UDu0dWHuxwIo4smvU7ViG+3WOT8TVHtLggcTZs6M=
X-Received: by 2002:a05:600c:1d23:b0:495:7016:b875 with SMTP id 5b1f17b1804b1-4957016c17dmr25808785e9.13.1784746753845;
        Wed, 22 Jul 2026 11:59:13 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:13 -0700 (PDT)
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
Subject: [PATCH v4 7/9] md/raid1,raid10: skip futile retries on P2PDMA mapping failures
Date: Wed, 22 Jul 2026 20:58:39 +0200
Message-ID: <20260722185841.449934-8-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Logan Gunthorpe <logang@deltatee.com>

BLK_STS_P2PDMA reflects the peer/member pairing, not member health:
retrying the same pages on the same member cannot succeed.  Keep
WriteErrorSeen so the range stays fenced, but skip WantReplacement and
FailFast eviction, as commit f7b24c7b41f2 ("md/raid1,raid10: don't fail
devices for invalid IO errors") did for BLK_STS_INVAL.

The failure is whole-range and deterministic, so narrow_write_error()'s
block-by-block submit_bio_wait() retries are pointless.  Record the
whole range as a bad block in the completion handler instead.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Co-developed-by: Mykola Marzhan <mykola@meshstor.io>
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1-10.c |  3 +++
 drivers/md/raid1.c    | 12 +++++++++---
 drivers/md/raid10.c   |  8 +++++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index cee21452e066..89daf8558251 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -309,6 +309,9 @@ static inline void raid1_write_error(struct mddev *mddev, struct md_rdev *rdev,
 {
 	set_bit(WriteErrorSeen, &rdev->flags);
 
+	if (bio->bi_status == BLK_STS_P2PDMA)
+		return;
+
 	if (!test_and_set_bit(WantReplacement, &rdev->flags))
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 19c4dec450de..917d694ef401 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2624,10 +2624,16 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 			 * narrow down and record precise write
 			 * errors.
 			 */
+			struct md_rdev *rdev = conf->mirrors[m].rdev;
+
 			fail = true;
-			narrow_write_error(r1_bio, m);
-			rdev_dec_pending(conf->mirrors[m].rdev,
-					 conf->mddev);
+			/* Mapping failures are whole-range and deterministic */
+			if (r1_bio->bios[m]->bi_status == BLK_STS_P2PDMA)
+				rdev_set_badblocks(rdev, r1_bio->sector,
+						   r1_bio->sectors, 0);
+			else
+				narrow_write_error(r1_bio, m);
+			rdev_dec_pending(rdev, conf->mddev);
 		}
 	if (fail) {
 		spin_lock_irq(&conf->device_lock);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 428bddddfe71..9045a3f02dae 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2940,7 +2940,13 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 				rdev_dec_pending(rdev, conf->mddev);
 			} else if (bio != NULL && bio->bi_status) {
 				fail = true;
-				narrow_write_error(r10_bio, m);
+				/* Mapping failures are whole-range and deterministic */
+				if (bio->bi_status == BLK_STS_P2PDMA)
+					rdev_set_badblocks(rdev,
+							   r10_bio->devs[m].addr,
+							   r10_bio->sectors, 0);
+				else
+					narrow_write_error(r10_bio, m);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			bio = r10_bio->devs[m].repl_bio;
-- 
2.52.0

