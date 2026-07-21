Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6046D0B3
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655967; cv=none; b=KiK9DUjqX/sXRvhPXS95LZKzsSsT6ouleibN9JL1TEZdF5G6YJztJ77ovcr80B7wiGnE126uKRTQRDkCAw1WwRBYO3U1xJEW4L37w1aqtSOqcwy+fg9DoLKeu2Q5uQadnt1KhF10szFzrI12ubSdZj/FQ+cBeG79uRHPUoJUlto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655967; c=relaxed/simple;
	bh=UmHDQ8Avh88213YFsBTKp7WY9yAPzXpx6PsDprJSvWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucPgxCUuPtm54Lm3WH9jDi0GKvtkzmmVaximgeHyq63EWcqqZWeNTcVOvQtr6h+ptWfZ+nr2ojY2QpfRvisgUT74e5CObdcOtM0T5WHSbSs82k/f2xrti9X7pQGGApH8KdKvhRzHATqcVZx1XT1c2tOkFOIRpwDBLcr1WaDqwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=esOZG+U9; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="esOZG+U9"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f633e6058so4150708f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655964; x=1785260764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=esOZG+U9ERajKjNOIUJfkXtFGMzt/lQo4ehj3YxLvK+PNIAUhM7ActdNwCxLyeCZZR
         fo8n1ZCxo77xJ/0fmo3T27PEPNtvlFMWCMIytrQrNfy6cz4Wu7h+FiM/MnVjRwF7PqPg
         ODELkrDbKQ2y56PlRAj7z7m9M5HHVFPzWaeM4WL2r8PJL2/xuHM5CAcUoPtkPVZvvva3
         op1DUS2ZwqUPzoVYjqtuS6dO96nkenFmbuCO+mGO0wtK/L7hGzNDdyeYieBD6Z/cZvOK
         cJb1VwcS5gJcJSDDyCAe8nIaUdm/URy+IWkj0RMlVbN85z4CpmTXbPe1AlxSJqSS/S1I
         qf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655964; x=1785260764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V5hliKyCAPWFZqHS5mW2T1dJRPt4J/vTka7mcNCHq10=;
        b=Aev9CkyrzoZVZ+4foSpmA46THNOrBV3g7M/R5AcI955ZgpCrZJQ8e/os8geTeG0jL0
         5WlXzVdLeMhacensk6BUvAmY5dJ+XdQxZ033VI++UKEDXwGwBRnfX2wtgLUa42RLYghX
         hpLVkT3BZQqVmt4ZAFd2ywR3WyDzs9qHa9h1r0Yvym1AqJgxngeMY6NHp9i7WYUKX433
         kk/OnPGk9DNxSUSIDQWhjrbAi8jrLTa7ipZ/r0HGanc2jcPrRNL2HFxX1yDjsfrmSkbS
         yMuor25JguSulK09CL0KSfwdbz31CHbJQ/tX6/xY3B9jTAVTvc5lmwEnwdk/bWbzuF2x
         uSMg==
X-Forwarded-Encrypted: i=1; AHgh+RqPZokQPnA9QugJd2kNGBusfoJIAlcx6+jguyoDuCX7b6sEzJ2oAz3kB/EoNstwrE14LYNk5LK/K5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFuBwVrr1dTpEH39JeAgOmBS3iCs+oHNyLGFKmjmwIFPbRhj/
	6SpkS4y3odzifmtHo88O1kEo7NwcltnmfKzXHfYFUTAA7PafosahWcw25r9SyPQNuA==
X-Gm-Gg: AR+sD11lJ0c+1FcwDM91Gx6U71uVTY0U6W/WedqeorBcYTaE4SYgJZQF/ebIUOjPYTD
	M7At+xhywRK6SiW8cSFzVqMJyDBwovKrF4qi9pHFMc8AS3t6CaoqtTBTlLsU8QV20UNkAoXKrPk
	Z9SYNm3CVlAzw5yb6HFEGyuJj5lDk4jQFecMUNe8+MmAQJSgzzSO8tdOG+m5JEDaQsTzWozQHKD
	XL/9Bx3THiMbY7jR3UvTy9blsJ29GICJV8XCIjCeKjmWizJp1f3Kj6htJHLZNv88B7odKsyh656
	8nnK8C5sBOcwmQwU3ZqSSU757hBhKtTR4zEKprTjjmHoEoHKDhKnG++YGb4p8BVteXWprJARq4N
	FeBvmyEby5kxGVMjRBoUULRCLul3rpu+l580GM5k0ypiyUmexnhmAuFQifRdSb/Q4HMM3xUOeWQ
	AlG1bN2YFAvS5WcHVV4NHR9bubdOVLU65z8A4zTZ1bfxAf9NM=
X-Received: by 2002:a05:6000:2084:b0:470:6dc:848a with SMTP id ffacd0b85a97d-47f622fcea6mr22185571f8f.2.1784655963771;
        Tue, 21 Jul 2026 10:46:03 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:03 -0700 (PDT)
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
Subject: [PATCH v3 2/8] md: ensure REQ_NOMERGE is set on P2PDMA bios
Date: Tue, 21 Jul 2026 19:44:56 +0200
Message-ID: <20260721174502.111503-3-mykola@meshstor.io>
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

md_submit_bio() strips REQ_NOMERGE from every bio.  For P2PDMA bios
the flag is what keeps requests single-provider (see
__bio_add_page()): merging a P2PDMA bio with one over a different
pgmap, or over host memory, maps the merged request with the wrong
bus address.  Set the flag on P2PDMA bios -- bios built via
bio_iov_bvec_set() arrive without it -- and keep stripping it
otherwise.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/md.c | 10 ++++++++--
 drivers/md/md.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index d1465bcd86c8..3770bdb4d4b2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -451,8 +451,14 @@ static void md_submit_bio(struct bio *bio)
 		return;
 	}
 
-	/* bio could be mergeable after passing to underlayer */
-	bio->bi_opf &= ~REQ_NOMERGE;
+	/*
+	 * A bio md split may merge again below md -- except P2PDMA bios,
+	 * which must stay single-provider (see __bio_add_page()).
+	 */
+	if (md_bio_is_p2pdma(bio))
+		bio->bi_opf |= REQ_NOMERGE;
+	else
+		bio->bi_opf &= ~REQ_NOMERGE;
 
 	md_handle_request(mddev, bio);
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index d8daf0f75cbb..73df1a6eccd8 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -11,8 +11,10 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/badblocks.h>
+#include <linux/bio.h>
 #include <linux/kobject.h>
 #include <linux/list.h>
+#include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/timer.h>
@@ -22,6 +24,19 @@
 #include <trace/events/block.h>
 
 #define MaxSector (~(sector_t)0)
+
+/*
+ * P2P and host pages never mix within a bio, so the first bvec is
+ * representative.  Read bi_io_vec directly: bio_first_bvec_all()
+ * WARNs on the split clones md handles, and data-less bios have no
+ * bi_io_vec.  Not valid after the bio's iterator is consumed.
+ */
+static inline bool md_bio_is_p2pdma(struct bio *bio)
+{
+	return bio_has_data(bio) && bio->bi_io_vec &&
+	       is_pci_p2pdma_page(bio->bi_io_vec->bv_page);
+}
+
 /*
  * Number of guaranteed raid bios in case of extreme VM load:
  */
-- 
2.52.0

