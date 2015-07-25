Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33671 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbbGYHPq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 25 Jul 2015 03:15:46 -0400
Received: by padck2 with SMTP id ck2so25010377pad.0
        for <linux-pci@vger.kernel.org>; Sat, 25 Jul 2015 00:15:45 -0700 (PDT)
Message-ID: <55B33799.5030706@linaro.org>
Date: Sat, 25 Jul 2015 15:15:37 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Marc Zyngier <marc.zyngier@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, Duc Dang <dhdang@apm.com>,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	linux-arm-kernel@lists.infradead.org, Ma Jun <majun258@huawei.com>
Subject: Re: [PATCH v5 01/19] genirq: irqdomain: Allow irq domain aliasing
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com> <1437643598-19795-2-git-send-email-marc.zyngier@arm.com>
In-Reply-To: <1437643598-19795-2-git-send-email-marc.zyngier@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/23/2015 05:26 PM, Marc Zyngier wrote:
> It is not uncommon (at least with the ARM stuff) to have a piece
> of hardware that implements different flavours of "interrupts".
> A typical example of this is the GICv3 ITS, which implements
> standard PCI/MSI support, but also some form of "generic MSI".
>
> So far, the PCI/MSI domain is registered using the ITS device_node,
> so that irq_find_host can return it. On the contrary, the raw MSI
> domain is not registered with an device_node, making it impossible
> to be looked up by another subsystem (obviously, using the same
> device_node twice would only result in confusion, as it is not
> defined which one irq_find_host would return).
>
> A solution to this is to "type" domains that may be aliasing, and
> to be able to lookup an device_node that matches a given type.
> For this, we introduce irq_find_matching_host() as a superset
> of irq_find_host:
>
> struct irq_domain *irq_find_matching_host(struct device_node *node,
>                                  enum irq_domain_bus_token bus_token);
>
> where bus_token is the "type" we want to match the domain against
> (so far, only DOMAIN_BUS_ANY is defined). This result in some
> moderately invasive changes on the PPC side (which is the only
> user of the .match method).
>
> This has otherwise no functionnal change.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   |  3 ++-
>   arch/powerpc/platforms/cell/interrupt.c          |  3 ++-
>   arch/powerpc/platforms/embedded6xx/flipper-pic.c |  3 ++-
>   arch/powerpc/platforms/powermac/pic.c            |  3 ++-
>   arch/powerpc/platforms/powernv/opal-irqchip.c    |  3 ++-
>   arch/powerpc/platforms/ps3/interrupt.c           |  3 ++-
>   arch/powerpc/sysdev/ehv_pic.c                    |  3 ++-
>   arch/powerpc/sysdev/i8259.c                      |  3 ++-
>   arch/powerpc/sysdev/ipic.c                       |  3 ++-
>   arch/powerpc/sysdev/mpic.c                       |  3 ++-
>   arch/powerpc/sysdev/qe_lib/qe_ic.c               |  3 ++-
>   arch/powerpc/sysdev/xics/xics-common.c           |  3 ++-
>   include/linux/irqdomain.h                        | 23 +++++++++++++++++++++--
>   kernel/irq/irqdomain.c                           | 18 +++++++++++++-----
>   14 files changed, 58 insertions(+), 19 deletions(-)

[...]

>   /**
>    * irq_domain_add_linear() - Allocate and register a linear revmap irq_domain.
>    * @of_node: pointer to interrupt controller's device tree node.
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 8c3577f..995d217 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -187,10 +187,12 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
>   EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
>
>   /**
> - * irq_find_host() - Locates a domain for a given device node
> + * irq_find_matching_host() - Locates a domain for a given device node
>    * @node: device-tree node of the interrupt controller
> + * @data: domain-specific data

Typo, @bus_token.

>    */
> -struct irq_domain *irq_find_host(struct device_node *node)
> +struct irq_domain *irq_find_matching_host(struct device_node *node,
> +					  enum irq_domain_bus_token bus_token)

Other than that,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
