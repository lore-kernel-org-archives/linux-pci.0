Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:51949 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbcJFGY5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2016 02:24:57 -0400
Message-Id: <ecb5d8669fd795fc52845f6c901e5aa26c86c452.1475733022.git.lukas@wunner.de>
In-Reply-To: <cover.1475733022.git.lukas@wunner.de>
References: <cover.1475733022.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 6 Oct 2016 08:24:29 +0200
Subject: [PATCH 1/1] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
 ->get_power hook
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, x86@kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit cc7cc02bada8 ("PCI: Query platform firmware for device power
state") augmented struct pci_platform_pm_ops with a ->get_power hook and
implemented it for acpi_pci_platform_pm, the only pci_platform_pm_ops
existing till v4.7.

However v4.8 introduced another pci_platform_pm_ops for Intel Mobile
Internet Devices with commit 5823d0893ec2 ("x86/platform/intel-mid: Add
Power Management Unit driver").  It is missing the ->get_power hook,
which is fatal since pci_set_platform_pm() enforces its presence.

Retrofit mid_pci_platform_pm with the missing callback to fix the
breakage.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 arch/x86/include/asm/intel-mid.h  |  1 +
 arch/x86/platform/intel-mid/pwr.c | 19 +++++++++++++++++++
 drivers/pci/pci-mid.c             |  6 ++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index 9d6b097..4511c10 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -17,6 +17,7 @@
 
 extern int intel_mid_pci_init(void);
 extern int intel_mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state);
+extern pci_power_t intel_mid_pci_get_power_state(struct pci_dev *pdev);
 
 #define INTEL_MID_PWR_LSS_OFFSET	4
 #define INTEL_MID_PWR_LSS_TYPE		(1 << 7)
diff --git a/arch/x86/platform/intel-mid/pwr.c b/arch/x86/platform/intel-mid/pwr.c
index c901a34..214bc99 100644
--- a/arch/x86/platform/intel-mid/pwr.c
+++ b/arch/x86/platform/intel-mid/pwr.c
@@ -260,6 +260,25 @@ int intel_mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state)
 }
 EXPORT_SYMBOL_GPL(intel_mid_pci_set_power_state);
 
+pci_power_t intel_mid_pci_get_power_state(struct pci_dev *pdev)
+{
+	struct mid_pwr *pwr = midpwr;
+	int id, reg, bit;
+	u32 power;
+
+	if (!pwr || !pwr->available)
+		return PCI_UNKNOWN;
+
+	id = intel_mid_pwr_get_lss_id(pdev);
+	if (id < 0)
+		return PCI_UNKNOWN;
+
+	reg = (id * LSS_PWS_BITS) / 32;
+	bit = (id * LSS_PWS_BITS) % 32;
+	power = mid_pwr_get_state(pwr, reg);
+	return (power >> bit) & 3;
+}
+
 int intel_mid_pwr_get_lss_id(struct pci_dev *pdev)
 {
 	int vndr;
diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
index c878aa7..a8b52dc 100644
--- a/drivers/pci/pci-mid.c
+++ b/drivers/pci/pci-mid.c
@@ -29,6 +29,11 @@ static int mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state)
 	return intel_mid_pci_set_power_state(pdev, state);
 }
 
+static pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
+{
+	return intel_mid_pci_get_power_state(pdev);
+}
+
 static pci_power_t mid_pci_choose_state(struct pci_dev *pdev)
 {
 	return PCI_D3hot;
@@ -52,6 +57,7 @@ static bool mid_pci_need_resume(struct pci_dev *dev)
 static struct pci_platform_pm_ops mid_pci_platform_pm = {
 	.is_manageable	= mid_pci_power_manageable,
 	.set_state	= mid_pci_set_power_state,
+	.get_state	= mid_pci_get_power_state,
 	.choose_state	= mid_pci_choose_state,
 	.sleep_wake	= mid_pci_sleep_wake,
 	.run_wake	= mid_pci_run_wake,
-- 
2.9.3

