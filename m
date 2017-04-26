Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 26 Apr 2017 17:13:35 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC/RFT PATCH 07/18] ARM: PCI: orion5x: Convert PCI scan API to
 pci_scan_root_bus_bridge()
Message-ID: <20170426161335.GA12240@red-moon>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
 <20170426111809.19922-8-lorenzo.pieralisi@arm.com>
 <20170426151257.GA4489@lunn.ch>
MIME-Version: 1.0
In-Reply-To: <20170426151257.GA4489@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Wenrui Li <wenrui.li@rock-chips.com>,
 Russell King <linux@armlinux.org.uk>, Murali Karicheri <m-karicheri2@ti.com>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 26, 2017 at 05:12:57PM +0200, Andrew Lunn wrote:
> On Wed, Apr 26, 2017 at 12:17:58PM +0100, Lorenzo Pieralisi wrote:
> > The introduction of pci_scan_root_bus_bridge() provides a PCI core
> > API to scan a PCI root bus backed by an already initialized
> > struct pci_host_bridge object, which simplifies the bus scan
> > interface and makes the PCI scan root bus interface easier to
> > generalize as members are added to the struct pci_host_bridge().
> > 
> > Convert ARM orion5x platform code to pci_scan_root_bus_bridge() to
> > improve the PCI root bus scanning interface.
> 
> Hi Lorenzo
> 
> Maybe there is something not right here.
> 
> With plain 4.11-rc7 i get:
> 
> root@orion5x:~# lspci -v
> 0000:00:00.0 Memory controller: Marvell Technology Group Ltd. 88f5182 [Orion-NAS] ARM SoC (rev 02)
>         Subsystem: Marvell Technology Group Ltd. Device 11ab
>         Flags: bus master, fast devsel, latency 0, IRQ 12
>         Memory at <ignored> (64-bit, prefetchable)
>         Capabilities: [40] Power Management version 2
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [60] Express Root Port (Slot-), MSI 00
> 
> 0001:01:00.0 Memory controller: Marvell Technology Group Ltd. 88f5182 [Orion-NAS] ARM SoC (rev 02)
>         Flags: bus master, fast Back2Back, 66MHz, medium devsel, latency 0
>         BIST result: 00
>         Memory at <unassigned> (64-bit, prefetchable)
>         Memory at <ignored> (64-bit, prefetchable)
>         Memory at <ignored> (64-bit, non-prefetchable)
>         Expansion ROM at <ignored> [disabled]
>         Capabilities: [40] Power Management version 2
>         Capabilities: [48] Vital Product Data
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [60] PCI-X non-bridge device
>         Capabilities: [68] CompactPCI hot-swap <?>
> 
> However, with your patches applied i get:
> 
> 0000:00:00.0 Memory controller: Marvell Technology Group Ltd. 88f5182 [Orion-NAS] ARM SoC (rev 02)
>         Subsystem: Marvell Technology Group Ltd. Device 11ab
>         Flags: bus master, fast devsel, latency 0
>         Memory at <ignored> (64-bit, prefetchable)
>         Capabilities: [40] Power Management version 2
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [60] Express Root Port (Slot-), MSI 00
> 
> 0001:01:00.0 Memory controller: Marvell Technology Group Ltd. 88f5182 [Orion-NAS] ARM SoC (rev 02)
>         Flags: bus master, fast Back2Back, 66MHz, medium devsel, latency 0
>         BIST result: 00
>         Memory at <unassigned> (64-bit, prefetchable)
>         Memory at <ignored> (64-bit, prefetchable)
>         Memory at <ignored> (64-bit, non-prefetchable)
>         Expansion ROM at <ignored> [disabled]
>         Capabilities: [40] Power Management version 2
>         Capabilities: [48] Vital Product Data
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [60] PCI-X non-bridge device
>         Capabilities: [68] CompactPCI hot-swap <?>
> 
> Note that IRQ 12 has disappeared from Flags: on 0000:00:00.0.

Thank you for testing it, that's exactly what we need.

To check if the plumbing is working (ie to check I have not messed
up the bus scan API rework), mind testing the patch below please
and report back (it applies on top of this series) ?

Thanks !
Lorenzo

-- >8 --
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 4632fa4..afa7271 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -400,8 +400,6 @@ static int pci_device_probe(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = to_pci_driver(dev->driver);
 
-	pci_assign_irq(pci_dev);
-
 	error = pcibios_alloc_irq(pci_dev);
 	if (error < 0)
 		return error;
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index de259f3..dc9a1b6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1967,6 +1967,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	ret = pcibios_add_device(dev);
 	WARN_ON(ret < 0);
 
+	pci_assign_irq(dev);
+
 	/* Setup MSI irq domain */
 	pci_set_msi_domain(dev);
 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
