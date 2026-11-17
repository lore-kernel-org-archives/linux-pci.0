Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914173;
	b=xT9d8KN9qci1/VDwg8FgrSBekplxuil056u4vSZ0EN7eJiGmBteKzEj6K3oQU+lBl1HK
	 r9f+1EYdunw0iXLDWO8NmDr7kDOznyRYP8GlpOb5QozgcmRLKfhAJ/UOWVW/HfIg2p27X
	 KaayFxC3O6m3WQVDsritWffGZ8z2Db/rJLSpJ9In6CLnYNZyLqwNJUb/oXdxTkdE0g7Ks
	 QXnk1cNwpYDNY5eTpSj0AaHCU/dVMvPF7J6sH22vYLEiQShKmKiT4BJK3FUmwbP+0R0R1
	 TsW1slq2uezbJSjPccXfDnkXbmyT9LYtaREl+YWOkw1WI75nzp2RU8JDEUoR6BExApQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914173;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KdPfRKQsITkj2xTm0Ckh0nynyb6gsVLNNS8iQhKtX9Y=;
	b=hCrehab44xWBMxmzRdffY2uxQz9YEfUgmrRThGmsGdRqtVcgqc5UpazLB68RyaZHvhp3
	 OPVJIeMd9rnBcsoVrGY6EPJF+w5o34dXIlJvrtGp0TU7eyaR4bI7uSBjsIOOKjbrPyH8b
	 QT8STuZV8NPbHPk/p1vfuI9jdTaSfwPC/chtLeRqgzb19oH5+J6hGY0AbeQiO4mwYeExZ
	 WaFB25zA76vvkdpfkohMZ6X66iXp8kvHLizCHATseYn0mW0j2ChDpDuF2GDaU4YbEFHTD
	 J/n3D0x3eeUlpk1z38E7ROb4lCFKSAD9RMYbgr+YUWJQqZQ67GJrwEBt0opOY6TxXlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=n+NzOeBA;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89A8606A323;
	Tue, 17 Nov 2026 11:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A89A8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=n+NzOeBA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 164BD1A00;
	Tue, 17 Nov 2026 03:16:09 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 46A183F763;
	Tue, 17 Nov 2026 03:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914172; bh=+seG+Es6T8P/0cUkexaRG5Jcisr8c6aEc2SHs8eVSIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+NzOeBAxsNGcwnMbahxLW1vlZFQM3oATmAeDVp631vAcYwtgSPnu/Tm5NR1MTRvY
	 5VvGSJ10TUlgkE08LaxPOtttIdMeB7pXbEasWgp1oSDKNSy99Xb7h/efGIC0QZtZQY
	 WOkvP8vP7b17X/ucRI9utTZCS6ah+ZaM2N7FSmr4=
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
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Breno Leitao <leitao@debian.org>,
	Dan Williams <djbw@kernel.org>,
	Terry Bowman <terry.bowman@amd.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 02/19] x86/APEI: Report Memory Error Section 2 through MCE
Date: Tue, 17 Nov 2026 12:10:12 +0100
Message-ID: <20261117111444.4185512-3-pierre.gondois@arm.com>
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

Add support for CPER Memory Error Section 2 through MCE, allowing
to emit an mce_record trace event. The implementation follows
the existing CPER Memory Error Section (1) implementation.

Fix the mismatch between the parameter definition/declaration
of apei_mce_report_mem_error().

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 arch/x86/include/asm/mce.h     |  5 ++++-
 arch/x86/kernel/acpi/apei.c    |  7 +++++++
 arch/x86/kernel/cpu/mce/apei.c | 12 ++++++++++++
 drivers/acpi/apei/apei-base.c  |  5 +++++
 drivers/acpi/apei/ghes.c       |  1 +
 include/acpi/apei.h            |  1 +
 6 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 9995176d68790..4a590a250720d 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -336,8 +336,11 @@ extern void (*deferred_error_int_vector)(void);
  */
 
 struct cper_sec_mem_err;
-extern void apei_mce_report_mem_error(int corrected,
+struct cper_sec_mem_err2;
+extern void apei_mce_report_mem_error(int severity,
 				      struct cper_sec_mem_err *mem_err);
+extern void apei_mce_report_mem_error2(int severity,
+				      struct cper_sec_mem_err2 *mem_err);
 
 /*
  * Enumerate new IP types and HWID values in AMD processors which support
diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index e21419e686eb3..96eb75b570e4e 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -46,6 +46,13 @@ void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 #endif
 }
 
+void arch_apei_report_mem_error2(int sev, struct cper_sec_mem_err2 *mem_err)
+{
+#ifdef CONFIG_X86_MCE
+	apei_mce_report_mem_error2(sev, mem_err);
+#endif
+}
+
 int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	return apei_smca_report_x86_error(ctx_info, lapic_id);
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index b993ac78a3b36..2404faa60c325 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -68,6 +68,18 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 }
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
+void apei_mce_report_mem_error2(int severity, struct cper_sec_mem_err2 *mem_err)
+{
+	u64 mask = 0;
+
+	if (!(mem_err->validation_bits & CPER_MEM2_VALID_PA))
+		return;
+	if (mem_err->validation_bits & CPER_MEM2_VALID_PA_MASK)
+		mask = mem_err->physical_addr_mask;
+
+	apei_mce_report_mem_error_common(severity, mem_err->physical_addr, mask);
+}
+
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 7a06d30bd40e9..a2dbdfabeb6c7 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -773,6 +773,11 @@ void __weak arch_apei_report_mem_error(int sev,
 }
 EXPORT_SYMBOL_GPL(arch_apei_report_mem_error);
 
+void __weak arch_apei_report_mem_error2(int sev,
+					struct cper_sec_mem_err2 *mem_err)
+{
+}
+
 int apei_osc_setup(void)
 {
 	static u8 whea_uuid_str[] = "ed855e0c-6c90-47bf-a62a-26de0fc5ad5c";
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 07306af5a54b9..703f3b7f700a6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1030,6 +1030,7 @@ static void ghes_do_proc(struct ghes *ghes,
 			}
 
 			atomic_notifier_call_chain(&ghes_report_mem2_chain, sev, mem_err);
+			arch_apei_report_mem_error2(sev, mem_err);
 			queued |= ghes_handle_memory_failure2(gdata, sev, sync);
 		} else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index dc60f7db5524f..a92174793d9c2 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -52,6 +52,7 @@ int erst_clear(u64 record_id);
 
 int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data);
 void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err);
+void arch_apei_report_mem_error2(int sev, struct cper_sec_mem_err2 *mem_err);
 
 #endif
 #endif
-- 
2.43.0

