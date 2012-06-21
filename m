Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45584 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab2FUVZZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2012 17:25:25 -0400
Received: by pbbrp8 with SMTP id rp8so2649101pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 21 Jun 2012 14:25:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1340271423-4352-5-git-send-email-jiang.liu@huawei.com>
References: <1340271423-4352-1-git-send-email-jiang.liu@huawei.com>
	<1340271423-4352-5-git-send-email-jiang.liu@huawei.com>
Date: Thu, 21 Jun 2012 14:25:25 -0700
Message-ID: <CAE9FiQVj7z0RXnSBdfO9sLO0UAQabdgO2u7NTaXH167C8vYM9w@mail.gmail.com>
Subject: Re: [PATCH v9 04/11] x86/PCI: introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap()
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 21, 2012 at 2:36 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
> Introduce pci_mmcfg_arch_map()/pci_mmcfg_arch_unmap(), which will be used
> when supporting PCI root bridge hotplug.
>
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/include/asm/pci_x86.h |    2 ++
>  arch/x86/pci/mmconfig_32.c     |   15 +++++++++++++++
>  arch/x86/pci/mmconfig_64.c     |   22 +++++++++++++++++++++-
>  3 files changed, 38 insertions(+), 1 deletions(-)
>
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index b3a5317..df898ce 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -135,6 +135,8 @@ struct pci_mmcfg_region {
>
>  extern int __init pci_mmcfg_arch_init(void);
>  extern void __init pci_mmcfg_arch_free(void);
> +extern int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg);
> +extern void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg);
>  extern struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus);
>
>  extern struct list_head pci_mmcfg_list;
> diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
> index 5dad04a..a22785d 100644
> --- a/arch/x86/pci/mmconfig_32.c
> +++ b/arch/x86/pci/mmconfig_32.c
> @@ -141,3 +141,18 @@ int __init pci_mmcfg_arch_init(void)
>  void __init pci_mmcfg_arch_free(void)
>  {
>  }
> +
> +int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
> +{
> +       return 0;
> +}
> +
> +void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
> +{
> +       unsigned long flags;
> +
> +       /* Invalidate the cached mmcfg map entry. */
> +       raw_spin_lock_irqsave(&pci_config_lock, flags);
> +       mmcfg_last_accessed_device = 0;
> +       raw_spin_unlock_irqrestore(&pci_config_lock, flags);
> +}
> diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
> index acc48c5..4e05779 100644
> --- a/arch/x86/pci/mmconfig_64.c
> +++ b/arch/x86/pci/mmconfig_64.c
> @@ -95,7 +95,7 @@ static const struct pci_raw_ops pci_mmcfg = {
>        .write =        pci_mmcfg_write,
>  };
>
> -static void __iomem * __init mcfg_ioremap(struct pci_mmcfg_region *cfg)
> +static void __iomem * __devinit mcfg_ioremap(struct pci_mmcfg_region *cfg)
>  {
>        void __iomem *addr;
>        u64 start, size;
> @@ -138,3 +138,23 @@ void __init pci_mmcfg_arch_free(void)
>                }
>        }
>  }
> +
> +int __devinit pci_mmcfg_arch_map(struct pci_mmcfg_region *cfg)
> +{
> +       cfg->virt = mcfg_ioremap(cfg);
> +       if (!cfg->virt) {
> +               printk(KERN_ERR PREFIX "can't map MMCONFIG at %pR\n",
> +                      &cfg->res);
> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +void pci_mmcfg_arch_unmap(struct pci_mmcfg_region *cfg)
> +{
> +       if (cfg && cfg->virt) {
> +               iounmap(cfg->virt + PCI_MMCFG_BUS_OFFSET(cfg->start_bus));
> +               cfg->virt = NULL;
> +       }
> +}

Can you merge pci_mmcfg_arch_map/unmap with pci_mmcfg_arch_init/free?

at least init/free could call map/unmap.

Thanks

Yinghai
