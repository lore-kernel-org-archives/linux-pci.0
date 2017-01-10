Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 10 Jan 2017 17:06:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: jingoohan1@gmail.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: designware: fix asynchronous external abort in
 keystone PCIe h/w
Message-ID: <20170110230629.GA4468@bhelgaas-glaptop.roam.corp.google.com>
References: <1483558350-8169-1-git-send-email-m-karicheri2@ti.com>
 <20170110151254.GA29965@bhelgaas-glaptop.roam.corp.google.com>
 <58751765.8090908@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <58751765.8090908@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 10, 2017 at 12:18:29PM -0500, Murali Karicheri wrote:
> On 01/10/2017 10:12 AM, Bjorn Helgaas wrote:
> > Hi Murali,
> > 
> > On Wed, Jan 04, 2017 at 02:32:30PM -0500, Murali Karicheri wrote:
> >> Recent fixes for iATU unroll support introduced a bug that causes
> >> asynchronous external abort in Keystone PCIe h/w which doesn't have
> >> ATU port and the corresponding register. So the check should be moved
> >> below where dw_pcie_prog_outbound_atu() is called to avoid that
> >> being called on keystine PCIe h/w.
> >>
> >> Here is the backtrace
> >>
> >> [    0.771174] OF: PCI:   MEM 0x60000000..0x6fffffff -> 0x60000000
> >> [    0.778118] Unhandled fault: asynchronous external abort (0x1211) at 0x00000000
> >> [    0.785548] pgd = c0003000
> >> [    0.788347] [00000000] *pgd=80000800004003, *pmd=00000000
> >> [    0.793864] Internal error: : 1211 [#1] PREEMPT SMP ARM
> >> [    0.799197] Modules linked in:
> >> [    0.802351] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.0-00009-g6ff59d2-dirty #7
> >> [    0.810130] Hardware name: Keystone
> >> [    0.813717] task: eb878000 task.stack: eb866000
> >> [    0.818356] PC is at dw_pcie_setup_rc+0x24/0x380
> >> [    0.823083] LR is at ks_pcie_host_init+0x10/0x170
> >>
> >> Fixes: 416379f9ebde ("PCI: designware: Check for iATU unroll support after initializing host")
> > 
> > I tentatively applied this to for-linus for v4.10, with a stable tag
> > for v4.9+.
> > 
> 
> Ok  Thanks!
> 
> > The patch itself mostly makes sense in terms of the code: we only use
> > iatu_unroll_enabled in dw_pcie_prog_outbound_atu().  We only call that
> > when "!pp->ops->rd_other_conf" or "!pp->ops->wr_other_conf".
> > 
> > So it makes sense that we only need to initialize iatu_unroll_enabled
> > in those cases.  But the current patch only initializes it if
> > "!pp->ops->rd_other_conf".
> > 
> 
> I think the code before also should have checked for both 
> if ((!pp->ops->rd_other_conf) && (!pp->ops->wr_other_conf))
> 
> The assumption was if rd_other_conf is Null, the platform provides 
> both rd_other_conf and wr_other_conf. I see I have added this API 
> to support Keystone and the above assumption is true so far. 
> It make sense to fix it if you agree.
> 
> > If we had "pp->ops->rd_other_conf && !pp->ops->wr_other_conf", we
> > would use iatu_unroll_enabled uninitialized in the
> > dw_pcie_wr_other_conf() path.  I suppose that's an invalid
> 
> Yes. So we need to fix the above to make the code correct instead
> of leaving it exposed.
> 
> > configuration, but it'd be better if we didn't have to rely on the
> > host drivers to avoid that configuration.
> 
> You mean to introduce the check in the designware core code above 
> right?

We *could* make the code look like:

  if (!pp->ops->rd_other_conf || !pp->ops->rd_other_conf)
    pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);

but that seems a little clunky and the connection between ATU and the
->*_other_conf() pointers is slightly obscure.  I guess it just ends
up being more detailed than I personally really want to worry about,
so I'm fine with leaving it as-is for now.

> > It's not obvious how this is connected to 416379f9ebde, though.  It
> > *looks* like we call dw_pcie_iatu_unroll_enabled() on Keystone both
> > before and after that commit, so it seems like the external abort
> > should have happened even before it.
> > 
> 
> You are right. The problem was introduced by 
> 
> commit a0601a47053714eecec726aea5ebcd829f817497
> Author: Joao Pinto <Joao.Pinto@synopsys.com>
> Date:   Wed Aug 10 11:02:39 2016 +0100
> 
>     PCI: designware: Add iATU Unroll feature
> 
> which is fixed by commit 416379f9ebde and is again fixed by my 
> commit. So probably I should have added both commits in
> my description. 

I added that.  The reason I wanted the correct "Fixes" information is
to figure out which stable kernels need this fix.  In this case, both:

  a0601a470537 ("PCI: designware: Add iATU Unroll feature") and
  416379f9ebde ("PCI: designware: Check for iATU unroll support after
    initializing host")

appeared in v4.9, so it doesn't change anything as far as the stable
tag is concerned.

The below is what I have on my for-linus branch:

commit 6fdb996a55684016de1ce639b9316b7092fde95f
Author: Murali Karicheri <m-karicheri2@ti.com>
Date:   Wed Jan 4 14:32:30 2017 -0500

    PCI: designware: Check for iATU unroll only on platforms that use ATU
    
    Previously we checked for iATU unroll support by reading PCIE_ATU_VIEWPORT
    even on platforms, e.g., Keystone, that do not have ATU ports.  This can
    cause bad behavior such as asynchronous external aborts:
    
      OF: PCI:   MEM 0x60000000..0x6fffffff -> 0x60000000
      Unhandled fault: asynchronous external abort (0x1211) at 0x00000000
      pgd = c0003000
      [00000000] *pgd=80000800004003, *pmd=00000000
      Internal error: : 1211 [#1] PREEMPT SMP ARM
      Modules linked in:
      CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.0-00009-g6ff59d2-dirty #7
      Hardware name: Keystone
      task: eb878000 task.stack: eb866000
      PC is at dw_pcie_setup_rc+0x24/0x380
      LR is at ks_pcie_host_init+0x10/0x170
    
    Move the dw_pcie_iatu_unroll_enabled() check so we only call it on
    platforms that do not use the ATU.  These platforms supply their own
    ->rd_other_conf() and ->wr_other_conf() methods.
    
    [bhelgaas: changelog]
    Fixes: a0601a470537 ("PCI: designware: Add iATU Unroll feature")
    Fixes: 416379f9ebde ("PCI: designware: Check for iATU unroll support after initializing host")
    Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
    Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    CC: stable@vger.kernel.org      # v4.9+

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index bed19994c1e9..af8f6e92e885 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -807,11 +807,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 {
 	u32 val;
 
-	/* get iATU unroll support */
-	pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
-	dev_dbg(pp->dev, "iATU unroll: %s\n",
-		pp->iatu_unroll_enabled ? "enabled" : "disabled");
-
 	/* set the number of lanes */
 	val = dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL);
 	val &= ~PORT_LINK_MODE_MASK;
@@ -882,6 +877,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	 * we should not program the ATU here.
 	 */
 	if (!pp->ops->rd_other_conf) {
+		/* get iATU unroll support */
+		pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
+		dev_dbg(pp->dev, "iATU unroll: %s\n",
+			pp->iatu_unroll_enabled ? "enabled" : "disabled");
+
 		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
 					  PCIE_ATU_TYPE_MEM, pp->mem_base,
 					  pp->mem_bus_addr, pp->mem_size);
