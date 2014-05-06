Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58243 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbaEFTMR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 May 2014 15:12:17 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Will Deacon <will.deacon@arm.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [RESEND PATCH 2/3] PCI: ARM: add support for generic PCI host controller
Date: Tue, 06 May 2014 21:11:48 +0200
Message-ID: <12021375.dFzSuv1Afb@wuerfel>
In-Reply-To: <20140506183811.GI13677@arm.com>
References: <1399048876-11862-1-git-send-email-will.deacon@arm.com> <12080862.flQZBvPba4@wuerfel> <20140506183811.GI13677@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 06 May 2014 19:38:12 Will Deacon wrote:
> Ok, I've respun the patch and included it below. It's turned probe() into a
> bit of a beast, but the cleanup is a lot simpler (unless I'm missing
> something).

Let's see if we can make it a bit more readable. None of these are important,
but together they could improve readability.

> +static int gen_pci_probe(struct platform_device *pdev)
> +{
> +       struct gen_pci *pci;
> +       int err, res_valid;
> +       struct pci_host_bridge_window *win;
> +       struct resource *bus_range;
> +       resource_size_t busn;
> +       const char *type;
> +       struct of_pci_range range;
> +       struct of_pci_range_parser parser;
> +       struct hw_pci hw;
> +       const struct of_device_id *of_id;
> +       const int *prop;
> +       u8 bus_max;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *np = dev->of_node;
> +
> +       if (!dev->of_node)
> +               return -ENODEV;

This check can go away: you don't get here without an of node.

> +       pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +       if (!pci)
> +               return -ENOMEM;
> +
> +       pci->host.dev.parent = dev;
> +       hw = (struct hw_pci) {
> +               .nr_controllers = 1,
> +               .private_data   = (void **)&pci,
> +               .setup          = gen_pci_setup,
> +               .map_irq        = of_irq_parse_and_map_pci,
> +               .ops            = &gen_pci_ops,
> +       };

C constructors are actually a gcc extension, I think it would be more
common to turn this into an initializer by moving it to the declaration:

	struct gen_pci *pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
	struct hw_pci hw = {
               .nr_controllers = 1,
               .private_data   = (void **)&pci,
               .setup          = gen_pci_setup,
               .map_irq        = of_irq_parse_and_map_pci,
               .ops            = &gen_pci_ops,
       };


> +       if (of_pci_range_parser_init(&parser, np)) {
> +               dev_err(dev, "missing \"ranges\" property\n");
> +               return -EINVAL;
> +       }

If you move everything related to the range parser into a separate function,
you end up with two more compact parts. 

> +       /* Create and register resources from the ranges property */
> +       res_valid = 0;
> +       for_each_of_pci_range(&parser, &range) {
> +               struct resource *parent, *res;
> +               resource_size_t offset;
> +               u32 restype = range.flags & IORESOURCE_TYPE_BITS;

You could also move the body of the for loop into another function, or
both.

	Arnd

