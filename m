Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:61655 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbbGTCh3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jul 2015 22:37:29 -0400
Message-ID: <55AC5DF3.8090502@huawei.com>
Date: Mon, 20 Jul 2015 10:33:23 +0800
From: "majun (F)" <majun258@huawei.com>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	"Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v4 09/19] drivers: base: Add MSI domain support for non-PCI
 devices
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com> <1436962613-17359-10-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1436962613-17359-10-git-send-email-marc.zyngier@arm.com>
Content-Type: text/plain; charset="gbk"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



ÔÚ 2015/7/15 20:16, Marc Zyngier Ð´µÀ:
> With the msi_list and the msi_domain properties now being at the
> generic device level, it is starting to be relatively easy to offer
> a generic way of providing non-PCI MSIs.
> 
[...]
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index c10ec56..b55cf63 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -18,6 +18,11 @@ struct pci_dev;
>  void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>  void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
>  
> +typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
> +				    struct msi_msg *msg);
> +
> +struct platform_msi_priv_data;
> +
>  struct msi_desc {
>  	struct list_head		list;
>  	unsigned int			irq;
> @@ -42,6 +47,10 @@ struct msi_desc {
>  				void __iomem *mask_base;
>  			};
>  		};
> +		struct {
> +			struct platform_msi_priv_data *platform_msi_priv_data;
> +			u16 msi_index;
> +		};
>  	};
>  };
>  
When I add this patch in linux 4.2.rc2, this part is rejected. So I added this part
myself. But there is compiling errors.

drivers/base/platform-msi.c: In function 'platform_msi_free_descs':
drivers/base/platform-msi.c:129:2: error: implicit declaration of function 'to_pci_dev' [-Werror=implicit-function-declaration]
  list_for_each_entry_safe(desc, tmp, dev_to_msi_list(dev), list) {
  ^
In file included from include/linux/list.h:8:0,
                 from include/linux/kobject.h:20,
                 from include/linux/device.h:17,
                 from drivers/base/platform-msi.c:20:
include/linux/msi.h:57:50: error: invalid type argument of '->' (have 'int')
 #define dev_to_msi_list(dev)  (&to_pci_dev((dev))->msi_list)
                                                  ^
include/linux/kernel.h:810:49: note: in definition of macro 'container_of'
  const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                 ^

> @@ -228,6 +237,12 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>  void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
>  struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
>  
> +struct irq_domain *platform_msi_create_irq_domain(struct device_node *np,
> +						  struct msi_domain_info *info,
> +						  struct irq_domain *parent);
> +int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
> +				   irq_write_msi_msg_t write_msi_msg);
> +void platform_msi_domain_free_irqs(struct device *dev);
>  #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
>  
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> 

