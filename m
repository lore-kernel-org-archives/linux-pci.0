Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from up.free-electrons.com ([94.23.35.102]:54813 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754611Ab3HAQOk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Aug 2013 12:14:40 -0400
Date: Thu, 1 Aug 2013 18:14:35 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
Message-ID: <20130801181435.72b687cc@skate>
In-Reply-To: <51FA87EE.60601@wwwdotorg.org>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<51FA87EE.60601@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Stephen Warren,

On Thu, 01 Aug 2013 10:08:14 -0600, Stephen Warren wrote:
> On 08/01/2013 07:25 AM, Thomas Petazzoni wrote:
> > Hello,
> > 
> > This set of patches introduces Message Signaled Interrupt support in
> > the Marvell EBU PCIe driver. It has been successfully tested on the
> > Armada XP GP platform with an Intel e1000e PCIe network card that
> > supports MSI.
> > 
> > This patch set is intended for merging in 3.12, so the respective
> > maintainers of the different areas are invited to review/ack the
> > patches, see below for the details. Note that several of those patches
> > are also needed for the Tegra PCIe driver.
> > 
> > There are still missing ACKs from Grant Likely (5, 6, 7), Thomas
> > Gleixner (8, 9) and Bjorn Helgaas (2, 12).
> 
> Recall that Grant gave up most/all of his maintainerships, so you
> probably want someone else to approve patches 5/6/7. It looks like
> Benjamin Herrenschmidt <benh@kernel.crashing.org> is listed in
> MAINTAINERS for those patches.

Thanks. I see you've Cc'ed Ben, thanks.

However, it is worth noting that the previous approach was based on a
drivers/of registry of msi_chip, which Rob Herring, as drivers/of
maintainer, has Acked. But then, this Sunday, Grant said he disagreed
with the approach. So even though he is no longer an official
maintainer, he seems to be the one who decides what direction
drivers/of and irqdomain should be having.

Of course, if Ben could look at those irqdomain patches and give his
Acked-by, it'd be great.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
