Return-Path: <linux-arch-owner@vger.kernel.org>
From: Pu Wen <puwen@hygon.cn>
To: trenn@suse.com, shuah@kernel.org, tglx@linutronix.de,
        zhangpanyong@hygon.cn
Cc: bp@alien8.de, mchehab@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, lenb@kernel.org, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com,
        peterz@infradead.org, tony.luck@intel.com, pbonzini@redhat.com,
        rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-x86_64@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH 11/11] tools/cpupower: Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:25:00 +0800
Message-Id: <1528550700-28580-1-git-send-email-puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch enables the cpupower tool support to Hygon Family 18h CPU:
- Add "HygonGenuine" in cpu_vendor_table[] to match Hygon vendor ID.
- Add definition X86_VENDOR_HYGON in enum cpupower_cpu_vendor.
- Add Hygon Family 18h support in get_boost_mode(), get_cpu_info(),
  init_maxfreq_mode().

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 tools/power/cpupower/utils/cpufreq-info.c               | 6 ++++--
 tools/power/cpupower/utils/helpers/cpuid.c              | 6 ++++--
 tools/power/cpupower/utils/helpers/helpers.h            | 2 +-
 tools/power/cpupower/utils/idle_monitor/mperf_monitor.c | 3 ++-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index df43cd4..75c2140 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -170,6 +170,7 @@ static int get_boost_mode(unsigned int cpu)
 	unsigned long pstates[MAX_HW_PSTATES] = {0,};
 
 	if (cpupower_cpu_info.vendor != X86_VENDOR_AMD &&
+	    cpupower_cpu_info.vendor != X86_VENDOR_HYGON &&
 	    cpupower_cpu_info.vendor != X86_VENDOR_INTEL)
 		return 0;
 
@@ -190,8 +191,9 @@ static int get_boost_mode(unsigned int cpu)
 	printf(_("    Supported: %s\n"), support ? _("yes") : _("no"));
 	printf(_("    Active: %s\n"), active ? _("yes") : _("no"));
 
-	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD &&
-	    cpupower_cpu_info.family >= 0x10) {
+	if ((cpupower_cpu_info.vendor == X86_VENDOR_AMD ||
+	     cpupower_cpu_info.vendor == X86_VENDOR_HYGON) &&
+	     cpupower_cpu_info.family >= 0x10) {
 		ret = decode_pstates(cpu, cpupower_cpu_info.family, b_states,
 				     pstates, &pstate_no);
 		if (ret)
diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
index 732b0b4..0e513b1 100644
--- a/tools/power/cpupower/utils/helpers/cpuid.c
+++ b/tools/power/cpupower/utils/helpers/cpuid.c
@@ -8,7 +8,7 @@
 #include "helpers/helpers.h"
 
 static const char *cpu_vendor_table[X86_VENDOR_MAX] = {
-	"Unknown", "GenuineIntel", "AuthenticAMD",
+	"Unknown", "GenuineIntel", "AuthenticAMD", "HygonGenuine",
 };
 
 #if defined(__i386__) || defined(__x86_64__)
@@ -109,6 +109,7 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 	fclose(fp);
 	/* Get some useful CPU capabilities from cpuid */
 	if (cpu_info->vendor != X86_VENDOR_AMD &&
+	    cpu_info->vendor != X86_VENDOR_HYGON &&
 	    cpu_info->vendor != X86_VENDOR_INTEL)
 		return ret;
 
@@ -125,7 +126,8 @@ int get_cpu_info(struct cpupower_cpu_info *cpu_info)
 		cpu_info->caps |= CPUPOWER_CAP_APERF;
 
 	/* AMD Boost state enable/disable register */
-	if (cpu_info->vendor == X86_VENDOR_AMD) {
+	if (cpu_info->vendor == X86_VENDOR_AMD ||
+	    cpu_info->vendor == X86_VENDOR_HYGON) {
 		if (ext_cpuid_level >= 0x80000007 &&
 		    (cpuid_edx(0x80000007) & (1 << 9)))
 			cpu_info->caps |= CPUPOWER_CAP_AMD_CBP;
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 41da392..9021396 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -61,7 +61,7 @@ extern int be_verbose;
 
 /* cpuid and cpuinfo helpers  **************************/
 enum cpupower_cpu_vendor {X86_VENDOR_UNKNOWN = 0, X86_VENDOR_INTEL,
-			  X86_VENDOR_AMD, X86_VENDOR_MAX};
+			  X86_VENDOR_AMD, X86_VENDOR_HYGON, X86_VENDOR_MAX};
 
 #define CPUPOWER_CAP_INV_TSC		0x00000001
 #define CPUPOWER_CAP_APERF		0x00000002
diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index d7c2a6d..f2a7e9c 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -241,7 +241,8 @@ static int init_maxfreq_mode(void)
 	if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_INV_TSC))
 		goto use_sysfs;
 
-	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD) {
+	if (cpupower_cpu_info.vendor == X86_VENDOR_AMD ||
+	    cpupower_cpu_info.vendor == X86_VENDOR_HYGON) {
 		/* MSR_AMD_HWCR tells us whether TSC runs at P0/mperf
 		 * freq.
 		 * A test whether hwcr is accessable/available would be:
-- 
2.7.4
