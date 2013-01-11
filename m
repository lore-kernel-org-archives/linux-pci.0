Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:49208 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab3AKAJr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jan 2013 19:09:47 -0500
Message-ID: <50EF5847.7040507@wwwdotorg.org>
Date: Thu, 10 Jan 2013 17:09:43 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Murray <andrew.murray@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 02/14] of/pci: Add of_pci_get_devfn() function
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de> <1357764194-12677-3-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1357764194-12677-3-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/09/2013 01:43 PM, Thierry Reding wrote:
> This function can be used to parse the device and function number from a
> standard 5-cell PCI resource. PCI_SLOT() and PCI_FUNC() can be used on
> the returned value obtain the device and function numbers respectively.

> diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c

>  static inline int __of_pci_pci_compare(struct device_node *node,
>  				       unsigned int devfn)
>  {
> +	int err;
>  
> +	err = of_pci_get_devfn(node);
> +	if (err < 0)
>  		return 0;
> +
> +	return devfn == err;

I know this is really picky, but calling that "err" when it's hopefully
not an error but rather a PCI device/function ID seems a little obscure.
Perhaps node_devfn? I assume that fact that devfn is unsigned and err is
signed won't be an issue.
