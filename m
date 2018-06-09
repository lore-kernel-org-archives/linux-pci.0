Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Pu Wen <puwen@hygon.cn>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, zhangpanyong@hygon.cn
Cc: thomas.lendacky@amd.com, peterz@infradead.org, tony.luck@intel.com,
        bp@alien8.de, pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net,
        lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-x86_64@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH 04/11] x86/perf: Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:22:42 +0800
Message-Id: <1528550562-28261-1-git-send-email-puwen@hygon.cn>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch enables the AMD performance events support to Hygon
Family 18h CPU:
- Add Hygon Family 18h support in amd_core_pmu_init() and
  amd_uncore_init().
- Rename x86_pmu.name from "AMD" to "HYGON" on Hygon platforms.
- Add Hygon support in PMU init codes in init_hw_perf_events().

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/events/amd/core.c   | 10 ++++++++++
 arch/x86/events/amd/uncore.c |  7 ++++---
 arch/x86/events/core.c       |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index c84584b..59c7b57 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -669,6 +669,13 @@ static int __init amd_core_pmu_init(void)
 		 * We fallback to using default amd_get_event_constraints.
 		 */
 		break;
+	case 0x18:
+		pr_cont("Fam18h ");
+		/*
+		 * In family 18h, there are no event constraints in the PMC hardware.
+		 * We fallback to using default amd_get_event_constraints.
+		 */
+		break;
 	default:
 		pr_err("core perfctr but no constraints; unknown hardware!\n");
 		return -ENODEV;
@@ -702,6 +709,9 @@ __init int amd_pmu_init(void)
 
 	x86_pmu = amd_pmu;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		x86_pmu.name = "HYGON";
+
 	ret = amd_core_pmu_init();
 	if (ret)
 		return ret;
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index f5cbbba..f8b0890 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -524,15 +524,16 @@ static int __init amd_uncore_init(void)
 {
 	int ret = -ENODEV;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return -ENODEV;
 
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;
 
-	if (boot_cpu_data.x86 == 0x17) {
+	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
 		/*
-		 * For F17h, the Northbridge counters are repurposed as Data
+		 * For F17h and F18h, the Northbridge counters are repurposed as Data
 		 * Fabric counters. Also, L3 counters are supported too. The PMUs
 		 * are exported based on  family as either L2 or L3 and NB or DF.
 		 */
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 45b2b1c..60efd9b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1773,6 +1773,7 @@ static int __init init_hw_perf_events(void)
 	case X86_VENDOR_INTEL:
 		err = intel_pmu_init();
 		break;
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		err = amd_pmu_init();
 		break;
-- 
2.7.4

