Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8A559CA7;
	Wed,  9 Sep 2026 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971506; cv=none; b=k7bKjcCZeKaRUritsJ3MMA3ZFI3O0D6E5uRZyLKe4OBLQMKXQk0C7/7BiYCPrsQchXcsOsLlhvasPmWuN4pNQeZMB3mPyu9qvE37JRadEWEDMgvBiipRbYYNbpRdepgS5SGmhWC0P80af2uUC080U5K/F2AMKO6yR2xvnrJpA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971506; c=relaxed/simple;
	bh=UhUb594ysF9NVW5xZ3Kg4cm9A4di3yvtA4rizWU6ISk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mr699936Ex7hAVC3xYku3MeEm2P8fg/XyXqAan0DR8mL+ajg4FpSUCosXHGY6O93+6U0B3Pvhtn7ujhMsguE8FHoHoxUnruR0QWMXuRJnF+Wq5igQ7/DNu4u1zJiCwIM6gogOWeQauWITIyD65d4oIzQ+UDcOeGvW0yf2OsMwXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5567F1F000FF;
	Wed,  9 Sep 2026 16:31:44 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	jic23@kernel.org,
	terry.bowman@amd.com,
	sashiko-bot@kernel.org
Subject: [PATCH v2] PCI/AER: Map a raw AER Capability image field by field
Date: Wed,  9 Sep 2026 09:31:40 -0700
Message-ID: <20260909163140.2723395-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct aer_capability_regs is not the hardware layout: the embedded
struct pcie_tlp_log spans 60 bytes where the Header Log it stands in for
is 16, so a flat copy misplaces everything behind it.

extlog_print_pcie(), ghes_handle_aer() and cxl_rch_get_aer_info() work
around that by stopping at the Header Log, dropping everything past
offset 44. Flit mode is never decoded either: the Flit bit and Logged
TLP Size sit at offset 0x18 in all three images, but nothing reads them,
so the Flit DWORDs at 0x38 are lost and the log prints as non-Flit.

Add aer_cap_regs_unpack() to map the registers individually, taking the
TLP Log layout from the Flit bit as pcie_read_tlp_log() does. Clamp the
logged length: Logged TLP Size is 5 bits wide, so an untrusted value
reaches 31 where dw[] holds 14 and pcie_print_tlp_log() walks
header_len unbounded.

Convert all three callers. cxl_rch_get_aer_info() now reads the whole
MMIO block, so size its ioremap by the hardware registers (96 bytes)
rather than by sizeof(struct aer_capability_regs) (100). No functional
change there: only the first 44 bytes were ever read.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260904172337.1409775-1-dave.jiang@intel.com?part=5
Link: https://lore.kernel.org/linux-cxl/CAJZ5v0hDv11cPuztPZsaDd7uwD_49KznJy=tzuRO+dZc=CnAEQ@mail.gmail.com/
Assisted-by: LLM
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2, all from Jonathan's review:
- Assisted-by: LLM, per Documentation/process/coding-assistants.rst
- Fold the aer_cap_regs_unpack() calls onto one line
- Say why cxl_dport_map_rch_aer()'s ioremap size changes
- Declare the readl() loop counter in the loop
- FIELD_GET() for the Flit bit; min() for both clamps
- Note in the kernel-doc why @raw_len is bounded

Depends on "[PATCH v6 00/13] ACPI: APEI: GHES: Collection of fixes for
issues reported by sashiko", now picked up by Rafael; please apply after
it. Patches 5 and 12 are build dependencies - this patch rewrites the
aer_info copies they add - and patch 7 is functional: without its
ACPI_APEI_PCIEAER guard fix, extlog_print_pcie() compiles out. The
drivers/pci and drivers/cxl changes are independent of that series.

No Fixes: tag on purpose. Patches 5 and 12 closed the out-of-bounds
reads; what is left is diagnostic completeness, and this adds an
exported helper and rewrites three call sites.

This is the follow-up Rafael asked for in the Link: above, and also
covers the pre-existing ras_rch.c findings reported there.
---
 drivers/acpi/acpi_extlog.c | 14 +-----
 drivers/acpi/apei/ghes.c   | 15 +------
 drivers/cxl/core/ras_rch.c | 28 +++---------
 drivers/pci/pcie/tlp.c     | 88 ++++++++++++++++++++++++++++++++++++++
 include/linux/aer.h        |  9 ++++
 5 files changed, 106 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 9e61354a807b..bf5f7b1a9aea 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -156,19 +156,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 
 	aer_severity = cper_severity_to_aer(severity);
 
