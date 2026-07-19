Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404D39733E
	for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784458434; cv=none; b=EIDnYT9qOW2XLD/xw4/KW/namUmJhxMmYplBb4e3sgQY0rrH24/3Q66pTDe0JOvn5aQK2yH+nfP8SgwBnjkD6SP11y5IjiN/v9ED5LSAqBZ6Dt7V9CvC8Qr32mWUfAvk3ygZ7k3P3zx/4KLqMlyeClsnlooidHCd7BqI8UN9K1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784458434; c=relaxed/simple;
	bh=Xid0awo2BPFgwYW3JA18b5cCaSsnbZ06zZ7HCLlf580=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hx4zxkeOeMPtoGbhD6didGSLAdL1SFM3t0bTy1bSAwERcqpF13PabSS7t8t7Zv0fK/1xlkzySgBaWYBjtfONlQahS68z+MIcxR1IOpFjSXCS9pOZ1HUTAo5weBoy9AeCDZMUb73TlTALY25NEJ0Dfh/qyoPyzdeWi0sNV0S9Qdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=J3s+1T1M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="J3s+1T1M"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso7900005e9.3
        for <linux-pci@vger.kernel.org>; Sun, 19 Jul 2026 03:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784458429; x=1785063229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eF2tyKd52a4KRQgMXYm9m1FypwFqk/B2D9AlJ6vMM1U=;
        b=J3s+1T1My83t9a6sOGhu7PkD7F35JibCFhW0VmCBo2Ze29yjkDtpfX0+mleJw7Cpg2
         l4IYr2m4Ar+yiBOqhWU1Kb8EiHYLUeVIn6lPnrS0gAtRnSKHddBuofM0ZJHKyujUv1rZ
         R5ygBA/muqr2tvz1ycLCaAjJOBOvD3ITy9WwVbjHu4I2MVYG4Vck2VRx1ZJ+RHWQKdXz
         eHCH0D7fF3BDoojIReQ/cpmb/61Wtp6CMYHcsHsCWDumwJQ+Ctwlfo38koAVxqRvHDOV
         XYvcLArdH/DuSb1+Naerha2LnDXiLPiZMFvMjhrdNiVN1hgze3ZQpu6RYqOzwdrWJF1N
         /NnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784458429; x=1785063229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eF2tyKd52a4KRQgMXYm9m1FypwFqk/B2D9AlJ6vMM1U=;
        b=Kcesh24vW8wdpWlndo5HZm7wcYfan1KZamaAb0J+OzGyocHALb1ib2E1aVwaab8H2n
         MWv5NWwqh3NbSvCJatA7vCBKt1yeQA47vdR5RgqnIgrBLzTBdimegKxZSIuL7fEbbX2K
         mnzkRCIYwSexjSJiQzygAFh9Fc+hcPu9JyfHvon0UD4XygX8T36Jy1ZwvkZYPRms9Dsw
         CS2o0irDf9h+JDx6pXTQDNmXVCLV3Z6WUG6Y/Mfg1Fhaho4KV0kBU0sjgOtsF4btT/LM
         l/UcuKLL3DMJvYUtE8xBlTcQMZgHMnbmCP17mN+6AqLFuMvD73l7jmRpRmcKOIb8jzvg
         GX/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp/Ph+kaKy6HwI5xJJyW1q4UigYPFcywmzeNi4TAvtjQ6bnaJSHTi3YRjfV9VK2X/0uBylyNqp2/og=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuUXemjeXxft7V598Fumbul9os/c0kPge3rXWNnV7SGhHOIh03
	mgckdh83b+eR3rqmocQgGNkQGQ+jRH8SZ7SvwgYvSIb/ghFmNLUvsmcedHyUY0OGIg==
X-Gm-Gg: AfdE7cmeslIbdIwPFXX9dqi0hfhZ+EdB9S0hsmLL17Y+xx/iThygNDTkLqz2sj7Pn0y
	ukwLOlVWRIXvkUC9ruvnTk8rm3kjAKEtdNrS+v69bMr+2CQ+sjvNdwmpiXpoXJnkIyDFMGltZ5u
	ka3S3bD0FCy/5OvusjlbaYJAPpfemdlwoyBXYqfdPz45yr1alAvzdYZ4v+737qjJBQDlcLOiu8a
	fED1gklDmjF41mGlkgpHhDO2TWwuUJ9LzjYoVIW3cdqZZ0DuBjGR/9NqqMtLxiHR8VKTD7CB4j4
	IcsbIQUFw32pPlSdJ6mOkgoDgINPa/7HkQWpHYoLjhrl7wSvlaIuJick/nt+425wzTCfeYjevJg
	y9HQ5AB0ve8zn2oGyLwb6bfErZDnY+Z9dpZys5j1oXCY0WOF9GHnRhAoqoAG/0g==
X-Received: by 2002:a05:600c:528e:b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-4954a3eff48mr107049845e9.14.1784458428769;
        Sun, 19 Jul 2026 03:53:48 -0700 (PDT)
