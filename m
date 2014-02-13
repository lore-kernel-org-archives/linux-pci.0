Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35789 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbaBMIKe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Feb 2014 03:10:34 -0500
From: Jingoo Han <jg1.han@samsung.com>
To: 'Liviu Dudau' <Liviu.Dudau@arm.com>,
	'Tanmay Inamdar' <tinamdar@apm.com>
Cc: 'Arnd Bergmann' <arnd@arndb.de>, devicetree@vger.kernel.org,
	'linaro-kernel' <linaro-kernel@lists.linaro.org>,
	'linux-pci' <linux-pci@vger.kernel.org>,
	'Will Deacon' <Will.Deacon@arm.com>,
	'LKML' <linux-kernel@vger.kernel.org>,
	'Catalin Marinas' <Catalin.Marinas@arm.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'LAKML' <linux-arm-kernel@lists.infradead.org>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <1391452428-22917-1-git-send-email-Liviu.Dudau@arm.com>
 <1391452428-22917-2-git-send-email-Liviu.Dudau@arm.com>
 <7398333.9L5KlyFggU@wuerfel>
 <CACoXjckKRQfR3CbC1JpgbhOumED+OqiMh1_Y73-h6q=ByMNanw@mail.gmail.com>
 <20140206101814.GA4993@e106497-lin.cambridge.arm.com>
In-reply-to: <20140206101814.GA4993@e106497-lin.cambridge.arm.com>
Subject: Re: [PATCH] pci: Add support for creating a generic host_bridge from
 device tree
Date: Thu, 13 Feb 2014 17:10:29 +0900
Message-id: <000201cf2893$0f5e3710$2e1aa530$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, February 06, 2014 7:18 PM, Liviu Dudau wrote:
> On Wed, Feb 05, 2014 at 10:26:27PM +0000, Tanmay Inamdar wrote:
> > Hello Liviu,
> >
> > I did not get the first email of this particular patch on any of
> > subscribed mailing lists (don't know why), hence replying here.
> 
> Strange, it shows in the MARC and GMANE archive for linux-pci, probably
> a hickup on your receiving side?
> 
> >
> > +struct pci_host_bridge *
> > +pci_host_bridge_of_init(struct device *parent, int busno, struct pci_ops *ops,
> > + void *host_data, struct list_head *resources)
> > +{
> > + struct pci_bus *root_bus;
> > + struct pci_host_bridge *bridge;
> > +
> > + /* first parse the host bridge bus ranges */
> > + if (pci_host_bridge_of_get_ranges(parent->of_node, resources))
> > + return NULL;
> > +
> > + /* then create the root bus */
> > + root_bus = pci_create_root_bus(parent, busno, ops, host_data, resources);
> > + if (!root_bus)
> > + return NULL;
> > +
> > + bridge = to_pci_host_bridge(root_bus->bridge);
> > +
> > + return bridge;
> > +}
> >
> > You are keeping the domain_nr inside pci_host_bridge structure. In
> > above API, domain_nr is required in 'pci_find_bus' function called
> > from 'pci_create_root_bus'. Since the bridge is allocated after
> > creating root bus, 'pci_find_bus' always gets domain_nr as 0. This
> > will cause problem for scanning multiple domains.
> 
> Good catch. I was switching between creating a pci_controller in arch/arm64 and
> adding the needed bits in pci_host_bridge. After internal review I've decided to
> add the domain_nr to pci_host_bridge, but forgot to update the code everywhere.

Hi Liviu Dudau,

One more thing,
I am reviewing and compiling your patch.
Would you consider adding 'struct pci_sys_data' and 'struct hw_pci'?

Currently, 4 PCIe Host drivers (pci-mvebu.c, pci-tegra.c,
pci-rcar-gen2.c, pcie-designware.c) are using 'struct pci_sys_data'
and 'struct hw_pci' in their drivers. Without this, it makes build
errors.

In arm32, 'struct pci_sys_data' and 'struct hw_pci' is defined
in "arch/arm/include/asm/mach/pci.h".

Tanmay Inamdar,
Your 'APM X-Gene PCIe' patch also needs 'struct pci_sys_data' and
'struct hw_pci'. With Liviu Dudau's patch, it will make build
errors. Would you check this?

Thank you.

Best regards,
Jingoo Han

> 
> Thanks for reviewing this, will fix in v2.
> 
> Do you find porting to the new API straight forward?
> 

