Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A463B637F
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839390; cv=none; b=IJbtzdgFHnLgeouImlPCJiRAErxHmKB7aqr1qgogU6MzeqRfS6MPXemsm/ye5FyuK9VXwLfb+mN5ULdPL3BSGlYUsCZExXX/urZDFkLLLMJgIyuAkhqUAxZN5fsd7SVuoOddCPy6KUnztqJFJ2O+Ubzh7JAou1sew1Aig1MEHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839390; c=relaxed/simple;
	bh=IeQBFCH3bM4bVxRkUROK9805WYYXPr2VLMisCc8LPq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kx0lc6Fu6X/RygDSi0XTEzTl5GgeMlGVHwqCULj+8dTL2Kgyq2HtBcL0nsJ7LBwpplXhPD74UBOBlpOlUdhU8Bkg1oUCxbThx2pkTwMZsWA6eQoMJ7hXfvEBuMR+GtzLRFCbiZRKq5yd2ST6Wvq4xbu7/IiF7lyhAUvFi2zBTPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=mF1+onUo; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="mF1+onUo"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4720f3bf164so588732f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839380; x=1785444180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xY1kaJm76bL7mULPuQYN6MgHSE4hk4KEujLtUR/lx4I=;
        b=mF1+onUoH8g5krZlDyx9lcBqRTRrF8paWBw3zaSjWmlVE6WvKJ0hEWSwfUYbccpbQ1
         t9YUnOrozr0YB0sILt9Ctur/Nz1zQ/+OXnwO4Yateq4zcnMQslQTbkXRAru/PCvt6s0v
         oJii8kk5FyPuMEupv9MF29Mgc1Y5C6bhNWmwe7p0TOW3xEArB6PLHLZqPweAU+ntzo1B
         ktrg4VEg0Gh8PWx+hQQgfsVKYPv7TvjDzrQV917gexA2Xy6m7/K6teAHHecYcbfbwQil
         nTYInJ/HyX7DpgOhTOvw6luyy1O0Q+pApnsCG6gVUm6a/fJMfcX/7HCemMP8nZ376T66
         QUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839380; x=1785444180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xY1kaJm76bL7mULPuQYN6MgHSE4hk4KEujLtUR/lx4I=;
        b=oZoIePBj5LzpTmJfGH2j3ipP51ZT5d6hz7Y4NPaeOy7FYuL+bohGdYRlitDsgN77UP
         c+IMr7izXTDAgkfUJ1uTkQXW4z3iA8jfL7oq3OJ4ks6tl0X6nxpszMG/Ou6J1ZQDOfUq
         ZyIf7qO7bDh4IplImwtD4Pp9PUAXDaRK3+GYFeQzedsaKGwtGtlfg03bqCE9rnU1npRG
         NKaHwa8P3vVrTEvWAxnK8jCboHeuz/zc2u8S1aCcMOxFGU1ESKa/pFwBYcAhgzczm3wZ
         ruNSireHbi4nZ00y5GjPe+D1eaQGO2BlTWxlE0dNJ2/weUC/g/ieYAq+E9U2sT0PGa5E
         VzeA==
X-Forwarded-Encrypted: i=1; AHgh+RoYXJf4l7CfKGriKxxi0ZfsA/NSRCg5qjEcpHITI7ZFPcdb1YMAKxvFRtgHzvOO/GrHqYfwwd3G0rI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1pE3iwNtJ8qCi5spjrBD2nX8UNjNby2dTTHmoY4fbzTstjGiH
	0FFSEEwAvMutYvP6YbSwg7mT8Gc//Igocw2p5q85pXs8CDgoMiYaSqmZIXg2TMPmdA==
X-Gm-Gg: AR+sD10dpyp09QHe7U172pr1QpYw4npWzOEGtsUBD72MqUOTY0i3hp5GJUzHpQtyiIR
	hMQNPWL55ljFruoHSpof5AD/DTVCSa0ROEHlz9X3KgKONJN3LrlSNINsmU00C1z03a8MQ5G66A/
	rhMS0Wnb6y+yLI7VgZxcxwFj0lAeq49WMwhDjg+50L1jgzRK28wMdDg79CxHEx9HBRzkmfjf1rS
	IIGSF8cr6SIid5Y/2dHDQvdXuPLgjcmmrDE6k2et5J+sgTsf9i86LF2ylhXvpVYOvr2kdw75XYw
	hxp92kKkKZPVaoSnfdJs2A/b/lRQHUm7LYxthQNDM0fOQxeevAVgmO4AqwHtPFq5GNJy5LY6f2q
	4dzj4VkUMNAullPxPDF5CNhYmL2zgmE/os5/jtj2Ns/nQbE0bbXnWsTuvqr3CCVKfxr9WkJ6Ro9
	gLp2+MmvNHD9SEiJgQnXRQoUqeNjylAr7D/7RvFVW7H+1jyjnURufR55atlvvqRajJ35n4LFB3b
	9pJoZ3jO0G8FyU/peMocY0ZtKWs3P2f/a4UHtiGwg==
X-Received: by 2002:a05:6000:2309:b0:47f:9208:9e4 with SMTP id ffacd0b85a97d-47f92080a4cmr4670984f8f.31.1784839379605;
        Thu, 23 Jul 2026 13:42:59 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:42:59 -0700 (PDT)
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
Subject: [PATCH v5 03/10] md/raid1: serialize non-write-behind writes on CollisionCheck rdevs
Date: Thu, 23 Jul 2026 22:41:59 +0200
Message-ID: <20260723204206.76930-4-mykola@meshstor.io>
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

A write that skips write-behind (full behind queue, a waiting
reader, failed behind-bio allocation) races the in-flight behind
write it overlaps: nothing orders the two on the write-mostly
member, and if the older behind data lands last the member keeps
stale data for sectors already acknowledged as rewritten.

Serialize on CollisionCheck, which marks exactly the rdevs owning a
serial tree: serialize_policy rdevs plus write-mostly members when
write-behind arms serialization -- the case the MD_SERIALIZE_POLICY
test misses.  remove_serial() under the same condition.  This also
avoids the old gate's latent NULL deref for rdevs hot-added under
serialize_policy (they never get a serial tree).

Fixes: 69df9cfc7042 ("raid1: serialize the overlap write")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index afe2ca96ad8c..997f79c05db7 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -564,7 +564,7 @@ static void raid1_end_write_request(struct bio *bio)
 				call_bio_endio(r1_bio);
 			}
 		}
-	} else if (test_bit(MD_SERIALIZE_POLICY, &rdev->mddev->flags))
+	} else if (test_bit(CollisionCheck, &rdev->flags))
 		remove_serial(rdev, lo, hi);
 	if (r1_bio->bios[mirror] == NULL)
 		rdev_dec_pending(rdev, conf->mddev);
@@ -1677,7 +1677,11 @@ static bool raid1_write_request(struct mddev *mddev, struct bio *bio,
 			mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO,
 					       &mddev->bio_set);
 
-			if (test_bit(MD_SERIALIZE_POLICY, &mddev->flags))
+			/*
+			 * CollisionCheck marks every rdev with a serial
+			 * tree; order against in-flight write-behind I/O.
+			 */
+			if (test_bit(CollisionCheck, &rdev->flags))
 				wait_for_serialization(rdev, r1_bio);
 		}
 
-- 
2.52.0

