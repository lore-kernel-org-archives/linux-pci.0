Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f193.google.com ([209.85.160.193]:36824 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756629AbbJ3A2X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2015 20:28:23 -0400
MIME-Version: 1.0
In-Reply-To: <1446162376-43419-6-git-send-email-jakeo@microsoft.com>
References: <1446162376-43419-1-git-send-email-jakeo@microsoft.com>
	<1446162376-43419-6-git-send-email-jakeo@microsoft.com>
Date: Fri, 30 Oct 2015 02:28:22 +0200
Message-ID: <CAHp75Vd=najBY7MJofStyLODWuG45=VzwLoWCSrQRm0nemuD4A@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] PCI: irqdomain: Look up IRQ domain by fwnode_handle
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: jakeo@microsoft.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kys@microsoft.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	Vitaly Kuznetsov <vkuznets@redhat.com>, tglx@redhat.com,
	haiyangz@microsoft.com, marc.zyngier@arm.com,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 30, 2015 at 1:46 AM,  <jakeo@microsoft.com> wrote:
> From: Jake Oshins <jakeo@microsoft.com>
>
> This patch adds a second way of finding an IRQ domain associated with
> a root PCI bus.  After looking to see if one can be found through
> the OF tree, it attempts to look up the IRQ domain through an
> fwnode_handle stored in the pci_sysdata struct.


> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> +       /*
> +        * If no IRQ domain was found via the OF tree, try looking it up
> +        * directly through the fwnode_handle.
> +        */
> +       if (!d) {
> +               if (pci_fwnode(bus)) {

Isn't it the same to
if (!d && pci_fwnode(bus))
 d = ...

?

> +                       d = irq_find_matching_fwnode(pci_fwnode(bus),
> +                                                    DOMAIN_BUS_PCI_MSI);
> +               }
> +       }
> +#endif


-- 
With Best Regards,
Andy Shevchenko