-	/*
-	 * struct pcie_tlp_log is larger than the hardware layout, so aer_info
-	 * only maps onto the struct up to the four Header Log DWORDs. Copy that
-	 * much, then place the TLP Prefix Log from where the hardware keeps it.
-	 * Everything else stays zero: nothing reads root_command, root_status or
-	 * the error source IDs, and header_len and flit are software-only.
-	 */
-	memcpy(&aer_regs, pcie_err->aer_info,
-	       offsetof(struct aer_capability_regs, header_log) +
-	       PCIE_STD_NUM_TLP_HEADERLOG * sizeof(u32));
-	memcpy(aer_regs.header_log.prefix,
-	       pcie_err->aer_info + PCI_ERR_PREFIX_LOG,
-	       sizeof(aer_regs.header_log.prefix));
+	aer_cap_regs_unpack(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
 
 	domain = pcie_err->device_id.segment;
 	bus = pcie_err->device_id.bus;
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 08c985e729d6..ade1cc8c9f8d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -668,20 +668,7 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 		if (!aer_info)
 			return;
 
-		/*
-		 * Map aer_info onto the struct as extlog_print_pcie() does:
-		 * copy up to the four Header Log DWORDs, then place the TLP
-		 * Prefix Log from where the hardware keeps it. The rest stays
-		 * zero, so firmware cannot drive the pcie_print_tlp_log() loop
-		 * over dw[] out of bounds.
-		 */
-		memset(aer_info, 0, sizeof(struct aer_capability_regs));
-		memcpy(aer_info, pcie_err->aer_info,
-		       offsetof(struct aer_capability_regs, header_log) +
-		       PCIE_STD_NUM_TLP_HEADERLOG * sizeof(u32));
-		memcpy(aer_info->header_log.prefix,
-		       pcie_err->aer_info + PCI_ERR_PREFIX_LOG,
-		       sizeof(aer_info->header_log.prefix));
+		aer_cap_regs_unpack(aer_info, pcie_err->aer_info, sizeof(pcie_err->aer_info));
 
 		aer_recover_queue(pcie_err->device_id.segment,
 				  pcie_err->device_id.bus,
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index e0e01aa5eba6..4005344dda55 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -19,7 +19,7 @@ void cxl_dport_map_rch_aer(struct cxl_dport *dport)
 		aer_phys = aer_cap + dport->rcrb.base;
 		dport->regs.dport_aer =
 			devm_cxl_iomap_block(host, aer_phys,
-					     sizeof(struct aer_capability_regs));
+					     PCIE_AER_CAP_HW_SIZE);
 	}
 }
 
@@ -58,31 +58,17 @@ void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 static bool cxl_rch_get_aer_info(void __iomem *aer_base,
 				 struct aer_capability_regs *aer_regs)
 {
-	/*
-	 * Bound the copy to the physically-defined AER registers (header
-	 * through the 16-byte Header Log). struct aer_capability_regs is a
-	 * software layout whose embedded struct pcie_tlp_log is larger than
-	 * the on-wire AER capability; copying sizeof(*aer_regs) would
-	 * over-read the RCRB-mapped MMIO block.
-	 */
-	int read_cnt = (PCI_ERR_HEADER_LOG + 16) / sizeof(u32);
-	u32 *aer_regs_buf = (u32 *)aer_regs;
-	int n;
+	/* A flat copy cannot fill the struct; aer_cap_regs_unpack() places it. */
+	u32 raw[PCIE_AER_CAP_HW_SIZE / sizeof(u32)];
 
 	if (!aer_base)
 		return false;
 
-	/*
-	 * Zero the destination so the software-only tail fields
-	 * (e.g. header_log.header_len) are deterministic rather than
-	 * left as uninitialized stack, which could drive a bogus loop
-	 * length in pcie_print_tlp_log().
-	 */
-	memset(aer_regs, 0, sizeof(*aer_regs));
-
 	/* Use readl() to guarantee 32-bit accesses */
-	for (n = 0; n < read_cnt; n++)
-		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
+	for (int n = 0; n < ARRAY_SIZE(raw); n++)
+		raw[n] = readl(aer_base + n * sizeof(u32));
+
+	aer_cap_regs_unpack(aer_regs, raw, sizeof(raw));
 
 	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
 	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
index 71f8fc9ea2ed..bba80c380358 100644
--- a/drivers/pci/pcie/tlp.c
+++ b/drivers/pci/pcie/tlp.c
@@ -8,6 +8,8 @@
 #include <linux/aer.h>
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/build_bug.h>
+#include <linux/minmax.h>
 #include <linux/pci.h>
 #include <linux/string.h>
 
@@ -92,6 +94,92 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 	return 0;
 }
 
