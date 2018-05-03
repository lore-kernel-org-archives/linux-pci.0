Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 3 May 2018 17:31:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gilles Buloz <Gilles.Buloz@kontron.com>
Subject: [PATCH] PCI: Check whether bridges allow access to extended config
 space
Message-ID: <20180503223127.GB15790@bhelgaas-glaptop.roam.corp.google.com>
References: <20180427165627.GA8199@bhelgaas-glaptop.roam.corp.google.com>
 <5AE6D7E2.9030506@kontron.com> <5AE71BF4.2010200@kontron.com>
 <20180430170447.GA95643@bhelgaas-glaptop.roam.corp.google.com>
 <5AE75809.30701@kontron.com> <5AE9B5BB.2080003@kontron.com>
 <20180502132501.GE11698@bhelgaas-glaptop.roam.corp.google.com>
 <5AE9C1AB.8020403@kontron.com>
 <20180502172341.GA123831@bhelgaas-glaptop.roam.corp.google.com>
 <5AEB033A.4060407@kontron.com>
MIME-Version: 1.0
In-Reply-To: <5AEB033A.4060407@kontron.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 linux-pci <linux-pci@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Minghuan.Lian@nxp.com" <Minghuan.Lian@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc LKML]

On Thu, May 03, 2018 at 12:40:27PM +0000, Gilles Buloz wrote:
> Subject:    [PATCH] For exception at PCI probe due to bridge reporting UR
> 
> Even if a device supports extended config access, no such access must be
> done to this device If there's a bridge not supporting that in the path
> to this device. Doing such access with UR reporting enabled on the root
> bridge leads to an exception.
> 
> This is the case on a LS1043A CPU (NXP QorIQ Layerscape) platform with
> the following bus topology :
>   LS1043 PCIe root
>     -> PEX8112 PCIe-to-PCI bridge (not supporting ext cfg on PCI side)
>       -> PMC slot connector (for legacy PMC modules)
> With a PMC module topology as follows :
>   PMC connector
>     -> PCI-to-PCIe bridge
>       -> PCIe switch (4 ports)
>         -> 4 PCIe devices (one on each port)
> In this case all devices behind the PEX8112 are supporting extended config
> access but this is prohibited by the PEX8112. Without this patch, an
> exception (synchronous abort) occurs in pci_cfg_space_size_ext().
> 
> This patch checks the parent bridge of each allocated child bus to know if
> extended config access is supported on the child bus, and sets a flag in
> child->bus_flags if not supported. This  flag is inherited by all children
> buses of this child bus and then is checked to avoid this unsupported
> accesses to every device on these buses.

Hi Gilles,

Thanks for the patch!  I reworked it a little bit to simplify the code
in pci_alloc_child_bus().  Can you test it and make sure I didn't
break anything?


commit cbaaa85b558a8f974e301fa0364d568efaf491ce
Author: Gilles Buloz <Gilles.Buloz@kontron.com>
Date:   Thu May 3 15:21:44 2018 -0500

    PCI: Check whether bridges allow access to extended config space
    
    Even if a device supports extended config space, i.e., it is a PCI-X Mode 2
    or a PCI Express device, the extended space may not be accessible if
    there's a conventional PCI bus in the path to it.
    
    We currently figure that out in pci_cfg_space_size() by reading the first
    dword of extended config space.  On most platforms that returns ~0 data if
    the space is inaccessible, but it may set error bits in PCI status
    registers, and on some platforms it causes exceptions that we currently
    don't recover from.
    
    For example, a PCIe-to-conventional PCI bridge treats config transactions
    with a non-zero Extended Register Address as an Unsupported Request on PCIe
    and a received Master-Abort on the destination bus (see PCI Express to
    PCI/PCI-X Bridge spec, r1.0, sec 4.1.3).
    
    A sample case is a LS1043A CPU (NXP QorIQ Layerscape) platform with the
    following bus topology:
    
      LS1043 PCIe Root Port
        -> PEX8112 PCIe-to-PCI bridge (doesn't support ext cfg on PCI side)
          -> PMC slot connector (for legacy PMC modules)
    
    With a PMC module topology as follows:
    
      PMC connector
        -> PCI-to-PCIe bridge
          -> PCIe switch (4 ports)
            -> 4 PCIe devices (one on each port)
    
    The PCIe devices on the PMC module support extended config space, but we
    can't reach it because the PEX8112 can't generate accesses to the extended
    space on its secondary bus.  Attempts to access it cause Unsupported
    Request errors, which result in synchronous aborts on this platform.
    
    To avoid these errors, check whether bridges are capable of generating
    extended config space addresses on their secondary interfaces.  If they
    can't, we restrict devices below the bridge to only the 256-byte
    PCI-compatible config space.
    
    Signed-off-by: Gilles Buloz <gilles.buloz@kontron.com>
    [bhelgaas: changelog, rework patch so bus_flags testing is all in
    pci_bridge_child_ext_cfg_accessible()]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac91b6fd0bcd..7b1b7b2e01e4 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -882,6 +882,45 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	return err;
 }
 
