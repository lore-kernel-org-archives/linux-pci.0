Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33316 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966603AbcBDR3r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2016 12:29:47 -0500
Received: by mail-wm0-f50.google.com with SMTP id g62so15110027wme.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Feb 2016 09:29:46 -0800 (PST)
From: Tomasz Nowicki <tn@semihalf.com>
To: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
Cc: robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com,
	Tomasz Nowicki <tn@semihalf.com>
Subject: [PATCH V4 22/23] arm64, pci, acpi: Assign legacy IRQs once device is enable.
Date: Thu,  4 Feb 2016 18:29:00 +0100
Message-Id: <1454606941-9523-23-git-send-email-tn@semihalf.com>
In-Reply-To: <1454606941-9523-1-git-send-email-tn@semihalf.com>
References: <1454606941-9523-1-git-send-email-tn@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is the last step before enabling generic ACPI PCI host controller
for ARM64. We need to take care of legacy IRQ mapping for non-MSI(X)
PCI devices. pcibios_enable_device() boot order is not sensitive to
ACPI device enumeration, so it is the best place to assign device's IRQs.

NOTE: *This is going to be temporary solution*. There is ongoing work
which aims for cleaning legacy IRQ allocation, see [1].
We can consider this patch as the necessary evil which will be removed
once [1] series hits mailnline in the near future.

1. http://comments.gmane.org/gmane.linux.kernel.pci/46461

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/kernel/pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 023b983..d1a701f 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -39,16 +39,26 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 }
 
 /**
- * pcibios_enable_device - Enable I/O and memory.
+ * pcibios_enable_device - Enable I/O, memory and legacy IRQs for ACPI.
  * @dev: PCI device to be enabled
  * @mask: bitmask of BARs to enable
  */
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
+	int ret;
+
 	if (pci_has_flag(PCI_PROBE_ONLY))
 		return 0;
 
-	return pci_enable_resources(dev, mask);
+	ret = pci_enable_resources(dev, mask);
+	if (ret < 0)
+		return ret;
+
+#ifdef CONFIG_ACPI
+	if (!pci_dev_msi_enabled(dev))
+		return acpi_pci_irq_enable(dev);
+#endif
+	return 0;
 }
 
 /*
-- 
1.9.1

