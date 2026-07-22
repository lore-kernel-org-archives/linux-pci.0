Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7740342124C
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746765; cv=none; b=LXUeLXlCgZPmZ0Sb3eel77MjcncB5SjXtv3EIguqNs+HteObicYytC68jQg/eT0eQXm+rZNVlamadCfg8YXljXhRg+y9SBeBen2b9zAvyehR47vznkUpdMbslf+bbdeUDbLQV7coATP5Xt48RMBdBXal/I5oElqXWto7N/J3bCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746765; c=relaxed/simple;
	bh=6JUXonkvhqCluPq91YNslI6Xc6PHhaJJ82TMx9QRo24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dfd4z5gAqFXMLw0lkj3Ncu1g0Bv24c3RsreW1h1hRTUb/wqQkxn2ZSRHtv+MuRDra4qMFBCHi3UBMVbY28X2WOpkBSoyHv2uCuO65w+v6ew7IxbYCsK9q+WHTubAm9RJyrgPU7mlru6hi7cR0U03DhZCGrEOe1aIyGa041swK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=Ai0g5NKB; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="Ai0g5NKB"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495590ba856so34851035e9.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746751; x=1785351551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=Ai0g5NKBb/WoSwM4WCinC9gL5DuAa88xLuEC4hRIs96ghwRQmvDlMLh5VL8zWotpFo
         JLjmRiIu37BjI3rhd4Ubw4snBPwDFxkD6abowchkrUjNFOey/CJUVv59O8K2o34bXApT
         4wCOv64ZNQn2gEcUXAlJfmTzBq/ChFOvz0KDkCMfXy+BPORDQH/yJVd8q4o1hH5eyKUb
         S/BWDDtTklXRRcmxmHW3gZoCTvjMSA7HKGVHZyrsR6bfdDbQLne1R7K151Fu6TuNRAWt
         gNTwsano4qKf9TqettAQaDaizTf9HGlyParu20USjlWCEDbIz720Sk/FeTdSzuha7whc
         pl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746751; x=1785351551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=PMj/tfxkejDCGLV79viQYDguuvxlkzZRLxorDG6yTyeDntJ1tC1f6O79NqomP9pJ7I
         le95yv34Nf2V+Enzs7K2W4ZdnXc13Vr3c7DbMQAXfP33AbCtv7rc+iv8two+HWFTL2ts
         q2B+LiUUBmWQp8rrBhGvGzXL8Y1G+UX3rcXVhjAOog8Xz5Z+WbfoXkLzzgTGQ/D+vQAa
         MUkJqrO3cZwD/bsLAZSMpDJjYj7CHVqoKK4N3Wk8YBLepzVKJRpaRZzIm4XqFnI/vrwd
         U9Hra88DdpIL+Ve9Kb9gzzWyy5t7wlzsaA52OqR6BcyzA2a2yjJmHPmD3YoAPVuztA5B
         nPyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzjIV6ioMZPlpd74Fzn1BKT+/oRxwUad6sn1if7SMLLs0rvlKlsYTQTZGPzF1rsJ5LfsiXog0u5EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXpsswXIZsnNX8Arvxc6ZPzHzDjtloD/xoPO8Jg/4VZcaqRI+o
	ffxm5bAbeqbdjwo1T1EKGFStSH0KSqtu7WG+6wl6Xii/1abKiXeFH+90GWoXlkhMgw==
X-Gm-Gg: AR+sD11VQfhDcFvYQzAKZwEiVB1y3V96nrla7BFVvEb4M7PlH6WWx/0297DiGsFylYH
	D9MyQjX9SP9GZslEzn18QHpWVORINSAggdTNfputirkh1uP0NF6TkK2NGge2i6nfVV0B5MMs2Hy
	8rXmln5jGI+TDHszc/Aep6RUQFjTMt7y33XG8g2k3fsrpUl/50HlCrmoRUeGzAovriOUkfEhRT2
	rn/kc4lME6nmlRsN/dnetdQtRI0ND5atkelntlc/qNWq//uwdVwSE54Y8tEIPYTr4fzpAIDxkb/
	U84E2SUsdgBq9BxRmvfnagPX8Qvi3wcxqbx2PiZliDsC8w1pjbs5tUVfJO6dqRfRmxpIVXF11OO
	KD825oj70qZ4ZmUH64jvrOvrNPbA7GiLLlg2OAIwrghbymF3UNBlS26tlRFJc7/WpR2iifpJ4ke
	kxl8zVVC4lHGS/JlDK2d631h8WanHqQ3ZItKKoeQyWgXMn2Ps=
X-Received: by 2002:a05:600c:1551:b0:495:5858:e163 with SMTP id 5b1f17b1804b1-4955858e1damr203016475e9.27.1784746751519;
        Wed, 22 Jul 2026 11:59:11 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:11 -0700 (PDT)
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
Subject: [PATCH v4 6/9] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Wed, 22 Jul 2026 20:58:38 +0200
Message-ID: <20260722185841.449934-7-mykola@meshstor.io>
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1.c  | 3 +++
 drivers/md/raid10.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index f07edeac6e5a..19c4dec450de 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2561,6 +2561,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 		}
 
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 		wbio->bi_iter.bi_sector = r1_bio->sector;
 		wbio->bi_iter.bi_size = r1_bio->sectors << 9;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 5b63175fb382..428bddddfe71 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2823,6 +2823,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 		wbio->bi_iter.bi_sector = wsector +
 				   choose_data_offset(r10_bio, rdev);
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 
 		if (submit_bio_wait(wbio) &&
 		    !rdev_set_badblocks(rdev, wsector, sectors, 0)) {
-- 
2.52.0

