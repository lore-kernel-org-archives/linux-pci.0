Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44223 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbeHCJjT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Aug 2018 05:39:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16-v6so4460507wrt.11
        for <linux-pci@vger.kernel.org>; Fri, 03 Aug 2018 00:44:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180730134316.11719-2-lorenzo.pieralisi@arm.com>
References: <20180730134316.11719-1-lorenzo.pieralisi@arm.com> <20180730134316.11719-2-lorenzo.pieralisi@arm.com>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 3 Aug 2018 13:14:15 +0530
Message-ID: <CAFZiPx35TzZzR93CqN1tgHAm44gBvWeJ1ArtOr3jWP=xVEX6Aw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: mobiveil: Fix struct mobiveil_pcie.pcie_reg_base
 address type
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Lorenzo,
Acked By: Subrahmanya Lingappa

Thanks,
Subrahmanya

On Mon, Jul 30, 2018 at 7:13 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> The field pcie_reg_base in struct mobiveil_pcie represents a physical
> address so it should be of phys_addr_t type rather than void __iomem*;
> this results in the following compilation  warnings:
>
> drivers/pci/controller/pcie-mobiveil.c: In function
> 'mobiveil_pcie_parse_dt':
> drivers/pci/controller/pcie-mobiveil.c:326:22: warning: assignment makes
> pointer from integer without a cast [-Wint-conversion]
>   pcie->pcie_reg_base = res->start;
>                       ^
> drivers/pci/controller/pcie-mobiveil.c: In function
> 'mobiveil_pcie_enable_msi':
> drivers/pci/controller/pcie-mobiveil.c:485:25: warning: initialization
> makes integer from pointer without a cast [-Wint-conversion]
>   phys_addr_t msg_addr = pcie->pcie_reg_base;
>                          ^~~~
> drivers/pci/controller/pcie-mobiveil.c: In function
> 'mobiveil_compose_msi_msg':
> drivers/pci/controller/pcie-mobiveil.c:640:21: warning: initialization
> makes integer from pointer without a cast [-Wint-conversion]
>   phys_addr_t addr = pcie->pcie_reg_base + (data->hwirq * sizeof(int));
>
> Fix the type and with it the compilation warnings.
>
> Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
> driver")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> ---
>  drivers/pci/controller/pcie-mobiveil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> index cf0aa7cee5b0..8b45f77d70f9 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -130,7 +130,7 @@ struct mobiveil_pcie {
>         void __iomem *config_axi_slave_base;    /* endpoint config base */
>         void __iomem *csr_axi_slave_base;       /* root port config base */
>         void __iomem *apb_csr_base;     /* MSI register base */
> -       void __iomem *pcie_reg_base;    /* Physical PCIe Controller Base */
> +       phys_addr_t pcie_reg_base;      /* Physical PCIe Controller Base */
>         struct irq_domain *intx_domain;
>         raw_spinlock_t intx_mask_lock;
>         int irq;
> --
> 2.15.0
>
