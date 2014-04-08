Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:48299 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756664AbaDHM6M (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 08:58:12 -0400
Received: by mail-pd0-f176.google.com with SMTP id r10so968250pdi.21
        for <linux-pci@vger.kernel.org>; Tue, 08 Apr 2014 05:58:12 -0700 (PDT)
Message-ID: <5343F252.2050708@linaro.org>
Date: Tue, 08 Apr 2014 20:57:54 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Liviu Dudau <Liviu.Dudau@arm.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linaro-kernel <linaro-kernel@lists.linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
CC: Grant Likely <grant.likely@secretlab.ca>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH v7 6/6] pci: Add support for creating a generic host_bridge
 from device tree
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com> <1394811272-1547-7-git-send-email-Liviu.Dudau@arm.com>
In-Reply-To: <1394811272-1547-7-git-send-email-Liviu.Dudau@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Liviu,

On 2014-3-14 23:34, Liviu Dudau wrote:
> Several platforms use a rather generic version of parsing
> the device tree to find the host bridge ranges. Move the common code
> into the generic PCI code and use it to create a pci_host_bridge
> structure that can be used by arch code.
> 
> Based on early attempts by Andrew Murray to unify the code.
> Used powerpc and microblaze PCI code as starting point.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Tested-by: Tanmay Inamdar <tinamdar@apm.com>
> ---
>  drivers/pci/host-bridge.c | 158 ++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h       |  13 +++
>  2 files changed, 171 insertions(+)
> 
> diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
> index 8708b652..7cda90b 100644
> --- a/drivers/pci/host-bridge.c
> +++ b/drivers/pci/host-bridge.c
> @@ -6,9 +6,14 @@
>  #include <linux/init.h>
>  #include <linux/pci.h>
>  #include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/slab.h>
>  
>  #include "pci.h"
>  
> +static atomic_t domain_nr = ATOMIC_INIT(-1);

domain_nr will only be used inside the #ifdef CONFIG_OF,
and this will lead to compile warning which complains that
'domain_nr' defined but not used when CONFIG_OF=n (for example
on x86).

How about moving the definition to --->

> +
>  static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
>  {
>  	while (bus->parent)
> @@ -92,3 +97,156 @@ void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
>  	res->end = region->end + offset;
>  }
>  EXPORT_SYMBOL(pcibios_bus_to_resource);
> +
> +#ifdef CONFIG_OF

here?

Thanks
Hanjun
