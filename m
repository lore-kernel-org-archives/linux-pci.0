Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp21.cstnet.cn ([159.226.251.21]:44116 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753247AbeFINaV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Jun 2018 09:30:21 -0400
From: Pu Wen <puwen@hygon.cn>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, tony.luck@intel.com, bp@alien8.de,
        zhangpanyong@hygon.cn
Cc: thomas.lendacky@amd.com, peterz@infradead.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org,
        mchehab@kernel.org, trenn@suse.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-x86_64@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH 05/11] x86/mce: Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:23:03 +0800
Message-Id: <1528550583-28307-1-git-send-email-puwen@hygon.cn>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch enables the X86 MCE infrastructure support to Hygon
Family 18h CPU:
- It enable Hygon check in __mcheck_cpu_init_early(), print_mce()
  and mce_usable_address() etc.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/kernel/cpu/mcheck/mce-severity.c |  3 ++-
 arch/x86/kernel/cpu/mcheck/mce.c          | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-severity.c b/arch/x86/kernel/cpu/mcheck/mce-severity.c
index 5bbd06f..610b5ff 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-severity.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-severity.c
@@ -331,7 +331,8 @@ int (*mce_severity)(struct mce *m, int tolerant, char **msg, bool is_excp) =
 
 void __init mcheck_vendor_init_severity(void)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		mce_severity = mce_severity_amd;
 }
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 42cf288..4711225 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -274,7 +274,8 @@ static void print_mce(struct mce *m)
 {
 	__print_mce(m);
 
-	if (m->cpuvendor != X86_VENDOR_AMD)
+	if (m->cpuvendor != X86_VENDOR_AMD &&
+	    m->cpuvendor != X86_VENDOR_HYGON)
 		pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
 }
 
@@ -512,7 +513,8 @@ static int mce_usable_address(struct mce *m)
 
 bool mce_is_memory_error(struct mce *m)
 {
-	if (m->cpuvendor == X86_VENDOR_AMD) {
+	if (m->cpuvendor == X86_VENDOR_AMD ||
+	    m->cpuvendor == X86_VENDOR_HYGON) {
 		return amd_mce_is_memory_error(m);
 
 	} else if (m->cpuvendor == X86_VENDOR_INTEL) {
@@ -543,6 +545,9 @@ static bool mce_is_correctable(struct mce *m)
 	if (m->cpuvendor == X86_VENDOR_AMD && m->status & MCI_STATUS_DEFERRED)
 		return false;
 
+	if (m->cpuvendor == X86_VENDOR_HYGON && m->status & MCI_STATUS_DEFERRED)
+		return false;
+
 	if (m->status & MCI_STATUS_UC)
 		return false;
 
@@ -1713,7 +1718,8 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
  */
 static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 {
-	if (c->x86_vendor == X86_VENDOR_AMD) {
+	if (c->x86_vendor == X86_VENDOR_AMD ||
+	    c->x86_vendor == X86_VENDOR_HYGON) {
 		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
@@ -1735,6 +1741,7 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_adjust_timer = cmci_intel_adjust_timer;
 		break;
 
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD: {
 		mce_amd_feature_init(c);
 		break;
@@ -1967,7 +1974,8 @@ static void vendor_disable_error_reporting(void)
 	 * last level cache (LLC), the integrated memory controller (iMC), etc.
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return;
 
 	mce_disable_error_reporting();
-- 
2.7.4
