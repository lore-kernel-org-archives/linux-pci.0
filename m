Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55831E858
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859757; cv=none; b=tKphd3Z+oUoGyqQ9YvfCtgpGapk4u0rNr5+lvK7ZDoOX8HQ/2Cgkb/kHIfyF2ID1qZjUR51zWBsx0aFQ5u8LegXxW13/ntd5CfOTuWNJHxTlU8BPAqgtunfpnhOOiuyq3BbL0lTWl9RiIiufS4U1Ri/bOciQTpuKfWzAcO0tkX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859757; c=relaxed/simple;
	bh=6ji9d8uAJLcoRju665G/IVINMSKJhweNyp0xkMhlyL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCLeepF0WXntAu0bu+6fJDQfBsfcUbA64L3CBH/r23jUv+ZJsjlKmqjgLXUlM5ii9EZzAE4c+7WW0zXQmKLbOK7wSONZb8YgVybFZIdkcFmrzng6xxTGfsBP+GTj6b5zpQeW1qhXRBFtc24pK046qcZtoTiY8OP3L6zBMzkaBkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nt3zK1OI; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nt3zK1OI"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ULITeN2215618
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:49:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=YYkBgAAFNWZDrKwhhTsTLZ1UTmm9m4xo9SJVRgbwcTU=; b=nt3zK1OIj+Kn
	z1jiSZJBRi3BnCGT3Fq9/s/jHBQgdFWaaPAmAC1ubAW3pkaxPfetEZiGQ1971hvv
	3VbLhGDDtSbw+3OAcQsK8keKqVarfVZoQuR9cIaiivoUQETcIbFQ8Fvq6gF69t/0
	J+lB0/LCJsahuaj5Jrd+0hBLnSJzDkwtG0Cs5dVGPqlIpUoxRitm7f/h5oJDpgPM
	NdLaIzed94TNrNTeN4mtIvchJ17Hl4TDQY/IQtqm1D11ZA4z2RcKRWHD8/I036vt
	17WDgGnI3BiWPDqBvnrpz/MTL4Obvu6sPFJJ988Rm7PipPT9p/5yyDHAEuDB85GH
	C8imNx4Z+Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f4f1svd9r-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 15:49:15 -0700 (PDT)
Received: from twshared20751.01.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 30 Jun 2026 22:49:12 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id B583240C59C28; Tue, 30 Jun 2026 15:43:30 -0700 (PDT)
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
Subject: [PATCH v10 2/4] dma-buf: add optional get_pci_tph() callback
Date: Tue, 30 Jun 2026 15:42:24 -0700
Message-ID: <20260630224328.3218796-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260630224328.3218796-1-zhipingz@meta.com>
References: <20260630224328.3218796-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIyMiBTYWx0ZWRfXxMeVyDPhOmc7
 WGKtELkrX3z+Ft8T1punPw8v2ePLqVZXVdJFbCGk/cLGwMTbI/Pyj0YPfD1ZD5bmEFf+CmlLc8g
 saU8ARhIijtuP7/97GLhGwWevbs2zX0=
X-Authority-Analysis: v=2.4 cv=OYCoyBTY c=1 sm=1 tr=0 ts=6a4447eb cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_1IyUuN4QrATX339ibzo:22 a=VabnemYjAAAA:8 a=NnIffO1M-inhYcDKZaoA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: LMZJ7-wRCxx7iAMw9lwIrvlW0GbmLDJF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIyMiBTYWx0ZWRfX1UoUWCCF4rp3
 SVvDFeEvtmYxN2XdklfqUKV6hW759koBujnUlqLl7LHf5JGOUYesJD6kPTcgQc9jX28riwrBgG5
 HtHvlPM5AlskI3p/+b/1Pon6GckTUFA3NqA2OtLQepM/tjDXjl2P3bYybBYcA5U9OhiO13M67FG
 lJutde0fGLKsgf0/K8hO5FA6VS9o49JHUQrRsCsbujnqp/BBv3bfXtNdYM6RBcZOoi25g35CPdJ
 SvFW6OaZHLIR91FP/4abLqC7kub1Vi5Lu5NxcOu5gBtiU48soA1gzThZoj6JftDV9/cuS2EEzkr
 Is1jKh6MeyUYf0pLMg4muP/ecQPcdgoAzwQPhCyxoSD2KipT/l1icjDQWxDRRyv11HW8qy/Mrdt
 uT3PVtfSkW7iLUnYqQzCRexOCqSCz/H1Kx52Knq3JUth+LxL55Nn8Qk/Ka3lqxdv2ZY4R/oDfIH
 O3CL3KtgeYyISHnKTDA==
X-Proofpoint-ORIG-GUID: LMZJ7-wRCxx7iAMw9lwIrvlW0GbmLDJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01

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
 drivers/dma-buf/dma-buf.c | 25 +++++++++++++++++++++++++
 include/linux/dma-buf.h   | 22 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index d504c636dc29..7a4c9b0d5dab 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *atta=
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
index d1203da56fc5..53b2686ad8fc 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,26 @@ struct dma_buf_ops {
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
+	 */
+	int (*get_pci_tph)(struct dma_buf *dmabuf, bool extended,
+			   u16 *steering_tag, u8 *ph);
+
 	/**
 	 * @map_dma_buf:
 	 *
@@ -563,6 +583,8 @@ void dma_buf_detach(struct dma_buf *dmabuf,
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

