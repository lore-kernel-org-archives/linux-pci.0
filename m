Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35400 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbHLPf6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 11:35:58 -0400
Received: by lbcbn3 with SMTP id bn3so11652956lbc.2
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2015 08:35:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439372036-15303-6-git-send-email-l.stach@pengutronix.de>
References: <1439372036-15303-1-git-send-email-l.stach@pengutronix.de>
	<1439372036-15303-6-git-send-email-l.stach@pengutronix.de>
Date: Wed, 12 Aug 2015 21:05:57 +0530
Message-ID: <CAHM4w1kKu1rbONmWvE2UnEWXNaY+b73JXwB6Af+_KD6CfpKL8w@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] PCI: designware: set up high part of MSI target address
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	patchwork-lst@pengutronix.de, kernel@pengutronix.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 12, 2015 at 3:03 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Set up the high part of the MSI target address in order to allow the
> MSI target to reside above the 4GB mark on 64bit and PAE systems.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/pci/host/pcie-designware.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 74034395cf2a..fcb798e47c30 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -299,12 +299,15 @@ no_valid_irq:
>  static void dw_msi_setup_msg(struct pcie_port *pp, unsigned int irq, u32 pos)
>  {
>         struct msi_msg msg;
> +       u64 msi_target;
>
>         if (pp->ops->get_msi_addr)
> -               msg.address_lo = pp->ops->get_msi_addr(pp);
> +               msi_target = pp->ops->get_msi_addr(pp);
>         else
> -               msg.address_lo = virt_to_phys((void *)pp->msi_data);
> -       msg.address_hi = 0x0;
> +               msi_target = virt_to_phys((void *)pp->msi_data);
> +
> +       msg.address_lo = (u32)(msi_target & 0xffffffff);
> +       msg.address_hi = (u32)(msi_target >> 32 & 0xffffffff);
>
>         if (pp->ops->get_msi_data)
>                 msg.data = pp->ops->get_msi_data(pp, pos);

Other than above, dw_pcie_msi_init also need to be fixed
for PCIE_MSI_ADDR_HI.
