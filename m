Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f193.google.com ([209.85.160.193]:33719 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030876AbbJ3Vnx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2015 17:43:53 -0400
MIME-Version: 1.0
In-Reply-To: <1446239475-49480-6-git-send-email-jakeo@microsoft.com>
References: <1446239475-49480-1-git-send-email-jakeo@microsoft.com>
	<1446239475-49480-6-git-send-email-jakeo@microsoft.com>
Date: Fri, 30 Oct 2015 23:43:52 +0200
Message-ID: <CAHp75VdSXLRAtgd-HLUhvPDJT6Wx=r2tPQHSFX69Exg9XFJKTQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] PCI: irqdomain: Look up IRQ domain by fwnode_handle
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: jakeo@microsoft.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kys@microsoft.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	devel@linuxdriverproject.org, olaf@aepfle.de,
	Robo Bot <apw@canonical.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>, tglx@redhat.com,
	haiyangz@microsoft.com, marc.zyngier@arm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 11:11 PM,  <jakeo@microsoft.com> wrote:
> From: Jake Oshins <jakeo@microsoft.com>
>
> This patch adds a second way of finding an IRQ domain associated with
> a root PCI bus.  After looking to see if one can be found through
> the OF tree, it attempts to look up the IRQ domain through an
> fwnode_handle stored in the pci_sysdata struct.
>
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> ---
>  arch/x86/include/asm/pci.h |  4 +++-
>  drivers/pci/probe.c        | 11 +++++++++++
>  include/asm-generic/pci.h  |  4 ++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 10213a1..fb74453 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -45,11 +45,13 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  #endif
>
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> -static inline void *pci_fwnode(struct pci_bus *bus)
> +static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)

I'm sorry what is the point to rename?

>  {
>         struct pci_sysdata *sd = bus->sysdata;
>         return sd->fwnode;
>  }
> +
> +#define pci_root_bus_fwnode    _pci_root_bus_fwnode
>  #endif
>
>  /* Can be used to override the logic in pci_scan_bus for skipping
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index f441d1b..60e50a8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -671,6 +671,17 @@ static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
>          */
>         d = pci_host_bridge_of_msi_domain(bus);
>
> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> +       /*
> +        * If no IRQ domain was found via the OF tree, try looking it up
> +        * directly through the fwnode_handle.
> +        */
> +       if (!d && pci_root_bus_fwnode(bus)) {
> +               d = irq_find_matching_fwnode(pci_root_bus_fwnode(bus),
> +                                            DOMAIN_BUS_PCI_MSI);

Gave a second glance and now noticed that you call
pci_root_bus_fwnode() twice. So, it actually might be more readable
like your first but modified variant:

if (!d) {
  void *fwnode = pci_fwnode(bus);

  if (fwnode)
    d = irq_find_matching_fwnode(fwnode, DOMAIN_BUS_PCI_MSI);
}

> +       }
> +#endif
> +
>         return d;
>  }


With Best Regards,
Andy Shevchenko
