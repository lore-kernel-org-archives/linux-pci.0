Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36068 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756458AbdEKV4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2017 17:56:55 -0400
Received: by mail-pg0-f47.google.com with SMTP id x64so1268776pgd.3
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2017 14:56:55 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        Rajat Jain <rajatja@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [RFC PATCH] PCI: disable MSI/MSI-X before resetting
Date: Thu, 11 May 2017 14:54:05 -0700
Message-Id: <20170511215405.91410-1-briannorris@chromium.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Despite the claims in the associated comment block, it seems that
clearing the command register is not enough to guarantee that no
MSI interrupts get triggered during Function Level Reset. Through code
instrumentation, I'm able to clearly trace cases like this:

(0) reset a device:
        echo 1 > /sys/bus/pci/devices/xxx/reset
(1) disable an MSI interrupt for device 'xxx' in a PCI reset handler
    (disable_irq())
(2) pcie_flr() initiates reset:
        pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR));
(3) about 0.5 ms later, kernel handles IRQ:
        -> __pci_msi_desc_mask_irq()
           -> pci_write_config_dword()
(4) this is well before the device is actually ready, and the system
    sees a bus abort

Tested with MSI, but presumably MSI-X could have the same issue.

Tested on Samsung Chromebook Plus, with RK3399 OP1.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
RFC, because I'm not really sure this is the right approach, or if
there's something else that's misconfigured or buggy.

Note that right now, configuration space aborts trigger SError aborts
(and panics) on RK3399, so this sort of problem is fatal. It's not clear
to me if that's a spec violation (many other PCI controllers manage to
mask such aborts), or an acceptable behavior. But FWIW, that means that
polling behavior like in commit 5adecf817dd6 ("PCI: Wait for up to
1000ms after FLR reset") cannot work; the first read when the device is
not ready will cause a panic.
---
 drivers/pci/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b01bd5bba8e6..861a3b2d7026 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4156,6 +4156,17 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	pci_set_power_state(dev, PCI_D0);
 
 	pci_save_state(dev);
+
+	/*
+	 * Disable MSI/MSI-X before resetting. Some devices have been found to
+	 * trigger interrupts while in the middle of Function Level Reset. The
+	 * MSI/MSI-X state will get restored after we reset.
+	 */
+	if (dev->msi_enabled)
+		pci_msi_set_enable(dev, 0);
+	if (dev->msix_enabled)
+		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
+
 	/*
 	 * Disable the device by clearing the Command register, except for
 	 * INTx-disable which is set.  This not only disables MMIO and I/O port
-- 
2.13.0.rc2.291.g57267f2277-goog
