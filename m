Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dliviu.plus.com ([80.229.23.120]:52003 "EHLO smtp.dudau.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbaBTOk2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Feb 2014 09:40:28 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.dudau.co.uk (Postfix) with SMTP id 6B8C7FFA6D
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2014 14:40:27 +0000 (GMT)
Date: Thu, 20 Feb 2014 14:38:29 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm64: Add architecture support for PCI
Message-ID: <20140220143829.GA1556@bart.dudau.co.uk>
References: <1391453028-23191-1-git-send-email-Liviu.Dudau@arm.com>
 <1391453028-23191-2-git-send-email-Liviu.Dudau@arm.com>
 <5302FED1.80903@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5302FED1.80903@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 18, 2014 at 02:33:53PM +0800, Yijing Wang wrote:
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mm.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/slab.h>
> > +
> > +#include <asm/pci-bridge.h>
> > +
> > +
> > +/*
> > + * Return the domain number for this bus
> > + */
> > +int pci_domain_nr(struct pci_bus *bus)
> > +{
> > +	struct pci_host_bridge *bridge = to_pci_host_bridge(bus->bridge);

Hi Yijing,

> 
> Here bus is specific to root bus ? or, what about use find_pci_host_bridge() to get the pci_host_bridge
> instead.

Yes, the call should be to find_pci_host_bridge(). I sort of implied that the
bus is always the root bus, which is obviously not correct. Thanks for pointing it out.

> 
> > +
> > +	if (bridge)
> > +		return bridge->domain_nr;
> > +
> > +	return 0;
> > +}
> > +
> > +int pci_proc_domain(struct pci_bus *bus)
> > +{
> > +	return pci_domain_nr(bus);
> > +}
> > +
> > +/*
> > + * Called after each bus is probed, but before its children are examined
> > + */
> > +void pcibios_fixup_bus(struct pci_bus *bus)
> > +{
> > +	struct pci_dev *dev;
> > +	struct resource *res;
> > +	int i;
> > +
> > +	if (bus->self != NULL) {
> 
> What about use !pci_is_root_bus() ?

Again, good call, will change.

> 
> > +		pci_read_bridge_bases(bus);
> > +
> > +		pci_bus_for_each_resource(bus, res, i) {
> > +			if (!res || !res->flags || res->parent)
> > +				continue;
> > +
> > +			/*
> > +			 * If we are going to reassign everything, we can
> > +			 * shrink the P2P resource to have zero size to
> > +			 * save space
> > +			 */
> > +			if (pci_has_flag(PCI_REASSIGN_ALL_RSRC)) {
> > +				res->flags |= IORESOURCE_UNSET;
> > +				res->start = 0;
> > +				res->end = -1;
> > +				continue;
> > +			}
> > +		}
> > +	}
> > +
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

