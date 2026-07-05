Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA737189C;
	Sun,  5 Jul 2026 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289324; cv=none; b=KfP0cJT/UJ3uuBlc6vlhMNLmWXqmuiJHcy7ox9DDFN6lHxqc8q7ii2Eg4+xY1Yd5hw/WlHtsOJ9zgkKyaF+fptkp8xuuwl32vzM/8g0d96ap7l3FKtUJYQhrMBWoAdcm6DLeJSJEIPBHyw6uer3yFJ2lkGLNl/wC9SwE4fV1qBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289324; c=relaxed/simple;
	bh=NC09L1VXHWZarnjbMyVIMVtzS572zVywbrxek4Nk1RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZRq4O1bcJ5kBFYUMfS2oyp0uG0/GDInEXGB8bY93FM+m6t1PHH6iY1nwPwmn8pRcE9TsciiUnAq77TdCQqT9XuH5GkMzfkuzG8DuPobg33Qw5Bzvxcy8ZhFIvlebZLmN62DQNgfdcTw+gDhYMvKQ4+qDR+j9mHtFvrIh2xAe/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6j6mQQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6j6mQQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5228A1F00A3D;
	Sun,  5 Jul 2026 22:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289322;
	bh=2kntky00XmTFYXft5TuOY+XtAIm6od0iL1tY/lZYHeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c6j6mQQaDROd9JWvUMHuWTNW6K8ptOkMnEwet8K+s57ENpeyPcrJc37jPqQDVNInT
	 8QNRJIlngZ2RA7X6QuxzLiYrDeV4c+kLVcMcCUSGEteeytaQWXQeHbr9MGA3xIM5OJ
	 K8VKkcZ0m40L+UPxAU6THW2EVaT16umT1liT9FIYZOc4uokokGShsVXu3kciBdrR0u
	 zmL/mlj1d2IGvA+J4ujFh3HfNkfQva1xkNz7RkuVTUzjx09uXYku5B9m2Cy7DgiEKh
	 ACGUhoaOiRNj/vjN7PFCxeNXoiPIS/b4uahLSxcB44sKO6pd2kgK6pcpCkxoGoLHMv
	 QLpWZuY7tLZDQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8FEC5F40068;
	Sun,  5 Jul 2026 18:08:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 05 Jul 2026 18:08:41 -0400
X-ME-Sender: <xms:6dVKau0_hFY_uZdVRudweKz3ZF7_czoiFrBYo7tQAVHBXow1LkYq0g>
    <xme:6dVKagIho6o1b9sa5JuD77w1BXm2qgdSbd4w5pjca6Pb3RKveuVz6VuR-xCJKtsOi
    Y0MwsZE4RROKY3zaq9YQKPSfvfpRgVyPK67yGfMQrVXlCsocXzSoEI>
X-ME-Received: <xmr:6dVKatGXgfSoESa8axe2VtHA3g4a5K5afNQZItGA5qMGZB7PbmRqLmxHWde9gVRd_WPehEaVzLFOL5CefiYhV9mB68bDBLAt6to>
X-ME-Proxy-Cause: dmFkZTFElqiR8C0YV4UIJS8tO12iY/+7B7guYUbhcA3QJlpglutTc8BJGCViCnFYn5DMB0
    c+xEkscHBWgUhkIqbKApf2RoWL3h0J/0O/YUp7sJ/WJHTiSO4Z3I/kWCls1bwse3xUTV4T
    cDOmyh7fJHkJnD1q4THnHiClWJhOXQbUM9ONP2yTfko73mzjUkTbjixRCiJgX8fxwMf4Y6
    ghKK6e8xltqMKjzz+8iUJ5YdV+FjkQrrDa3Q6RFnrES70F43CIWz7ewLluB3ASi48xeXfH
    rrEnjssVOjbs0Gt1btTm3kjEusnkxih+FWbBkpe0rE3BNMQg4T1vOyp80g7ixJciFcgMBn
    JIRaKnrkCyZH2RENM6qO3EZLR9hSd8ai04zgrpRz122Vbb7GFtU1XksPCGWsQOJ7os+0YO
    QcOJ/OOtLT0ptseP519gS0F/Xm8qLXH1w0UFJvbhcoVT6oltJXxK+PQXSjhch2hPiuXzGd
    DhXn6QSHB3S7kS3F8NA8xoem0rrXwqdZebvTE2fKHdpavW+xvapzlYMQeME8lbts5fmKmS
    CFw3jjKK89ElsPAweWcZ+i4Js22xOMaFopgEw2zH4gYzGX3R43v6Yoni8CAShFf5pMiYaF
    9qU4gXdPSI4CKUbh27YIOkoJSp+Aer4ischKMBrveeW3ja504DtTNWzAZ8TQ
