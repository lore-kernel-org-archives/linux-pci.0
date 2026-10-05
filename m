Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0C14779AA;
	Mon,  5 Oct 2026 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791199120; cv=none; b=N+ZukQvRO54qWX1RWze2igcO2KcxDEYU/hwgvMHhOQTTqqAXTMVnHmdIfP4BPuod87IU+oPPRLMxWLvomBMOmIEit8d6wuhct5TKxDp4YpwSADLVn5uMXz/5ZguitLUrmsOUWu1yZPmHjdDgGQv4Uf6153vSju0pFNmlww4SdLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791199120; c=relaxed/simple;
	bh=8IUrosC6W/xobqKOSM43nQ6GGRlHLOM590t73UTw3kQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=GZKpXgiJmWlnq3kMYg5S95bg76Hr7Bf5MH1W0po0m7hoDdxurnBPNXtG6J93b3YG0/rGOnli+0meiKOiY20pBOy4BHZU3vI0rSiMuP9spVLyrd5YthShrGxlXlpTqkereqaJz7TmHLfVL8HXpC65mMEtnm6OpLCSyu7LXO4yKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=r9gUI9KX; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=/nyhSE7B; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="r9gUI9KX";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="/nyhSE7B"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791199069; bh=VG7SijGObD/mat/VETltwvm
	0Dx4PXid4IbEr+4FUyqI=; b=r9gUI9KX2eL/TJVGF6WsGdcg/iaTiFZHq6ag42CNAbYTvuwXSb
	TtmgWJjGZCecv1w9c2Uw1BUqno1Eh4J2fWtltVlxw7mxNm2d2uqlorES4BjmWUv5G73nWnn7vkr
	HWT6VnbBZRCRKJm8tl5V2WpbAiy7W9NkJPtt/pdcYJ4+dqZxFyYddPOcQgAHG8xlFdwCN6fKuKj
	IRY7W07+jitQhvAgGDYhxd3L95ad119qQzRkwjv0QZ5woKFHdeqh/HZaLZZRTYSicjlO/IpLzxH
	k/JmYwAllcYOVNeW2xDp/vRF3NtUITF1rnktV+FsySt29tf54/SNYctecDiSoNLDJzg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791199069; bh=VG7SijGObD/mat/VETltwvm
	0Dx4PXid4IbEr+4FUyqI=; b=/nyhSE7B0ZhVRn6DBgUhbKCZMAqNUSBYtdzNE6VHZh7MCJwVwd
	q9sQUBPwyC5dyO/9G2XhS5wD5LxfPptTtfAQ==;
Date: Mon, 05 Oct 2026 12:17:49 +0100
From: Bradley Morgan <brads@mainlining.org>
To: ankita@nvidia.com
CC: Smita.KoralahalliChannabasappa@amd.com, aik@amd.com,
 alison.schofield@intel.com, andriy.shevchenko@linux.intel.com,
 aneesh.kumar@kernel.org, bhelgaas@google.com, dave.jiang@intel.com,
 dave@stgolabs.net, icheng@nvidia.com, ilpo.jarvinen@linux.intel.com,
 iweiny@kernel.org, jgg@nvidia.com, jic23@kernel.org,
 linux-coco@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 ming.li@zohomail.com, smadhavan@nvidia.com, vishal.l.verma@intel.com,
 yilun.xu@linux.intel.com
Subject: Re: [RFC PATCH 1/4] PCI/TSM: Create MMIO descriptors via TDISP Report
In-Reply-To: <20261005070252.84810-2-ankita@nvidia.com>
Message-ID: <317D506F-8079-4776-8EBC-2BA1A7535BC9@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 October 2026 08:02:49 BST, Ankit Agrawal <ankita@nvidia.com> wrote:
>After pci_tsm_bind() and pci_tsm_lock() the low level TSM driver is
>expected to populate the TDISP GET_DEVICE_INTERFACE_REPORT response
>payload for the device.
>
>Add pci_tsm_mmio_alloc()/pci_tsm_mmio_free() to parse that report into
>a set of encrypted MMIO ranges, and pci_tsm_mmio_setup()/
>pci_tsm_mmio_teardown() to mark those ranges as encrypted in iomem via
>a new encrypted_iomem_resource tree (IORES_DESC_ENCRYPTED). With those
>descriptors the TSM driver can use pci_tsm_mmio_setup() to inform
>ioremap() how to map the device per the device expectations. The VM
>is expected to validate the interface with the relying party before
>accepting the device for operation.
>
>pci_tsm_mmio_alloc() also recovers the obfuscated starting address for
>each encrypted MMIO range, since the VM is never disclosed the HPA
>that correlates to the GPA of the device's MMIO. The obfuscated
>address is BAR aligned.
>
>Based on an original patch by Aneesh Kumar K.V [1], and cherry-picked
>from Dan Williams' upstream commit [2]. Major functional differences
>from Dan's posting is due to the lack of evidence-store infrastructure
>yet (device_evidence / DEVICE_EVIDENCE_TYPE_REPORT). The
>pci_tsm_mmio_alloc() takes the raw report bytes directly from the caller
>instead of pulling them from a device evidence store.
>
>Link: https://lore.kernel.org/linux-coco/20251117140007.122062-8-aneesh.kumar@kernel.org/ [1]
>Link: https://lore.kernel.org/all/20260705220819.2472765-15-djbw@kernel.org/ [2]

