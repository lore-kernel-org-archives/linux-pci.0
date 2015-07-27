Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:43385 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbbG0Kyi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2015 06:54:38 -0400
Date: Mon, 27 Jul 2015 11:54:20 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	James Morse <James.Morse@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jayachandran C <jchandra@broadcom.com>
Subject: Re: [PATCH v2 2/2] ARM: pci: kill pcibios_msi_controller
Message-ID: <20150727105420.GF7557@n2100.arm.linux.org.uk>
References: <1437754383-8162-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1437754383-8162-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20150726185822.GB7557@n2100.arm.linux.org.uk>
 <20150727094046.GB10308@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150727094046.GB10308@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 27, 2015 at 10:40:46AM +0100, Lorenzo Pieralisi wrote:
> On Sun, Jul 26, 2015 at 07:58:22PM +0100, Russell King - ARM Linux wrote:
> > This doesn't seem to be a good approach.  Maybe having a version of
> > pci_scan_root_bus() which takes the MSI data as an argument would be
> > better than selectively copying pci_scan_root_bus() into the ARM code?
> 
> I understand your point, let's try to find a fast way forward, we are
> stuck otherwise:
> 
> 3) I patch pci_scan_root_bus() to pass the MSI pointer. I think that
>    pcibios_msi_controller was added to avoid doing this, that
>    function has already 5 parameters and it is a treewide change,
>    I suspect Bjorn won't be happy about this at all.

Or you could use the suggestion I made in the paragraph you quoted above,
which is a variation on your (3) without the down-sides of needing to
change lots of callsites.  Something like this (bios32.c is incomplete):

 arch/arm/kernel/bios32.c |  8 +++-----
 drivers/pci/probe.c      | 15 +++++++++++++--
 include/linux/pci.h      |  4 ++++
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index fcbbbb1b9e95..e4f7c0eb6c14 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -462,9 +462,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		if (!sys)
 			panic("PCI: unable to allocate sys data!");
 
-#ifdef CONFIG_PCI_MSI
-		sys->msi_ctrl = hw->msi_ctrl;
-#endif
 		sys->busnr   = busnr;
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
@@ -486,8 +483,9 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 			if (hw->scan)
 				sys->bus = hw->scan(nr, sys);
 			else
-				sys->bus = pci_scan_root_bus(parent, sys->busnr,
-						hw->ops, sys, &sys->resources);
+				sys->bus = pci_scan_root_bus_msi(parent,
+						sys->busnr, hw->ops, sys,
+						&sys->resources, hw->msi_ctrl);
 
 			if (!sys->bus)
 				panic("PCI: unable to scan bus!");
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index cefd636681b6..4915c6d9c22d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2096,8 +2096,9 @@ void pci_bus_release_busn_res(struct pci_bus *b)
 			res, ret ? "can not be" : "is");
 }
 
-struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata,
+		struct list_head *resources, struct msi_controller *msi)
 {
 	struct resource_entry *window;
 	bool found = false;
@@ -2114,6 +2115,8 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 	if (!b)
 		return NULL;
 
+	b->msi = msi;
+
 	if (!found) {
 		dev_info(&b->dev,
 		 "No busn resource found for root bus, will use [bus %02x-ff]\n",
@@ -2128,6 +2131,14 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 
 	return b;
 }
+EXPORT_SYMBOL(pci_scan_root_bus_msi);
+
+struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
+{
+	return pci_scan_root_bus_msi(parent, bus, ops, sysdata, resources,
+				     NULL);
+}
 EXPORT_SYMBOL(pci_scan_root_bus);
 
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8a0321a8fb59..4d4f9d29fcc9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -787,6 +787,10 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
+struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
+				      struct pci_ops *ops, void *sysdata,
+				      struct list_head *resources,
+				      struct msi_controller *msi);
 struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 					     struct pci_ops *ops, void *sysdata,
 					     struct list_head *resources);

And it's probably a good idea to kill off the ifdef around this:

struct hw_pci {
#ifdef CONFIG_PCI_MSI
        struct msi_controller *msi_ctrl;
#endif

so that we can avoid ifdefs in random places in arch/arm code (as is the
decision in the rest of PCI for this.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