+static bool pci_bridge_child_ext_cfg_accessible(struct pci_dev *bridge)
+{
+	int pos;
+	u32 status;
+
+	/*
+	 * If extended config space isn't accessible on a bridge's primary
+	 * bus, we certainly can't access it on the secondary bus.
+	 */
+	if (bridge->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
+		return false;
+
+	/*
+	 * PCIe Root Ports and switch ports are PCIe on both sides, so if
+	 * extended config space is accessible on the primary, it's also
+	 * accessible on the secondary.
+	 */
+	if (pci_is_pcie(bridge) &&
+	    (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT ||
+	     pci_pcie_type(bridge) == PCI_EXP_TYPE_UPSTREAM ||
+	     pci_pcie_type(bridge) == PCI_EXP_TYPE_DOWNSTREAM))
+		return true;
+
+	/*
+	 * For the other bridge types:
+	 *   - PCI-to-PCI bridges
+	 *   - PCIe-to-PCI/PCI-X forward bridges
+	 *   - PCI/PCI-X-to-PCIe reverse bridges
+	 * extended config space on the secondary side is only accessible
+	 * if the bridge supports PCI-X Mode 2.
+	 */
+	pos = pci_find_capability(bridge, PCI_CAP_ID_PCIX);
+	if (!pos)
+		return false;
+
+	pci_read_config_dword(bridge, pos + PCI_X_STATUS, &status);
+	return status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ);
+}
+
 static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 					   struct pci_dev *bridge, int busnr)
 {
@@ -923,6 +962,16 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	pci_set_bus_of_node(child);
 	pci_set_bus_speed(child);
 
+	/*
+	 * Check whether extended config space is accessible on the child
+	 * bus.  Note that we currently assume it is always accessible on
+	 * the root bus.
+	 */
+	if (!pci_bridge_child_ext_cfg_accessible(bridge)) {
+		child->bus_flags |= PCI_BUS_FLAGS_NO_EXTCFG;
+		pci_info(child, "extended config space not accessible on secondary bus\n");
+	}
+
 	/* Set up default resource pointers and names */
 	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
 		child->resource[i] = &bridge->resource[PCI_BRIDGE_RESOURCES+i];
@@ -1393,6 +1442,9 @@ int pci_cfg_space_size(struct pci_dev *dev)
 	u32 status;
 	u16 class;
 
+	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
+		return PCI_CFG_SPACE_SIZE;
+
 	class = dev->class >> 8;
 	if (class == PCI_CLASS_BRIDGE_HOST)
 		return pci_cfg_space_size_ext(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 230615620a4a..f7aa6d9f8999 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -217,6 +217,7 @@ enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MSI	= (__force pci_bus_flags_t) 1,
 	PCI_BUS_FLAGS_NO_MMRBC	= (__force pci_bus_flags_t) 2,
 	PCI_BUS_FLAGS_NO_AERSID	= (__force pci_bus_flags_t) 4,
+	PCI_BUS_FLAGS_NO_EXTCFG	= (__force pci_bus_flags_t) 8,
 };
 
 /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
