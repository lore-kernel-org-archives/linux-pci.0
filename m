Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C8F48383A
	for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839404; cv=none; b=APDAWIgXWeOqsCe0cvgfwX0adZc3m1zi0nu8UgtsTLv1b32FIoPkSgHAkz76DiiW4yuPUb5HwisowvHTQWParEzKQegguzUIys6TWMMujqlx4r+RXEl9VcovHPIxeyy1EitJRLbP38zjjFl0Lb4yeDWFRGSw+I/mDIykN/RTIYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839404; c=relaxed/simple;
	bh=sQcSSX/jufOA+fic/HSdeMNwwQDiSrn4ZEB0dsr0Z0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTAX43pTO2Hu/fEvcBTBqwcK7ECA647YqlpkFIKllMhEnylj/2ITGq2/9C1x+yEE+UVEqxGdWGCgsG4mrqBvYfjnSDsmw8mM1gy4lGZxqLAH58/ioGz4loJtaG5VMGbsdH2SUldTS5RzS//K2PQGZrAyTYCiabZ2QJEdHR0EaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=A0PhEHmn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="A0PhEHmn"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f633e6058so950443f8f.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2026 13:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839393; x=1785444193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlFyTwpdvsIeETeN6SJHO+G4KnBBWZplfaizFoTi1JY=;
        b=A0PhEHmnTJ9+QVVolXbcvu7kUytNNzkuhnHI49ebvWjAT6aQC68XJXaZrWn7EYoFv5
         UIO5jsHccWyUmv7Nv/1ttGqpO6WGslxxl0LC7v3d2+kqu8O6A4jeX57CmWsLOJU5+l07
         JUMPQJJdBfPptyNw5ZmEZpCs6++PzJKMUNnrMRAA6hdTyIF/T/F4TH/OpLZvYP8EtPdH
         axSjIMMIRo/9Qv11/Sq3CpM7Sp/JMxKM93gVOS9NxH9ur9U9e2WTf5uKUKO+kc1gb6gb
         DoXu81Q0TiGqj9JO1cZDqx/lBMgNGlBkDNSOWle9RU93/xX2Cd5Xm0D106GZydDPVLmQ
         bwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839393; x=1785444193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wlFyTwpdvsIeETeN6SJHO+G4KnBBWZplfaizFoTi1JY=;
        b=pTr0ZU+2CVO2gVmAchcLN1JAh7C9uHArUEfz3ANnvcJoeSTBj7QS2u8Nwokczvu6uP
         X3aooPugqsZh1b4oAeoMpni5511BBmgjC/1Q3Xq0SGQKb5DkE4B0O4C7h7IhXcZ3jWg5
         ww/mWW+XfP612IRHVDqxecKy5eTJdSEt1gMamiiDoI0dmLXrLfH7UESWgJ4PVK7OxBzQ
         ZJ2jUQ/mBkOtxgJeQ4dLahqLcntsrpL4dqJk3/U+H4oYN8BI8MnFpTNWp3T6Tpq7sY45
         cTXwd8Fx9qLHpFe77NJHtA6fGagyK2cCAneN3BXszidULMFNihzue8EYS9j/nfZqSf+u
         TBQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpPMEmnXhS7amX1OInkbd9uIXmpytnNHZpZlaq1frnLJbMiVipk+uKRhC6dLU+i4+ty7aLseqxycJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/HPhvvJmh1wJumu3lavQapJK1cMAezpPib77VY+hVku3WLfiV
	EytqiJbv/gPqSzKPOFh+8UYu78WipVn3vezLMDtngcFK2cb729hLCJQGmymaYET5gQAPFdM9L1I
	kB0Wc6w==
X-Gm-Gg: AR+sD11K/qKwMOULVZG4AVnx5L4jDKyeEylvNqk3gpup7MOSx1AxuTWO8+BSLDUtH7W
	eogDfLsgBQyF/WBSWNUV6Ke2vNQSRkFc30d17X/G27QfrX/fhZGUhJNjS1d6QsLue+qfc1UBmcg
	kyYMonLGJNwymA/oZpdpyL6vaYzgJbQQaRziJ7DETC/k2bBGllgOVzrbK9nCq0SeUIGrlgOYonL
	EjgFBvWPYgOnCWZSPTHpq8b7VoIFAlMkSJwNvMyTriv2qChHCQnvpjb51kVpqs5caYqnWo3SLo9
	vEsh4fYErIQiXhh4X4b+YmTIIyyNSFAvP+eoo+dj2Z1oIx3huIMslq4nl+gG1MhZq1lk6F270cO
	DVhpIAqcFWXsF3tr3dnUXHaZ6g/ptOEqSxk8zc+2y9r2e1+HQ6yXeRAAZCfnM45CLuNQhcZTG1w
	KQDA74HOGv7pxZaCrz7sqX0G1Vi9qRftybTe/wQGR4pa1MGH5o3utgVwnhTwExHbSXSRAm9Ar2L
	BCxtMhPPkBONy5dli2AfmPxu/OugWzlKg1iu7GwFQ==
X-Received: by 2002:a05:6000:4203:b0:47f:7b75:61a with SMTP id ffacd0b85a97d-47f8d71f494mr6221114f8f.15.1784839392888;
        Thu, 23 Jul 2026 13:43:12 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:12 -0700 (PDT)
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
Subject: [PATCH v5 09/10] nvme-rdma: use ib_dma_map_sgtable_attrs()
Date: Thu, 23 Jul 2026 22:42:05 +0200
Message-ID: <20260723204206.76930-10-mykola@meshstor.io>
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

ib_dma_map_sg() folds every mapping error into a zero return, losing
the DMA layer's error code.  Switch both scatterlist mappings to
ib_dma_map_sgtable_attrs(), which preserves it for the next patch to
act on.  No behavior change: failures are still reported as -EIO.

A local sg_table is needed: dma_map_sgtable() maps orig_nents
entries, and the embedded table's orig_nents is the allocated count,
not the count blk_rq_map_sg() produced.  rdma_rw_ctx_init() does the
same.

Assisted-by: Claude:claude-fable-5
Cc: stable@vger.kernel.org # v7.1
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..63830334c73e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1469,6 +1469,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		int *count, int *pi_count)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct sg_table sgt;
 	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
@@ -1480,12 +1481,16 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
 
-	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
-			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
+	sgt = (struct sg_table) {
+		.sgl		= req->data_sgl.sg_table.sgl,
+		.orig_nents	= req->data_sgl.nents,
+	};
+	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+	if (unlikely(ret)) {
 		ret = -EIO;
 		goto out_free_table;
 	}
+	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
 		req->metadata_sgl->sg_table.sgl =
@@ -1501,14 +1506,16 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq,
 				req->metadata_sgl->sg_table.sgl);
-		*pi_count = ib_dma_map_sg(ibdev,
-					  req->metadata_sgl->sg_table.sgl,
-					  req->metadata_sgl->nents,
-					  rq_dma_dir(rq));
-		if (unlikely(*pi_count <= 0)) {
+		sgt = (struct sg_table) {
+			.sgl		= req->metadata_sgl->sg_table.sgl,
+			.orig_nents	= req->metadata_sgl->nents,
+		};
+		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+		if (unlikely(ret)) {
 			ret = -EIO;
 			goto out_free_pi_table;
 		}
+		*pi_count = sgt.nents;
 	}
 
 	return 0;
-- 
2.52.0

