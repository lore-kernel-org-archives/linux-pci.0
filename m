Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:36953 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936500AbcJaMRf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2016 08:17:35 -0400
Date: Mon, 31 Oct 2016 13:18:22 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 2/3] pci: No config access for removed devices
Message-ID: <20161031121822.GB9693@wunner.de>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <1477695497-6207-3-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477695497-6207-3-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 28, 2016 at 06:58:16PM -0400, Keith Busch wrote:
> If we've  detected that the PCI device is removed, there is no need to
> access the device's config space. This patch has all the device config
> reads and writes return error when in such a state.
> 
> If the device is not present on a config read, the value returned will be
> set to all 1's. This is the same as what hardware is expected to return
> when accessing a removed device, but software can do this faster without
> relying on hardware.
> 
> When checking if a device is present, we short-cut the removal by
> returning the known state instead of querying the bus.

I went through all the function calls that occur in the PCI core and
the pciehp driver on device removal and the result is the patch below.
This, together with your change to pci_device_is_present() in patch [2/3]
and your change to MSI-X shutdown in patch [3/3] should be sufficient to
avoid config space access on teardown of a surprise-removed device.

The changes in patch [2/3] to pci_read_config*() and pci_write_config*()
would thus become redundant.  I had originally suggested to check the
is_removed flag in them, but later realized that it causes a small
performance penalty when they're called while the device is still present,
which is the normal case.  Also, while the actual device access is avoided,
CPU cycles are still wasted for various locking and calculation of
to-be-written register contents in the config space.

However it might still make sense to keep the changes to pci_read_config*()
and pci_write_config*() in order to prevent device accesses in drivers.
That's ultimately for Bjorn to decide.

Thanks,

Lukas

-- >8 --
Subject: [PATCH] PCI: Skip access to surprise removed devices

Skip config space access to surprise removed devices in the PCI core and
pciehp driver to speed up teardown.

Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c |  3 +++
 drivers/pci/msi.c                |  5 +++++
 drivers/pci/pci.c                | 12 +++++++-----
 drivers/pci/pcie/aspm.c          |  4 ++++
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4582fdf..f68703e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -684,6 +684,9 @@ static void pcie_disable_notification(struct controller *ctrl)
 {
 	u16 mask;
 
+	if (ctrl_dev(ctrl)->is_removed)
+		return;
+
 	mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
 		PCI_EXP_SLTCTL_MRLSCE | PCI_EXP_SLTCTL_PFDE |
 		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index cc13332..db1462c 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -894,6 +894,11 @@ void pci_msi_shutdown(struct pci_dev *dev)
 	if (!pci_msi_enable || !dev || !dev->msi_enabled)
 		return;
 
+	if (dev->is_removed) {
+		dev->msi_enabled = 0;
+		return;
+	}
+
 	BUG_ON(list_empty(dev_to_msi_list(&dev->dev)));
 	desc = first_pci_msi_entry(dev);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 55c0c79..d4a47b2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1577,10 +1577,12 @@ static void do_pci_disable_device(struct pci_dev *dev)
 {
 	u16 pci_command;
 
-	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
-	if (pci_command & PCI_COMMAND_MASTER) {
-		pci_command &= ~PCI_COMMAND_MASTER;
-		pci_write_config_word(dev, PCI_COMMAND, pci_command);
+	if (!dev->is_removed) {
+		pci_read_config_word(dev, PCI_COMMAND, &pci_command);
+		if (pci_command & PCI_COMMAND_MASTER) {
+			pci_command &= ~PCI_COMMAND_MASTER;
+			pci_write_config_word(dev, PCI_COMMAND, pci_command);
+		}
 	}
 
 	pcibios_disable_device(dev);
@@ -1771,7 +1773,7 @@ static void __pci_pme_active(struct pci_dev *dev, bool enable)
 {
 	u16 pmcsr;
 
-	if (!dev->pme_support)
+	if (!dev->pme_support || dev->is_removed)
 		return;
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 0ec649d..8bddaef 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -437,6 +437,9 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	state &= (link->aspm_capable & ~link->aspm_disable);
 	if (link->aspm_enabled == state)
 		return;
+	/* Skip device access if bridge was surprise-removed */
+	if (parent->is_removed)
+		goto set_state;
 	/* Convert ASPM state to upstream/downstream ASPM register state */
 	if (state & ASPM_STATE_L0S_UP)
 		dwstream |= PCI_EXP_LNKCTL_ASPM_L0S;
@@ -459,6 +462,7 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 	if (!(state & ASPM_STATE_L1))
 		pcie_config_aspm_dev(parent, upstream);
 
+set_state:
 	link->aspm_enabled = state;
 }
 
-- 
2.9.3

