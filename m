Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:55425 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076AbaBUAc3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 20 Feb 2014 19:32:29 -0500
Date: Thu, 20 Feb 2014 17:32:27 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: pci-mvebu driver on km_kirkwood
Message-ID: <20140221003227.GF19893@obsidianresearch.com>
References: <53039894.10905@keymile.com>
 <20140218212751.07c2aeb5@skate>
 <53046D98.6020801@keymile.com>
 <20140219102658.76eec91e@skate>
 <53047BBB.6040108@keymile.com>
 <20140219143749.65ff3155@skate>
 <CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
 <20140220095518.7ca36f0a@skate>
 <20140220173518.GA19893@obsidianresearch.com>
 <20140220212914.29ddc031@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140220212914.29ddc031@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 20, 2014 at 09:29:14PM +0100, Thomas Petazzoni wrote:

> In practice, the story is a little bit more subtle than that: the PCIe
> driver may want to decide to either tell the PCI core to enlarge the
> window BAR up to the next power of two size, or to dedicate two windows
> to it.

That is a smart, easy solution! Maybe that is the least invasive way
to proceed for now?

I have no idea how you decide when to round up and when to allocate
more windows, that feels like a fairly complex optimization problem!

Alternatively, I suspect you can use the PCI quirk mechanism to alter
the resource sizing on a bridge?

> Jason, would you mind maybe replying to Bjorn Helgaas email (Thu, 20
> Feb 2014 12:18:42 -0700) ? I believe that a lot of the misunderstanding
> between Bjorn and me is due to the fact that I don't use the correct
> PCI terminology to describe how the Marvell hardware works, and how the
> Marvell PCIe driver copes with it. I'm sure you would explain it in a
> way that would be more easily understood by someone very familiar with
> the PCI terminology such as Bjorn. Thanks a lot!

Done!

Hope it helps,
Jason
