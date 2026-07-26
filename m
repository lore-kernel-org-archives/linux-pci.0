Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D93876B2
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065561; cv=none; b=lGuefNKYhafERbm7aOc/bayShYzU72tn+eujQlITW7IYPVQZzkJ+6DJkNTjUdu2AxxQRf1ApNOCIf2i6cDxiIy0KgIdiGbdzO3QX+6G6MIZBCnFSfs8sF192aL5xp2jX/xM9ILFg1HnVCNXbhsPJWZCdUo3zWX17wWlminHLNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065561; c=relaxed/simple;
	bh=cRH7W6syefYxFA3VhhN4QvzFBoE55r52A/E6t9wrD1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mni1lB4Md/xLgUMKyS4jCHup3U05iF8ZpTpuW5dpnj1PzNJFLfjR/DdC4QugqJWWIoZdsSDtAqLzNmSNih1JEgTI952/TX5VNjHZGutEiftOg84xAM7ArkoMIgUQFanq/KyhEBQ90VdkEUknnBMo933KGp0yCcv6YVDr4SqGJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=iCUrjlGZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="iCUrjlGZ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso1731880f8f.0
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 04:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065557; x=1785670357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNWXk+rlZiNRYyXRDGVV7qCvY4AZPHPO/XYCzCCpSWs=;
        b=iCUrjlGZRTnRycnm44bhvE6KESyl6CPlRBFaqy1scd6HtQ3mzTeRQmEcSph/Jwx2jb
         3Lx2khsCVyQO1x3j1jrd3SU8kGfPXuQIfa8JK1SRDdC5vxhNIV0FXnxksrxuhnq5aaSw
         VEgxUPzxsAsrZ5Oa/gdaa9zyewbGoh5VsTRdf3OOXpFOZ18Ftv143Z7aA70+ODdBOC42
         tkNuPZiZDXmzV9jTnoZc99lFxvF+yB6JjYrg7BG+hRpRot6neyOlAh0TaQN9aYVMc2gB
         vSig2bu8v9Kin9PFG3+hz06JjxjxuUWAfB3AWOn4pibSuUXWVUNPeG8F0iTMjtLW/6Rr
         DZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065557; x=1785670357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LNWXk+rlZiNRYyXRDGVV7qCvY4AZPHPO/XYCzCCpSWs=;
        b=AEvwJZ9UIfI0BQEEC/ZRZRYXnXBK/wE1I5or+S2kcYMhUY/hZbifpbD4vgEboLT94L
         lNH8DSG06GbYsMryVhvmCkaf/OJzHkusGY7Vxv3UJavipb8ZeOw/Pt5X8ilRRCu0B7pL
         sspOhDsb1JqqOs3uCP4JlqN12l2DX+muBr0MmnppKedpyFULXBF2Z1hhMcichJg1csZu
         3QA686RP67oSgRnTLClup+UCBOGzvig3jPRHUBpGbK0vc0wswfA55UOeskivMJkLJp70
         PLjWSjGUnGDj84exILALVgd4ibxq6TKA34oTwJFpzcYiUu8SBS7zIJcUOOUckHxv8t2r
         1Ugw==
X-Forwarded-Encrypted: i=1; AHgh+RqyXqjhlTECecwhq6TLAf/BhHur+XgqTBr3B1SIKYUHkl4iBg32RnKZaGxb9eWxKiFVGPNlNfQDA/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWtKqDoDfwhYRX9BQkYdZ39QY5tsw1M/2nHYb0HjI3L4M2+aow
	L3a2CwdQrGpbN9bkfrELWGCyuG45Ly5/awgec9rncUfk90ujvM27zitYo2CKC2RH8g==
