Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754693AbeASLRz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Jan 2018 06:17:55 -0500
Date: Fri, 19 Jan 2018 11:18:59 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Niklas Cassel <niklas.cassel@axis.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, arnd@arndb.de, kishon@ti.com,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add dummy pci_irqd_intx_xlate() for CONFIG_PCI=n
 build
Message-ID: <20180119111859.GA24300@red-moon>
References: <20180119093906.27670-1-niklas.cassel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119093906.27670-1-niklas.cassel@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 19, 2018 at 10:39:06AM +0100, Niklas Cassel wrote:
> If CONFIG_PCI=n and CONFIG_PCI_DRA7XX_EP=y, the build fails with:
> 
>   drivers/pci/dwc/pci-dra7xx.c:229:11: error: 'pci_irqd_intx_xlate'
>   undeclared here (not in a function)
> 
> When building drivers/pci/dwc/pci-dra7xx.c without CONFIG_PCI,
> gcc is usually smart enough to realize that RC specific code
> is unreachable and can thus be eliminated.
> 
> However, gcc cannot do this if there is a function that isn't
> even declared.
> 
> Hence fix the issue by introducing a dummy for pci_irqd_intx_xlate().
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Thanks for the patch.

I think the commit log should be rewritten (when you write it think at
someone reading it in some time - what you wrote won't probably make
any sense) but first, Bjorn are you picking this up ? It does not make
much sense to squash it in one of my pci/dwc branch commits - therefore
I am asking, just let me know.

Thanks,
Lorenzo

> ---
>  include/linux/pci.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 83299833a6ce..41c676a011f4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1675,6 +1675,13 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>  #define dev_is_pf(d) (false)
>  static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
>  { return false; }
> +static inline int pci_irqd_intx_xlate(struct irq_domain *d,
> +				      struct device_node *node,
> +				      const u32 *intspec,
> +				      unsigned int intsize,
> +				      unsigned long *out_hwirq,
> +				      unsigned int *out_type)
> +{ return -EINVAL; }
>  #endif /* CONFIG_PCI */
>  
>  /* Include architecture-dependent settings and functions */
> -- 
> 2.14.2
> 
