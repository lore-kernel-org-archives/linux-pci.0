Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:42110 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdCJIoy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2017 03:44:54 -0500
Subject: Re: [RFT PATCH] PCI: provide helper to reset all domain for host
 drivers
To: Brian Norris <briannorris@chromium.org>
References: <1489132706-56952-1-git-send-email-shawn.lin@rock-chips.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <6d207d54-bc32-f307-2aa1-0afed821342e@rock-chips.com>
Date: Fri, 10 Mar 2017 16:44:42 +0800
MIME-Version: 1.0
In-Reply-To: <1489132706-56952-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/3/10 15:58, Shawn Lin wrote:
> Otherwise the domain_nr will be increased if doing ubind and
> bind host drives. I don't find any useful routine to reset it
> from current code, so add this helper. This patch is based on patchset[1]
> from Brian.
>
> [1]: https://patchwork.kernel.org/patch/9614517/
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>

Oh, add "linux,pci-domain = <0>" for our DT could also works.


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
>
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
>


-- 
Best Regards
Shawn Lin
