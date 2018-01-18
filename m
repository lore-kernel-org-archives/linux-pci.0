Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:44181 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753406AbeARQjD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Jan 2018 11:39:03 -0500
MIME-Version: 1.0
In-Reply-To: <20180118150357.GA7544@axis.com>
References: <20180118131612.871559-1-arnd@arndb.de> <20180118150357.GA7544@axis.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 18 Jan 2018 17:39:02 +0100
Message-ID: <CAK8P3a1w1HTvNaqtrQq+FmnARrr=cs+iqQFNJEC2y3L0OX_aTg@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: dra7xx: add back CONFIG_PCI dependency for endpoint
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 18, 2018 at 4:03 PM, Niklas Cassel <niklas.cassel@axis.com> wrote:
> On Thu, Jan 18, 2018 at 02:15:54PM +0100, Arnd Bergmann wrote:
>> It was a nice idea to split out the PCI host and endpoint mode configuration
>> into separate options. Unfortunately it doesn't build:
>>
>> drivers/pci/dwc/pci-dra7xx.c:229:11: error: 'pci_irqd_intx_xlate' undeclared here (not in a function)
>>
>> This is certainly a fixable problem, but since it's clear that this
>> configuration was never tested, let's maybe revert back to the
>> dependency for now, until it can be done in a way that works
>> better.
>
> Hello Arnd,
>
> That is not true :( I did test..
>
> git checkout b052835c6385
> disable CONFIG_PCI
> make
> works like a charm :P

Right, I see it now, sorry for the accusation ;-)

> Commit 524d59f6e30a ("PCI: dra7xx: Fix legacy INTD IRQ handling"),
> which was merged after my commit, added a dependency towards
> pci_irqd_intx_xlate.
>
> It might be a bit unfortunately that commit 489f8fe6aa71
> ("PCI: dwc: dra7xx: Help compiler to remove unused code"),
> a commit that you helped me with Arnd, was placed after
> b052835c6385 ("PCI: dwc: dra7xx: Refactor Kconfig and Makefile
> handling for host/ep mode") instead of before, in my patch
> series order.

I have a vague memory of that, yes.

> However, since pci_irqd_intx_xlate is only defined inside
> CONFIG_PCI, even 489f8fe6aa71 will not help.
>
> Not completely sure about this, but perhaps a better fix is:
>
> +++ b/include/linux/pci.h
> @@ -1686,6 +1686,12 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
>  #define dev_is_pf(d) (false)
>  static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
>  { return false; }
> +static inline int pci_irqd_intx_xlate(struct irq_domain *d,
> +                                     struct device_node *node,
> +                                     const u32 *intspec,
> +                                     unsigned int intsize,
> +                                     unsigned long *out_hwirq,
> +                                     unsigned int *out_type) { return 0; }
>  #endif /* CONFIG_PCI */
>
>  /* Include architecture-dependent settings and functions */
>
>
> And a 'Fixes:' tag that references 524d59f6e30a

Looks fine to me, but I'd put the '{ return 0; }' in a new line for consistency
with the other functions here, and maybe return -EINVAL instead of
zero.

Can you submit that as a proper patch and add my

Acked-by: Arnd Bergmann <arnd@arndb.de>

?

Thanks!


       Arnd
