Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:60042 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaAKB1h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2014 20:27:37 -0500
Received: by mail-pa0-f44.google.com with SMTP id fa1so5497848pad.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2014 17:27:37 -0800 (PST)
Subject: [PATCH v2 07/12] PCI: Remove unused pcie_aspm_enabled()
To: Stephen Hemminger <stephen@networkplumber.org>,
	linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yu Zhao <yu.zhao@intel.com>,
	Andrew Patterson <andrew.patterson@hp.com>
Date: Fri, 10 Jan 2014 18:27:34 -0700
Message-ID: <20140111012734.14505.57102.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140111012339.14505.40203.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

My philosophy is unused code is dead code.  And dead code is subject to bit
rot and is a likely source of bugs.  Use it or lose it.

This reverts part of 3e1b16002af2 ("ACPI/PCI: PCIe ASPM _OSC support
capabilities called when root bridge added"), removing this interface:

    pcie_aspm_enabled()

[bhelgaas: split to separate patch]
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Andrew Patterson <andrew.patterson@hp.com>
---
 drivers/pci/pcie/aspm.c |   12 ------------
 include/linux/pci.h     |    2 --
 2 files changed, 14 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index f1272dc54de1..e1e7026b838d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -984,18 +984,6 @@ void pcie_no_aspm(void)
 	}
 }
 
-/**
- * pcie_aspm_enabled - is PCIe ASPM enabled?
- *
- * Returns true if ASPM has not been disabled by the command-line option
- * pcie_aspm=off.
- **/
-int pcie_aspm_enabled(void)
-{
-       return !aspm_disabled;
-}
-EXPORT_SYMBOL(pcie_aspm_enabled);
-
 bool pcie_aspm_support_enabled(void)
 {
 	return aspm_support_enabled;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bf1f385bf14d..583348275085 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1198,10 +1198,8 @@ extern bool pcie_ports_auto;
 #endif
 
 #ifndef CONFIG_PCIEASPM
-static inline int pcie_aspm_enabled(void) { return 0; }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
 #else
-int pcie_aspm_enabled(void);
 bool pcie_aspm_support_enabled(void);
 #endif
 

