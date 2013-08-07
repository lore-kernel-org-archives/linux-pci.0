Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:58764 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932166Ab3HGJIr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2013 05:08:47 -0400
Date: Wed, 7 Aug 2013 11:03:41 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCHv6 00/13] MSI support for Marvell EBU PCIe driver
Message-ID: <20130807110341.4be97aa8@skate>
In-Reply-To: <1375828754.12557.70.camel@pasglop>
References: <1375363516-2620-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130806201000.3e97c63b@skate>
	<1375828754.12557.70.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Benjamin Herrenschmidt,

On Wed, 07 Aug 2013 08:39:14 +1000, Benjamin Herrenschmidt wrote:

> > Would you mind having a look at:
> > 
> >  * Patches 4, 5, 6, 7 for Benjamin as the irqdomain maintainer.
> 
> Ah sorry, I wasn't aware you were actually waiting for my acks, I didn't
> read the whole thread, my bad. I'm not irqdomain maintainer btw.

Hum, interesting. This is not what my 3.11-rc3 kernel tree says:

IRQ DOMAINS (IRQ NUMBER MAPPING LIBRARY)
M:      Benjamin Herrenschmidt <benh@kernel.crashing.org>
S:      Maintained

As of a0062d4e3a0a ('MAINTAINERS: Remove Grant Likely'), Grant resigned
as the maintainer of IRQ DOMAINS, so you are now the only maintainer
for this subsystem.

> I wrote the original powerpc implementation but since then it has been taken
> over by Grant and others. But I can certainly comment :-)

As the official maintainer, your comments would certainly be
appreciated.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
