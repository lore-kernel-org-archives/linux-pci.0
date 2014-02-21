Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:50187 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932469AbaBURbM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 21 Feb 2014 12:31:12 -0500
Date: Fri, 21 Feb 2014 10:31:05 -0700
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gerlando Falauto <gerlando.falauto@keymile.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Gregory Cl??ment <gregory.clement@free-electrons.com>
Subject: Re: pci-mvebu driver on km_kirkwood
Message-ID: <20140221173105.GA17611@obsidianresearch.com>
References: <20140221003227.GF19893@obsidianresearch.com>
 <20140221093444.35870a73@skate>
 <5307152D.3020804@keymile.com>
 <20140221101218.45766e8a@skate>
 <53071970.1040400@keymile.com>
 <20140221103936.56b3d9f8@skate>
 <53074584.5010202@keymile.com>
 <20140221144708.48559045@skate>
 <20140221163902.GB4706@obsidianresearch.com>
 <20140221180508.7ed6cfaf@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140221180508.7ed6cfaf@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 21, 2014 at 06:05:08PM +0100, Thomas Petazzoni wrote:
 
> Now I have another question: our mvebu_pcie_align_resource() function
> makes sure that the base address of the BAR is aligned on its size,
> because it is a requirement of MBus windows. However, if you later
> split the BAR into multiple windows, will this continue to work out?

No, you must align to (1 << log2_round_down(size)) - that will always
be the largest mbus window created and thus the highest starting
alignment requirement.

I looked for a bit to see if I could find why the core is rounding up
to 196MB and it wasn't clear to me either.

Gerlando, if you instrument the code in setup-bus.c, particularly
pbus_size_mem, you will probably find out.

Jason
