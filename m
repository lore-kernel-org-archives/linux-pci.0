Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sun, 2 Jul 2017 16:12:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/4] ARM/PCI: mv78xx0: pass pci_ops correctly again
Message-ID: <20170702211214.GC18324@bhelgaas-glaptop.roam.corp.google.com>
References: <20170621215323.3921382-1-arnd@arndb.de>
 <20170621215323.3921382-2-arnd@arndb.de>
 <20170622093855.GA23310@red-moon>
 <20170627231143.GI17844@bhelgaas-glaptop.roam.corp.google.com>
 <20170701135457.GB8977@red-moon>
MIME-Version: 1.0
In-Reply-To: <20170701135457.GB8977@red-moon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 01, 2017 at 02:54:57PM +0100, Lorenzo Pieralisi wrote:
> Hi Bjorn,
> 
> On Tue, Jun 27, 2017 at 06:11:43PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 22, 2017 at 10:38:55AM +0100, Lorenzo Pieralisi wrote:
> > > On Wed, Jun 21, 2017 at 11:53:00PM +0200, Arnd Bergmann wrote:
> > > > We used to pass the operations when calling pci_scan_root_bus, but
> > > > that argument was removed:
> > > > 
> > > > arch/arm/mach-mv78xx0/pcie.c:175:23: error: 'pcie_ops' defined but not used [-Werror=unused-variable]
> > > > 
> > > > Setting it in pci_hw should address this.
> > > 
> > > No unfortunately it does not. The way I structured the code the
> > > bridge set-up is carried out in the struct hw_pci.scan() callback and
> > > for mv78xx0 it was not done properly.
> > > 
> > > As said in the other thread we need a pci_fixup_irqs() removal v3 to
> > > address these issues, given that on some host bridges v2 it is still
> > > untested.
> > > 
> > > Lorenzo
> > > 
> > > > Fixes: ace27646da8e ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  arch/arm/mach-mv78xx0/pcie.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
> > > > index 2b406e909a43..cb7f95c9d8eb 100644
> > > > --- a/arch/arm/mach-mv78xx0/pcie.c
> > > > +++ b/arch/arm/mach-mv78xx0/pcie.c
> > > > @@ -214,6 +214,7 @@ static int __init mv78xx0_pcie_map_irq(const struct pci_dev *dev, u8 slot,
> > > >  }
> > > >  
> > > >  static struct hw_pci mv78xx0_pci __initdata = {
> > > > +	.ops		= &pcie_ops,
> > > >  	.nr_controllers	= 8,
> > > >  	.preinit	= mv78xx0_pcie_preinit,
> > > >  	.setup		= mv78xx0_pcie_setup,
> > 
> > I provisionally made the following change for mv78xx0, based on similar
> > hunks for dove, iop13xx, and orion5x.
> > 
> > This is on my pci/enumeration branch:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/enumeration&id=31ddd0eab68e19cf3dfc14321c99ff0b95cda4ad
> > 
> > Please take a look and see if it makes sense.
> 
> It makes code compile but it is missing some initializations.
> 
> Patch below, to be folded in commit
> 
> e592c4a52cb8 ("ARM/PCI: Convert PCI scan API to pci_scan_root_bus_bridge()")
> 
> in your pci/irq-fixups branch, I did that and recompiled (I can't test
> this code) and everything seems fine.

Folded into pci/irq-fixups, thanks!

> -- >8 --
> diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
> index f793ebb..636d84b 100644
> --- a/arch/arm/mach-mv78xx0/pcie.c
> +++ b/arch/arm/mach-mv78xx0/pcie.c
> @@ -196,12 +196,19 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL, PCI_ANY_ID, rc_pci_fixup);
>  
>  static int __init mv78xx0_pcie_scan_bus(int nr, struct pci_host_bridge *bridge)
>  {
> +	struct pci_sys_data *sys = pci_host_bridge_priv(bridge);
> +
>  	if (nr >= num_pcie_ports) {
>  		BUG();
>  		return -EINVAL;
>  	}
>  
> +	list_splice_init(&sys->resources, &bridge->windows);
> +	bridge->dev.parent = NULL;
> +	bridge->sysdata = sys;
> +	bridge->busnr = sys->busnr;
>  	bridge->ops = &pcie_ops;
> +
>  	return pci_scan_root_bus_bridge(bridge);
>  }
>  
> -- 
> 2.10.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
