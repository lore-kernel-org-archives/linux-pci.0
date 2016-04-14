Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51113 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752399AbcDNO1E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2016 10:27:04 -0400
Date: Thu, 14 Apr 2016 16:26:51 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Hanna Hawa <hannah@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/2] pci: host: new driver for Marvell Armada 7K/8K PCIe
 controller
Message-ID: <20160414162651.6765241a@free-electrons.com>
In-Reply-To: <3196859.0zi20qjiKR@wuerfel>
References: <1459071058-18328-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1459071058-18328-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<3196859.0zi20qjiKR@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Mon, 28 Mar 2016 23:21:57 +0200, Arnd Bergmann wrote:
> On Sunday 27 March 2016 11:30:58 Thomas Petazzoni wrote:
> > +       /* Wait until the link becomes active again */
> > +       while (timeout) {
> > +               if (armada8k_pcie_link_up(pp))
> > +                       break;
> > +               udelay(1);
> > +               timeout--;
> > +       }
> > 
> 
> Why the busy-loop here?
> 
> Maybe just do a single msleep(1) here to wait for the link to
> come up instead?

I've changed the udelay(1) by msleep(1). Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