X-ME-Proxy: <xmx:6dVKasWHKDG6Cm27SshnyHreXFE1mpXTxUR6AW2SS4Am20XlzJmr3Q>
    <xmx:6dVKalxbF4DNL6giDBEP1RDaCguBn75apAtsOa6A_Dy-TmbbFxMkbg>
    <xmx:6dVKahSMjmfoZakQHW8sv1XxIohzR3STAAP49DG14cFddMKtqm9MuQ>
    <xmx:6dVKahjtviYBccKpXRJg_98NwfEr5wqMAOR9UFBIm0Ge-iH6Rowo_Q>
    <xmx:6dVKaoljIp3xTWO4FTj7XIalgZunATnStX_C0K5m92fcyLyuy6xkmQr0>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:41 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Arnd Bergmann <arnd@arndb.de>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH 14/15] PCI/TSM: Create MMIO descriptors via TDISP Report
Date: Sun,  5 Jul 2026 15:08:18 -0700
Message-ID: <20260705220819.2472765-15-djbw@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705220819.2472765-1-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After pci_tsm_bind() and pci_tsm_lock() the low level TSM driver is
expected to populate PCI_TSM_EVIDENCE_TYPE_REPORT in its evidence store.
This report is defined by the TDISP GET_DEVICE_INTERFACE_REPORT response
payload.

Add a helper to create encrypted MMIO descriptors from that report
data. With those descriptors the TSM driver can use pci_tsm_mmio_setup() to
inform ioremap() how to map the device per the device's expectations. The
VM is expected to validate the interface with the relying party before
accepting the device for operation.

The helper also provides the obfuscated starting address for each encrypted
MMIO range as the VM is never disclosed on the hpa that correlates to the
gpa of the device's mmio. The obfuscated address is BAR aligned.

Based on an original patch by Aneesh [1]

Cc: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-coco/20251117140007.122062-8-aneesh.kumar@kernel.org/ [1]
Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 include/linux/ioport.h  |   2 +
 include/linux/pci-tsm.h |  35 +++++++
 drivers/pci/tsm/core.c  | 224 ++++++++++++++++++++++++++++++++++++++++
 kernel/resource.c       |   8 ++
 4 files changed, 269 insertions(+)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index f7930b3dfd0a..122f1eefb4b9 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -144,6 +144,7 @@ enum {
 	IORES_DESC_RESERVED			= 7,
 	IORES_DESC_SOFT_RESERVED		= 8,
 	IORES_DESC_CXL				= 9,
+	IORES_DESC_ENCRYPTED			= 10,
 };
 
 /*
@@ -240,6 +241,7 @@ struct resource_constraint {
 extern struct resource ioport_resource;
 extern struct resource iomem_resource;
 extern struct resource soft_reserve_resource;
+extern struct resource encrypted_iomem_resource;
 
 extern struct resource *request_resource_conflict(struct resource *root, struct resource *new);
 extern int request_resource(struct resource *root, struct resource *new);
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index 397e5d8459cb..6d5fadd79360 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -156,12 +156,42 @@ struct pci_tsm_pf0 {
 	struct pci_doe_mb *doe_mb;
 };
 
+/**
+ * struct pci_tsm_mmio_entry - an encrypted MMIO range
+ * @res: MMIO address range (typically Guest Physical Address, GPA)
+ * @tsm_offset: Host Physical Address, HPA obfuscation offset added by the TSM.
+ *		Translates report addresses to GPA.
+ */
+struct pci_tsm_mmio_entry {
+	struct resource res;
+	u64 tsm_offset;
+};
+
+struct pci_tsm_mmio {
+	int nr;
+	struct pci_tsm_mmio_entry mmio[];
+};
+
+static inline struct pci_tsm_mmio_entry *
+pci_tsm_mmio_entry(struct pci_tsm_mmio *mmio, int idx)
+{
+	return &mmio->mmio[idx];
+}
+
+static inline struct resource *pci_tsm_mmio_resource(struct pci_tsm_mmio *mmio,
+						     int idx)
+{
+	return &mmio->mmio[idx].res;
+}
+
 /**
  * struct pci_tsm_devsec - context for tracking private/accepted PCI resources
  * @base_tsm: generic core "tsm" context
+ * @mmio: encrypted MMIO resources for this assigned device
  */
 struct pci_tsm_devsec {
 	struct pci_tsm base_tsm;
+	struct pci_tsm_mmio *mmio;
 };
 
 /* physical function0 and capable of 'connect' */
