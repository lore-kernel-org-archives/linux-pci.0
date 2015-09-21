Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33034 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127AbbIUPnP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2015 11:43:15 -0400
Received: by iofh134 with SMTP id h134so124052037iof.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2015 08:43:14 -0700 (PDT)
Date: Mon, 21 Sep 2015 10:43:09 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: jakeo@microsoft.com
Cc: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v2 04/12] drivers:pci: Add IRQ domain lookup by PCI domain
Message-ID: <20150921154309.GQ25767@google.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
 <1441929670-10058-5-git-send-email-jakeo@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441929670-10058-5-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jake,

I don't know how this will be morphed after Marc's comments, but when you
repost this series, please take a look at the existing change history,
e.g.,  with "git log --oneline drivers/pci/probe.c", and make your subject
lines follow the existing conventions.  In this case, they look like:

  PCI: Make pci_msi_setup_pci_dev() non-static for use by arch code
  PCI: Set MPS to match upstream bridge
  PCI: Move MPS configuration check to pci_configure_device()
  PCI: Add pci_scan_root_bus_msi()
  PCI: Tolerate hierarchies with no Root Port
  ...

Bjorn

On Fri, Sep 11, 2015 at 12:01:03AM +0000, jakeo@microsoft.com wrote:
> From: Jake Oshins <jakeo@microsoft.com>
> 
> The PCI driver currently looks up IRQ domains for root PCI buses by walking
> up the Open Firmware tree looking for any that cover this particular PCI root.
> Since x86 PCs don't implement Open Firmware, this patch offers an alternative
> lookup by the PCI domain ID (known as "segment" in the PCI and ACPI specs.)
> 
> I could have tried to build a (fake) Open Firmware tree and leverage the old
> code, but I rejected that possibility both because it would have required
> changes in lots of other places and because most distributions don't even
> compile in the OF infrastructure when targeting PCs.
> 
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> ---
>  drivers/pci/probe.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0b2be17..e7e5ff3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/cpumask.h>
>  #include <linux/pci-aspm.h>
> +#include <linux/irqdomain.h>
>  #include <asm-generic/pci-bridge.h>
>  #include "pci.h"
>  
> @@ -663,12 +664,22 @@ static void pci_set_bus_speed(struct pci_bus *bus)
>  static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
>  {
>  	struct irq_domain *d;
> +	int pci_domain;
>  
>  	/*
>  	 * Any firmware interface that can resolve the msi_domain
>  	 * should be called from here.
>  	 */
>  	d = pci_host_bridge_of_msi_domain(bus);
> +	if (d)
> +		return d;
> +
> +	/*
> +	 * If firmware couldn't help find, it try looking it up by PCI
> +	 * domain/segment.
> +	 */
> +	pci_domain = pci_domain_nr(bus);
> +	d = irq_find_matching_host(NULL, DOMAIN_BUS_PCI_MSI, &pci_domain);
>  
>  	return d;
>  }
> -- 
> 1.9.1
> 
