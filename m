Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43904 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757279Ab3HLRJ5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2013 13:09:57 -0400
Message-ID: <520916E0.5030404@wwwdotorg.org>
Date: Mon, 12 Aug 2013 11:09:52 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Jason Cooper <jason@lakedaemon.net>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv9 00/10] MSI support for Marvell EBU PCIe driver
References: <1376080035-29344-1-git-send-email-thomas.petazzoni@free-electrons.com> <20130812163723.GK25111@titan.lakedaemon.net>
In-Reply-To: <20130812163723.GK25111@titan.lakedaemon.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/12/2013 10:37 AM, Jason Cooper wrote:
> Thomas,
> 
> Whole series applied as follows:
> 
> +---+ mvebu/msi_pci (1-4,7)
>     |
>     +---+---+ mvebu/msi_irq (5,6)
>             |
>             +---+---+ mvebu/msi_mvebu (8-10)
> 
> mvebu/msi_pci built successfully with Randy's config for x86_64.
> 
> Thierry, I've tagged mvebu/msi_pci.  Unless it all falls apart in -next,
> those commit-id's won't change from what will be in arm-soc.

So, the branch still isn't stable, hence I shouldn't use it as a
baseline to apply Thierry's PCIe patches?
