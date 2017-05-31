Return-Path: <SRS0=fCbu=5F=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=fCbu=5F=arm.com=lorenzo.pieralisi@kernel.org>
Date: Wed, 31 May 2017 11:20:40 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ray Jui <ray.jui@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Will Deacon <will.deacon@arm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
	Joao Pinto <Joao.Pinto@synopsys.com>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Russell King <linux@armlinux.org.uk>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mingkai Hu <mingkai.hu@freescale.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Minghuan Lian <minghuan.Lian@freescale.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Roy Zang <tie-fei.zang@freescale.com>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Jon Mason <jonmason@broadcom.com>
Subject: Re: [RFC/RFT PATCH 03/18] PCI: Introduce pci_scan_root_bus_bridge()
Message-ID: <20170531102040.GA14039@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-4-lorenzo.pieralisi@arm.com>
 <CAK8P3a0HmrrYBP5em1s4VOY4Tb6=bwOrDDN6K8rPp8OEXtpMtA@mail.gmail.com>
 <20170502171501.GA5545@red-moon>
 <20170525205643.GA9474@bhelgaas-glaptop.roam.corp.google.com>
 <20170526130748.GB27131@red-moon>
 <2a204641-a1da-977e-180a-0be130106891@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2a204641-a1da-977e-180a-0be130106891@broadcom.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 26, 2017 at 10:29:39AM -0700, Ray Jui wrote:
> 
> 
> On 5/26/17 6:07 AM, Lorenzo Pieralisi wrote:
> > On Thu, May 25, 2017 at 03:56:43PM -0500, Bjorn Helgaas wrote:
> >> [+cc Ray, Scott, Jon]
> >>
> >> On Tue, May 02, 2017 at 06:15:01PM +0100, Lorenzo Pieralisi wrote:
> >>> On Fri, Apr 28, 2017 at 02:28:38PM +0200, Arnd Bergmann wrote:
> >>>> On Wed, Apr 26, 2017 at 1:17 PM, Lorenzo Pieralisi
> >>>> <lorenzo.pieralisi@arm.com> wrote:
> >>>>> Current pci_scan_root_bus() interface is made up of two main
> >>>>> code paths:
> >>>>>
> >>>>> - pci_create_root_bus()
> >>>>> - pci_scan_child_bus()
> >>>>>
> >>>>> pci_create_root_bus() is a wrapper function that allows to create
> >>>>> a struct pci_host_bridge structure, initialize it with the passed
> >>>>> parameters and register it with the kernel.
> >>>>>
> >>>>> As the struct pci_host_bridge require additional struct members,
> >>>>> pci_create_root_bus() parameters list has grown in time, making
> >>>>> it unwieldy to add further parameters to it in case the struct
> >>>>> pci_host_bridge gains more members fields to augment its functionality.
> >>>>>
> >>>>> Since PCI core code provides functions to allocate struct
> >>>>> pci_host_bridge, instead of forcing the pci_create_root_bus() interface
> >>>>> to add new parameters to cater for new struct pci_host_bridge
> >>>>> functionality, it is more suitable to add an interface in PCI
> >>>>> core code to scan a PCI bus straight from a struct pci_host_bridge
> >>>>> created and customized by each specific PCI host controller driver.
> >>>>>
> >>>>> Add a pci_scan_root_bus_bridge() function to allow PCI host controller
> >>>>> drivers to create and initialize struct pci_host_bridge and scan
> >>>>> the resulting bus.
> >>>>>
> >>>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>>>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >>>>
> >>>> Good idea, yes. To avoid growing the number of interfaces too
> >>>> much, should we change the existing users of pci_register_host_bridge
> >>>> in host drivers over to this entry point, and make the other one
> >>>> local to probe.c then?
> >>>
> >>> Yes, the problem is that there are drivers (ie pcie-iproc.c) that
> >>> require the struct pci_bus (created by pci_register_host_bridge())
> >>> to fiddle with it to check link status and THEN scan the bus (so
> >>> the pci_register_host_bridge() call can't be embedded in the scan
> >>> interface - the driver requires struct pci_bus for pci_ops to work
> >>> before scanning the bus itself).
> >>
> >> I think code like iproc_pcie_check_link() that requires a struct
> >> pci_bus before we even scan the bus is lame.  I think the driver
> >> should be able to bring up the link before telling the PCI core about
> >> the bridge.  Aardvark uses a typical pattern:
> >>
> >>   advk_pcie_probe
> >>     advk_pcie_setup_hw
> >>       advk_pcie_wait_for_link
> >>     pci_scan_root_bus
> >>
> >> I would rather see iproc restructured along that line than add a
> >> callback.
> >>
> >> That would require replacing the pci_bus_read_config uses in
> >> iproc_pcie_check_link() with something different, maybe iproc-internal 
> >> accessors.  Slightly messy, but I think doable.
> > 
> > I agree with you, it probably requires some cfg space accessors copy
> > and paste though but that's doable. I can write the patch myself but
> > I can't test it so help is appreciated here.
> > 
> > Thanks,
> > Lorenzo
> > 
> 
> I agree with Bjorn on the new proposed sequence that link check should
> be done before the standard root bus scan starts.
> 
> Lorenzo, I'm getting quite busy and won't have time to re-write this in
> the near term. I appreciate that you offer to help to re-organize the
> code. Once you have a patch, I can help to test it on our platforms.

