Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:56588 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbcFIMSe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2016 08:18:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Hanna Hawa <hannah@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/3] PCI: host: new PCI host controller driver for Marvell Armada 3700
Date: Thu, 09 Jun 2016 14:19:07 +0200
Message-ID: <11140978.npsCNQs782@wuerfel>
In-Reply-To: <20160609111921.11975627@free-electrons.com>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com> <3112077.0RPfokLCAs@wuerfel> <20160609111921.11975627@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 9, 2016 11:19:21 AM CEST Thomas Petazzoni wrote:
> > What is the version of the GIC in the Armada 3700? If you have GICv3
> > or GICv2m, could you use that instead of the built-in MSI logic?
> > 
> > We typically handle this using the msi-map or msi-parent properties
> > pointing to either the gic or the PCI host, depending on which one
> > you want to use, but either of them should work, and the GIC should
> > be more efficient because you can distribute the interrupts of the
> > PCI devices over all CPUs by workload, rather than having to
> > multiplex all MSI through a single GIC interrupt.
> 
> There is a GIC-500, but Marcin told me that attempts to use MSI with it
> have not been successful so far. There will be investigation on this
> topic in the future, but for the moment, we'd like to have the MSI
> functionality built into the PCIe driver supported. We can migrate
> later to GIC-500 powered MSIs once working.

I think you should still add the msi-parent or msi-map properties then,
just have them point at the PCI host node instead of the GIC-500,
and evaluate that to get the built-in controller.

	Arnd

