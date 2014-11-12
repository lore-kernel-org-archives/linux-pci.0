Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:58695 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbaKLCqh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Nov 2014 21:46:37 -0500
Message-ID: <5462CA00.10601@huawei.com>
Date: Wed, 12 Nov 2014 10:46:24 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: RFC for ideas to clean up PCI MSI code
References: <54624D35.2070808@linux.intel.com>
In-Reply-To: <54624D35.2070808@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/11/12 1:53, Jiang Liu wrote:
> Hi Bjorn, Yijing and Thomas,
> 	Recently Yijing is trying to kill some weak functions in
> drivers/pci/msi.c by using msi_chip mechanism. And it inspired me
> that we could go one step further to kill those weak functions
> at all and move common PCI MSI code into PCI core by using the
> new hierarch irqdomain framework.
> 	The way to achieve the goal is:
> 1) arch code creates irqdomain for PCI MSI controllers. By default,
> there's only one global PCI MSI irqdomain. But there's may be multiple
> for some architecture like x86. So arch also need to implement a weak
> function (I know you don't like weak functions):
> 	struct irq_domain *arch_get_pci_msi_irq_domain(struct pci_dev *);

Arm also may have multiple msi_chips/msi irq domains, currently, corresponding msi_chip is stored
in bus->msi. But it's not a good idea, I'm refactoring generic pci host bridge, we could
save it in generic pci_host_bridge.

> 
> 2) replace
> arch_setup_msi_irqs()/arch_setup_msi_irqs()/arch_teardown_msi_irqs()/arch_teardown_msi_irq()
> with
> irq_domain interfaces.

Agree.

> 
> 3) kill arch_msi_mask_irq()/arch_msi_mask_irq() by directly setting
> irq_chip.irq_mask()/irq_unmask().

arch_msi_mask_irq() is only called in pci_msi_shutdown, in this case,
the msi mask status will not be overrode, so we can restore it later.
If use irq_chip.irq_mask(), we need another place to save the mask status.

> 
> 4) we could also find a way to kill arch_restore_msi_irqs() by using
> new irqdomain interfaces.

My personal opinion, I think place arch_retore_msi_irqs() stuffs in irq_chip is better. :)


> 
> For arch code to support the new MSI, it needs to implement callbacks in
> msi_domain_ops and irq_chip. All other PCI MSI code becomes common
> and will be moved into pci/msi.c. Proposed interfaces as below:
> 
> struct irq_chip {
>         void            (*irq_compose_msi_msg)(struct irq_data *data,
> struct msi_msg *msg);
> };
> 
> struct msi_domain_ops {
>         void (*calc_hwirq)(struct msi_domain_info *info, void *arg,
>                            struct msi_desc *desc);
>         irq_hw_number_t (*get_hwirq)(struct msi_domain_info *info, void
> *arg);
>         int (*msi_init)(struct irq_domain *domain, struct
> msi_domain_info *info,
>                         unsigned int virq, irq_hw_number_t hwirq, void
> *arg);
>         void (*msi_free)(struct irq_domain *domain,
>                          struct msi_domain_info *info, unsigned int virq);
> };
> 
> struct msi_domain_info {
>         struct msi_domain_ops *ops;
>         struct irq_chip *chip;
>         void *data;
> };
> 
> struct irq_domain *msi_create_irq_domain(struct device_node *of_node,
>                                          struct msi_domain_info *info,
>                                          struct irq_domain *parent);
> 
> So, what's your thoughts about the proposal? If now objection, I may
> send out a draft version for x86 within about one week:)

I think the proposal is better than original msi_chip framework.
I like this idea. :)

Thanks!
Yijing.


> Thanks!
> Gerry
> 
> .
> 


-- 
Thanks!
Yijing

