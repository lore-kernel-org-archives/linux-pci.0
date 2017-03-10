Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34135 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932697AbdCJToV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2017 14:44:21 -0500
Received: by mail-pg0-f44.google.com with SMTP id 77so42207505pgc.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Mar 2017 11:44:20 -0800 (PST)
Date: Fri, 10 Mar 2017 11:44:17 -0800
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [RFT PATCH] PCI: provide helper to reset all domain for host
 drivers
Message-ID: <20170310194417.GB16352@google.com>
References: <1489132706-56952-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489132706-56952-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

I might be mistaken here, but I don't think this is wise:

On Fri, Mar 10, 2017 at 03:58:26PM +0800, Shawn Lin wrote:
> Otherwise the domain_nr will be increased if doing ubind and
> bind host drives. I don't find any useful routine to reset it
> from current code, so add this helper. This patch is based on patchset[1]
> from Brian.
> 
> [1]: https://patchwork.kernel.org/patch/9614517/
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> Hi Brian,
> 
> I wasn't able to run my platfrom with linux-next but I test this for
> my local kernel-v4.4, and I just send this for test!
> 
>  drivers/pci/host/pcie-rockchip.c | 1 +
>  drivers/pci/pci.c                | 6 ++++++
>  include/linux/pci.h              | 3 +++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index bd6df72..61787e7 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -1435,6 +1435,7 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>  	pci_remove_root_bus(rockchip->root_bus);
>  	pci_unmap_iospace(rockchip->io);
>  	irq_domain_remove(rockchip->irq_domain);
> +	pci_reset_all_domain();

You don't want to reset *all* domains here; what if some other driver
created another domain? You're essentially cloberring it here.

>  	phy_power_off(rockchip->phy);
>  	phy_exit(rockchip->phy);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3ec24877..7c7c63b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5181,6 +5181,12 @@ int pci_get_new_domain_nr(void)
>  	return atomic_inc_return(&__domain_nr);
>  }
>  
> +void pci_reset_all_domain(void)
> +{
> +	atomic_set(&__domain_nr, -1);

IIUC, instead of completely resetting here, it seems like we'd need to
rework the entire domain allocation code, so that it can properly
hotplug domains, and track the potential "holes" in indexing that might
arise.

Brian

> +}
> +EXPORT_SYMBOL(pci_reset_all_domain);
> +
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  static int of_pci_bus_find_domain_nr(struct device *parent)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index eb3da1a..c9bd939 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1456,11 +1456,13 @@ static inline int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>  #ifdef CONFIG_PCI_DOMAINS
>  extern int pci_domains_supported;
>  int pci_get_new_domain_nr(void);
> +void pci_reset_all_domain(void);
>  #else
>  enum { pci_domains_supported = 0 };
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>  static inline int pci_proc_domain(struct pci_bus *bus) { return 0; }
>  static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
> +static inline void pci_reset_all_domain(void) {}
>  #endif /* CONFIG_PCI_DOMAINS */
>  
>  /*
> @@ -1617,6 +1619,7 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
>  static inline int pci_domain_nr(struct pci_bus *bus) { return 0; }
>  static inline struct pci_dev *pci_dev_get(struct pci_dev *dev) { return NULL; }
>  static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
> +static inline void pci_reset_all_domain(void) {};
>  
>  #define dev_is_pci(d) (false)
>  #define dev_is_pf(d) (false)
> -- 
> 1.9.1
> 
> 
