Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:35393 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbdGFOWZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jul 2017 10:22:25 -0400
Subject: Re: [PATCH v2 9/9] pci: remove limitation of the number of the
 available IRQs
To: Joao Pinto <Joao.Pinto@synopsys.com>, <bhelgaas@google.com>,
        <marc.zyngier@arm.com>
CC: <m-karicheri2@ti.com>, <thomas.petazzoni@free-electrons.com>,
        <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
        <tie-fei.zang@freescale.com>, <hongxing.zhu@nxp.com>,
        <l.stach@pengutronix.de>, <jespern@axis.com>,
        <wangzhou1@hisilicon.com>, <gabriele.paoloni@huawei.com>,
        <svarbanov@mm-sol.com>, <linux-pci@vger.kernel.org>
References: <cover.1496677911.git.jpinto@synopsys.com>
 <3839dbf866a10034298b758f63fe019873b829bc.1496677911.git.jpinto@synopsys.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <255c8d6f-603f-645f-c467-694352bd2dcf@axis.com>
Date: Thu, 6 Jul 2017 16:22:18 +0200
MIME-Version: 1.0
In-Reply-To: <3839dbf866a10034298b758f63fe019873b829bc.1496677911.git.jpinto@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/05/2017 06:19 PM, Joao Pinto wrote:
> The Synopsys PCIe Controller supports up to 256 IRQs distributed
> by 8 controller registers.
> 
> Having this in mind, the number of the maximum number of
> IRQs was changed to 256 and now the number of controllers is
> calculated based on the number of vectors used by the specific
> SoC driver.
> 
> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
> ---
> Change v1->v2:
> - New patch
> 
>  drivers/pci/dwc/pcie-designware-host.c | 12 ++++++++----
>  drivers/pci/dwc/pcie-designware.h      | 10 +++-------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
> index 6c771cc..31c7ccd 100644
> --- a/drivers/pci/dwc/pcie-designware-host.c
> +++ b/drivers/pci/dwc/pcie-designware-host.c
> @@ -73,11 +73,13 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
>  /* MSI int handler */
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  {
> -	u32 val;
>  	int i, pos, irq;
> +	u32 val, num_ctrls;
>  	irqreturn_t ret = IRQ_NONE;
>  
> -	for (i = 0; i < MAX_MSI_CTRLS; i++) {
> +	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +
> +	for (i = 0; i < num_ctrls; i++) {
>  		dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS + i * 12, 4,
>  				    &val);

Hello Joao


Nice to see that we now have support for all 8 controllers,
good job!

Older versions of the DesignWare IP only had support for a
combined msi irq (msi_ctrl_int), but since recent versions
of the IP also supports a dedicated irq line per controller
(msi_ctrl_int_vec[7:0]), do you	think that it makes sense
to take this into consideration for this patchset?

By doing so, dw_handle_msi_irq would not have to iterate
over all 8 controllers, as the irq itself would tell us
what controller to read the status from (to finally see
which irq(s) that actually triggered).


Regards,
Niklas