X-Gm-Gg: AR+sD13HOeespgYyzug0U9hOiTyqrSsGV0gdK9m8HXPb5oroI+DnxYyFiqbkGEQ142W
	giAmwulxN10Hyz2huWOrwLFxClEY6b7j/UYd06YBgthqGx2fyQzWRy6LPdFPdI+F3UtBKmfvBDK
	i8AdaRQzPvmsfDzVS2TjV7eRkkaqWwphoDlszr+HezA+1VonDS7+clDJzTUcnB3lq1i8uzKnPTS
	j3axdI74bmMGwPeiKjPsb7jyB92RbYA3bao5RmG5tRYoh3Ipw8JUZmLte9GiCtZ49/+iTKS488q
	RUlZFyhts543ohT3UeF8ppS210IZMj/ivahC1GnyS/qjMfIaf4QFyAe25Cj50b+nOax1ZSGQFQt
	ptvO9SnTHvZZsBOioVn/7B9v7z0IyvpNn49wHTNI1vInT0pzSdNeAihom5sB6hwHbkJIWwsJ3nw
	TDQdS45u4zRCRdSic8OOHxi6S6Sc0pR8qW2pJNcSKdLf+4RFWEfNqKf7L3l3L2K5PIFQ/SGdt0e
	lEJPKocd+4IQkhD1V7HpwahcLoGIlX4T612xLTC64vkHcVikwNA
X-Received: by 2002:a05:6000:4012:b0:47f:93e1:e7d0 with SMTP id ffacd0b85a97d-47f9fea2d2emr6157677f8f.36.1785065557128;
        Sun, 26 Jul 2026 04:32:37 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:36 -0700 (PDT)
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
Subject: [PATCH v6 01/12] block: add BLK_STS_P2PDMA for unsupported peer-to-peer transfers
Date: Sun, 26 Jul 2026 13:32:18 +0200
Message-ID: <20260726113229.2154269-2-mykola@meshstor.io>
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

From: Logan Gunthorpe <logang@deltatee.com>

blk_dma_map_iter_start() reports BLK_STS_INVAL when a P2PDMA transfer
is attempted between two devices whose PCIe topology cannot route it.
blk_path_error() treats INVAL as retryable, so multipath requeues the
I/O forever, and callers cannot tell it apart from an invalid request.
md also ignores it for member failures, so a mirror silently diverges.

Restoring the old BLK_STS_TARGET would stay ambiguous -- nvme maps
NS_NOT_READY, LBA_RANGE and CMD_INTERRUPTED to it too.  Add a dedicated
BLK_STS_P2PDMA, non-retryable in blk_path_error(), and return it from
blk_dma_map_iter_start().

Fixes: 858299dc6160 ("block: add scatterlist-less DMA mapping helpers")
Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_map")
Cc: stable@vger.kernel.org # v6.17
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 block/blk-core.c          |  3 +++
 block/blk-mq-dma.c        |  3 ++-
 include/linux/blk_types.h | 10 ++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 365641266c9e..83cb5464265f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -177,6 +177,9 @@ static const struct {
 
 	/* Command duration limit device-side timeout */
 	ENT(DURATION_LIMIT,	-ETIME,		"duration limit exceeded"),
+
+	/* no PCIe P2PDMA route between initiator and target */
+	ENT(P2PDMA,		-EREMOTEIO,	"peer-to-peer transfer unroutable"),
 	ENT(INVAL,		-EINVAL,	"invalid"),
 
 	/* everything else not covered above: */
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index bfdb9ed70741..e88d6b3524e6 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -189,8 +189,9 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 		 */
 	case PCI_P2PDMA_MAP_NONE:
 		break;
+	case PCI_P2PDMA_MAP_NOT_SUPPORTED:
 	default:
-		iter->status = BLK_STS_INVAL;
+		iter->status = BLK_STS_P2PDMA;
 		return false;
 	}
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c..c8de7809320a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -165,6 +165,15 @@ typedef u16 blk_short_t;
  */
 #define BLK_STS_DURATION_LIMIT	((__force blk_status_t)17)
 
+/*
+ * BLK_STS_P2PDMA is returned when a peer-to-peer DMA transfer cannot be
+ * mapped (typically because there is no route between the initiator and the
+ * target that the platform's PCIe topology and ACS settings allow). This
+ * is a property of the initiator/target pair, not of the target device's
+ * health. This error should never be retried.
+ */
+#define BLK_STS_P2PDMA	((__force blk_status_t)18)
+
 /*
  * Invalid size or alignment.
  */
@@ -188,6 +197,7 @@ static inline bool blk_path_error(blk_status_t error)
 	case BLK_STS_NOTSUPP:
 	case BLK_STS_NOSPC:
 	case BLK_STS_TARGET:
+	case BLK_STS_P2PDMA:
 	case BLK_STS_RESV_CONFLICT:
 	case BLK_STS_MEDIUM:
 	case BLK_STS_PROTECTION:
-- 
2.52.0

