Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5851396573
	for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 10:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458428; cv=none; b=ZH2CbyBhfQPT21/MmCv99Rw2W3ntadbWJ2xiTpzq4uiF+vit2x/E8E+P4xv7lm9AknxMSEmkHw/bmzd8Hz2sdf7kmH0xR9cQvLsyblEN2z6N4JAZrGoNUSBuJsnzf+3guyW85iA3ossgSJ5COWHpbG9JyfY/ZYs3diVC9mJeVus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458428; c=relaxed/simple;
	bh=ckOwh+/KVDM4Fp986EbTgYg+bPUMzv5VlFWjz/PbPJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZLV57viusEUMkWHP9bOFTUyNykGfWrwVxHxSwDzh6M9+GuHlZjbUk9b8btB9IC7dHqn8JoX/Lq/trHjhTKDOlvrnl+NOZbKHGahUMIcKiNK9fdon//+3P/wvcZrWHuqegzwcTGJDcv1JqgG6HOwHa4BQoHC5AhbDMc7+aCjY5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=JAFucgbw; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="JAFucgbw"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49557073245so2298365e9.1
        for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 03:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784458425; x=1785063225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2eFgBNGHZVs+4VEn+rFjG8dtsShNuRCRL19zmjqYsAk=;
        b=JAFucgbwqnuXms9cXGHT8sLvtkrldP4kQoLjBJrfyz5rDi2+4d5LG3rxQcsOb56Nlb
         44iYz5BRwf+XIY1G3w6CKTzBUP8cY1ivHuE8tcO2q/7xURPinrCs3IqfItPOmCv+jYYH
         CpattxbHEKF4zH1H5AYZAy2ZImrZbNxRyr1chBAVeu907UB150gQktRQsNlBo5SSfTzV
         /T2jMiUfEKKpppOUMn42Ox4DrZtiuAlSG3NlshP8/okOzvoJ/KQJBcCtdORJHBJjSMmT
         QedaBihhuQXXHk9pc3tU+g6LiDE37OrCjUyYoBU+lFcx7fkjakAetCNySuduRRuq4vCr
         Obuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458425; x=1785063225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2eFgBNGHZVs+4VEn+rFjG8dtsShNuRCRL19zmjqYsAk=;
        b=d2oOkPaB4wPK3p+4clUaLQLcFC+FUYuAzJdoMvHJ9oaexaJIhUPJ1H54hp2x/4z9qa
         9Q3o/98tEglALlnc03I5KpOkCVUmaFtx52iOt9xqzDfqDDyz9eK3eg2o8yzXcU//2OdU
         7UDbSjTmWjQD6QCQnZZBDUn/Qw9uv1+JygfST9gtmDviItMNgG8AMQLELSVaFZsaVsX4
         F6l20V0dg/R4KdXWZaGQkDIVNkloIhcsO0waluiUFfwqW7EKxF5imoyzRZvf3FkPT5QI
         osk2Z5jWe8+44f1gpcDwvxAjOA1hSTJnSHh/D90FhtgaptxhM3XG1riG2+E2xWq89uFb
         BbIg==
X-Forwarded-Encrypted: i=1; AHgh+RqUCl+CnQJnZHVUx6ATFYMWVBnMfBY6C11eyoSI2uNWS6naj8oeh78Lqxf/7PYNSr9E7rYLlM9EmTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKeTN6XmQKVsIEZMlxgOMb8ryLjMgVsiNvM6o+1ne93oBfGTcl
	EkHes3SbmyfF9s+Jk3xp3uTinRg0zjkhIG+C16+1fHpWfJmPO7voj4B0bDK8VC8JrA==
X-Gm-Gg: AfdE7cn2uqqN7e+3krgu2K0gUnOwr6DbBs715QUsfNta9m8UdrRvUoUixXf0LqXLBgP
	slsCBa6RqZmpDm5sl91wOHgtIk+bXD1wn3RKd5Jnj+hqciz5OBi+FUOPkvw2ryOfK6vWLsYu2Ef
	FxW0VjS6f0D7FFL37k1iMU9p323m29oigYz2DxPWekfSz/G9Ikv9TuxrSctExfKZe2onAdcoAky
	Moo4Qsaf9D1S5pDzDBc8guUGkb4SqdPKui3Z2jczn+pB7KHgVSZWGbIeCMuKzujQq0bjXI9xC2C
	8IryYoc+HWu9YVMBnM/kjWUGqx+GeBK1IKSoH9WQlcBY10hT/8TwbzLyB0/HrE0y0tBkuLAFPJS
	fDj4308dGydUsRZ/RhZUlB7kE9SIZUzD/sY5EFYZmUg2eh3SEefumfgFcvLtAkJcORafXO+5b
X-Received: by 2002:a05:600c:4585:b0:492:437a:a653 with SMTP id 5b1f17b1804b1-4954a50b811mr100979195e9.26.1784458425036;
        Sun, 19 Jul 2026 03:53:45 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm197679575e9.3.2026.07.19.03.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:44 -0700 (PDT)
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
Subject: [PATCH v2 5/7] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Sun, 19 Jul 2026 10:53:25 +0000
Message-ID: <20260719105327.864949-6-mykola@meshstor.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719105327.864949-1-mykola@meshstor.io>
References: <20260719105327.864949-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

narrow_write_error() re-issues a failed write in badblock-granularity
chunks, cloning from the master bio and resetting bi_opf to a bare
REQ_OP_WRITE. For a P2PDMA bio that reset drops REQ_NOMERGE, which is
the only request-level protection against the member queue merging
P2PDMA segments across pgmaps or with host memory (see the preceding
md_submit_bio() fix): the retry path would quietly reopen the hole
the submission path closes. Restore the flag on P2PDMA retry clones.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c  | 3 +++
 drivers/md/raid10.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 914fb86452c0..f562b6bd438b 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2573,6 +2573,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 		}
 
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 		wbio->bi_iter.bi_sector = r1_bio->sector;
 		wbio->bi_iter.bi_size = r1_bio->sectors << 9;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0a3cfdd3f5df..f7ef903a3d4e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2831,6 +2831,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 		wbio->bi_iter.bi_sector = wsector +
 				   choose_data_offset(r10_bio, rdev);
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 
 		if (submit_bio_wait(wbio) &&
 		    !rdev_set_badblocks(rdev, wsector, sectors, 0)) {
-- 
2.43.0

