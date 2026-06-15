Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CE83BB10D
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507161; cv=none; b=GaI6TBlw0cm+QZMLex4Ovi/LLoc08/c5WZ10knPCcI+QmUOZl2ujks9njz+alKKqFj9Ex/F9k3aLitBcdEHTMSe/u7CgOq/JKlz1/CCZV6lXMVxk5c++dmfJaZSdPpN39JdZyVdI2s33qBrqzabYqGir2e0eVXv34sTpIY3LcsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507161; c=relaxed/simple;
	bh=FVeUhqWQ7R+Gj/BJXno1qRZEvsdwpqmSVpXar+cQYg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMGiu+dI9PKNkYy1R0pVW2iJCpD7wYJe7iqiluPTrCv/JAASYtsXywlIKR+tM7y1VDfLtczCvbsCYXM4JVRd/29Hu9X6LiGnDAfY1FoM2TBVChY/mqbXUAgQYg8JACUGo5gkRG86ZR6/lrGmTIIOKYJzS7yxIEYqA8VjALS7GVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=TUycQ0Sl; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="TUycQ0Sl"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6J9C31218580
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 00:05:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=JeSGRuwX91zOvjF4v2GthEyP2VW8b6u7SQFPyUI3/CI=; b=TUycQ0Sl7trO
	Y7lB78MwW/Tf7FtAi5WNN/MRtv6FsbDLojG1tByQT6WyYkDBGFQXBL/X59UWvY4M
	bJCU8JOb8qc13qDgZVCKmz9xGKu9sKTg4i7/AopQXnzmLkaVPATDFYVjlbe+FNkR
	ViMdXBWZEMI8u9TOPd1BYU/FZ+xtaI0c0KmY4xhe0yZUk1WVsVbp29uvmUZmaWG8
	w96GCG9DicnQGG22rsPlWDjoqwGx1tsk2PkIc9Ww+i7f8PrrFN9SH/RzSApH/JVA
	17sjlOmQ9pUG3kvKTkZ+TZi/pHc8I1Uc/nlc0DZPPgxp+WrnELnDp968k045NcCt
	k7sZY+U33Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es2h0qn5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 00:05:58 -0700 (PDT)
Received: from twshared5616.02.snb2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 15 Jun 2026 07:05:55 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 7385A3EE34510; Sun, 14 Jun 2026 23:59:16 -0700 (PDT)
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
Subject: [PATCH v8 2/4] dma-buf: add optional get_pci_tph() callback
Date: Sun, 14 Jun 2026 23:58:59 -0700
Message-ID: <20260615065912.2177918-3-zhipingz@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260615065912.2177918-1-zhipingz@meta.com>
References: <20260615065912.2177918-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a2fa456 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=8elwO82fXORLTBIkMd32:22 a=VabnemYjAAAA:8 a=NnIffO1M-inhYcDKZaoA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA3MiBTYWx0ZWRfXyb5/ksifC1R2
 auiy9dm7BOBROUuMmx6SqlM85mPFJneHld8u8GI8SX5h12AgSWS9KTivFxjIVIPLbWjAoK3p6Cy
 4g8xwYe+cNpKU6lIkZfJWnZsLkNsyws=
X-Proofpoint-GUID: z7EwlUUGwO8WJ8XZEYAmAwgOcow0mdGn
X-Proofpoint-ORIG-GUID: z7EwlUUGwO8WJ8XZEYAmAwgOcow0mdGn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA3MiBTYWx0ZWRfX1SBGf0mlN1lo
 oqzpCxwnp+sL8EWWNNwCSI4PvUdmWuTJQBR0zymZVzpYT4tBODlGq9ObjzK12YQg3F8mWkdcW7Y
 K7QPoQoUvPS/BwXJsCls5y7gFPjPLtiyS8B/2WS4Q6YQF/IwL2B4fZtmP0nRZaS2ULSyoIn2yR8
 4nqK970ziGAolxtWnw/4hoEw3ids+LYsANsHidVrzCkWyu3EzsOAilX9Yi2MQ9Vbz1qYVOglOA4
 sJWxAS/bt+qRM7Lb+rMvNJE33ON68hZgpI8VRL5DuD2wYpe6BCrItyXJA+nOvjtlO6a2h+vleLb
 2jo06ly2NtpNK7xrckeOvpOXZkCWfK+n0MasQ9U56nPOIRbRxxkp4Jy2EU16eOVoFQTKWUkyqMs
 zZLZtw9JF+BJyxXX/WzTLXmdDphLldoBHvOGZ5GdJNrcv4b4Mz4MzCElH9Ga0p6fgaBW3SioSaj
 +uqE2n33J1qdy7z5gjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01

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
 include/linux/dma-buf.h   | 16 ++++++++++++++++
 2 files changed, 41 insertions(+)

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
index d1203da56fc5..5e7b69a40f3d 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -113,6 +113,20 @@ struct dma_buf_ops {
 	 */
 	void (*unpin)(struct dma_buf_attachment *attach);
=20
+	/**
+	 * @get_pci_tph:
+	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
+	 * @extended: false for 8-bit ST, true for 16-bit Extended ST
+	 * @steering_tag: Returns the raw TPH steering tag for the requested
+	 *                namespace
+	 * @ph: Returns the TPH processing hint (2-bit value)
+	 *
+	 * Optional callback for dma_buf_get_pci_tph(). Called with
+	 * &dma_buf.resv held.
+	 */
+	int (*get_pci_tph)(struct dma_buf *dmabuf, bool extended,
+			   u16 *steering_tag, u8 *ph);
+
 	/**
 	 * @map_dma_buf:
 	 *
@@ -563,6 +577,8 @@ void dma_buf_detach(struct dma_buf *dmabuf,
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

