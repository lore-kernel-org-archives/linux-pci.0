Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED813B47CC
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 20:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839393; cv=none; b=DX3pOt7dPxOn5A1jJVMxUvqwFZT2P8oYkOUA1/fCd7rxPniBuKGBYhXFrs/BBYTymL//3AfueWrhscv2ITV7eDEORIIdOR+iJuIHThKJkzA525kbVOYrlckH4mHQvyTTsfcAQgow6UV9MX68z4YtHFmAgplPU47ooA0sWXpQxmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839393; c=relaxed/simple;
	bh=B1aIegApdgScj51bEIGVKX+FENfztmE4q/fjJ31TwzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROsxHY4gCFSrreoSdVJUAk2UNZcXcJzd/Pyu4ZusdW/+z0t/SiCqenWvid3gZkMchPqgHRN0/NCnOkkXykK8LwKJuaWE4Mu54UG6IQpmC/7XLUjIrA8pnyRG6fBel4xS+Px2BRFf9n+nIA8bRwywuUjch856O6xlk6gsyf42Mmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=Vh+j2fYI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="Vh+j2fYI"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f7027ca11so691074f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 13:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839384; x=1785444184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=;
        b=Vh+j2fYIAAlwbHOWPa/hK7YJWC5+OwIKFTcBSfP8hHCijIILORAWmxr+3P6EqtVgzQ
         oACyPP5VymPVgFWCa/QsQudx1SiPEkxSbl4CZCkvael5lKoYxr44301de+BaY1DHKx1Y
         6IPDD2uMr7JW+vQai4Y1xq+/OsXG253cfNngZ5segD6cZdlkvG7azAk6yykodkYdvWPK
         RtLLvBOhOAh2gPOF3sYAwcELt5tsgEx5JZqh1Vr2AzLiV8UubU30Mj1mWCQYdLN27sgK
         UmUfC/LqYccptvEscUmHWmKlPg5h8kr5V0GVmAssdlPsheM+DsAHMp5wdTObvg9HvfY9
         BMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839384; x=1785444184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vP39KbYqkNNRmuPyaoPhdZlQ+sTmuJQGW6DJY4lSzaU=;
        b=RFRGJ/SmBwY6A3MBaAJMdYbwwcmupmVmVote/+qc9X1ZWNUWu6tlOmvH84KPj7FsPn
         8hUt2jINAhNHMJXJ2qAx4vqacg/AYxJvqx7mYewYcxY1e5B6Or9B0QNehFkVw6YtMxdp
         iRvTQKdnbUtg1kA96D2OCAQ0LTkptfE4VOrj6+HMT23HTa9Jm9nFR8UQFeEq1lHWMFj6
         F5rgEZsGrqML7EVjbHjh17A4VgHAW9wcdtCtjXB31TP1gZFpP+q6gxx1EHVO4bqnkm7d
         BnjMTIj8KzN1siGwD3D1Js3hE25H7Qq+gURojX6B8FRK6D6UZUNam82P8dyLn2MtkocQ
         Y6Ig==
X-Forwarded-Encrypted: i=1; AHgh+RoBn1KGiEVEdwrKkOzlUsA3Yku8ZQjIEM4P6jt6sa/bkxBIKpQ66hwjLbMVnmHXPXVtvXgTCwIvXg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9SXw+9CYh3kJIityoE3KgQhOOLJ30EmVIM26usGziXRRT6FuH
	ujA81JrwMMtpI43frXuaMwKgsGF7hBme6PPh0SvFMNQWoqUKZkPCyDiLf3QPi8mK+Q==
X-Gm-Gg: AR+sD11xesd3PqZM3DnNuLvPPa/Fra+QO45dABzHmquwy0kQTVgmrEXWTBCiIdtErt6
	IALuUHpUU7qQ5upnrZX7CL6Yh/dqOWzqh98gg975KOu24uvQfpvTmMeJcHiQcQoaI0TsqJDUhDK
	1Jd8/S3Q/FLN+rzNhkrcshJvf1vteHD1bKt0Pc60Na6V3fP7M8iZH85AUSWv8UWvg2GbccgRaq+
	3z4ZnKJ1+AH57HXGiDglhbq87IGagse5LYPaiJ93+R6lZu3r7Rcmkjmv5ukzMYIbChXOnmJY+Ut
	oM0BpI2APRRy8zHDcRVFueyxJzN24TiEEXwS3F4m6sDXtf6nZiHwtCQ4LX5ykRMSBvwrUXMzc5v
	AHc4qlfFg2s7aTglgCVYRcmo7pQbf+Er3zKi0qGNVTjMJ90ccQPDWiIFhZKxQxKN32+7OhHnjg+
	G/OW8xWeHmlbroQb2IRDXyl/nkL1WFs/xjJgiZj8G6PMc9m8tce+n0A76zWwuSb1lQOb7wpNAEt
	lc5id+fFdb5Bm/O3LAgRmOMYuFIPI9yDGWDB2kwTA==
X-Received: by 2002:a05:6000:1ac5:b0:47f:28e2:d4c4 with SMTP id ffacd0b85a97d-47f8da6e5bcmr6028034f8f.2.1784839384106;
        Thu, 23 Jul 2026 13:43:04 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:03 -0700 (PDT)
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
Subject: [PATCH v5 05/10] md/raid1,raid10: factor out raid1_write_error() helper
Date: Thu, 23 Jul 2026 22:42:01 +0200
Message-ID: <20260723204206.76930-6-mykola@meshstor.io>
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

