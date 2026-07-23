Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73341B8D9
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 20:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839396; cv=none; b=UnyRFxZAvXrQXGQFB0u9PKctT6KWqs/Cw0vlT6RxjOWhPaqjLTJcmURNynJZ16ikfAwrYab2eW9s3RMEm6CMfymSGki2VJnXwdRIrO1o0yIxDi+IK+FRLebyBJvb2CNCa0o06TsK8FkJWxvQiHMcsYyJCBGvWaxyMRA9SeGv4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839396; c=relaxed/simple;
	bh=6JUXonkvhqCluPq91YNslI6Xc6PHhaJJ82TMx9QRo24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpSA8noSSOzMoyXp7785V+qzuN3z6pafSfIEIMmc4m6VCATvIpY+Qk4AD8EwzvuFCoi4kDPD7V9BUDfCE2+Y8OcV+ltplyDeAhIkbFcf/c6EOu3jbY7ykz4ROXEhDO2jZruc1xR3qysq1rewIaJNs3z8VssCYENIFM1iufAoyOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=b9TCH004; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="b9TCH004"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4728c12ba97so667177f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 13:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839387; x=1785444187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=b9TCH004kM7Ijzlq2L+uYapxZbsJtgiPIoccs97iLOok/j4G0z9BoSi7OGTZzfNraM
         9nBbybkLeR3kaqz8qibH9iQR2/+3QMIg8k9UtqWVXdcUsUBX4RdymARurgQLc9PBz+tX
         cU1oMcOcw42w0OxGq4UZ131+iaLE2py0jzPsTM1peGRNz2HSGRqdZT2XUA1zms+v/aFP
         RSKb39m9qHn/9kGElrHMfdLkSFCt2vA+ObV319T3/Q3iv30jBdhCVHMR7mKE0DXcTuWe
         tR1+ya8cQ5UblTusXMB+XkhJKb/d+KQIXTWrnGw3X47bbkfgMA0AmX7SlpGUHEbpPpM4
         +F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839387; x=1785444187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=CSOfEUj9OZQrAc6EUy2XY2DmgCnKLVUYXZHERH9SiEO83tC9Tfr8krS1pIhX3i6/d3
         nfa0Bl3jCkMIwEJiZt3rasv+3NX7QfuBWWcwPc+CS25MbveN7NDL3MFKlCEo+ZhbFNOC
         rthJqKiSXcT3tkUKfgmTXJflYFumc0PMoAXFdizGtee04TBAnTLd6m2HOH3a1xtKJOtT
         J6x9tB/blzhZqbKeI8hp/DVr4SQ+x186VADjpFozOdcKahtOKt9CneS5c3iC18uFwSIV
         AUYhM4fWWAo29Nt3HQpD2dVejO8hKz7233MgQ+BuX2vSSMuPMfWoaphyeFzhYZllZz0J
         aalA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3zO+K0bixMGZGf/FRe9qJBSRzyiH/oJ21PtWDz36RvI5UhECDmP3oYtD2fni5M8Imb1YNXc8x8cY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZBIhbxlQmDGiw0FCoD4rmoriLocsiGqzW/xKCZ9F9QX1fPIw
	+6mumtijB2k51pueVRtD73L72+oX6PtdQox92cWIx6SfMzb8Ys+uFPT/WbvncKZ11w==
X-Gm-Gg: AR+sD11sAl0zqX+1e1fcc0L6aIiaEFdAvSKVUddOywVAC0NO38CBSTG893eMNks2had
	sr0hG+6ZZZgTpUm90B1FWnuUuc//rEuQ0LGlBp5paFHL+0pTWwFQnWanFrxYfK338beiMrNG8GV
	cNj95Qtj9GS8sMiabfP2GY+U2byR8gcyahttbAdmpI9EcY6ZKCkWC38JYJ1Nnf5DW+F76k+mqta
	9IdHBlM4ROJQEQuNjnH6E+syYEGNnvRmiLPZzvMbvbozlnJ58XKNE2l+rxLPkQ4bMYlvFcc7C+N
	uhtFHdYyCc7WQqHCqqBWOYGvtrtgncTlMdOOCMLBB/qqc8kN9y+T18szvHN3dETzF/SlBil4e1k
	M92vGkDsgm1hl9GOOm7kHQueNQG2CpdFCoypDkHfmkKl/iDlsBAzTlFLdiF4AK/FVRMKayYoFe/
	ZD5Fm9pUBn/d1X7IS3qHvih6+PZHNKUYnVGOI7MjAPFvXPb5QLjWx4FYP5u9MTq/5efiXxNCgpg
	bgmqFHRLndyPqaXGmQnRqiwADlFMaNKW1lw9/qlCw==
X-Received: by 2002:a05:6000:611:b0:47f:25b1:e7b6 with SMTP id ffacd0b85a97d-47f8dc7a211mr5521629f8f.30.1784839386364;
        Thu, 23 Jul 2026 13:43:06 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:05 -0700 (PDT)
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
Subject: [PATCH v5 06/10] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Thu, 23 Jul 2026 22:42:02 +0200
Message-ID: <20260723204206.76930-7-mykola@meshstor.io>
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

