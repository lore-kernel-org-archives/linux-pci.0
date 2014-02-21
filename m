Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59791 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664AbaBUT4k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Feb 2014 14:56:40 -0500
Message-ID: <1393012403.6771.89.camel@pasglop>
Subject: Re: pci-mvebu driver on km_kirkwood
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 22 Feb 2014 06:53:23 +1100
In-Reply-To: <CAErSpo5c=iMHM_uATxsiUthaHtt-UvX6ySQx2pVgfJT4ABuWGQ@mail.gmail.com>
References: <20130711163220.2b3adf38@skate> <53039894.10905@keymile.com>
	 <20140218212751.07c2aeb5@skate> <53046D98.6020801@keymile.com>
	 <20140219102658.76eec91e@skate> <53047BBB.6040108@keymile.com>
	 <20140219143749.65ff3155@skate>
	 <CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
	 <20140220095518.7ca36f0a@skate>
	 <CAErSpo5pG3eOG58MiCCOHgr_jQReH0uBnWQFvzQYg3qrOGpZEw@mail.gmail.com>
	 <20140221002438.GE19893@obsidianresearch.com>
	 <CAErSpo5c=iMHM_uATxsiUthaHtt-UvX6ySQx2pVgfJT4ABuWGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2014-02-21 at 12:05 -0700, Bjorn Helgaas wrote:
> But I wonder if powerpc has a similar issue here: I think EEH might
> need, for example 16MB bridge window alignment.  Since
> pcibios_window_alignment() only affects the *starting* address, could
> the core assign a 9MB window whose starting address is 16MB-aligned?
> Could EEH deal with that?  What if the PCI core assigned the space
> right after the 9MB window to another device?

Gavin, did you guys deal with that at all ? Are we aligning the size as
well somewhat ?

Cheers,
Ben.


