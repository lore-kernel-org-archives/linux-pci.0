Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Pu Wen <puwen@hygon.cn>
To: boris.ostrovsky@oracle.com, jgross@suse.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        zhangpanyong@hygon.cn
Cc: thomas.lendacky@amd.com, peterz@infradead.org, tony.luck@intel.com,
        bp@alien8.de, pbonzini@redhat.com, rkrcmar@redhat.com,
        rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org,
        mchehab@kernel.org, trenn@suse.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-x86_64@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, Pu Wen <puwen@hygon.cn>
Subject: [PATCH 07/11] x86/xen: Add support for Hygon's Dhyana Family 18h processor
Date: Sat,  9 Jun 2018 21:23:37 +0800
Message-Id: <1528550617-28395-1-git-send-email-puwen@hygon.cn>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch enables the Xen Hypervisor support to Hygon
Family 18h CPU:
- Add Hygon support in Xen PMU arch init codes.
- Add Hygon support in PMU MSR read/write codes.
- Add Hygon support in read PMC codes.

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/xen/pmu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index 7d00d4a..e2bee70 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -68,7 +68,8 @@ static __read_mostly int intel_num_arch_counters, intel_num_fixed_counters;
 
 static void xen_pmu_arch_init(void)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 
 		switch (boot_cpu_data.x86) {
 		case 0x15:
@@ -285,7 +286,8 @@ static bool xen_amd_pmu_emulate(unsigned int msr, u64 *val, bool is_read)
 
 bool pmu_msr_read(unsigned int msr, uint64_t *val, int *err)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		if (is_amd_pmu_msr(msr)) {
 			if (!xen_amd_pmu_emulate(msr, val, 1))
 				*val = native_read_msr_safe(msr, err);
@@ -308,7 +310,8 @@ bool pmu_msr_write(unsigned int msr, uint32_t low, uint32_t high, int *err)
 {
 	uint64_t val = ((uint64_t)high << 32) | low;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 		if (is_amd_pmu_msr(msr)) {
 			if (!xen_amd_pmu_emulate(msr, &val, 0))
 				*err = native_write_msr_safe(msr, low, high);
@@ -379,7 +382,8 @@ static unsigned long long xen_intel_read_pmc(int counter)
 
 unsigned long long xen_read_pmc(int counter)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return xen_amd_read_pmc(counter);
 	else
 		return xen_intel_read_pmc(counter);
-- 
2.7.4

