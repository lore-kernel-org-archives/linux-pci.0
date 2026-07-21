Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C1B46F4A5
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655973; cv=none; b=sqBcvb1KhFMVOVaxQVVtk4mbIRWXWJSdrBNE7SpKcY5NdVeUZNenhc5PpcGkD2LeFSHn8PC7Dd2XsHfMQSX2eKvLgigafeCXIWefBJ8C0vsWtslqeyDt0IYwd4q4JKQkUaRzoZAiSL01m/aWqEZZPaAbT+iEq4p7274nZ+C3a08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655973; c=relaxed/simple;
	bh=2hXrMq9EcVe8qu/MqiwSrwMrpbLS1aTcErxtzRiVgss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiVaKiE7bXAUGkmn66QtJrinre7S5g5LAngN7mEaVyEyjN8S77SHW01cCDtKfJbD1G2fSOJhCgvpL+mUMwnbmbyze8FxV6se73FpoF1fCdi5WGZaqqnIGADlVEgq3FOe/Bchf/1Q+lAi0lFVH1M58huCsh9T2yfdmwa4y+pHW/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=KhRbw6Mw; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="KhRbw6Mw"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49548e01d02so21343095e9.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784655970; x=1785260770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yn3hWNKXTlSTf/hzkreGnovc9sItcGhl/RSESOOgGvw=;
        b=KhRbw6MwzUd7bmMo0hV4z9+afj8sqjGTYv73xy6EeRCBt96GRnE1E6SzHul1x+s1O0
         9DqH8N1S30ibm9hDorMJgvv2sLDeIR4YCrcAGgFkOqCKdyLp43eSt1hsTWKuN4aqMEL+
         0DQ91igtVJipG2Ykkq5dppdt87wMOMHOEirEl6NljGbSqx4HmhMM3cfHbYxDiDgapclo
         RFHXQdxP/QrMCc5itBCIA2wE3yJoFbTs2n6096hPv/4W6BWJVMJM8D8mpaAWelTwqB5B
         8HxCA6PfnK3y+ZCnwSFUGWb/3PpAeIlHDLiiiaer1vtOe2QiYKWPd+bbGp356lvGTjcW
         f+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655970; x=1785260770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yn3hWNKXTlSTf/hzkreGnovc9sItcGhl/RSESOOgGvw=;
        b=nQY68RKqI02TeguqkenNe6bwQbd/HIaLcSi54qh0FlcLlCKEe6CwhFFzpb5a+cGWxu
         ViLB4S4MO9LOQcKwiWCd5awfJkWue+sCJbR0SBQf75GhBt+8LflllcXHWiCXUe45tAj1
         4NiqAp3sc3CyjLpxX2C2+1jBBFq/gKv9H5RPXqQ2R5MA3bAjWAx08BTMRRgsTT7D9j3a
         5yu3Q78FWR81mLY/T6dwXvwbi8kJjzAlKU5rsELnszAgg0s7UTxtWhe9zVX0NoMKBxOn
         X38Yth2RQFkSTYJwo8uK701cgUXUVT7liihkgRcXqriABiUz2VqMw08KQO29hpJgsrYD
         6K8A==
X-Forwarded-Encrypted: i=1; AHgh+Rqn3wsN2tbuDHc0t344Lw0d9z5NFI39jks83fRVUUDgxbsfGZJuV06df6sdOsPRvB/LZXyKI8Rmvsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPgMwmBwVjVpiKTeHqZFPw5/yAzcPFm7mIuVo6qTmRtCNobh12
	Tx1mbmuiV/1N6Q6i1nFGWVnQIz24xv4IGXmKZQTNw2miEpyXzp+zt3HlqoPe/UuMzg==
X-Gm-Gg: AfdE7cmWphs908RNUHC8qM3BOYuPfv4aox0TJsMHBtRDDcqSI+HhCsZfHMXewl1jzSl
	KtOIZ/UpgTCDhl3+N6sZH3wyEBB6n8aBbemm/ne4EaDdwDDQxb5kYRN0ynTzVP5OipbKi0tz9DA
	bqTLEuOV8BnAap2PXkxLwsuuEU9fjqkiRnvPyEgZ5U2ENYk8o1fawJvGTqzxbAxNHQUJ0q3wBz/
	S3vvbb7rJSJwAPl8+tN2ycgP/6Cnuv8dCI41YnEOKyfmhzO4RAn56SctNjiLtDtEFb9cOPNff0a
	i4+wbFtQRZOi/Ofeq/oVjeYitHLckNAZ6zBOGR1c9bOfBPtGWkeNI3ZeYEDXtg1mAkB6ccNAQi+
	kXBwsLR/rbePyfsW6wtIzBjbIJZ1Txb62esK71dtYy2Sz7zkCtnzF0DmXmNk67t17mv/KH6noLV
	5+odw5w7LD628zeVWlqqP5+x6lPJPvQiVKxskU4nRlEY2ioHOdkXj9WDl0zQ==
X-Received: by 2002:a05:600c:2908:b0:493:bb6b:5bb5 with SMTP id 5b1f17b1804b1-4954a3dcc67mr172161575e9.13.1784655970189;
        Tue, 21 Jul 2026 10:46:10 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63eddd27sm40860513f8f.28.2026.07.21.10.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:46:09 -0700 (PDT)
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
Subject: [PATCH v3 5/8] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Tue, 21 Jul 2026 19:44:59 +0200
Message-ID: <20260721174502.111503-6-mykola@meshstor.io>
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
index 7d769b6460ca..16b7465c233a 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2570,6 +2570,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
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
2.52.0