+/* Only the registers ahead of the Header Log map 1:1. */
+static_assert(offsetof(struct aer_capability_regs, header_log) ==
+	      PCI_ERR_HEADER_LOG);
+/* The Prefix Log registers hold dw[4..13] in Flit mode. */
+static_assert((PCI_ERR_PREFIX_LOG +
+	       (PCIE_STD_MAX_TLP_HEADERLOG - PCIE_STD_NUM_TLP_HEADERLOG) *
+	       sizeof(u32)) == PCIE_AER_CAP_HW_SIZE);
+
+/**
+ * aer_cap_regs_unpack - Convert a raw AER Capability image to the kernel layout
+ * @regs: Destination, fully initialised
+ * @raw: AER Capability register block in hardware order
+ * @raw_len: Bytes readable at @raw
+ *
+ * struct aer_capability_regs is not the hardware layout: struct pcie_tlp_log
+ * spans 60 bytes where the Header Log it stands in for is 16, so a flat copy
+ * misplaces everything behind it. Map the registers one by one instead,
+ * taking the TLP Log layout from the Flit bit as pcie_read_tlp_log() does.
+ *
+ * Registers past @raw_len are left zero, so a short image cannot be read
+ * past.
+ */
+void aer_cap_regs_unpack(struct aer_capability_regs *regs, const void *raw,
+			 size_t raw_len)
+{
+	unsigned int i, tlp_len;
+	bool flit;
+
+	memset(regs, 0, sizeof(*regs));
+
+	if (raw_len < PCI_ERR_HEADER_LOG)
+		return;
+	memcpy(regs, raw, PCI_ERR_HEADER_LOG);
+
+	flit = FIELD_GET(PCI_ERR_CAP_TLP_LOG_FLIT, regs->cap_control);
+	if (flit) {
+		tlp_len = FIELD_GET(PCI_ERR_CAP_TLP_LOG_SIZE, regs->cap_control);
+	} else {
+		/*
+		 * dw[4..7] alias the Prefix Log. Take all four whatever
+		 * eetlp_prefix_max says; pcie_print_tlp_log() stops at the
+		 * first zero one.
+		 */
+		tlp_len = PCIE_STD_NUM_TLP_HEADERLOG + PCIE_STD_MAX_TLP_PREFIXLOG;
+	}
+
+	tlp_len = min(tlp_len, ARRAY_SIZE(regs->header_log.dw));
+
+	for (i = 0; i < tlp_len; i++) {
+		unsigned int off;
+
+		if (i < PCIE_STD_NUM_TLP_HEADERLOG)
+			off = PCI_ERR_HEADER_LOG + i * sizeof(u32);
+		else
+			off = PCI_ERR_PREFIX_LOG +
+			      (i - PCIE_STD_NUM_TLP_HEADERLOG) * sizeof(u32);
+
+		if (off + sizeof(u32) > raw_len)
+			break;
+		memcpy(&regs->header_log.dw[i], raw + off, sizeof(u32));
+	}
+
+	/*
+	 * @i is what got filled. Non-Flit length needs the TLP parsed, so cap
+	 * it at 4 as the native path does.
+	 */
+	regs->header_log.header_len = flit ? i : min(i, PCIE_STD_NUM_TLP_HEADERLOG);
+	regs->header_log.flit = flit;
+
+	if (raw_len >= PCI_ERR_ROOT_COMMAND + sizeof(regs->root_command))
+		memcpy(&regs->root_command, raw + PCI_ERR_ROOT_COMMAND,
+		       sizeof(regs->root_command));
+	if (raw_len >= PCI_ERR_ROOT_STATUS + sizeof(regs->root_status))
+		memcpy(&regs->root_status, raw + PCI_ERR_ROOT_STATUS,
+		       sizeof(regs->root_status));
+	if (raw_len >= PCI_ERR_ROOT_ERR_SRC + sizeof(regs->cor_err_source) +
+		       sizeof(regs->uncor_err_source)) {
+		memcpy(&regs->cor_err_source, raw + PCI_ERR_ROOT_ERR_SRC,
+		       sizeof(regs->cor_err_source));
+		memcpy(&regs->uncor_err_source,
+		       raw + PCI_ERR_ROOT_ERR_SRC + sizeof(regs->cor_err_source),
+		       sizeof(regs->uncor_err_source));
+	}
+}
+EXPORT_SYMBOL_GPL(aer_cap_regs_unpack);
+
 #define EE_PREFIX_STR " E-E Prefixes:"
 
 /**
diff --git a/include/linux/aer.h b/include/linux/aer.h
index df0f5c382286..043ee76b6f53 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -24,6 +24,13 @@
 #define PCIE_STD_MAX_TLP_PREFIXLOG     4
 #define PCIE_STD_MAX_TLP_HEADERLOG	(PCIE_STD_NUM_TLP_HEADERLOG + 10)
 
+/*
+ * Size of the AER Capability register block in hardware, long enough for the
+ * longest Flit mode TLP Log. struct aer_capability_regs below is larger and
+ * laid out differently; use aer_cap_regs_unpack() to convert.
+ */
+#define PCIE_AER_CAP_HW_SIZE		96
+
 struct pci_dev;
 
 struct pcie_tlp_log {
@@ -68,6 +75,8 @@ static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 
 void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		    struct aer_capability_regs *aer);
+void aer_cap_regs_unpack(struct aer_capability_regs *regs, const void *raw,
+			 size_t raw_len);
 int cper_severity_to_aer(int cper_severity);
 void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 		       int severity, struct aer_capability_regs *aer_regs);

base-commit: 86adf9d0f7b074e0a1310c1bc4db66cac5c83eec
-- 
2.54.0

