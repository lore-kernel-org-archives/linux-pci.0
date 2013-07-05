Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:52463 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab3GEWG7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Jul 2013 18:06:59 -0400
Date: Sat, 6 Jul 2013 00:06:55 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv4 05/11] of: pci: add registry of MSI chips
Message-ID: <20130706000655.00ae3659@skate>
In-Reply-To: <CAErSpo5LqKbG=_Uw9eEfR-J0mD2Wg8oi_DdjEfPqgB_VxjouMg@mail.gmail.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1372686136-1370-6-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAErSpo5LqKbG=_Uw9eEfR-J0mD2Wg8oi_DdjEfPqgB_VxjouMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Fri, 5 Jul 2013 15:56:55 -0600, Bjorn Helgaas wrote:

> > +int of_msi_chip_add(struct msi_chip *chip)
> > +{
> > +       if (! of_property_read_bool(chip->of_node, "msi-controller"))
> 
> The space between "! of_property..." is atypical.

Indeed.


> > +struct msi_chip *of_find_msi_chip_by_node(struct device_node *of_node)
> > +{
> > +       struct msi_chip *c;
> 
> Normally there's a blank line here.
> 
> The list traversal below isn't safe, is it?  A simultaneous remove,
> e.g., of an MSI chip unrelated to the one we're looking up, might
> change the list while we're traversing it.

True, will fix!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
