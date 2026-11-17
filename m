Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914388;
	b=OX3m7x4j/wlUFu0JSBuBhH94jAOqS0umUj+7QjC/eoiNDf7qamU6T0/kroLeXyCvSUyj
	 W1aBq3igMqHfeZ1DXJ3/YnC+A4TzoZhv/xFZdBzCNRCYtOdMg8Zy+Y7FGSub+AHQZRnt7
	 B8ecUVAf1FcTAuAa2lJHb4LmC/HlTUGQIcKrwtw7rrlRqofGDhF8AFilo8y894pd9f2Nm
	 zH3ua7PqhXBYgLMnkClBRmOdrra5Z9kDV+e+iu2Wo5RezQwoc65Wm26xsz5zJR8MgI6y+
	 tf6G3FxWGH4i960wcdttTPUaGfln9OILyHN21YExWBmdRMbe2S6z8yzjdr6PUvrPPMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914388;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SIYzj+lYaoqY2d7tfqlkoRpjU8XkkKSmiyZ/PHktka8=;
	b=FpSjTR+FEcYSVryXPdU+CQushyuVdSqNVzp+22m/kfM3vPjxVfcpKWFH6+4Cjf22dFEI
	 pH2c1g5+TRXAr48Uh25F7DLF+EQHmueLgrtUOXJLZtkDWcLSPOdPFP3LkSnLaDriaIodA
	 z1FjafNVVB3vxiW4DJmNoXhmm8WbAht9iFE7h1GxqEvz/s1ryWzIU5B+sE2zWrxoC7bVv
	 P+ha13GcZqEUA5motznrRODG567pKckceBjS1CyyAiHTBZuxlIiNE1sF5e7hfLttPjDiK
	 whAy5IBgYtEDHdzHvYi2ZxujQ8LPb9LGFpDX+TDnTjB+2MWVpDb7AQbxJBIthUNkHag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ps3EGgde;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0FF606A339;
	Tue, 17 Nov 2026 11:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D0FF606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Ps3EGgde
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FD151C00;
	Tue, 17 Nov 2026 03:19:43 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47A7B3F763;
	Tue, 17 Nov 2026 03:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914386; bh=4uxQTmCJiBMpLk/aGJKins77aw++2s56PhdCnxpSPcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ps3EGgdep9GNH0IIM2nfDRpSFE3ESwrFsbgZV67NsOMuKif8ECA00O+wyfV4fkbRo
	 uphKLcBEyo/zblvY++ZR7HzF0UnItqpCgKJGlFbGIGjnV1LM0RztYwaqP2SWTZc9Vu
	 /1XBU39FBYufw+dabU2klb52ElFhroFtXOlvPl6U=
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
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 13/19] ACPI: APEI: Share helpers with the common CPER reporter
Date: Tue, 17 Nov 2026 12:10:23 +0100
Message-ID: <20261117111444.4185512-14-pierre.gondois@arm.com>
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

Prepare a following patch by renaming/exporting some ghes internal
functions to extlog.c. Namely:
- Rename ghes_mem_err_min_len() to acpi_extlog_mem_err_min_len()
- cxl_cper_post_event() ghes_severity() are not static anymore.

No functional change intended.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/acpi/apei/apei-internal.h |  5 +++++
 drivers/acpi/apei/extlog.c        | 22 ++++++++++++++++++++++
 drivers/acpi/apei/ghes.c          | 31 ++++---------------------------
 3 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index a7c70adf91478..f7f0ab8e5ed7f 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -8,7 +8,12 @@
 #define APEI_INTERNAL_H
 
 #include <linux/acpi.h>
+#include <cxl/event.h>
 
+int ghes_severity(int severity);
+void cxl_cper_post_event(enum cxl_event_type event_type,
+			 struct cxl_cper_event_rec *rec, u32 len);
+u32 acpi_extlog_mem_err_min_len(u64 validation_bits);
 void acpi_extlog_report(const struct acpi_hest_generic_status *estatus);
 
 struct apei_exec_context;
