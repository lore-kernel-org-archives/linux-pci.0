Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Huang Ying <ying.huang@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Huang Ying <ying.huang@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [BUGFIX -v3 1/4] PCI/PM: enable D3/D3cold by default for most devices
Date: Wed,  8 Aug 2012 09:07:38 +0800
Message-Id: <1344388061-18981-2-git-send-email-ying.huang@intel.com>
In-Reply-To: <1344388061-18981-1-git-send-email-ying.huang@intel.com>
References: <1344388061-18981-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch fixes the following bug:

http://marc.info/?l=linux-usb&m=134318961120825&w=2

Originally, device lower power states include D1, D2, D3.  After that,
D3 is further divided into D3hot and D3cold.  To support both scenario
safely, original D3 is mapped to D3cold.

When adding D3cold support, because worry about some device may have
broken D3cold support, D3cold is disabled by default.  This disable D3
on original platform too.  But some original platform may only have
working D3, but no working D1, D2.  The root cause of the above bug is
it too.

To deal with this, this patch enables D3/D3cold by default for most
devices.  This restores the original behavior.  For some devices that
suspected to have broken D3cold support, such as PCIe port, D3cold is
disabled by default.

Reported-by: Bjorn Mork <bjorn@mork.no>
Signed-off-by: Huang Ying <ying.huang@intel.com>
Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c              |    1 +
 drivers/pci/pcie/portdrv_pci.c |    5 +++++
 2 files changed, 6 insertions(+)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1941,6 +1941,7 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->pm_cap = pm;
 	dev->d3_delay = PCI_PM_D3_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
+	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
 	dev->d2_support = false;
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -200,6 +200,11 @@ static int __devinit pcie_portdrv_probe(
 		return status;
 
 	pci_save_state(dev);
+	/*
+	 * D3cold may not work properly on some PCIe port, so disable
+	 * it by default.
+	 */
+	dev->d3cold_allowed = false;
 	if (!pci_match_id(port_runtime_pm_black_list, dev))
 		pm_runtime_put_noidle(&dev->dev);
 
