Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45992 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab3A1WAY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 17:00:24 -0500
Message-ID: <5106F4EA.20904@wwwdotorg.org>
Date: Mon, 28 Jan 2013 15:00:10 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 02/27] of/pci: Add of_pci_get_devfn() function
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-3-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1359399397-29729-3-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/28/2013 11:56 AM, Thomas Petazzoni wrote:
> From: Thierry Reding <thierry.reding@avionic-design.de>
> 
> This function can be used to parse the device and function number from a
> standard 5-cell PCI resource. PCI_SLOT() and PCI_FUNC() can be used on
> the returned value obtain the device and function numbers respectively.

> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c

>  static inline int __of_pci_pci_compare(struct device_node *node,
>  				       unsigned int devfn)
>  {
> -	unsigned int size;
> -	const __be32 *reg = of_get_property(node, "reg", &size);
> +	int err;

I think I commented when Thierry posted this, that calling that "err"
seems a little odd. Thierry replied:

Maybe renaming the devfn parameter to data and using devfn for the local
variable would be more obvious.
