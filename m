Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36084 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbbIQPVg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Sep 2015 11:21:36 -0400
Received: by ioii196 with SMTP id i196so25542500ioi.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2015 08:21:36 -0700 (PDT)
Date: Thu, 17 Sep 2015 10:21:25 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/AER: Cleanup AER error status registers on
 probing/restoring devices
Message-ID: <20150917152125.GG25767@google.com>
References: <1441211451-14319-1-git-send-email-izumi.taku@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441211451-14319-1-git-send-email-izumi.taku@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 03, 2015 at 01:30:51AM +0900, Taku Izumi wrote:
> AER uncorrectable or correctable error might be recorded
> when power on devices. These errors can be ignored, so
> BIOS usually cleans up these registers ahead of OS's scanning
> devices.
> However, in case of hot-plug PCIe devices, BIOS can't care.
> Currently OS don't clean up AER error status registers on probing
> devices, ignorable AER errors recorded when power-on remains.
> This causes false-positive.
> The same is true of during-resume-from-suspend.
> 
> This patch address this problem by cleaning up AER error status
> registers on probing devices and on restoring devices.
> 
> v1 -> v2:
>  - delete unnecessary EXPORT_SYMBOL_GPL
>  - add pci_is_pcie() check to pci_cleanup_aer_error_status_regs()
>  - cleanup AER error status register at pci_restore_state()
> 
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>

Applied with tweaks as below to pci/aer for v4.4, thanks!


commit b07461a8e45b7a62ef7fb46e4f6ada66f63406a8
Author: Taku Izumi <izumi.taku@jp.fujitsu.com>
Date:   Thu Sep 17 10:09:37 2015 -0500

    PCI/AER: Clear error status registers during enumeration and restore
    
    AER errors might be recorded when powering-on devices.  These errors can be
    ignored, so firmware usually clears them before the OS enumerates devices.
    However, firmware is not involved when devices are added via hotplug, so
    the OS may discover power-up errors that should be ignored.  The same may
    happen when powering up devices when resuming after suspend.
    
    Clear the AER error status registers during enumeration and resume.
    
    [bhelgaas: changelog, remove repetitive comments]
    Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6a9a111..62ecf45 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -27,6 +27,7 @@
 #include <linux/pci_hotplug.h>
 #include <asm-generic/pci-bridge.h>
 #include <asm/setup.h>
+#include <linux/aer.h>
 #include "pci.h"
 
 const char *pci_power_names[] = {
@@ -1099,6 +1100,8 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_ats_state(dev);
 	pci_restore_vc_state(dev);
 
+	pci_cleanup_aer_error_status_regs(dev);
+
 	pci_restore_config_space(dev);
 
 	pci_restore_pcix_state(dev);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 9803e3d..fba785e 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -74,6 +74,34 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_cleanup_aer_uncorrect_error_status);
 
+int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+{
+	int pos;
+	u32 status;
+	int port_type;
+
+	if (!pci_is_pcie(dev))
+		return -ENODEV;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!pos)
+		return -EIO;
+
+	port_type = pci_pcie_type(dev);
+	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
+		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, status);
+	}
+
+	pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS, &status);
+	pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS, status);
+
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
+
+	return 0;
+}
+
 /**
  * add_error_device - list device to be handled
  * @e_info: pointer to error info
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0b2be17..8cd9710 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/pci-aspm.h>
+#include <linux/aer.h>
 #include <asm-generic/pci-bridge.h>
 #include "pci.h"
 
@@ -1621,6 +1622,8 @@ static void pci_init_capabilities(struct pci_dev *dev)
 
 	/* Enable ACS P2P upstream forwarding */
 	pci_enable_acs(dev);
+
+	pci_cleanup_aer_error_status_regs(dev);
 }
 
 static void pci_set_msi_domain(struct pci_dev *dev)
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4fef65e..744b997 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -42,6 +42,7 @@ struct aer_capability_regs {
 int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
+int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
 #else
 static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
@@ -55,6 +56,10 @@ static inline int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
+{
+	return -EINVAL;
+}
 #endif
 
 void cper_print_aer(struct pci_dev *dev, int cper_severity,
