Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF148035B;
	Thu,  2 Jul 2026 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996168; cv=none; b=hbp3v0XTdAt9La6PtUyenVvsAMM9TtqxscyeGKcT87a1FrupvvnmtCy3LkbypVBPqShrfNbHFy+Si7CoIgSB7ofrgaLZy+0oOeMV+nuiY2/H+hVwo8962iHDkkmUsKqswX26xI1QARdW5JBO7YHDcjkTNCsnmS5AQwHOcC24zEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996168; c=relaxed/simple;
	bh=EPqCcztrQ7UUkcnh6OXvF6H+g3EieFy8Z4rA1hLVD+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dvi/JIIPDPmZC9Ojde+fNaulNtIp0uW43tZQ6BmsvAek6D7bzFYea+L/ye3YNZZFVpK3J8VfDgAznCuWiE0LKRw51KIhcLuJEiYT7mErZmxLgwx/PnCvlOmpQl+h1PIXX7UfCPBPQv/mxLSkcrttlWgUTex2+RVSVw8x6VDcc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=WxhDSfyw; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="WxhDSfyw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KVHFe8j9wBHo7UBhOTe8Hw2xK1t7BrREA5MX1hh6i08=;
	b=WxhDSfywO2ISprtTs25tqDysfuoiA+C7rAF29EKtSiUlcQyDRk6MeA7ayE4ImTXsPjMVkbc1Q
	TVye4I8IdUbbKQePMaho8bP4lydZjLXjUtv2iNg0lJ/yBv96Nlrw9iCimZeqsodUNLxR2qSywke
	ofdNznXHrc3gdS4ce6PN8PU=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4grbsq64z7zpSvW;
	Thu,  2 Jul 2026 20:34:07 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id AB61A40576;
	Thu,  2 Jul 2026 20:42:37 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:42:36 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v19 13/18] vfio/pci: Introduce VFIO_DEVICE_FEATURE_TPH family uapi for PCI TPH control
Date: Thu, 2 Jul 2026 20:42:19 +0800
Message-ID: <20260702124224.57168-14-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260702124224.57168-1-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Add user API definitions for PCI TPH device feature set, including three
feature IDs:
- VFIO_DEVICE_FEATURE_TPH: Global TPH enable and capability query
- VFIO_DEVICE_FEATURE_TPH_RESOLVE: Resolve PH/ST from specified source
  (GET only)
- VFIO_DEVICE_FEATURE_TPH_ST: Batch program ST table entries (SET only)

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 include/uapi/linux/vfio.h | 62 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5ee..ed04b6280cd6 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -1534,6 +1534,68 @@ struct vfio_device_feature_dma_buf {
  */
 #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
 
+/* PCIe TPH device feature definitions for VFIO_DEVICE_FEATURE ioctl */
+#define VFIO_DEVICE_FEATURE_TPH		13
+#define VFIO_DEVICE_FEATURE_TPH_RESOLVE	14
+#define VFIO_DEVICE_FEATURE_TPH_ST	15
+
+/*
+ * VFIO_DEVICE_FEATURE_TPH - Control and query PCI TPH capabilities
+ *
+ * SET: Opt-in to TPH feature; flags must be zero.
+ * GET: Return supported TPH capability bits in flags.
+ */
+struct vfio_device_feature_tph {
+	__u32 flags;
+};
+
+/* Capability bits returned by GET on VFIO_DEVICE_FEATURE_TPH */
+#define VFIO_DEVICE_TPH_CAP_DMABUF	(1u << 0) /* DMABUF sources resolvable */
+#define VFIO_DEVICE_TPH_CAP_CPU		(1u << 1) /* CPU sources resolvable via _DSM */
+#define VFIO_DEVICE_TPH_CAP_LITERAL	(1u << 2) /* LITERAL ST source supported */
+
+/*
+ * VFIO_DEVICE_FEATURE_TPH_RESOLVE - Resolve PH/ST tag value from source
+ * Note: GET only
+ */
+struct vfio_device_feature_tph_resolve {
+	__u32 flags;	/* IN: source type + namespace modifiers */
+	__u32 src;	/* IN: dma-buf fd or CPU ID based on flags */
+	__u8 valid;	/* OUT: bitmap indicating valid output fields */
+#define VFIO_DEVICE_TPH_VALID_PH (1u << 0) /* ph holds valid processing hint */
+#define VFIO_DEVICE_TPH_VALID_ST (1u << 1) /* st holds valid steering tag */
+	__u8 ph;	/* OUT: TPH processing hint */
+	__u16 st;	/* OUT: raw steering tag value */
+};
+
+/*
+ * VFIO_DEVICE_FEATURE_TPH_ST - Batch program architected ST table entries
+ * Return value: number of successfully written entries
+ * Note: SET only
+ */
+struct vfio_device_feature_tph_st {
+	__u32 flags;		/* IN: source type + namespace modifiers */
+	__u16 start;		/* IN: first ST table index / MSI-X vector */
+	__u16 count;		/* IN: number of contiguous entries to program */
+	__aligned_u64 dests;	/* IN: user pointer to array of source u32 values */
+};
+
+/* Common flags shared by TPH_RESOLVE and TPH_ST features */
+#define VFIO_DEVICE_TPH_SRC_NONE           (1u << 0) /* TPH_ST only: set ST=0 */
+#define VFIO_DEVICE_TPH_SRC_DMABUF	   (1u << 1) /* src = dma-buf fd */
+#define VFIO_DEVICE_TPH_SRC_CPU_VOLATILE   (1u << 2) /* src = volatile memory CPU ID */
+#define VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT (1u << 3) /* src = persistent memory CPU ID */
+#define VFIO_DEVICE_TPH_SRC_LITERAL        (1u << 4) /* TPH_ST only: src = raw literal ST */
+#define VFIO_DEVICE_TPH_EXTENDED           (1u << 30) /* Use extended 16-bit ST namespace */
+#define VFIO_DEVICE_TPH_REQUIRE_ST         (1u << 31) /* TPH_ST only: fail if resolved ST=0 */
+
+/* Mask for mutually exclusive source type bits, only one may be set */
+#define VFIO_DEVICE_TPH_SRC_MASK	(VFIO_DEVICE_TPH_SRC_NONE | \
+					 VFIO_DEVICE_TPH_SRC_DMABUF | \
+					 VFIO_DEVICE_TPH_SRC_CPU_VOLATILE | \
+					 VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT | \
+					 VFIO_DEVICE_TPH_SRC_LITERAL)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.17.1

