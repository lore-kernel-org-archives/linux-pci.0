Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761358AbdAJPM7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Jan 2017 10:12:59 -0500
Date: Tue, 10 Jan 2017 09:12:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: jingoohan1@gmail.com, Joao.Pinto@synopsys.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: designware: fix asynchronous external abort in
 keystone PCIe h/w
Message-ID: <20170110151254.GA29965@bhelgaas-glaptop.roam.corp.google.com>
References: <1483558350-8169-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483558350-8169-1-git-send-email-m-karicheri2@ti.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Murali,

On Wed, Jan 04, 2017 at 02:32:30PM -0500, Murali Karicheri wrote:
> Recent fixes for iATU unroll support introduced a bug that causes
> asynchronous external abort in Keystone PCIe h/w which doesn't have
> ATU port and the corresponding register. So the check should be moved
> below where dw_pcie_prog_outbound_atu() is called to avoid that
> being called on keystine PCIe h/w.
> 
> Here is the backtrace
> 
> [    0.771174] OF: PCI:   MEM 0x60000000..0x6fffffff -> 0x60000000
> [    0.778118] Unhandled fault: asynchronous external abort (0x1211) at 0x00000000
> [    0.785548] pgd = c0003000
> [    0.788347] [00000000] *pgd=80000800004003, *pmd=00000000
> [    0.793864] Internal error: : 1211 [#1] PREEMPT SMP ARM
> [    0.799197] Modules linked in:
> [    0.802351] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.0-00009-g6ff59d2-dirty #7
> [    0.810130] Hardware name: Keystone
> [    0.813717] task: eb878000 task.stack: eb866000
> [    0.818356] PC is at dw_pcie_setup_rc+0x24/0x380
> [    0.823083] LR is at ks_pcie_host_init+0x10/0x170
> 
> Fixes: 416379f9ebde ("PCI: designware: Check for iATU unroll support after initializing host")

I tentatively applied this to for-linus for v4.10, with a stable tag
for v4.9+.

The patch itself mostly makes sense in terms of the code: we only use
iatu_unroll_enabled in dw_pcie_prog_outbound_atu().  We only call that
when "!pp->ops->rd_other_conf" or "!pp->ops->wr_other_conf".

So it makes sense that we only need to initialize iatu_unroll_enabled
in those cases.  But the current patch only initializes it if
"!pp->ops->rd_other_conf".

If we had "pp->ops->rd_other_conf && !pp->ops->wr_other_conf", we
would use iatu_unroll_enabled uninitialized in the
dw_pcie_wr_other_conf() path.  I suppose that's an invalid
configuration, but it'd be better if we didn't have to rely on the
host drivers to avoid that configuration.

It's not obvious how this is connected to 416379f9ebde, though.  It
*looks* like we call dw_pcie_iatu_unroll_enabled() on Keystone both
before and after that commit, so it seems like the external abort
should have happened even before it.

> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Tested-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  - Applies to pci/master
>  - Bug was introduced in v4.9
>  - Tested on K2E EVM with SATA and DRA7-EVM with an intel PCI ethernet card
> 
>  drivers/pci/host/pcie-designware.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index bed1999..af8f6e9 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -807,11 +807,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>  	u32 val;
>  
> -	/* get iATU unroll support */
> -	pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> -	dev_dbg(pp->dev, "iATU unroll: %s\n",
> -		pp->iatu_unroll_enabled ? "enabled" : "disabled");
> -
>  	/* set the number of lanes */
>  	val = dw_pcie_readl_rc(pp, PCIE_PORT_LINK_CONTROL);
>  	val &= ~PORT_LINK_MODE_MASK;
> @@ -882,6 +877,11 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	 * we should not program the ATU here.
>  	 */
>  	if (!pp->ops->rd_other_conf) {
> +		/* get iATU unroll support */
> +		pp->iatu_unroll_enabled = dw_pcie_iatu_unroll_enabled(pp);
> +		dev_dbg(pp->dev, "iATU unroll: %s\n",
> +			pp->iatu_unroll_enabled ? "enabled" : "disabled");
> +
>  		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX0,
>  					  PCIE_ATU_TYPE_MEM, pp->mem_base,
>  					  pp->mem_bus_addr, pp->mem_size);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
