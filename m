Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550083822B1
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746760; cv=none; b=PPS0FDdWOYGyvzNEXbckLBKcg7rxtlsoBO41MOlT9+F57GsVE7fcP5lZiUnOae9E41xSeAZSYoFf75LfvchtJ7cnErgxKkElyxVPEwyYi5esN6pnFjQI5sgXi9VwWfDAar5VSsz6AVD7bpUdsEGXRLTzXI9s/xCWIFOu/zdWhTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746760; c=relaxed/simple;
	bh=B1aIegApdgScj51bEIGVKX+FENfztmE4q/fjJ31TwzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwTSmNDoddY1+qY/Bg8zT26folmb2Nq2Nn13YTWthfnYLuvKdcokSh8ngWo7HUBDlAIehjO2YTVyRXCrvKwG7wyTe1WsNROCXH4ccciawHUWZzvgjwPUvvwac+EffbGdXMFKueEfpc4FEHl5EbcSCOhF5vOxJ0suq5+aX9WuMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=YG3QqS7J; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="YG3QqS7J"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49548e01d02so27530375e9.0
        for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746749; x=1785351549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=;
        b=YG3QqS7Jid6IqJYT0W7IiR1qx0yowOy6yEbFhcrhAtS3pKtMdicZN82yqP+/8j0Hhl
         hf2tGciLP7iSxi/MovmA5oJLfV4L7DaEnA+J3Xop0aDrc8Uzb53Y/lhJoR6dABf5MpGd
         bE80Cyj0DHk1mTrQOaGh9JRDTnFGNlk0BEkx4irU0EZq4N/8pxv9fVFGsGEQQYidwuPw
         5Ka1UuYw99pGXAYaP5Z6miKfuA6guPZDTvvj0qlqK2GEoOvsV5/s052JTkFrcGYeaWjM
         4ZiGgdfbhyUGN8eQk8gJafo4CwRzSAj8VaXAN/20FDG4mv3q5HZwhGyP1aPXdGxIF/Hf
         lhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746749; x=1785351549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=;
        b=BVQVmf0qEb44g0OaHkQFG+dfi+kDtZqq73kryjlQvP0lmoqUg6aAUhPX2jDzTpFdE0
         7XzPST1xaLu1Tg+GvXVWn5/L0wCtg3IcMezgKZw76XQ6bjY7E3lhePAxIstOMBUvGfEF
         92AVvLyO93NpVYlpKd+LXEM2h/DFjkX9WAJ9FCJC4hrPTti0sSaAEGxPumH3VctATdF3
         zQjJp397edkn6kissfr8lnwyAFO/+BY9J2bZYFq0s5fYEWx8D/48EQd9GfLuihDb6XV1
         nUWA4YyWSaiX31MVZyDOscEMb10uzelSfZns1pC6ZGtqO3nTT1+XKlgNp5OoICHmUgIY
         4lWA==
X-Forwarded-Encrypted: i=1; AHgh+RrxxR9sFDJFz7i1PGI6RrR3yl5P8o9UyMkutXaYhZA2d2tyKzz0oaDHj8aeb8/Lyz79gjMafLO/q98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDq34nBOTB3wzIvnHVHOLW3oinl/DUURAyVyJrt8X9LSK3tv5p
	OkohoUOUE98/uPnERnavxrjZILsCwGEoug7il9B6aYAvgZS93HcIKXW1n3JRBpcsFg==
X-Gm-Gg: AR+sD12XHp7d+iGbwNCAHRBJ2IDnicAiYQrHWkPxU0J2sZMHgpTKZleRNPPM4CF6zj1
	In3AkiRZ9+zByzwxXAASqiEi4tsK2SJgopnr/sdz5Icgy43BSiF995Mm+T9W6ah639WcdKWjpKm
	8VvXuDhfINExfv66y02gWxraI9Y9XOHhvOijcCK9+EbmjsBk0U9NdmBvthIP2q3wDLQ0rXL7tqa
	f9DybTkKz9T8/8b6viAn78HAq/Nolkz1C5kF6WrBDT2mRK1zxVv5EJDLBbYq870pAS2jv3Ug4RS
	1kQDxggpapK/unTSOY4hjr2PQkxVaFXeTBNnzCtPZ4HrIsgVShi2bTS6U/R28y4AJS/L/hGofrD
	yXl7hr8JX3eq9gdaiJIz1TRLqcrDe4fAbvaKP4CX5l2no0APTlwli6jGyegC0An0s5WY5SoMHwD
	e5bSGgYPA57Onclm0OlLM1IpAFoNrWMYWISV+t55C2m/6FPo0=
