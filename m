Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914368;
	b=rTadH5abnyfYMFiK4bkTN1AdHnHflhB0WEG81amMzoXRkDZKmJzEMtFbN2lPelPMUrmb
	 5390LDIrkjqRw66f97UtRfCwnTc+tf0K2YwG6t+m7c3+qEHt9jiqiXlwueM7v3cM/Gttu
	 BEt2G14aJp0LsmC7uvmkzdrT3nTvxvNP5hqkYX40tcQD2LuAseBz2tPmfceOOGYVoCbNE
	 Jge/CCKZzRN75W+Fl9VsgHIxfzvMYR8qNgIjRhEff2keAUtxfl7gavJHubFRkTkxlx3sN
	 DCi7uToKHjL2MYGy2rZxUfpokgb8q9yuaNShOl8nDZe81UFLUIEkgxeb5JYD9JehMFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914368;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HMa7cyrFLm9mbger7me1ibPiYFwcKQ8/3f9Xc5xBBsA=;
	b=OMYLQAGasoyxLH1US+WQ6Q6rxblzFWsw4mMxwykIYt4PGoTpFII1Z8BiqFrZknwpqCW3
	 yVy8e6JxZN/NbDvmFgxKUPePXV2P7aFRVdmgPWxQ4UsRsQ7A+qdZ76n+gvlUxa6RVo5yk
	 reopSc11OHQHIRWL/l33whY0IIJl5YxyjYYlDt8ngITsNU/lupvXSUK4vrFFYn5xwkzzV
	 w5wKQcByJdNDuDyRk5I5FPpfBCqDbv2Suhzig/oVoZKdjgqiHVIvrrEBKMyLxf6K+2nYt
	 rN+b4/DYG6CmYc4+kkRfy4fG4BQuu0QR4STKFLBhm03t+Hwyxde/YC/WbSpn+hfUZEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b9Fl462W;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF12B606A332;
	Tue, 17 Nov 2026 11:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF12B606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=b9Fl462W
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F6511C01;
	Tue, 17 Nov 2026 03:19:24 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6E7D33F763;
	Tue, 17 Nov 2026 03:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914367; bh=d/Ne58QY7vVRzJ158HgTiTB3dOlCObvupUZahtXvGso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b9Fl462WKXZV8a8WSR0sARTJjqPjAOhGqmFj1+kuCEcBAYsg33b5C29ICUUHAG310
	 y1ogNxRclyrOmFKSsUPDRuj8NL5n1njXIZRz+klwq4Ex2V3utRLwmRfuLFM0ZgF/00
	 zIJ3WAaIPkG45w7HTj/JrrB5vkVaHaaLGmOpgBRE=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 12/19] ACPI: extlog: Extract CPER reporting from acpi_extlog
Date: Tue, 17 Nov 2026 12:10:22 +0100
Message-ID: <20261117111444.4185512-13-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117111444.4185512-1-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the CPER reporting code to a separate file in order
to re-use it in the GHES code in a later patch.

CONFIG_ACPI_EXTLOG selects ACPI_APEI_GHES and acpi_extlog_report()
will be used in ghes.c, built with CONFIG_ACPI_APEI_GHES. Thus also
build extlog.c under CONFIG_ACPI_APEI_GHES.

Relax the definition of extlog_mem[|2]_event tracepoints to
CONFIG_ACPI_APEI_GHES. The common reporter references them even
when CONFIG_ACPI_EXTLOG is disabled. Guard its memory trace calls
with CONFIG_RAS because GHES can be enabled without RAS.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/acpi_extlog.c        |  90 +---------------
 drivers/acpi/apei/Makefile        |   2 +-
 drivers/acpi/apei/apei-internal.h |   2 +
 drivers/acpi/apei/extlog.c        | 171 ++++++++++++++++++++++++++++++
 drivers/acpi/apei/ghes.c          |   1 -
 drivers/ras/ras.c                 |   2 +-
 include/ras/ras_event.h           |   4 +-
 7 files changed, 178 insertions(+), 94 deletions(-)
 create mode 100644 drivers/acpi/apei/extlog.c

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 1782a19eb474b..47b2e5f133911 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -8,20 +8,13 @@
 
 #include <linux/module.h>
 #include <linux/acpi.h>
