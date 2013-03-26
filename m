Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:60223 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab3CZVQD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2013 17:16:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to interrupt controller driver
Date: Tue, 26 Mar 2013 21:15:40 +0000
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
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com> <1364316746-8702-8-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1364316746-8702-8-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201303262115.41200.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 26 March 2013, Thomas Petazzoni wrote:
> +                       msimask = readl_relaxed(per_cpu_int_base +
> +                                       ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
> +                               & PCI_MSI_DOORBELL_MASK;
> +
> +                       writel(~PCI_MSI_DOORBELL_MASK, per_cpu_int_base +
> +                              ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
> +

Upon reading this code again, I stumbled over the barriers. You use
a readl_relaxed() without barrier but a writel() with barrier. Is
that intentional? Are you sure that you don't need a full readl()
to guarantee that all inbound DMA that was sent by the device before
the MSI message has arrived by the time the interrupt handler function
is called? It depends on the implementation of the MSI controller whether
that guarantee is already made by the fact that you are handling the
interrupt.

	Arnd