X-Received: by 2002:a05:600c:5490:b0:495:6130:7805 with SMTP id 5b1f17b1804b1-49561307a51mr135357485e9.14.1784746749133;
        Wed, 22 Jul 2026 11:59:09 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:59:08 -0700 (PDT)
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
Subject: [PATCH v4 5/9] md/raid1,raid10: factor out raid1_write_error() helper
Date: Wed, 22 Jul 2026 20:58:37 +0200
Message-ID: <20260722185841.449934-6-mykola@meshstor.io>
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

Factor out a common raid1_write_error() helper from raid1.c and
raid10.c.

This will help reduce code duplication in subsequent patches.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1-10.c | 13 +++++++++++++
 drivers/md/raid1.c    | 13 ++-----------
 drivers/md/raid10.c   | 10 +---------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 56a56a4da4f8..cee21452e066 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -303,3 +303,16 @@ static inline bool raid1_should_handle_error(struct bio *bio)
 	return !(bio->bi_opf & (REQ_RAHEAD | REQ_NOWAIT)) &&
 		bio->bi_status != BLK_STS_INVAL;
 }
+
+static inline void raid1_write_error(struct mddev *mddev, struct md_rdev *rdev,
+				     struct bio *bio, bool allow_failfast)
+{
+	set_bit(WriteErrorSeen, &rdev->flags);
+
+	if (!test_and_set_bit(WantReplacement, &rdev->flags))
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+
+	if (allow_failfast && test_bit(FailFast, &rdev->flags) &&
+	    (bio->bi_opf & MD_FAILFAST))
+		md_error(mddev, rdev);
+}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 7d769b6460ca..f07edeac6e5a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -483,17 +483,8 @@ static void raid1_end_write_request(struct bio *bio)
 	 * 'one mirror IO has finished' event handler:
 	 */
 	if (bio->bi_status && !ignore_error) {
-		set_bit(WriteErrorSeen,	&rdev->flags);
-		if (!test_and_set_bit(WantReplacement, &rdev->flags))
-			set_bit(MD_RECOVERY_NEEDED, &
-				conf->mddev->recovery);
-
-		if (test_bit(FailFast, &rdev->flags) &&
-		    (bio->bi_opf & MD_FAILFAST) &&
-		    /* We never try FailFast to WriteMostly devices */
-		    !test_bit(WriteMostly, &rdev->flags)) {
-			md_error(r1_bio->mddev, rdev);
-		}
+		raid1_write_error(conf->mddev, rdev, bio,
+				  !test_bit(WriteMostly, &rdev->flags));
 
 		/*
 		 * When the device is faulty, it is not necessary to
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0a3cfdd3f5df..5b63175fb382 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -482,16 +482,8 @@ static void raid10_end_write_request(struct bio *bio)
 			 */
 			md_error(rdev->mddev, rdev);
 		else {
-			set_bit(WriteErrorSeen,	&rdev->flags);
-			if (!test_and_set_bit(WantReplacement, &rdev->flags))
-				set_bit(MD_RECOVERY_NEEDED,
-					&rdev->mddev->recovery);
-
 			dec_rdev = 0;
-			if (test_bit(FailFast, &rdev->flags) &&
-			    (bio->bi_opf & MD_FAILFAST)) {
-				md_error(rdev->mddev, rdev);
-			}
+			raid1_write_error(rdev->mddev, rdev, bio, true);
 
 			/*
 			 * When the device is faulty, it is not necessary to
-- 
2.52.0

