Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Marc Zyngier <marc.zyngier@arm.com>,
	Thierry Reding <treding@nvidia.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Simon Horman <horms@verge.net.au>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>,
	Jingoo Han <jg1.han@samsung.com>
Subject: RE: [PATCH] PCI: pcie-rcar: Fix OF node passed to MSI irq domain
Date: Thu, 12 Nov 2015 08:57:03 +0000
Message-ID: <PS1PR06MB11806B2B906CABB553B94442F5120@PS1PR06MB1180.apcprd06.prod.outlook.com>
References: <1446542899-25137-1-git-send-email-phil.edworthy@renesas.com>
	<PS1PR06MB11804ED428472FC1FD776F6EF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
	<20151109161115.GA13870@ulmo.nvidia.com>
	<PS1PR06MB1180111D6423287273B64B0FF5150@PS1PR06MB1180.apcprd06.prod.outlook.com>
	<20151110155232.GA25368@ulmo.nvidia.com> <20151111163802.3a96080c@arm.com>
In-Reply-To: <20151111163802.3a96080c@arm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc,

On 11 November 2015 16:38, Marc Zyngier wrote:
> On Tue, 10 Nov 2015 16:52:33 +0100
> Thierry Reding <treding@nvidia.com> wrote:
> 
> > On Mon, Nov 09, 2015 at 06:01:49PM +0000, Phil Edworthy wrote:
> > > Hi Thierry,
> > >
> > > On 09 November 2015 17:24, Phil wrote:
> > > > On 09 November 2015 16:11, Thierry wrote:
> > > > > On Mon, Nov 09, 2015 at 03:20:24PM +0000, Phil Edworthy wrote:
> > > > > > cc'ing others (Tegra, Altera, Designware) who may have the same bug
> > > > > >
> > > > > > On 03 November 2015 09:28, Phil Edworthy wrote:
> > > > > > > The OF node passed to irq_domain_add_linear() should be a
> > > > > > > pointer to interrupt controller's device tree node, or NULL,
> > > > > > > but not the PCI controller's node.
> > > > > > >
> > > > > > > This fixes an oops in msi_domain_alloc_irqs() when it tries
> > > > > > > to call msi_check().
> > > > > > >
> > > > > > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > > > > > ---
> > > > > > >  drivers/pci/host/pcie-rcar.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> > > > > > > index 2377bf0..c6fa562 100644
> > > > > > > --- a/drivers/pci/host/pcie-rcar.c
> > > > > > > +++ b/drivers/pci/host/pcie-rcar.c
> > > > > > > @@ -709,7 +709,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie
> > > > *pcie)
> > > > > > >  	msi->chip.setup_irq = rcar_msi_setup_irq;
> > > > > > >  	msi->chip.teardown_irq = rcar_msi_teardown_irq;
> > > > > > >
> > > > > > > -	msi->domain = irq_domain_add_linear(pcie->dev->of_node,
> > > > > > > INT_PCI_MSI_NR,
> > > > > > > +	msi->domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
> > > > > > >  					    &msi_domain_ops, &msi-
> >chip);
> > > > > > >  	if (!msi->domain) {
> > > > > > >  		dev_err(&pdev->dev, "failed to create IRQ domain\n");
> > > > >
> > > > > On Tegra the PCI controller is in fact the interrupt controller for
> > > > > MSIs. And looking at the code here it seems like the same would apply to
> > > > > RCAR.
> > > > Yes you are correct here.
> > > >
> > > > > I'm also slightly confused as to why this would cause ->msi_check() to
> > > > > fail. The default implementation (msi_domain_ops_check()) doesn't do
> > > > > anything.
> > > > >
> > > > > Also, how is passing in NULL instead of a valid struct device_node *
> > > > > going to prevent an oops? Perhaps this is one of those reference count
> > > > > imbalance bugs that have recently been showing up?
> > > > On arm64 (previously I didn't realise this just affects arm64, not arm),
> > > > the changes in commit f075915ac0b11 ("PCI/MSI: Drop domain field from
> > > > msi_controller") and d8a1cb757550 ("PCI/MSI: Let pci_msi_get_domain use
> > > > struct device::msi_domain") return an uninitialized msi domain that leads
> > > > to the oops. It appears that these changes assume that msi interrupt
> > > > controller is separate from the PCI controller.
> > > More accurately, when CONFIG_GENERIC_MSI_IRQ_DOMAIN is enabled,
> > > pci_msi_get_domain() calls dev_get_msi_domain() and at this point
> > > dev->msi_domain is uninitialized.
> >
> > Marc, any idea what's going on here?
> 
> Thanks for putting me in the loop.
> 
> No precise idea yet, but the proposed fix definitely looks like the
> wrong one. Actually, not passing a node identifier to any domain
> constructor is pretty much always a mistake when using DT.
> 
> Can someone post a stack trace for this issue so that I can have a
> look? I'm currently traveling, so expect a slightly delayed reply...

Unfortunately, not all the code for this arm64 board is upstream
yet, this code base is off 4.3-rc7.

systemd-udevd[1315]: undefined instruction: pc=ffffffc03106d41c
Code: ffffffc0 311f9740 ffffffc0 3106d138 (ffffffc0)
Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
Modules linked in: e1000e(+)
CPU: 0 PID: 1315 Comm: systemd-udevd Not tainted 4.3.0-rc7+ #4
Hardware name: Renesas Salvator-X board based on r8a7795 (DT)
task: ffffffc0307af080 ti: ffffffc030ecc000 task.ti: ffffffc030ecc000
PC is at 0xffffffc03106d41c
LR is at msi_domain_alloc_irqs+0x3c/0x1e0
pc : [<ffffffc03106d41c>] lr : [<ffffffc0000fa744>] pstate: 00000145
sp : ffffffc030ecf930
x29: ffffffc030ecf930 x28: 0000000000000124
x27: ffffffc0312628dc x26: ffffffc03193c890
x25: ffffffc0311fd000 x24: 00000000000001b4
x23: ffffffc0311fd160 x22: ffffffc03193a810
x21: ffffffc03193c800 x20: ffffffc0312628c0
x19: 0000000000000003 x18: 0000000000770000
x17: 0000007f96948570 x16: ffffffc0001dfa70
x15: 003b9aca00000000 x14: 63696d616e796420
x13: 6f74207465732029 x12: 0000000000000038
x11: ffffff8000668fff x10: 0140000000000000
x9 : 0000000000000000 x8 : ffffffc030d7f500
x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000
x3 : ffffffc03106d418 x2 : ffffffc03193c890
x1 : ffffffc0311fd160 x0 : ffffffc0311fd000

Process systemd-udevd (pid: 1315, stack limit = 0xffffffc030ecc020)
Stack: (0xffffffc030ecf930 to 0xffffffc030ed0000)
f920:                                   ffffffc030ecf9a0 ffffffc00036537c
f940: ffffffc03193c800 ffffffc0312628c0 ffffffc03193c800 ffffff8000668000
f960: ffffffc03193c890 0000000000000001 0000000000000003 ffffffc03193ca70
f980: ffffffc03193c890 0000000000000001 0000000000000002 ffffffc03193ca70
f9a0: ffffffc030ecf9d0 ffffffc000365990 0000000000000003 ffffffc000365960
f9c0: 0000000000000003 ffffffc0003658dc ffffffc030ecfa40 ffffffc000365a30
f9e0: 0000000000000003 ffffffc0312628c0 ffffffc03193c800 0000000000000003
fa00: ffffffc0304107c0 ffffffbffc020250 ffffffc030410000 0000000000020000
fa20: 0000000000000001 ffffffc03193c800 ffffffc03193c890 000000000004e5e0
fa40: ffffffc030ecfa70 ffffffbffc0192ec ffffffc0304107c0 ffffffc03193c800
fa60: ffffffc03193c890 ffffffbffc01e5e0 ffffffc030ecfa90 ffffffbffc01c9b8
fa80: ffffffc0304127c0 ffffffbffc01e5e0 ffffffc030ecfb10 ffffffc00035aaf0
faa0: ffffffc03193c890 ffffffbffc025f98 ffffffc03193c800 ffffffbffc025f30
fac0: ffffffbffc0206e8 ffffffbffc026090 ffffffc030ff3d00 ffffff800029d000
fae0: ffffffc0001173bc ffffffc00035aadc ffffffc03193c890 0000ffbffc025f98
fb00: ffffffc03193c800 ffffffbffc025f30 ffffffc030ecfb50 ffffffc0003d6030
fb20: ffffffc03193c890 ffffffc0009ca000 0000000000000000 ffffffbffc025f98
fb40: 0000000000000002 ffffffc0009ca000 ffffffc030ecfb90 ffffffc0003d61c0
fb60: ffffffc03193c890 ffffffbffc025f98 ffffffc03193c8f0 ffffffc00095bf08
fb80: ffffffc000968000 ffffffc0003d614c ffffffc030ecfbc0 ffffffc0003d4240
fba0: 0000000000000000 ffffffbffc025f98 ffffffc0003d6124 ffffffc030ecfc10
fbc0: ffffffc030ecfc00 ffffffc0003d5a9c ffffffbffc025f98 ffffffc030502cc0
fbe0: 0000000000000000 ffffffc000608b28 ffffffc0318e04a8 ffffffc0319d47e8
fc00: ffffffc030ecfc10 ffffffc0003d56d8 ffffffc030ecfc50 ffffffc0003d6a38
fc20: ffffffbffc025f98 ffffffc000934b20 ffffffc031262d00 ffffffbffc031000
fc40: 0000000000000000 0000000000000008 ffffffc030ecfc70 ffffffc00035995c
fc60: ffffffc000934b20 ffffffc000934b20 ffffffc030ecfc80 ffffffbffc031034
fc80: ffffffc030ecfc90 ffffffc0000828ec ffffffc030ecfd10 ffffffc00013ecc4
fca0: ffffffbffc026040 ffffffc000941000 ffffffbffc026040 ffffffc031262dc0
fcc0: 0000000000000001 ffffffc000941000 ffffffbffc026040 0000000000000001
fce0: 0000000000000001 ffffffbffc026090 ffffffc030ff3d00 ffffff800029d000
fd00: ffffffc0001173bc ffffffc030ff3d10 ffffffc030ecfd40 ffffffc00011a700
fd20: ffffffc030ecfe70 ffffffc030ff3d10 ffffffbffc026040 0000000000000001
fd40: ffffffc030ecfe40 ffffffc00011ac3c 0000000000000000 0000000000000009
fd60: 0000007f96809f40 0000007f96944c14 0000000080000000 0000000000000015
fd80: 000000000000011c 0000000000000111 ffffffc00061b000 ffffffc030ecc000
fda0: ffffffc000000076 0000006400000077 ffffffbf00000072 ffffff800000006e
fdc0: ffffffbf0000003f ffffffbffc031070 ffffffc0306125c0 ffffffc0306125c0
fde0: 000081a40000000f 0000000000000001 0000000000000000 00000000003c10e3
fe00: 00000000564449f9 0000000000000000 0000000000000000 0000000000000000
fe20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
fe40: 0000007fef721500 ffffffc000085cb0 0000000000000000 0000007f96809f40
fe60: ffffffffffffffff ffffffc030ecfed0 ffffff800029d000 00000000003c10e3
fe80: ffffff8000497b90 ffffff80004979d5 ffffff8000659d80 0000000000026370
fea0: 000000000002c418 0000000000000000 0000000000000000 0000002d0000002c
fec0: 0000000000000017 0000000000000012 0000000000000009 0000007f96809f40
fee0: 0000000000000000 0000000000000009 0000000000000000 60ceffffffffffff
ff00: ffffffffffffffff ffffffffffffffff 0000000000000111 fefefefefefeff42
ff20: 0101010101010101 0000000000000018 0000000000000000 ffffffffffff0000
ff40: 0000007f9688366c 0000000000000020 0000007f96944bf0 0000007f9681a768
ff60: 0000000000520000 000000559d66f190 0000007f96809f40 0000000000020000
ff80: 0000000000000000 0000007fef721ad8 0000000000000000 000000559d671360
ffa0: 0000000000000000 0000007fef721ac8 0000000000020000 0000007fef721500
ffc0: 0000007f96803c44 0000007fef721500 0000007f96944c14 0000000080000000
ffe0: 0000000000000009 0000000000000111 ffffffffffffffff ffffffffffffffff
Call trace:
[<ffffffc03106d41c>] 0xffffffc03106d41c
[<ffffffc000365378>] pci_msi_setup_msi_irqs+0x24/0x64
[<ffffffc00036598c>] pci_enable_msix+0x3cc/0x438
[<ffffffc000365a2c>] pci_enable_msix_range+0x34/0x80
[<ffffffbffc0192e8>] e1000e_set_interrupt_capability+0xd0/0x110 [e1000e]
[<ffffffbffc01c9b4>] e1000_probe+0x444/0xcb8 [e1000e]
[<ffffffc00035aaec>] pci_device_probe+0x94/0x10c
[<ffffffc0003d602c>] driver_probe_device+0x1e8/0x2e0
[<ffffffc0003d61bc>] __driver_attach+0x98/0xa0
[<ffffffc0003d423c>] bus_for_each_dev+0x54/0x98
[<ffffffc0003d5a98>] driver_attach+0x1c/0x28
[<ffffffc0003d56d4>] bus_add_driver+0x1c0/0x228
[<ffffffc0003d6a34>] driver_register+0x5c/0xf4
[<ffffffc000359958>] __pci_register_driver+0x40/0x4c
[<ffffffbffc031030>] e1000_init_module+0x30/0x70 [e1000e]
[<ffffffc0000828e8>] do_one_initcall+0x88/0x198
[<ffffffc00013ecc0>] do_init_module+0x58/0x1c4
[<ffffffc00011a6fc>] load_module+0x1954/0x1ce0
[<ffffffc00011ac38>] SyS_finit_module+0x78/0x88
[<ffffffc000085cac>] el0_svc_naked+0x20/0x28
Code: ffffffc0 311f9740 ffffffc0 3106d138 (ffffffc0)
---[ end trace 3249daca187c36b0 ]---

Thanks
Phil
