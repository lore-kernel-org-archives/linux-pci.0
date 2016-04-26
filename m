Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56759 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbcDZVpO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Apr 2016 17:45:14 -0400
Date: Tue, 26 Apr 2016 16:45:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>
Subject: Re: [PATCH v3 0/2] pci: host: new driver for Marvell Armada 7K/8K
 PCIe controller
Message-ID: <20160426214510.GA6789@localhost>
References: <1461659506-10387-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160426173144.GB27803@localhost>
 <20160426210850.13cc8a0e@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160426210850.13cc8a0e@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 26, 2016 at 09:08:50PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 26 Apr 2016 12:31:44 -0500, Bjorn Helgaas wrote:
> 
> > >  create mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt
> > >  create mode 100644 drivers/pci/host/pcie-armada8k.c
> > 
> > Thanks, Thomas, I applied these to pci/host-armada for v4.7.
> 
> Thanks!
> 
> > I added the tweaks below to use dev_dbg() instead of pr_debug(), use
> > dw_pcie_wait_for_link() instead of another hand-coded timeout loop,
> > and fix a typo and remove unused constants.
> 
> Looks all good, thanks for applying! Just one tiny question below.
> 
> >  	/*
> >  	 * Interrupts are directly handled by the device driver of the
> > -	 * PCI device. However, there are also latched into the PCIe
> > +	 * PCI device.  However, they are also latched into the PCIe
> 
> Any reason to have two spaces after the dot here?

Only habit because my eighth-grade typing teacher in 1979 did it that
way, and (I think) vim does it that way by default.  Poor reasons,
both, and definitely trumped by consistency with the rest of the file,
which does use a single space in both other instances.  I removed the
extra space :)

Bjorn