Received: from mf-00-01.. ([194.220.239.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm197679575e9.3.2026.07.19.03.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 03:53:48 -0700 (PDT)
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
Subject: [PATCH v2 7/7] nvme-rdma: return BLK_STS_TARGET for unsupported P2P transfers
Date: Sun, 19 Jul 2026 10:53:27 +0000
Message-ID: <20260719105327.864949-8-mykola@meshstor.io>
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

Since commit 23528aa3320a ("nvme: enable PCI P2PDMA support for RDMA
transport") nvme-rdma accepts P2PDMA bios, but a mapping failure for
peer memory the HCA cannot reach is misreported as a path error:
ib_dma_map_sg() returns 0, discarding the -EREMOTEIO that
dma_map_sgtable() documents for exactly this case, and the driver
converts it to -EIO -> nvme_host_path_error().

Under the default multipath configuration (the multipath head node
advertises BLK_FEAT_PCI_P2PDMA since commit fb0eeeed91f3
("nvme-multipath: enable PCI P2PDMA for multipath devices")) the
path-error status makes nvme_failover_req() requeue the bios with a
fresh retry budget each cycle, and since the mapping failure is a
deterministic property of the peer/device pairing the I/O simply
never completes: a hot requeue livelock, and a stacked md mirror
hangs instead of failing over to its other leg.  With
nvme_core.multipath=N the request burns nvme_max_retries requeues --
nothing ever reaching the wire -- and completes as
BLK_STS_TRANSPORT, which blk_path_error() classifies as retryable
and md/raid1,raid10 treat as a genuine device error: retry storms on
writes, read-error-budget eviction of a healthy member on reads (see
the preceding md patches, whose mapping-failure handling keys on
BLK_STS_TARGET).

Map both the data and the metadata scatterlists with
ib_dma_map_sgtable_attrs() so the DMA layer's error code is
preserved, and translate -EREMOTEIO to BLK_STS_TARGET: the
classification nvme-pci established in commit 91fb2b6052f7
("nvme-pci: convert to using dma_map_sgtable()") and the preceding
blk-mq-dma patch restores.  The metadata path needs the same
treatment because integrity buffers are not always host memory:
bio_integrity_map_user() allows P2P pages whenever the queue
advertises P2PDMA, and nvme-pci already maps P2P metadata.

Returning BLK_STS_TARGET from queue_rq is a deliberate trade-off: it
forecloses failover for a configuration where a sibling path through
a different HCA could reach the peer.  This matches nvme-pci, which
has returned BLK_STS_TARGET for unsupported P2P mappings since
that same commit and equally forecloses cross-controller failover;
distinguishing this-path-unreachable from all-paths-unreachable at
completion time would cost a spurious requeue cycle per I/O, and a
stacking consumer (md) routes around the leg one layer up.

Start the request only after mapping succeeds, as nvme-pci does: a
mapping failure now errors out of queue_rq on a not-yet-started
request, so nvme_mpath_start_request() accounting is never taken and
cannot leak on the direct blk-mq completion (this also closes the same
latent leak for mapping-failure BLK_STS_IOERR returns; the post-send
error tail is untouched). A mapping -ENOMEM now takes the existing
BLK_STS_RESOURCE branch instead of masquerading as a path error, and a
DMA-layer -EINVAL completes as BLK_STS_IOERR instead of a path error;
generic -EIO keeps today's host-path-error behavior, and virt-DMA
devices are unaffected. Ratelimit the map-failure message -- with an md
mirror steering peer-memory I/O around an unreachable leg it fires per
redirected I/O, not per rare event.

Fixes: 23528aa3320a ("nvme: enable PCI P2PDMA support for RDMA transport")
Cc: stable@vger.kernel.org # v7.1
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 42 +++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..9017d927edc4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1469,6 +1469,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		int *count, int *pi_count)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct sg_table sgt;
 	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
@@ -1480,12 +1481,14 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
 
-	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
-			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
-		ret = -EIO;
+	sgt = (struct sg_table) {
+		.sgl		= req->data_sgl.sg_table.sgl,
+		.orig_nents	= req->data_sgl.nents,
+	};
+	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+	if (unlikely(ret))
 		goto out_free_table;
-	}
+	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
 		req->metadata_sgl->sg_table.sgl =
@@ -1501,14 +1504,14 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq,
 				req->metadata_sgl->sg_table.sgl);
-		*pi_count = ib_dma_map_sg(ibdev,
-					  req->metadata_sgl->sg_table.sgl,
-					  req->metadata_sgl->nents,
-					  rq_dma_dir(rq));
-		if (unlikely(*pi_count <= 0)) {
-			ret = -EIO;
+		sgt = (struct sg_table) {
+			.sgl		= req->metadata_sgl->sg_table.sgl,
+			.orig_nents	= req->metadata_sgl->nents,
+		};
+		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+		if (unlikely(ret))
 			goto out_free_pi_table;
-		}
+		*pi_count = sgt.nents;
 	}
 
 	return 0;
@@ -2026,8 +2029,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto unmap_qe;
 
-	nvme_start_request(rq);
-
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    queue->pi_support &&
 	    (c->common.opcode == nvme_cmd_write ||
@@ -2039,11 +2040,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	err = nvme_rdma_map_data(queue, rq, c);
 	if (unlikely(err < 0)) {
-		dev_err(queue->ctrl->ctrl.device,
-			     "Failed to map data (%d)\n", err);
+		dev_err_ratelimited(queue->ctrl->ctrl.device,
+				    "Failed to map data (%d)\n", err);
 		goto err;
 	}
 
+	nvme_start_request(rq);
+
 	sqe->cqe.done = nvme_rdma_send_done;
 
 	ib_dma_sync_single_for_device(dev, sqe->dma,
@@ -2063,6 +2066,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		ret = nvme_host_path_error(rq);
 	else if (err == -ENOMEM || err == -EAGAIN)
 		ret = BLK_STS_RESOURCE;
+	/*
+	 * The DMA layer refused to map peer memory to this device: a
+	 * property of the pairing, not a path failure.  Match nvme-pci
+	 * and do not retry (see blk_path_error()).
+	 */
+	else if (err == -EREMOTEIO)
+		ret = BLK_STS_TARGET;
 	else
 		ret = BLK_STS_IOERR;
 	nvme_cleanup_cmd(rq);
-- 
2.43.0

