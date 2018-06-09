Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Pu Wen <puwen@hygon.cn>
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, zhangpanyong@hygon.cn
Cc: lenb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com,
        peterz@infradead.org, tony.luck@intel.com, bp@alien8.de,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, mchehab@kernel.org,
        trenn@suse.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-x86_64@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Pu Wen <puwen@hygon.cn>
Subject: [PATCH 09/11] driver/cpufreq: Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:24:12 +0800
Message-Id: <1528550652-28485-1-git-send-email-puwen@hygon.cn>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch enables the cpufreq driver support to Hygon Family 18h CPU:
- It recognize Hygon's boost state in boost_state(),
  boost_set_msr(), extract_msr() functions.
- It also add SMBUS support for Hygon Family 18h in
  amd_freq_sensitivity_init().

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 drivers/cpufreq/acpi-cpufreq.c         | 5 ++++-
 drivers/cpufreq/amd_freq_sensitivity.c | 9 +++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 9449657..04c9b81 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -95,6 +95,7 @@ static bool boost_state(unsigned int cpu)
 		rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &lo, &hi);
 		msr = lo | ((u64)hi << 32);
 		return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &lo, &hi);
 		msr = lo | ((u64)hi << 32);
@@ -113,6 +114,7 @@ static int boost_set_msr(bool enable)
 		msr_addr = MSR_IA32_MISC_ENABLE;
 		msr_mask = MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
 		break;
+	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
 		msr_addr = MSR_K7_HWCR;
 		msr_mask = MSR_K7_HWCR_CPB_DIS;
@@ -223,7 +225,8 @@ static unsigned extract_msr(struct cpufreq_policy *policy, u32 msr)
 	struct cpufreq_frequency_table *pos;
 	struct acpi_processor_performance *perf;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		msr &= AMD_MSR_RANGE;
 	else
 		msr &= INTEL_MSR_RANGE;
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index be926d9..4ac7c3c 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -111,11 +111,16 @@ static int __init amd_freq_sensitivity_init(void)
 {
 	u64 val;
 	struct pci_dev *pcidev;
+	unsigned int pci_vendor;
 
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		pci_vendor = PCI_VENDOR_ID_AMD;
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		pci_vendor = PCI_VENDOR_ID_HYGON;
+	else
 		return -ENODEV;
 
-	pcidev = pci_get_device(PCI_VENDOR_ID_AMD,
+	pcidev = pci_get_device(pci_vendor,
 			PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
 
 	if (!pcidev) {
-- 
2.7.4

