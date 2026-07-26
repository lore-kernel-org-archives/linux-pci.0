Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA94F3AFB01
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065586; cv=none; b=o0i8T/hd8WKENPmbJbtsCi7OHquEA3woUKgJAhCiaeDA+SHva+8wVF7NVstlw8BgRcFcbxJLzO1SD6ZyK6Bd0Wr7qDLYfg8mmjoBPLkGffS5GlGHpGgrAwC+mrjdXDyoVVwc5JflhttQUMRq4eiOvRd6AcrG2uPSvTQAfLDdHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065586; c=relaxed/simple;
	bh=H9P5Xbuz/sTn32viro02mVv351LoCChcVH807+lKGhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxKkjDJ9+pvPtwsRwWszcBzy6oio3tifieze0wKdOLyhXnrApXgy+pDj7we8UJlbvvVEqEuoaAr3zc4CEN2CpiJhmxzzkjBkT0vu5vyv7e0dhwbBiYWiYUxKr6swD7cVGymVGHtULPrrRBulrfgtxpx/dkRvjOt9vKRXWrwdKlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=YTGLQV5z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="YTGLQV5z"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so3372115e9.2
        for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065582; x=1785670382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TkTyU0DB9gKJtEp9Pq/+q6fIrgCHRa+7wKH1kyBFfbo=;
        b=YTGLQV5zeW+uWE5H5f45Ba8jX453Zgmqv7NyXudf1gGa5hHvageH3GW27rUl69YSyP
         aH6aGIJIWVAbAFy9c7kgR8jUCVT2QyPJr2mvA9UMR+tjrbyTP5+Ly2eY7FNIYKCu8Eti
         PSgR0rKjktTrKpZNbvXv36SYcssiPLsSEw6owHID6d5NZkG2WflkK/TGKvvcqc3HxzJ1
         Zhi9eacNWuIJVltTn0T2H7uIpVSAr/gqyvZcHt87/TXppnkValvnNhjapQeBjYDSGAuU
         XmL6bLNp2qtAAr9dKqjTsyDAd5+NhNJm9cVxBjy/XH4UOLGp+kQlIro+Q3HOlJIv1IgC
         HH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065582; x=1785670382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TkTyU0DB9gKJtEp9Pq/+q6fIrgCHRa+7wKH1kyBFfbo=;
        b=OLQE8xjCJd1T5+nnG/LRXtEiIHTAzCAqlTi25tzbrr15LnR/L4vjPKOoLtSbV9ZMOX
         +MYzuAusaObJoWiQVgkV8s/JlB6Ri5e+6M7xiF/slGFet1Xvpugb0RPM7aDToXWSlfnw
         mv0SROCdXl9Quwej5ac4T3ogAFdETyRgMWI+ro6kk6W2sjYgxrvipxRvlqwGCMSPd5B9
         Ftvl41Uy2FctW+G4bQjIq6K2x/Rwp7koOuyjn83A8DMJNbyPVH5nAwCYYyAgjf8bs85K
         kCnuagTBhLW2F9T+76bV/RzSuAZTAMjmXvE4+NUiC/K2MFXcuL47S6pYEjmeivWbBw6H
         +0eA==
X-Forwarded-Encrypted: i=1; AHgh+RoJaRNXRRuufBOARdXj6KVo86edjbvbSwXDc58ia8aVMCq9o6AqypW17PCMZ+HQoA9Ln67BNHqrkc8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb+02362QujePI+e5Fc/dzqnxhItREHZQCwcrKWLZRydVueb/M
	taMwl2WcZOHJgMa4/nh7L8JDo/BtFGxDVo76CBrLMLz957K3N8xvbWUfdr+FCmh0Fw==
