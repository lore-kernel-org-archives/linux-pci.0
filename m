Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36284 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966964Ab3HIFul (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Aug 2013 01:50:41 -0400
Message-ID: <1376027346.32100.8.camel@pasglop>
Subject: Re: [PATCHv8 04/10] of: pci: add registry of MSI chips
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 09 Aug 2013 15:49:06 +1000
In-Reply-To: <1376000268-18397-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1376000268-18397-5-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-08-09 at 00:17 +0200, Thomas Petazzoni wrote:
> 
> +#if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
> +int of_pci_msi_chip_add(struct msi_chip *chip);
> +void of_pci_msi_chip_remove(struct msi_chip *chip);
> +struct msi_chip *of_pci_find_msi_chip_by_node(struct device_node
> *of_node);
> +#else
> +static inline int of_pci_msi_chip_add(struct msi_chip *chip) { return
> -EINVAL; }
> +static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { }

Missing a ; at the end of the above line... breaks the build of
CONFIG_PCI_MSI is not set.

> +static inline struct msi_chip *
> +of_pci_find_msi_chip_by_node(struct device_node *of_node) { return
> NULL };
> +#endif
> +
>  #endif


