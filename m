Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F464823CA
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 20:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839397; cv=none; b=L29ifR2p/TL2/SNkaW0bg9kR/wUFnIs3y3rTtD26n6WZ3YLoiH8wR4UEtmyfc1QX5VhV9yq7f3Vr83knnXdEJltDwcCEGs0SaxYFVNa5IK+fhjPzvsWAWGeWegLQxX4uyAWBtZBA38QY1oqz+KVGwODtVRybhNV0bbvqmwQXk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839397; c=relaxed/simple;
	bh=1E+TY7i/EaKVM6Ai4S4WruKLMZDKABVE9DkE2+RPAms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkmUmWh6NK6e2SPDS2JCADjjQLltS+U2XTBGysClHsubxSsFSDKgTjVmFPDCA3zYswrlAzQGD++dqRuEP/hWdnVEu3W/6QcMZPSI83qYTEOqIVAG63U89WNfvwAyax67sEDFlPj/jdxnlSemOt2vR4NZyknasMelNaWjdmPGCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=f7HrgNst; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="f7HrgNst"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49553515a8bso11377305e9.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 13:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839389; x=1785444189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ii4b8aBCeGQxAV9y7kovFsk89PBwma3JtjswJc/vPQ=;
        b=f7HrgNst7G5OrUHnt81ledYHC7cH9MuwxYocukraxqKFrRYLJ3cE4qu7RATZtJaqH6
         hxzHUGAiWO56gs+RxSo2gcYhx3wcf803GyYcEMmMJd40B9sTTnCpBrlSmLZaM/kCyfmY
         o/qmKb9wP4IVNumAOV+s/ZrXrSBYjv2UMEH2YXHiLa6sgCJLzOWDsSn95fNWGzdM371J
         RmjKUeo+Rrd2eLNy+5MAN9//S1yD7feDAAxXprIteO4WNISR34g/hf3lhQSKMpc/q6Fz
         CCsLahqpLRdqSEeEZc88+tuyBJxQGYZIZOBBvelUnlrHUS9VxzRQy98T5B3bZDaupxcH
         bCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839389; x=1785444189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ii4b8aBCeGQxAV9y7kovFsk89PBwma3JtjswJc/vPQ=;
        b=mn3bbe0/fIJkGrGdTv+MQKffPKITOgQSuIvA1XBnOPas2nA1lpTCo56dAT7qO51GRZ
         5xb22xzqDbfnGrpOeA34j2R0P7LSKHS5ZQqpbgbfAH3mzWb/APyL+gk763uuKF58wXsp
         BHdWysHGZ6xHcW56m2/DLahHIVYMxTqiHOR66AHGBK+PoCil8mRkjqKCPNR+cJybYLOE
         xBTjyBZq3cPnjzY6jh48HvrXU79KWihWvjkOQavqrMooyAIFabpOFETuNRqo/oFYxXIU
         y4g1G/G/GZMHZDS4123kvfqDDdMDT/Bu+WQ9OdH/L7872gOqSb9L3f6O7oJsW9izfmzu
         Pk4Q==
X-Forwarded-Encrypted: i=1; AHgh+RrQTS289CyF6rP2khYVQE2T3IjMK9tBRUlcsAUdN13eFbsOFQOj9dlVIpPZTYU/OFPPlG7kZ88HyY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW1e1iUFy3OEIZ1RN4bm1Ttz6r4pL6DgWZxvnsbqIMsQ2t3wQw
	Xcy31HXG1u/+iJWEtm6Pz0Mk7SbEao4YuIxA4DBMG9yFf5qtbdlwlNNR14gZuaHwOg==
X-Gm-Gg: AR+sD12vV9EKJ2F4SgVMwYV3Wrv5/mQlFcC3giwhNKA+Kr9wQQ8a0mr0tBQm6J2fNhr
	gJrp75CjS8h5+LNdpJFVbn3RXOzVLCZueRe/URZ3ChBCdhjtQJULPOFDTzijvMmCj3fFmwd6Ogh
	Cr4gk33cMICgDe4uGuD8Z9waMEGgw80C5Qla1UBJrWezy7C/oPjhEKARzKHffk95OkGpWs5Qulu
	VZJrVIhbb2IbikUxf50vlGtXPJ95ZmZz13M35bHV+iwq6253bEC8sWerUPILkuIQ3NOfjqXss34
	IOLf8EjMHBebKSBZoAsbAf9JROWvIuJ9M5TRXYD4cHDr+Qy+TzKNQu9rdaFhc0RHZ1rOHKNO7WO
	WyXijpEQxVLU2kO5erzts8kXaDk1mSl2JSYG7ZhqIvVrlc+LJT805VsOER07ZCJ+8OSzQhH0M0E
	2CmZoCJg4CowCXORrq91v1BXVftzHGOoyxwSktGDQRy9tBxj4dbZfDRCU1KvNj/0ZfvAoqGMOBt
	/CwauqDkIa7Kjg40iYmNpHcI3vPoysb2gu/QVM9qQ==
X-Received: by 2002:a05:6000:4702:b0:475:f100:35f4 with SMTP id ffacd0b85a97d-47f8dca9a60mr5832815f8f.49.1784839388604;
        Thu, 23 Jul 2026 13:43:08 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:08 -0700 (PDT)
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
Subject: [PATCH v5 07/10] md/raid1,raid10: skip futile retries on P2PDMA mapping failures
Date: Thu, 23 Jul 2026 22:42:03 +0200
Message-ID: <20260723204206.76930-8-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1-10.c |  3 +++
 drivers/md/raid1.c    | 11 ++++++++---
 drivers/md/raid10.c   |  7 ++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

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
index 19c4dec450de..83ebf40237d5 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2624,10 +2624,15 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 			 * narrow down and record precise write
 			 * errors.
 			 */
+			struct md_rdev *rdev = conf->mirrors[m].rdev;
+
 			fail = true;
-			narrow_write_error(r1_bio, m);
-			rdev_dec_pending(conf->mirrors[m].rdev,
-					 conf->mddev);
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
index 428bddddfe71..77c7d8a59916 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2940,7 +2940,12 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 				rdev_dec_pending(rdev, conf->mddev);
 			} else if (bio != NULL && bio->bi_status) {
 				fail = true;
-				narrow_write_error(r10_bio, m);
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

