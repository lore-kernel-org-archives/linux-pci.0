Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77033C10A0
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784148676; cv=none; b=VXf+/Y3B/xzHr7HLhiAbIKQdwyb4hCs2ljWpuWtcyI/GvTVVJJg65QmvXcHZzvKRv6xNwOuTfalYLzeG3TYn/HNAKbfa0NLBdBnVcEtLWh7KOAiCZS3R0bxPgPxHex67yxbqH2tCF9HC5wXGLaLLdlqRnBf5D3vxvE364jTiqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784148676; c=relaxed/simple;
	bh=hH0oCOt46m2hm/X6EUpe9dhsM2rRkFSCPdvZldlfteI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYVawJA4mEIEVuQk3ZeHefyhs2VGKp7dqMIWg0b2vuIch+xYcIXgVg5eRe5HdNgKDw3NTanN8dO4DLGr+XEM5iTFfKRAneMo4+CVwPHYl+yg3T9qMbGJEo7hrz9VEp4SrA/+tsW5as6n4C2G/nfGUSBCaqkz8WAtBa1PmGIk+zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Uh26rEuc; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Uh26rEuc"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FKPsRG1082404
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 13:51:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=mE0qE20Jg5jMcoZeMFp6/z3S1hhM8+NMOOcTnJV9SHo=; b=Uh26rEucbtK3
	G5FNS+hdhwAeXEQjWlfYhDRtpeWMsLiW9+bKM579f8tGNg/woqHEm30EExPHCtR7
	a1Td735qP70CBBR+4vhyen3lglov/e1Lhy3jVbMKVvFCxDfM2mqz1LNeTQN0E1jW
	I1Qhql4YwX2PrdOk6AGoOKS3Wt8VBSPy6WFccTd/RuAX6zntkpS0jGeJCiDoUO0r
	QM2VXX3mk2W+GpniQaVsil3tiD2YbrOJmdx2LsdGp4f7IYWO+u+JkBNYHW1QlNZd
	5ZJBKajKh4I3vCmJI1FfYs6g1wsRIvzDHv0EhQ78gfQEFnleW8tpyVC2BxTGvFqO
	cyESLdMVdw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fdqss9rb6-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 13:51:12 -0700 (PDT)
Received: from twshared10463.03.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 15 Jul 2026 20:51:04 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 1A2E0423AA01D; Wed, 15 Jul 2026 13:40:12 -0700 (PDT)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael
 Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Alex Williamson
	<alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Zhiping Zhang
	<zhipingz@meta.com>
Subject: [PATCH v12 2/4] dma-buf: add optional get_pci_tph() callback
Date: Wed, 15 Jul 2026 13:39:57 -0700
Message-ID: <20260715204008.3911275-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715204008.3911275-1-zhipingz@meta.com>
References: <20260715204008.3911275-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a57f2c0 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=xtH7KyWI9dI7BmFOsl-x:22 a=VabnemYjAAAA:8 a=mECi3VIRXVL5EC2FsE4A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 1sVJiKn8wH8kkESZqfdqplWfRSZoBHzj
X-Proofpoint-GUID: 1sVJiKn8wH8kkESZqfdqplWfRSZoBHzj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDIwNyBTYWx0ZWRfX71E3I3Sb9PKC
 KYc4cjsVVoxf/uxXEMDjJ/8URahvH/MvhGDvUEHzmCYaQ5NRN2dcDRFQSC594VKYk+WZn6BBc+J
 921xq/uuJjWz4HQgeMtZbl08WR8vwuo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDIwNyBTYWx0ZWRfX5qddHA2U3Jd4
 a6GAChlb7rBXRUtUxt/3nLrlwqrrn2S1FyaRdfsNUNlBycZy6Bby9oarN/Xqyj9YzmCjNqjm0oz
 wtYT9KqoZNQExzsoTFisPFByvg9/rk1k5NSzAPd0SXorCDebQ9UneFtvwij/7bF+ywLJKQUlO50
 JrNkVUh0h5WOn6UlF+sQGmS1D2njE11MrxQHtvdAT1Z7q059tVf8gn7rCUmN7+aHDSHp40EHVfG
 9Ofb1oGndlHfPSQAvFbYc2d0pAJ1xJ4THjMBgizVrmIGWHjVn6n+sUNnpO02a7F/SzU03wVXnFO
 f7cxvxEFxVUTxdgC/PztYe8f4z87dbSKTRElmqAEOokZGQ+tPYwlub+l56F8VuAN49k0WCbu95U
 jcqo1sFVdF3rzFDN1dlZA/OhiNJK3FrnBct6PkVknvAcYd3M2QQsoKzh8qBxE3BcTw8rim4MNMt
 qCObmCsNFc5WaXZMm8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_05,2026-07-15_02,2025-10-01_01