-#include <linux/aer.h>
 #include <linux/cper.h>
 #include <linux/ratelimit.h>
-#include <linux/edac.h>
-#include <linux/pci.h>
-#include <linux/ras.h>
-#include <cxl/event.h>
-#include <acpi/ghes.h>
 #include <asm/cpu.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
 
 #include "apei/apei-internal.h"
-#include <ras/ras_event.h>
 
 #define EXT_ELOG_ENTRY_MASK	GENMASK_ULL(51, 0) /* elog entry address mask */
 
@@ -112,42 +105,6 @@ static void print_extlog_rcd(struct acpi_hest_generic_status *estatus, int cpu)
 	cper_estatus_print(pfx_seq, estatus);
 }
 
-static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
-{
-#ifdef CONFIG_ACPI_APEI_PCIEAER
-	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
-	struct aer_capability_regs aer_regs = {};
-	unsigned int devfn;
-	unsigned int bus;
-	int aer_severity;
-	int domain;
-
-	if (gdata->error_data_length < sizeof(*pcie_err)) {
-		pr_warn_ratelimited(FW_WARN
-				    "PCIe error section too small (%u)\n",
-				    gdata->error_data_length);
-		return;
-	}
-
-	if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
-	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
-		return;
-
-	aer_severity = cper_severity_to_aer(gdata->error_severity);
-	/* A component reset by firmware needs reinitialization. */
-	if (gdata->flags & CPER_SEC_RESET)
-		aer_severity = AER_FATAL;
-
-	aer_cap_regs_unpack(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
-
-	domain = pcie_err->device_id.segment;
-	bus = pcie_err->device_id.bus;
-	devfn = PCI_DEVFN(pcie_err->device_id.device,
-			  pcie_err->device_id.function);
-	aer_recover_queue(domain, bus, devfn, aer_severity, &aer_regs);
-#endif
-}
-
 static int extlog_print(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -155,11 +112,6 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	int	bank = mce->bank;
 	int	cpu = mce->extcpu;
 	struct acpi_hest_generic_status *estatus, *tmp;
-	struct acpi_hest_generic_data *gdata;
-	const guid_t *fru_id;
-	char *fru_text;
-	guid_t *sec_type;
-	static u32 err_seq;
 
 	estatus = extlog_elog_entry_check(cpu, bank);
 	if (!estatus)
@@ -189,47 +141,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 	if (tmp->error_severity == CPER_SEV_FATAL)
 		print_extlog_rcd(tmp, cpu);
 
-	/* log event via trace */
-	err_seq++;
-	apei_estatus_for_each_section(tmp, gdata) {
-		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
-			fru_id = (guid_t *)gdata->fru_id;
-		else
-			fru_id = &guid_null;
-		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
-			fru_text = gdata->fru_text;
-		else
-			fru_text = "";
-		sec_type = (guid_t *)gdata->section_type;
-		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
-
-			if (gdata->error_data_length >= sizeof(*mem))
-				trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
-						       (u8)gdata->error_severity);
-		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
-			struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
-
-			if (gdata->error_data_length >= sizeof(*mem))
-				trace_extlog_mem2_event(mem, err_seq, fru_id, fru_text,
-							(u8)gdata->error_severity);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
-			struct cxl_cper_sec_prot_err *prot_err =
-				acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_prot_err(prot_err,
-					       gdata->error_severity,
-					       gdata->error_data_length);
-		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			extlog_print_pcie(gdata);
-		} else {
-			void *err = acpi_hest_get_payload(gdata);
-
-			log_non_standard_event(sec_type, fru_id, fru_text,
-					       gdata->error_severity, err,
-					       gdata->error_data_length);
-		}
-	}
+	acpi_extlog_report(tmp);
 
 	mce->kflags |= MCE_HANDLED_EXTLOG;
 	return NOTIFY_OK;
diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
index 66588d6be56fe..6e83cd110db9a 100644
--- a/drivers/acpi/apei/Makefile
+++ b/drivers/acpi/apei/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
-obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
+obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o extlog.o
 # clang versions prior to 18 may blow out the stack with KASAN
 ifeq ($(CONFIG_COMPILE_TEST)_$(CONFIG_CC_IS_CLANG)_$(call clang-min-version, 180000),y_y_)
 KASAN_SANITIZE_ghes.o := n
diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 77c10a7a7a9f4..a7c70adf91478 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -9,6 +9,8 @@
 
 #include <linux/acpi.h>
 
+void acpi_extlog_report(const struct acpi_hest_generic_status *estatus);
+
 struct apei_exec_context;
 
 typedef int (*apei_exec_ins_func_t)(struct apei_exec_context *ctx,
diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
new file mode 100644
index 0000000000000..8eef33a4326a7
--- /dev/null
+++ b/drivers/acpi/apei/extlog.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Common CPER section reporting.
+ *
+ * Copyright (C) 2013 Intel Corp.
+ * Author: Chen, Gong <gong.chen@intel.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/aer.h>
+#include <linux/cper.h>
+#include <linux/export.h>
+#include <linux/pci.h>
+#include <linux/ratelimit.h>
+#include <linux/ras.h>
+#include <cxl/event.h>
+#include <acpi/ghes.h>
+#include <ras/ras_event.h>
+
+#include "apei-internal.h"
+
+static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
+{
+#ifdef CONFIG_ACPI_APEI_PCIEAER
+	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
+	struct aer_capability_regs aer_regs = {};
+	unsigned int devfn;
+	unsigned int bus;
+	int aer_severity;
+	int domain;
+
+	if (gdata->error_data_length < sizeof(*pcie_err)) {
+		pr_warn_ratelimited(FW_WARN
+				    "PCIe error section too small (%u)\n",
+				    gdata->error_data_length);
+		return;
+	}
+
+	if (!(pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
+	      pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO))
+		return;
+
+	aer_severity = cper_severity_to_aer(gdata->error_severity);
+	/* A component reset by firmware needs reinitialization. */
+	if (gdata->flags & CPER_SEC_RESET)
+		aer_severity = AER_FATAL;
+
+	aer_cap_regs_unpack(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
+
+	domain = pcie_err->device_id.segment;
+	bus = pcie_err->device_id.bus;
+	devfn = PCI_DEVFN(pcie_err->device_id.device,
+			  pcie_err->device_id.function);
+	aer_recover_queue(domain, bus, devfn, aer_severity, &aer_regs);
+#endif
+}
+
+/**
+ * acpi_extlog_mem_error - trace a validated CPER memory section
+ * @gdata: section header followed by its payload
+ * @err_seq: sequence number shared by sections in the same error record
+ *
+ * The caller must validate the payload length, including any optional fields
+ * claimed by the memory validation bits, before calling this function.
+ */
+static void acpi_extlog_mem_error(struct acpi_hest_generic_data *gdata, u32 err_seq)
+{
+#ifdef CONFIG_RAS
+	struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
+	const guid_t *fru_id;
+	const char *fru_text;
+
+	if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
+		fru_id = (guid_t *)gdata->fru_id;
+	else
+		fru_id = &guid_null;
+	if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
+		fru_text = gdata->fru_text;
+	else
+		fru_text = "";
+
+	trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
+			       (u8)gdata->error_severity);
+#endif
+}
+
+/**
+ * acpi_extlog_mem2_error - trace a validated CPER memory section 2
+ * @gdata: section header followed by its payload
+ * @err_seq: sequence number shared by sections in the same error record
+ *
+ * The caller must validate the payload length before calling this function.
+ */
+static void acpi_extlog_mem2_error(struct acpi_hest_generic_data *gdata, u32 err_seq)
+{
+#ifdef CONFIG_RAS
+	struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
+	const guid_t *fru_id;
+	const char *fru_text;
+
+	if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
+		fru_id = (guid_t *)gdata->fru_id;
+	else
+		fru_id = &guid_null;
+	if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
+		fru_text = gdata->fru_text;
+	else
+		fru_text = "";
+
+	trace_extlog_mem2_event(mem, err_seq, fru_id, fru_text,
+				(u8)gdata->error_severity);
+#endif
+}
+
+/**
+ * acpi_extlog_report - report sections of a validated generic error status block
+ * @estatus: caller-owned status block, already checked by cper_estatus_check()
+ *
+ * The caller handles console output and firmware acknowledgment. Section
+ * processing, including PCIe recovery, does not depend on RAS consumers.
+ */
+void acpi_extlog_report(const struct acpi_hest_generic_status *estatus)
+{
+	static atomic_t seqno = ATOMIC_INIT(0);
+	struct acpi_hest_generic_data *gdata;
+	const guid_t *fru_id;
+	const char *fru_text;
+	guid_t *sec_type;
+	u32 err_seq;
+
+	/* log event via trace */
+	err_seq = atomic_inc_return(&seqno);
+	apei_estatus_for_each_section(estatus, gdata) {
+		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
+			fru_id = (guid_t *)gdata->fru_id;
+		else
+			fru_id = &guid_null;
+		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
+			fru_text = gdata->fru_text;
+		else
+			fru_text = "";
+		sec_type = (guid_t *)gdata->section_type;
+		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
+			struct cper_sec_mem_err *mem = acpi_hest_get_payload(gdata);
+
+			if (gdata->error_data_length >= sizeof(*mem))
+				acpi_extlog_mem_error(gdata, err_seq);
+		} else if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
+			struct cper_sec_mem_err2 *mem = acpi_hest_get_payload(gdata);
+
+			if (gdata->error_data_length >= sizeof(*mem))
+				acpi_extlog_mem2_error(gdata, err_seq);
+		} else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) {
+			struct cxl_cper_sec_prot_err *prot_err =
+				acpi_hest_get_payload(gdata);
+
+			cxl_cper_post_prot_err(prot_err,
+					       gdata->error_severity,
+					       gdata->error_data_length);
+		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+			extlog_print_pcie(gdata);
+		} else {
+			void *err = acpi_hest_get_payload(gdata);
+
+			log_non_standard_event(sec_type, fru_id, fru_text,
+					       gdata->error_severity, err,
+					       gdata->error_data_length);
+		}
+	}
+}
+EXPORT_SYMBOL_FOR_MODULES(acpi_extlog_report, "acpi_extlog");
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3aecd3f828e58..49d40af791bbb 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -779,7 +779,6 @@ void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
 	schedule_work(cxl_cper_prot_err_work);
 #endif
 }
-EXPORT_SYMBOL_FOR_MODULES(cxl_cper_post_prot_err, "acpi_extlog");
 
 void cxl_cper_register_prot_err_work(struct work_struct *work)
 {
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index c6b14202a5e92..0ac774a500176 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -109,7 +109,7 @@ static int __init ras_init(void)
 }
 subsys_initcall(ras_init);
 
-#if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)
+#ifdef CONFIG_ACPI_APEI_GHES
 EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(extlog_mem2_event);
 #endif
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index 069c7b3a5e6c0..8df7fb349612a 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -14,7 +14,7 @@
 #include <linux/cper.h>
 
 /*
- * MCE Extended Error Log trace event
+ * CPER memory events from MCE Extended Error Log and GHES.
  *
  * These events are generated when hardware detects a corrected or
  * uncorrected event.
@@ -22,7 +22,7 @@
 
 /* memory trace event */
 
-#if defined(CONFIG_ACPI_EXTLOG) || defined(CONFIG_ACPI_EXTLOG_MODULE)
+#ifdef CONFIG_ACPI_APEI_GHES
 TRACE_EVENT(extlog_mem_event,
 	TP_PROTO(struct cper_sec_mem_err *mem,
 		 u32 err_seq,
-- 
2.43.0

