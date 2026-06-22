Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E693346E6C
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782154452; cv=none; b=kEiJ2N5HxzCshlbYbLgk9F/K31qCP7vy/qRPaxuDUlV+5ZpeaVwcTtvfA0Zhx80TWHbId/DaEWmV8SUREsrF+IM0ZKbDxdZto7IOM6xcSrpbQJbpy5FMcGD3zSFDyqD0HFAZJd37qLEiJXEz6yYOb6c7HSb0WXHCfgxFP+E7jSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782154452; c=relaxed/simple;
	bh=6ji9d8uAJLcoRju665G/IVINMSKJhweNyp0xkMhlyL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbNGlM12raSONzt8VB1vygpvTOefXNH1mLrPVfZg9gDPCqTzhVRL+cqypJdqcG+Zqx/NcoUKvvvzo2A+jdU2IYR+Gj2UgZgphWl2nE/1xWnZoUi0b0/6Rye8RZpt87nXsoQnJk/Ruq0B0lJntJ5x6eIeqrstbenQRTuImCnUl8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=H8dyjJ+O; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="H8dyjJ+O"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MIphbo2559661
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 11:54:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=YYkBgAAFNWZDrKwhhTsTLZ1UTmm9m4xo9SJVRgbwcTU=; b=H8dyjJ+OZ2ra
	vtcX+qfo1l9GRS2dDVdUnIfTNVls9Ru/fmTUD1AMMFkTQOWIY1OU774GQf2OdZSk
	giyd8X0sLdbZHulfkRqr3RYLdeW1PEq69uSZfwvNJzFDrFMGGHjH+q46vXw9At/h
	VrYM0B6d344yf65GjXr0wAi2ld14ZEFTPkmC6rCevABkyIASXBXafmI/isQOIboZ
	w9UeEnBqcNXUIQW2Ht2PcCAqjSHVMPfHO1LJ2hVDH5SlTMErR9tNlU3xQdSlwyWX
	U+n8y21d9BV3k/hVoMxxczedxjUjOEV+VUnCW9lpkWdpo+CuISIjtA7Qcgv5pPMi
	oqBf2pIYcQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ewt5jw7sr-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 11:54:10 -0700 (PDT)
Received: from twshared3243.34.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 22 Jun 2026 18:54:07 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id DA0493FB8E341; Mon, 22 Jun 2026 11:42:15 -0700 (PDT)
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
Subject: [PATCH v9 2/4] dma-buf: add optional get_pci_tph() callback
Date: Mon, 22 Jun 2026 11:41:35 -0700
Message-ID: <20260622184211.2229399-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260622184211.2229399-1-zhipingz@meta.com>
References: <20260622184211.2229399-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=I65Vgtgg c=1 sm=1 tr=0 ts=6a3984d2 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=VabnemYjAAAA:8 a=NnIffO1M-inhYcDKZaoA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 1FemQBE2HL8hajuC6Qf23-mFe7N8Uewh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4NCBTYWx0ZWRfX0NHt56T5XrtF
 ar1d422ZUO7udSREiHXdcITl7SKT66AEm3NsWy2IBQKmIzAuqx7f6B8RvhOURDp2tYr+i9sZeoN
 CHY8UtEKLs73qAUsvuHM324TpLWa5mHJSUiLN7pWoZKvSvzYNkUfWh09lAKk4CUu97P4CCxzmP1
 H2+KQHeHvGglDGnHyG2lK6esNfpPeU91efKWBQm8ASjvXalxOxMgkKPpLghcN/Av7dPofKARQt7
 p38rSe4Yq+MYTF70P4B1aikC+AU1O6sP/y94mL1sVIidaL9U78tvFKHuEQ5zLKmA3/rnYPFp47s
 +Ly7WL38HOlLQUHo6TY7abtOxLdq6iitYAVDgCIhbxpvXH65Jtjp72qrTWmFxoREkC+Xmn57h3w
 fcUV7y9o06vltS/JHXVfR7k5OIytgDH8ma3zMWPkFOroeSoiK4kiIZQMTkPM8RsYALm0esKHVH+
 LpPd/k/GoJ2hy68AEOw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4NCBTYWx0ZWRfX9r7aeoLJzzJS
 MsNLRwmhWi7UKG4ygNNABeNAmQqI+7Q3IwzjHsZ84SPg5G99ZflwdFuGSLlj3xr0FItDzQIzY9J
 2F4eywv7HoHXMxWrE4AYGG2Y53EUslk=
X-Proofpoint-ORIG-GUID: 1FemQBE2HL8hajuC6Qf23-mFe7N8Uewh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01

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