@@ -263,6 +293,11 @@ static inline const struct pci_tsm_ops *to_pci_tsm_ops(struct pci_tsm *tsm)
 	return tsm->tsm_dev->pci_ops;
 }
 struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *tsm);
+int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
+void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio);
+
+struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev);
+int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
 #else
 static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
 {
diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
index 372363a39a44..9ac216ad896d 100644
--- a/drivers/pci/tsm/core.c
+++ b/drivers/pci/tsm/core.c
@@ -15,6 +15,7 @@
 #include <linux/pci-tsm.h>
 #include <linux/sysfs.h>
 #include <linux/tsm.h>
+#include <linux/unaligned.h>
 #include <linux/xarray.h>
 #include "../pci.h"
 
@@ -552,6 +553,229 @@ static ssize_t dsm_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(dsm);
 
+static void mmio_teardown(struct pci_tsm_mmio *mmio, int nr)
+{
+	while (nr--)
+		remove_resource(pci_tsm_mmio_resource(mmio, nr));
+}
+
+/**
+ * pci_tsm_mmio_setup() - mark device MMIO as encrypted in iomem
+ * @pdev: device owner of MMIO resources
+ * @mmio: container of an array of resources to mark encrypted
+ */
+int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
+{
+	int i;
+
+	device_lock_assert(&pdev->dev);
+	if (pdev->dev.driver)
+		return -EBUSY;
+
+	for (i = 0; i < mmio->nr; i++) {
+		struct resource *res = pci_tsm_mmio_resource(mmio, i);
+		int j;
+
+		if (resource_size(res) == 0 || !res->end)
+			break;
+
+		/* Only require the caller to set the range, init remainder */
+		*res = DEFINE_RES_NAMED_DESC(res->start, resource_size(res),
+					     pci_name(pdev), IORESOURCE_MEM,
+					     IORES_DESC_ENCRYPTED);
+
+		for (j = 0; j < PCI_NUM_RESOURCES; j++)
+			if (resource_contains(pci_resource_n(pdev, j), res))
+				break;
+
+		/* Request is outside of device MMIO */
+		if (j >= PCI_NUM_RESOURCES)
+			break;
+
+		if (insert_resource(&encrypted_iomem_resource, res) != 0)
+			break;
+	}
+
+	if (i >= mmio->nr)
+		return 0;
+
+	mmio_teardown(mmio, i);
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_mmio_setup);
+
+void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio)
+{
+	mmio_teardown(mmio, mmio->nr);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_mmio_teardown);
+
+/*
+ * PCIe ECN TEE Device Interface Security Protocol (TDISP)
+ *
+ * Device Interface Report data object layout as defined by PCIe r7.0 section
+ * 11.3.11
+ */
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_TABLE BIT(0)
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_PBA BIT(1)
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
+
+/* An interface report 'pfn' is 4K in size */
+struct pci_tsm_devif_mmio {
+	__le64 phys;
+	__le32 nr_pfns;
+	__le32 attributes;
+};
+
+struct pci_tsm_devif_report {
+	__le16 interface_info;
+	__le16 reserved;
+	__le16 msi_x_message_control;
+	__le16 lnr_control;
+	__le32 tph_control;
+	__le32 mmio_range_count;
+	struct pci_tsm_devif_mmio mmio[];
+};
+
+/**
+ * pci_tsm_mmio_alloc() - allocate encrypted MMIO range descriptor
+ * @pdev: device owner of MMIO ranges
+ *
+ * Return: the encrypted MMIO range descriptor on success, NULL on failure
+ *
+ * Assumes that this is called within the live lifetime of a PCI device's
+ * association with a low level TSM.
+ */
+struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev)
+{
+	struct device_evidence *evidence = pdev->tsm->evidence;
+	u64 reporting_bar_base, last_reporting_end;
+	struct device_evidence_object *report_obj;
+	const struct pci_tsm_devif_report *report;
+	u32 mmio_range_count;
+	int last_bar = -1;
+	int i;
+
+	if (!evidence)
+		return NULL;
+
+	report_obj = &evidence->obj[DEVICE_EVIDENCE_TYPE_REPORT];
+
+	guard(rwsem_read)(&evidence->lock);
+	if (report_obj->len < sizeof(struct pci_tsm_devif_report))
+		return NULL;
+
+	report = report_obj->data;
+	mmio_range_count = __le32_to_cpu(report->mmio_range_count);
+
+	/* check that the report object is self-consistent on mmio entries */
+	if (report_obj->len < struct_size(report, mmio, mmio_range_count))
+		return NULL;
+
+	/* create pci_tsm_mmio descriptors from the report data */
+	struct pci_tsm_mmio *mmio __free(kfree) =
+		kzalloc_flex(*mmio, mmio, mmio_range_count);
+	if (!mmio)
+		return NULL;
+
+	for (i = 0; i < mmio_range_count; i++) {
+		u64 range_off;
+		struct range range;
+		const struct pci_tsm_devif_mmio *mmio_data = &report->mmio[i];
+		struct pci_tsm_mmio_entry *entry =
+			pci_tsm_mmio_entry(mmio, mmio->nr);
+		u64 tsm_offset = __le64_to_cpu(mmio_data->phys);
+		u64 size = __le32_to_cpu(mmio_data->nr_pfns) * SZ_4K;
+		u32 attr = __le32_to_cpu(mmio_data->attributes);
+		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
+				    attr);
+
+		if (bar >= PCI_STD_NUM_BARS ||
+		    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
+		    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
+			pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
+			return NULL;
+		}
+
+		if (last_bar > bar) {
+			pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
+			return NULL;
+		}
+
+		if (last_bar < bar) {
+			unsigned long mask = pci_resource_len(pdev, bar) - 1;
+
+			/* Transition to a new bar */
+			last_bar = bar;
+
+			/*
+			 * Determine the obfuscated base of the BAR. BAR
+			 * offsets are never obfuscated.
+			 */
+			reporting_bar_base = tsm_offset & ~mask;
+		} else if (tsm_offset < last_reporting_end) {
+			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
+			return NULL;
+		}
+
+		/* Per spec the tsm_offset never results in overflow / underflow */
+		last_reporting_end = tsm_offset + size;
+		if (last_reporting_end < tsm_offset) {
+			pci_dbg(pdev, "Reporting range overflow\n");
+			return NULL;
+		}
+
+		range_off = tsm_offset - reporting_bar_base;
+		if (pci_resource_len(pdev, bar) < range_off + size) {
+			pci_dbg(pdev, "Reporting range larger than BAR size\n");
+			return NULL;
+		}
+
+		range.start = pci_resource_start(pdev, bar) + range_off;
+		range.end = range.start + size - 1;
+
+		/* Only record the TEE ranges for later consideration by ioremap() */
+		if (FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE,
+			      attr)) {
+			pci_dbg(pdev, "Skipping non-TEE range, BAR%d %pra\n",
+				 bar, &range);
+			continue;
+		}
+
+		entry->res.start = range.start;
+		entry->res.end = range.end;
+		entry->tsm_offset = tsm_offset;
+		mmio->nr++;
+	}
+
+	return_ptr(mmio);
+}
+EXPORT_SYMBOL_GPL(pci_tsm_mmio_alloc);
+
+/**
+ * pci_tsm_mmio_free() - free a pci_tsm_mmio instance
+ * @pdev: device owner of MMIO ranges
+ * @mmio: instance to free
+ *
+ * Returns 0 if @mmio was idle on entry, -EBUSY otherwise
+ */
+int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
+{
+	for (int i = 0; i < mmio->nr; i++) {
+		struct resource *res = pci_tsm_mmio_resource(mmio, i);
+
+		if (dev_WARN_ONCE(&pdev->dev, resource_assigned(res),
+				  "MMIO resource still assigned %pr\n", res))
+			return -EBUSY;
+	}
+	kfree(mmio);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_tsm_mmio_free);
+
 /**
  * pci_tsm_accept() - accept a device for private MMIO operation
  * @pdev: PCI device to accept
diff --git a/kernel/resource.c b/kernel/resource.c
index 3d17e3196a3e..ba91ce43ff7a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -56,6 +56,14 @@ struct resource soft_reserve_resource = {
 	.flags	= IORESOURCE_MEM,
 };
 
+struct resource encrypted_iomem_resource = {
+	.name	= "Encrypted MMIO",
+	.start	= 0,
+	.end	= -1,
+	.desc	= IORES_DESC_ENCRYPTED,
+	.flags	= IORESOURCE_MEM,
+};
+
 static DEFINE_RWLOCK(resource_lock);
 
 /*
-- 
2.54.0