Patch here, please test (and update the patch accordingly, it should
not be that complicated) because I have got other things to do too
and I have no insights into this host controller HW so it is likely
I made some mistakes.

Thanks,
Lorenzo

-- >8 --
Subject: [PATCH] drivers: pci: host: iproc: convert link check to raw PCI
 config accessors

Current iproc driver host bridge controller driver requires struct
pci_bus to be created in order to carry out PCI link checks with standard
PCI config space accessors.

This struct pci_bus dependency is fictitious and burdens the driver
with unneeded constraints (eg to use separate APIs to create and scan
the root bus).

Add PCI raw config space accessors to PCIe iproc driver and remove the
fictitious struct pci_bus dependency.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/pci/host/pcie-iproc.c | 117 ++++++++++++++++++++++++++++++------------
 1 file changed, 83 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 0f39bd2..0cc52a7 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -452,14 +452,13 @@ static inline void iproc_pcie_apb_err_disable(struct pci_bus *bus,
  * Note access to the configuration registers are protected at the higher layer
  * by 'pci_lock' in drivers/pci/access.c
  */
-static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
+static void __iomem *iproc_pcie_map_cfg_bus(struct iproc_pcie *pcie,
+					    int busno,
 					    unsigned int devfn,
 					    int where)
 {
-	struct iproc_pcie *pcie = iproc_data(bus);
 	unsigned slot = PCI_SLOT(devfn);
 	unsigned fn = PCI_FUNC(devfn);
-	unsigned busno = bus->number;
 	u32 val;
 	u16 offset;
 
@@ -499,6 +498,58 @@ static void __iomem *iproc_pcie_map_cfg_bus(struct pci_bus *bus,
 		return (pcie->base + offset);
 }
 
+static void __iomem *iproc_pcie_bus_map_cfg_bus(struct pci_bus *bus,
+						unsigned int devfn,
+						int where)
+{
+	return iproc_pcie_map_cfg_bus(iproc_data(bus), bus->number, devfn,
+				      where);
+}
+
+static int iproc_pci_raw_config_read32(struct iproc_pcie *pcie,
+				       unsigned int devfn, int where,
+				       int size, u32 *val)
+{
+	void __iomem *addr;
+
+	addr = iproc_pcie_map_cfg_bus(pcie, 0, devfn, where & ~0x3);
+	if (!addr) {
+		*val = ~0;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	*val = readl(addr);
+
+	if (size <= 2)
+		*val = (*val >> (8 * (where & 3))) & ((1 << (size * 8)) - 1);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int iproc_pci_raw_config_write32(struct iproc_pcie *pcie,
+					unsigned int devfn, int where,
+					int size, u32 val)
+{
+	void __iomem *addr;
+	u32 mask, tmp;
+
+	addr = iproc_pcie_map_cfg_bus(pcie, 0, devfn, where & ~0x3);
+	if (!addr)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (size == 4) {
+		writel(val, addr);
+		return PCIBIOS_SUCCESSFUL;
+	}
+
+	mask = ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
+	tmp = readl(addr) & mask;
+	tmp |= val << ((where & 0x3) * 8);
+	writel(tmp, addr);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static int iproc_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 *val)
 {
@@ -524,7 +575,7 @@ static int iproc_pcie_config_write32(struct pci_bus *bus, unsigned int devfn,
 }
 
 static struct pci_ops iproc_pcie_ops = {
-	.map_bus = iproc_pcie_map_cfg_bus,
+	.map_bus = iproc_pcie_bus_map_cfg_bus,
 	.read = iproc_pcie_config_read32,
 	.write = iproc_pcie_config_write32,
 };
@@ -556,12 +607,11 @@ static void iproc_pcie_reset(struct iproc_pcie *pcie)
 	msleep(100);
 }
 
-static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
+static int iproc_pcie_check_link(struct iproc_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	u8 hdr_type;
-	u32 link_ctrl, class, val;
-	u16 pos = PCI_EXP_CAP, link_status;
+	u32 hdr_type, link_ctrl, link_status, class, val;
+	u16 pos = PCI_EXP_CAP;
 	bool link_is_active = false;
 
 	/*
@@ -578,7 +628,7 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
 	}
 
 	/* make sure we are not in EP mode */
-	pci_bus_read_config_byte(bus, 0, PCI_HEADER_TYPE, &hdr_type);
+	iproc_pci_raw_config_read32(pcie,  0, PCI_HEADER_TYPE, 1, &hdr_type);
 	if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE) {
 		dev_err(dev, "in EP mode, hdr=%#02x\n", hdr_type);
 		return -EFAULT;
@@ -588,13 +638,16 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
 #define PCI_BRIDGE_CTRL_REG_OFFSET 0x43c
 #define PCI_CLASS_BRIDGE_MASK      0xffff00
 #define PCI_CLASS_BRIDGE_SHIFT     8
-	pci_bus_read_config_dword(bus, 0, PCI_BRIDGE_CTRL_REG_OFFSET, &class);
+	iproc_pci_raw_config_read32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
+				    4, &class);
 	class &= ~PCI_CLASS_BRIDGE_MASK;
 	class |= (PCI_CLASS_BRIDGE_PCI << PCI_CLASS_BRIDGE_SHIFT);
-	pci_bus_write_config_dword(bus, 0, PCI_BRIDGE_CTRL_REG_OFFSET, class);
+	iproc_pci_raw_config_write32(pcie, 0, PCI_BRIDGE_CTRL_REG_OFFSET,
+				     4, class);
 
 	/* check link status to see if link is active */
-	pci_bus_read_config_word(bus, 0, pos + PCI_EXP_LNKSTA, &link_status);
+	iproc_pci_raw_config_read32(pcie, 0, pos + PCI_EXP_LNKSTA,
+				    2, &link_status);
 	if (link_status & PCI_EXP_LNKSTA_NLW)
 		link_is_active = true;
 
@@ -603,20 +656,21 @@ static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
 #define PCI_TARGET_LINK_SPEED_MASK    0xf
 #define PCI_TARGET_LINK_SPEED_GEN2    0x2
 #define PCI_TARGET_LINK_SPEED_GEN1    0x1
-		pci_bus_read_config_dword(bus, 0,
-					  pos + PCI_EXP_LNKCTL2,
+		iproc_pci_raw_config_read32(pcie, 0,
+					  pos + PCI_EXP_LNKCTL2, 4,
 					  &link_ctrl);
 		if ((link_ctrl & PCI_TARGET_LINK_SPEED_MASK) ==
 		    PCI_TARGET_LINK_SPEED_GEN2) {
 			link_ctrl &= ~PCI_TARGET_LINK_SPEED_MASK;
 			link_ctrl |= PCI_TARGET_LINK_SPEED_GEN1;
-			pci_bus_write_config_dword(bus, 0,
-					   pos + PCI_EXP_LNKCTL2,
-					   link_ctrl);
+			iproc_pci_raw_config_write32(pcie, 0,
+						pos + PCI_EXP_LNKCTL2,
+						4, link_ctrl);
 			msleep(100);
 
-			pci_bus_read_config_word(bus, 0, pos + PCI_EXP_LNKSTA,
-						 &link_status);
+			iproc_pci_raw_config_read32(pcie, 0,
+						pos + PCI_EXP_LNKSTA,
+						2, &link_status);
 			if (link_status & PCI_EXP_LNKSTA_NLW)
 				link_is_active = true;
 		}
@@ -1252,18 +1306,10 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	sysdata = pcie;
 #endif
 
-	bus = pci_create_root_bus(dev, 0, &iproc_pcie_ops, sysdata, res);
-	if (!bus) {
-		dev_err(dev, "unable to create PCI root bus\n");
-		ret = -ENOMEM;
-		goto err_power_off_phy;
-	}
-	pcie->root_bus = bus;
-
-	ret = iproc_pcie_check_link(pcie, bus);
+	ret = iproc_pcie_check_link(pcie);
 	if (ret) {
 		dev_err(dev, "no PCIe EP device detected\n");
-		goto err_rm_root_bus;
+		goto err_power_off_phy;
 	}
 
 	iproc_pcie_enable(pcie);
@@ -1272,7 +1318,14 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		if (iproc_pcie_msi_enable(pcie))
 			dev_info(dev, "not using iProc MSI\n");
 
-	pci_scan_child_bus(bus);
+	bus = pci_scan_root_bus(dev, 0, &iproc_pcie_ops, sysdata, res);
+	if (!bus) {
+		dev_err(dev, "unable to scan PCI root bus\n");
+		ret = -ENOMEM;
+		goto err_power_off_phy;
+	}
+	pcie->root_bus = bus;
+
 	pci_assign_unassigned_bus_resources(bus);
 
 	if (pcie->map_irq)
@@ -1285,10 +1338,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 
 	return 0;
 
-err_rm_root_bus:
-	pci_stop_root_bus(bus);
-	pci_remove_root_bus(bus);
-
 err_power_off_phy:
 	phy_power_off(pcie->phy);
 err_exit_phy:
-- 
2.10.0