LGTM from a kernel/resource.c standpoint:

Reviewed-by: Bradley Morgan <brads@mainlining.org> # kernel/


>
>Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
>Assisted-by: Claude:sonnet-5
>---
> drivers/pci/tsm.c       | 236 ++++++++++++++++++++++++++++++++++++++++
> include/linux/ioport.h  |   2 +
> include/linux/pci-tsm.h |  33 ++++++
> kernel/resource.c       |   8 ++
> 4 files changed, 279 insertions(+)
>
>diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
>index 5fdcd7f2e820..c8cfe89b6224 100644
>--- a/drivers/pci/tsm.c
>+++ b/drivers/pci/tsm.c
>@@ -9,11 +9,16 @@
> #define dev_fmt(fmt) "PCI/TSM: " fmt
> 
> #include <linux/bitfield.h>
>+#include <linux/overflow.h>
> #include <linux/pci.h>
> #include <linux/pci-doe.h>
> #include <linux/pci-tsm.h>
>+#include <linux/range.h>
>+#include <linux/sizes.h>
>+#include <linux/slab.h>
> #include <linux/sysfs.h>
> #include <linux/tsm.h>
>+#include <linux/unaligned.h>
> #include <linux/xarray.h>
> #include "pci.h"
> 
>@@ -898,3 +903,234 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, u8 type, const void *req,
> 		       resp, resp_sz);
> }
> EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
>+
>+static void mmio_teardown(struct pci_tsm_mmio *mmio, int nr)
>+{
>+	while (nr--) {
>+		struct resource *res = pci_tsm_mmio_resource(mmio, nr);
>+
>+		/*
>+		 * Entries past the point where pci_tsm_mmio_setup() stopped
>+		 * (or that were never run through setup() at all, e.g. a
>+		 * caller that only wants the resolved range from
>+		 * pci_tsm_mmio_alloc()) were never insert_resource()'d, so
>+		 * res->parent is NULL. remove_resource() dereferences
>+		 * res->parent unconditionally.
>+		 */
>+		if (res->parent)
>+			remove_resource(res);
>+	}
>+}
>+
>+/**
>+ * pci_tsm_mmio_setup() - mark device MMIO as encrypted in iomem
>+ * @pdev: device owner of MMIO resources
>+ * @mmio: container of an array of resources to mark encrypted
>+ */
>+int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
>+{
>+	int i;
>+
>+	device_lock_assert(&pdev->dev);
>+	if (pdev->dev.driver)
>+		return -EBUSY;
>+
>+	for (i = 0; i < mmio->nr; i++) {
>+		struct resource *res = pci_tsm_mmio_resource(mmio, i);
>+		int j;
>+
>+		if (resource_size(res) == 0 || !(res->flags & IORESOURCE_MEM))
>+			break;
>+
>+		/* Only require the caller to set the range, init remainder */
>+		*res = DEFINE_RES_NAMED_DESC(res->start, resource_size(res),
>+					     pci_name(pdev), IORESOURCE_MEM,
>+					     IORES_DESC_ENCRYPTED);
>+
>+		for (j = 0; j < PCI_NUM_RESOURCES; j++)
>+			if (resource_contains(pci_resource_n(pdev, j), res))
>+				break;
>+
>+		/* Request is outside of device MMIO */
>+		if (j >= PCI_NUM_RESOURCES)
>+			break;
>+
>+		if (insert_resource(&encrypted_iomem_resource, res) != 0)
>+			break;
>+	}
>+
>+	if (i >= mmio->nr)
>+		return 0;
>+
>+	mmio_teardown(mmio, i);
>+
>+	return -EINVAL;
>+}
>+EXPORT_SYMBOL_GPL(pci_tsm_mmio_setup);
>+
>+void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio)
>+{
>+	mmio_teardown(mmio, mmio->nr);
>+}
>+EXPORT_SYMBOL_GPL(pci_tsm_mmio_teardown);
>+
>+/*
>+ * PCIe ECN TEE Device Interface Security Protocol (TDISP)
>+ *
>+ * Device Interface Report data object layout as defined by PCIe r7.0 section
>+ * 11.3.11
>+ */
>+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_TABLE BIT(0)
>+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_PBA BIT(1)
>+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
>+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
>+#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
>+
>+/* An interface report 'pfn' is 4K in size */
>+struct pci_tsm_devif_mmio {
>+	__le64 phys;
>+	__le32 nr_pfns;
>+	__le32 attributes;
>+};
>+
>+struct pci_tsm_devif_report {
>+	__le16 interface_info;
>+	__le16 reserved;
>+	__le16 msi_x_message_control;
>+	__le16 lnr_control;
>+	__le32 tph_control;
>+	__le32 mmio_range_count;
>+	struct pci_tsm_devif_mmio mmio[];
>+};
>+
>+/**
>+ * pci_tsm_mmio_alloc() - allocate encrypted MMIO range descriptor
>+ * @pdev: device owner of MMIO ranges
>+ * @report: raw TDISP Device Interface Report bytes (PCIe r7.0 section
>+ *	    11.3.11), e.g. as returned by GET_DEVICE_INTERFACE_REPORT
>+ * @report_len: length of @report in bytes
>+ *
>+ * Return: the encrypted MMIO range descriptor on success, NULL on failure
>+ *
>+ * Unlike upstream, @report is supplied directly by the caller rather than
>+ * pulled from a device evidence store, which this tree does not yet have.
>+ */
>+struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
>+					const void *report, size_t report_len)
>+{
>+	const struct pci_tsm_devif_report *devif_report = report;
>+	u64 reporting_bar_base, last_reporting_end;
>+	u32 mmio_range_count;
>+	int last_bar = -1;
>+	int i;
>+
>+	if (report_len < sizeof(*devif_report))
>+		return NULL;
>+
>+	mmio_range_count = __le32_to_cpu(devif_report->mmio_range_count);
>+
>+	/* check that the report is self-consistent on mmio entries */
>+	if (report_len < struct_size(devif_report, mmio, mmio_range_count))
>+		return NULL;
>+
>+	/* create pci_tsm_mmio descriptors from the report data */
>+	struct pci_tsm_mmio *mmio __free(kfree) =
>+		kzalloc_flex(*mmio, mmio, mmio_range_count);
>+	if (!mmio)
>+		return NULL;
>+
>+	for (i = 0; i < mmio_range_count; i++) {
>+		u64 range_off;
>+		struct range range;
>+		const struct pci_tsm_devif_mmio *mmio_data = &devif_report->mmio[i];
>+		struct pci_tsm_mmio_entry *entry =
>+			pci_tsm_mmio_entry(mmio, mmio->nr);
>+		u64 tsm_offset = __le64_to_cpu(mmio_data->phys);
>+		u64 size = (u64)__le32_to_cpu(mmio_data->nr_pfns) * SZ_4K;
>+		u32 attr = __le32_to_cpu(mmio_data->attributes);
>+		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
>+				    attr);
>+
>+		if (bar >= PCI_STD_NUM_BARS ||
>+		    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
>+		    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
>+			pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
>+			return NULL;
>+		}
>+
>+		if (last_bar > bar) {
>+			pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
>+			return NULL;
>+		}
>+
>+		if (last_bar < bar) {
>+			resource_size_t mask = pci_resource_len(pdev, bar) - 1;
>+
>+			/* Transition to a new bar */
>+			last_bar = bar;
>+
>+			/*
>+			 * Determine the obfuscated base of the BAR. BAR
>+			 * offsets are never obfuscated.
>+			 */
>+			reporting_bar_base = tsm_offset & ~mask;
>+		} else if (tsm_offset < last_reporting_end) {
>+			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
>+			return NULL;
>+		}
>+
>+		/* Per spec the tsm_offset never results in overflow / underflow */
>+		last_reporting_end = tsm_offset + size;
>+		if (last_reporting_end < tsm_offset) {
>+			pci_dbg(pdev, "Reporting range overflow\n");
>+			return NULL;
>+		}
>+
>+		range_off = tsm_offset - reporting_bar_base;
>+		if (pci_resource_len(pdev, bar) < range_off + size) {
>+			pci_dbg(pdev, "Reporting range larger than BAR size\n");
>+			return NULL;
>+		}
>+
>+		range.start = pci_resource_start(pdev, bar) + range_off;
>+		range.end = range.start + size - 1;
>+
>+		/* Only record the TEE ranges for later consideration by ioremap() */
>+		if (FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE,
>+			      attr)) {
>+			pci_dbg(pdev, "Skipping non-TEE range, BAR%d %pra\n",
>+				bar, &range);
>+			continue;
>+		}
>+
>+		entry->res.start = range.start;
>+		entry->res.end = range.end;
>+		entry->res.flags = IORESOURCE_MEM;
>+		entry->tsm_offset = tsm_offset;
>+		mmio->nr++;
>+	}
>+
>+	return_ptr(mmio);
>+}
>+EXPORT_SYMBOL_GPL(pci_tsm_mmio_alloc);
>+
>+/**
>+ * pci_tsm_mmio_free() - free a pci_tsm_mmio instance
>+ * @pdev: device owner of MMIO ranges
>+ * @mmio: instance to free
>+ *
>+ * Returns 0 if @mmio was idle on entry, -EBUSY otherwise
>+ */
>+int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
>+{
>+	for (int i = 0; i < mmio->nr; i++) {
>+		struct resource *res = pci_tsm_mmio_resource(mmio, i);
>+
>+		if (dev_WARN_ONCE(&pdev->dev, resource_assigned(res),
>+				  "MMIO resource still assigned %pr\n", res))
>+			return -EBUSY;
>+	}
>+	kfree(mmio);
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(pci_tsm_mmio_free);
>diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>index f7930b3dfd0a..122f1eefb4b9 100644
>--- a/include/linux/ioport.h
>+++ b/include/linux/ioport.h
>@@ -144,6 +144,7 @@ enum {
> 	IORES_DESC_RESERVED			= 7,
> 	IORES_DESC_SOFT_RESERVED		= 8,
> 	IORES_DESC_CXL				= 9,
>+	IORES_DESC_ENCRYPTED			= 10,
> };
> 
> /*
>@@ -240,6 +241,7 @@ struct resource_constraint {
> extern struct resource ioport_resource;
> extern struct resource iomem_resource;
> extern struct resource soft_reserve_resource;
>+extern struct resource encrypted_iomem_resource;
> 
> extern struct resource *request_resource_conflict(struct resource *root,
> struct resource *new);
> extern int request_resource(struct resource *root, struct resource *new);
>diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
>index a6435aba03f9..e54ad057fa8e 100644
>--- a/include/linux/pci-tsm.h
>+++ b/include/linux/pci-tsm.h
>@@ -199,6 +199,34 @@ enum pci_tsm_req_scope {
> 	PCI_TSM_REQ_DEBUG_WRITE = 3,
> };
> 
>+/**
>+ * struct pci_tsm_mmio_entry - an encrypted MMIO range
>+ * @res: MMIO address range (typically Guest Physical Address, GPA)
>+ * @tsm_offset: Host Physical Address, HPA obfuscation offset added by the TSM.
>+ *		Translates report addresses to GPA.
>+ */
>+struct pci_tsm_mmio_entry {
>+	struct resource res;
>+	u64 tsm_offset;
>+};
>+
>+struct pci_tsm_mmio {
>+	int nr;
>+	struct pci_tsm_mmio_entry mmio[];
>+};
>+
>+static inline struct pci_tsm_mmio_entry *
>+pci_tsm_mmio_entry(struct pci_tsm_mmio *mmio, int idx)
>+{
>+	return &mmio->mmio[idx];
>+}
>+
>+static inline struct resource *pci_tsm_mmio_resource(struct pci_tsm_mmio *mmio,
>+						     int idx)
>+{
>+	return &mmio->mmio[idx].res;
>+}
>+
> #ifdef CONFIG_PCI_TSM
> int pci_tsm_register(struct tsm_dev *tsm_dev);
> void pci_tsm_unregister(struct tsm_dev *tsm_dev);
>@@ -216,6 +244,11 @@ void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
> ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope
> scope,
> 			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
> 			  size_t out_len, u64 *tsm_code);
>+int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
>+void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio);
>+struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
>+					const void *report, size_t report_len);
>+int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
> #else
> static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
> {
>diff --git a/kernel/resource.c b/kernel/resource.c
>index cfc1a00e86aa..5500f7828b2d 100644
>--- a/kernel/resource.c
>+++ b/kernel/resource.c
>@@ -56,6 +56,14 @@ struct resource soft_reserve_resource = {
> 	.flags	= IORESOURCE_MEM,
> };
> 
>+struct resource encrypted_iomem_resource = {
>+	.name	= "Encrypted MMIO",
>+	.start	= 0,
>+	.end	= -1,
>+	.desc	= IORES_DESC_ENCRYPTED,
>+	.flags	= IORESOURCE_MEM,
>+};
>+
> static DEFINE_RWLOCK(resource_lock);
> 
> /*
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
