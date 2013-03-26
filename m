Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:54689 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab3CZRSB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 13:18:01 -0400
Date: Tue, 26 Mar 2013 18:17:54 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>,
	Andrew Murray <andrew.murray@arm.com>
Subject: Re: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to
 interrupt controller driver
Message-ID: <20130326181754.33b89559@skate>
In-Reply-To: <201303261707.41563.arnd@arndb.de>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1364316746-8702-8-git-send-email-thomas.petazzoni@free-electrons.com>
	<201303261707.41563.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Arnd Bergmann,

On Tue, 26 Mar 2013 17:07:41 +0000, Arnd Bergmann wrote:

> I think the @d0020000 part needs to be removed for the nodes that
> have no reg property.

Sure, will fix.

> I think I did not follow the entire discussion. What has led to having
> two subnodes in the end, rather than a single node like this?
> 
> 
>        interrupt-controller@d0020000 {
>               compatible = "marvell,mpic";
>               #interrupt-cells = <1>;
>               #msi-cells = <1>;
>               #address-cells = <1>;
>               #size-cells = <1>;
>               interrupt-controller;
>               msi-controller;
>               reg = <0xd0020a00 0x1d0>,
>                      <0xd0021070 0x58>;
>               marvell,doorbell = <0xd0020a04>;
>        };

I've tried to explain that in the commit log of PATCH 6, which says:

    However, we need the driver to expose two different IRQ domains: one
    for the main interrupt controller itself, and one for the MSI
    interrupt controller. In order to achieve this, we will create two
    subnodes in the interrupt-controller@d0020000 node: one subnode for
    the main interrupt controller, and one subnode for the MSI interrupt
    controller. The two irq domains can't be registered on the same DT
    node, otherwise when irq_find_host() gets used by of_irq_map_one()
    to resolve IRQs of devices, they may find the MSI interrupt
    controller instead of the main interrupt controller.
    
    Note that both the parent and the child node need to have the
    'interrupt-controller' empty property:
    
      * The interrupt-controller property is needed in the main
    interrupt controller node (interrupt-controller@d0020000) because
    the of_irq_init() function skips nodes that are matching the given
       compatible string, but that don't have the interrupt-controller
       property.
    
     * The interrupt-controller property is needed in the child
    interrupt controller node (main-intc@d0020000) otherwise the
    resolution done by of_irq_map_one() doesn't work.

So really, the thing is that irq_domain_add_linear() registers an IRQ
domain on a specific DT node, and then irq_find_host() finds back an
IRQ domain from a given DT node. So if you have two IRQ domains
registered on the same DT node, then you don't know which one will be
used.

So if I do the two irq_domain_add_linear() (one for MPIC, one for MSI)
on one single DT node, when the timer driver will request its
interrupt, it turns out that the MSI IRQ domain is used and not the
MPIC IRQ domain, even though the timer has <&mpic> as its interrupt
parent.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