X-Gm-Gg: AR+sD11DC2RH66RyJY3u1dLHLFQqP0n2CBVr+QmzgnEMyJvKlpich06m0rcDVXoz4De
	GQorNn1LQXOrR2m8nHjPkoy6TGKoIiak/60X7lG8VoOmtqarh4h82YFgOOloiNxFWTAKRSm+goi
	qc5ktuXB4ZSdoqGxMQIuofClcWwT72DQDHLJzaD5EHcd03w7CYZY/IAM0jP23xavahPtKC614oH
	d+qhlO1TeR8PQGsmPqZ+6RHg7LYFACrhCyeWII8ysollxO2t1vFQQC9yUz3IAPA6FJi2vFkd0K3
	J8m7NU5hA56dWCeDJqpgLdNJzliB91NOJU80OTklWwxswVDRGt2JJp8lyLEWhjLQI0iYdATCVsS
	IGG78WnslV7u/a7UIJpIrTtPbHkLWfTGMRKMD2yHXmhUJPK146hogT0r84+y2AcLGIUBPZdRpRm
	SZMOncmrsibzlvHg0uaVZs9cOxXXd0iKjnaBW0txDzO5HCamPGPhxF2kx8aKGKjT0v1hMZmPvRW
	QB9uqp4z9XNJRmfYOn7QFQk0/AHKKyKfG6Og6XbJb58/vaF4TM4EcC9ZsOYJEHevzJXTLTqIWGp
	ZF/cLu9Toy3r6hV8z3FKrJrN
X-Received: by 2002:a05:600c:46cb:b0:493:f78f:cd70 with SMTP id 5b1f17b1804b1-496b76164b3mr52698745e9.18.1785065581534;
        Sun, 26 Jul 2026 04:33:01 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:33:01 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 12/12] nvme-rdma: factor out the scatterlist DMA mapping helper
Date: Sun, 26 Jul 2026 13:32:29 +0200
Message-ID: <20260726113229.2154269-13-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The data and the metadata mapping do the same thing: describe the
segments blk_rq_map_sg() produced in a local sg_table -- the embedded
one's orig_nents is the allocated size, not the valid-segment count --
map that, and hand back the DMA-mapped count.  Fold both into a
helper.

No functional change.

Suggested-by: Logan Gunthorpe <logang@deltatee.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 42 +++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2f50509a7a61..525e5aea65a1 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1465,11 +1465,33 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 	return -EINVAL;
 }
 
+/*
+ * Map the segments blk_rq_map_sg() produced.  They are described by a local
+ * sg_table because the embedded one's orig_nents is the allocated size, not
+ * the number of valid segments; rdma_rw_ctx_init() does the same.
+ */
+static int nvme_rdma_dma_map_sgl(struct ib_device *ibdev,
+		struct scatterlist *sgl, int nents,
+		enum dma_data_direction dir, int *count)
+{
+	struct sg_table sgt = {
+		.sgl		= sgl,
+		.orig_nents	= nents,
+	};
+	int ret;
+
+	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, dir, 0);
+	if (unlikely(ret))
+		return ret;
+
+	*count = sgt.nents;
+	return 0;
+}
+
 static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		int *count, int *pi_count)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
-	struct sg_table sgt;
 	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
@@ -1481,14 +1503,10 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
 
-	sgt = (struct sg_table) {
-		.sgl		= req->data_sgl.sg_table.sgl,
-		.orig_nents	= req->data_sgl.nents,
-	};
-	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+	ret = nvme_rdma_dma_map_sgl(ibdev, req->data_sgl.sg_table.sgl,
+				    req->data_sgl.nents, rq_dma_dir(rq), count);
 	if (unlikely(ret))
 		goto out_free_table;
-	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
 		req->metadata_sgl->sg_table.sgl =
@@ -1504,14 +1522,12 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq,
 				req->metadata_sgl->sg_table.sgl);
-		sgt = (struct sg_table) {
-			.sgl		= req->metadata_sgl->sg_table.sgl,
-			.orig_nents	= req->metadata_sgl->nents,
-		};
-		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+		ret = nvme_rdma_dma_map_sgl(ibdev,
+					    req->metadata_sgl->sg_table.sgl,
+					    req->metadata_sgl->nents,
+					    rq_dma_dir(rq), pi_count);
 		if (unlikely(ret))
 			goto out_free_pi_table;
-		*pi_count = sgt.nents;
 	}
 
 	return 0;
-- 
2.52.0