Add an optional dma_buf_ops.get_pci_tph callback and a
DMA-buf importer wrapper, dma_buf_get_pci_tph().

TPH is PCIe TLP Processing Hint. 8-bit ST and 16-bit Extended ST are
distinct PCIe TPH namespaces, so the importer requests the namespace it
can emit and the exporter returns the matching ST/PH tuple or
-EOPNOTSUPP.

dma_buf_get_pci_tph() is the importer entry point. It requires
&dmabuf->resv to be held while the callback runs and returns
-EOPNOTSUPP when the exporter does not provide PCI TPH metadata.

The first user is VFIO_DEVICE_FEATURE_DMA_BUF_TPH in vfio-pci, with
mlx5 as the first importer.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/dma-buf/dma-buf.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   | 25 +++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..71f335442ba7 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -939,6 +939,7 @@ dma_buf_pin_on_map(struct dma_buf_attachment *attach)
  *     - dma_buf_unmap_attachment()
  *     - dma_buf_vmap()
  *     - dma_buf_vunmap()
+ *     - dma_buf_get_pci_tph()
  *
  * 2. Importers must not hold the dma-buf reservation lock when calling =
these
  *    functions:
@@ -979,6 +980,7 @@ dma_buf_pin_on_map(struct dma_buf_attachment *attach)
  *     - &dma_buf_ops.unmap_dma_buf()
  *     - &dma_buf_ops.vmap()
  *     - &dma_buf_ops.vunmap()
+ *     - &dma_buf_ops.get_pci_tph()
  *
  * 3. Exporters must hold the dma-buf reservation lock when calling thes=
e
  *    functions:
@@ -1144,6 +1146,36 @@ void dma_buf_unpin(struct dma_buf_attachment *atta=
ch)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
=20
+/**
+ * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metadat=
a
+ * @dmabuf: DMA buffer to query
+ * @extended: false for 8-bit ST, true for 16-bit Extended ST
+ * @steering_tag: returns the raw steering tag for the requested namespa=
ce
+ * @ph: returns the TPH processing hint
+ *
+ * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
+ *
+ * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
+ * exporter does not implement the callback or has no metadata for the
+ * requested namespace.
+ *
+ * The returned steering tag and processing hint are only valid until th=
e
+ * exporter invalidates the current mapping (signalled to the importer v=
ia
+ * &dma_buf_attach_ops.invalidate_mappings). Importers must re-query aft=
er a new
+ * mapping is established following invalidation.
+ */
+int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
+			u16 *steering_tag, u8 *ph)
+{
+	dma_resv_assert_held(dmabuf->resv);
+
+	if (!dmabuf->ops->get_pci_tph)
+		return -EOPNOTSUPP;
+
+	return dmabuf->ops->get_pci_tph(dmabuf, extended, steering_tag, ph);
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_get_pci_tph, "DMA_BUF");
+
 /**
  * dma_buf_map_attachment - Returns the scatterlist table of the attachm=
ent;
  * mapped into _device_ address space. Is a wrapper for map_dma_buf() of=
 the
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index d1203da56fc5..14e8eb61a62c 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,29 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_pci_tph:
+	 *
+	 * Retrieve PCIe TLP Processing Hint (TPH) steering metadata for
+	 * this buffer so an importer can program a matching ST/PH hint on
+	 * outbound TLPs targeting the exporter for peer-to-peer DMA.
+	 *
+	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
+	 * @extended: false for 8-bit ST, true for 16-bit Extended ST
+	 * @steering_tag: Returns the raw TPH steering tag for the requested
+	 *                namespace
+	 * @ph: Returns the TPH processing hint (2-bit value)
+	 *
+	 * Optional callback for dma_buf_get_pci_tph(). Called with
+	 * &dma_buf.resv held. Returns 0 on success or -EOPNOTSUPP when
+	 * the exporter has no metadata for the requested namespace.
+	 *
+	 * Returned metadata follows the lifetime rules documented for
+	 * dma_buf_get_pci_tph().
+	 */
+	int (*get_pci_tph)(struct dma_buf *dmabuf, bool extended,
+			   u16 *steering_tag, u8 *ph);
+
 	/**
 	 * @map_dma_buf:
 	 *
@@ -563,6 +586,8 @@ void dma_buf_detach(struct dma_buf *dmabuf,
 		    struct dma_buf_attachment *attach);
 int dma_buf_pin(struct dma_buf_attachment *attach);
 void dma_buf_unpin(struct dma_buf_attachment *attach);
+int dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
+			u16 *steering_tag, u8 *ph);
=20
 struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_inf=
o);
=20
--=20
2.53.0-Meta

