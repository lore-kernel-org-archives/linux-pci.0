Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40560 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966964Ab3HIF7a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 9 Aug 2013 01:59:30 -0400
Message-ID: <1376027920.32100.11.camel@pasglop>
Subject: Re: [PATCHv8 00/10] MSI support for Marvell EBU PCIe driver
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
Date: Fri, 09 Aug 2013 15:58:40 +1000
In-Reply-To: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-08-09 at 00:17 +0200, Thomas Petazzoni wrote:
> Hello,
> 
> This set of patches introduces Message Signaled Interrupt support in
> the Marvell EBU PCIe driver. It has been successfully tested on the
> Armada XP GP platform with an Intel e1000e PCIe network card that
> supports MSI.

Appart from the build breakage when not using CONFIG_PCI_MSI which
I reported in a previous email, I'm fine with the series. No need
to add my acks to all of the ARM specific stuff.

Cheers,
Ben.


