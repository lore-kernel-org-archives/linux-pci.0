Return-Path: <SRS0=wV8o=6E=arm.com=lorenzo.pieralisi@kernel.org>
Return-Path: <SRS0=wV8o=6E=arm.com=lorenzo.pieralisi@kernel.org>
Date: Sat, 1 Jul 2017 14:54:57 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/4] ARM/PCI: mv78xx0: pass pci_ops correctly again
Message-ID: <20170701135457.GB8977@red-moon>
References: <20170621215323.3921382-1-arnd@arndb.de>
 <20170621215323.3921382-2-arnd@arndb.de>
 <20170622093855.GA23310@red-moon>
 <20170627231143.GI17844@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170627231143.GI17844@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Jun 27, 2017 at 06:11:43PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 22, 2017 at 10:38:55AM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Jun 21, 2017 at 11:53:00PM +0200, Arnd Bergmann wrote:
> > > We used to pass the operations when calling pci_scan_root_bus, but
> > > that argument was removed:
> > > 
> > > arch/arm/mach-mv78xx0/pcie.c:175:23: error: 'pcie_ops' defined but not used [-Werror=unused-variable]
> > > 
> > > Setting it in pci_hw should address this.
> > 
> > No unfortunately it does not. The way I structured the code the
> > bridge set-up is carried out in the struct hw_pci.scan() callback and
> > for mv78xx0 it was not done properly.
> > 
> > As said in the other thread we need a pci_fixup_irqs() removal v3 to
> > address these issues, given that on some host bridges v2 it is still
> > untested.
> > 
> > Lorenzo
> > 
> > > Fixes: ace27646da8e ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  arch/arm/mach-mv78xx0/pcie.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
> > > index 2b406e909a43..cb7f95c9d8eb 100644
> > > --- a/arch/arm/mach-mv78xx0/pcie.c
> > > +++ b/arch/arm/mach-mv78xx0/pcie.c
> > > @@ -214,6 +214,7 @@ static int __init mv78xx0_pcie_map_irq(const struct pci_dev *dev, u8 slot,
> > >  }
> > >  
> > >  static struct hw_pci mv78xx0_pci __initdata = {
> > > +	.ops		= &pcie_ops,
> > >  	.nr_controllers	= 8,
> > >  	.preinit	= mv78xx0_pcie_preinit,
> > >  	.setup		= mv78xx0_pcie_setup,
> 
> I provisionally made the following change for mv78xx0, based on similar
> hunks for dove, iop13xx, and orion5x.
> 
> This is on my pci/enumeration branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/enumeration&id=31ddd0eab68e19cf3dfc14321c99ff0b95cda4ad
> 
> Please take a look and see if it makes sense.

It makes code compile but it is missing some initializations.

Patch below, to be folded in commit

e592c4a52cb8 ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")

in your pci/irq-fixups branch, I did that and recompiled (I can't test
this code) and everything seems fine.

Thanks a lot !

Lorenzo

-- >8 --
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index f793ebb..636d84b 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -196,12 +196,19 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup);
 
 static int __init mv78xx0_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
 {
+	struct pci_sys_data *sys = pci_host_bridge_priv(bridge);
+
 	if (nr >= num_pcie_ports) {
 		BUG();
 		return -EINVAL;
 	}
 
+	list_splice_init(&sys->resources, &bridge->windows);
+	bridge->dev.parent = NULL;
+	bridge->sysdata = sys;
+	bridge->busnr = sys->busnr;
 	bridge->ops = &pcie_ops;
+
 	return pci_scan_root_bus_bridge(bridge);
 }
 
-- 
2.10.0