diff --git a/drivers/acpi/apei/extlog.c b/drivers/acpi/apei/extlog.c
index 8eef33a4326a7..8d9b91a764902 100644
--- a/drivers/acpi/apei/extlog.c
+++ b/drivers/acpi/apei/extlog.c
@@ -55,6 +55,28 @@ static void extlog_print_pcie(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+/*
+ * The fields from "extended" on are absent from the 73-byte UEFI 2.1/2.2
+ * layout that older firmware still emits. Return the length needed for the
+ * fields the validation bits claim, so over-claiming is rejected without
+ * rejecting an honest short record.
+ */
+u32 acpi_extlog_mem_err_min_len(u64 validation_bits)
+{
+	u32 len = sizeof(struct cper_sec_mem_err_old);
+
+	if (validation_bits & (CPER_MEM_VALID_ROW_EXT | CPER_MEM_VALID_CHIP_ID))
+		len = offsetof(struct cper_sec_mem_err, rank);
+	if (validation_bits & CPER_MEM_VALID_RANK_NUMBER)
+		len = offsetof(struct cper_sec_mem_err, mem_array_handle);
+	if (validation_bits & CPER_MEM_VALID_CARD_HANDLE)
+		len = offsetof(struct cper_sec_mem_err, mem_dev_handle);
+	if (validation_bits & CPER_MEM_VALID_MODULE_HANDLE)
+		len = sizeof(struct cper_sec_mem_err);
+
+	return len;
+}
+
 /**
  * acpi_extlog_mem_error - trace a validated CPER memory section
  * @gdata: section header followed by its payload
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 49d40af791bbb..b51b621208ed1 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -52,7 +52,6 @@
 #include <acpi/apei.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
-#include <cxl/event.h>
 #include <ras/ras_event.h>
 
 #include "apei-internal.h"
@@ -308,7 +307,7 @@ static void ghes_fini(struct ghes *ghes)
 		unmap_gen_v2(ghes);
 }
 
-static inline int ghes_severity(int severity)
+int ghes_severity(int severity)
 {
 	switch (severity) {
 	case CPER_SEV_INFORMATIONAL:
@@ -824,8 +823,8 @@ DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
 static DEFINE_RAW_SPINLOCK(cxl_cper_work_lock);
 struct work_struct *cxl_cper_work;
 
-static void cxl_cper_post_event(enum cxl_event_type event_type,
-				struct cxl_cper_event_rec *rec, u32 len)
+void cxl_cper_post_event(enum cxl_event_type event_type,
+			 struct cxl_cper_event_rec *rec, u32 len)
 {
 	struct cxl_cper_work_data wd;
 
@@ -931,28 +930,6 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
 	hwerr_log_error_type(HWERR_RECOV_OTHERS);
 }
 
-/*
- * The fields from "extended" on are absent from the 73-byte UEFI 2.1/2.2
- * layout that older firmware still emits. Return the length needed for the
- * fields the validation bits claim, so over-claiming is rejected without
- * rejecting an honest short record.
- */
-static u32 ghes_mem_err_min_len(u64 validation_bits)
-{
-	u32 len = sizeof(struct cper_sec_mem_err_old);
-
-	if (validation_bits & (CPER_MEM_VALID_ROW_EXT | CPER_MEM_VALID_CHIP_ID))
-		len = offsetof(struct cper_sec_mem_err, rank);
-	if (validation_bits & CPER_MEM_VALID_RANK_NUMBER)
-		len = offsetof(struct cper_sec_mem_err, mem_array_handle);
-	if (validation_bits & CPER_MEM_VALID_CARD_HANDLE)
-		len = offsetof(struct cper_sec_mem_err, mem_dev_handle);
-	if (validation_bits & CPER_MEM_VALID_MODULE_HANDLE)
-		len = sizeof(struct cper_sec_mem_err);
-
-	return len;
-}
-
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -994,7 +971,7 @@ static void ghes_do_proc(struct ghes *ghes,
 
 			/* Then require what the claimed fields actually need. */
 			if (gdata->error_data_length <
-			    ghes_mem_err_min_len(mem_err->validation_bits)) {
+			    acpi_extlog_mem_err_min_len(mem_err->validation_bits)) {
 				pr_warn_ratelimited(FW_WARN GHES_PFX
 						    "memory error section too small (%u) for the fields it claims\n",
 						    gdata->error_data_length);
-- 
2.43.0

