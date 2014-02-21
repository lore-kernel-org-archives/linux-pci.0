Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39261 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754777AbaBUSpG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 13:45:06 -0500
Date: Fri, 21 Feb 2014 19:45:02 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>
Subject: Re: pci-mvebu driver on km_kirkwood
Message-ID: <20140221194502.42d3742d@skate>
In-Reply-To: <53079871.8080801@keymile.com>
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
	<20140221003227.GF19893@obsidianresearch.com>
	<20140221093444.35870a73@skate>
	<5307152D.3020804@keymile.com>
	<20140221101218.45766e8a@skate>
	<53071970.1040400@keymile.com>
	<20140221103936.56b3d9f8@skate>
	<53074584.5010202@keymile.com>
	<20140221144708.48559045@skate>
	<53079871.8080801@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Gerlando Falauto,

On Fri, 21 Feb 2014 19:18:25 +0100, Gerlando Falauto wrote:

> > Hum, right. This is a bit weird, maybe I should change that, I don't
> > think the mvebu-mbus driver should accept 1-byte offset sizes.
> 
> I don't know anything about this, I only know the size dumped is of the 
> form 0x...ffff, that's all.

I'll have to look into this.

> >> # cat /sys/kernel/debug/mvebu-mbus/devices
> >> [00] 00000000e8000000 - 00000000ec000000 : pcie0.0 (remap 00000000e8000000)
> >> [01] disabled
> >> [02] disabled
> >> [03] disabled
> >> [04] 00000000ff000000 - 00000000ff010000 : nand
> >> [05] 00000000f4000000 - 00000000f8000000 : vpcie
> >> [06] 00000000fe000000 - 00000000fe010000 : dragonite
> >> [07] 00000000e0000000 - 00000000e8000000 : pcie0.0
> >
> > This seems correct: we have two windows pointing to the same device,
> > and they have consecutive addresses.
> 
> I don't know how to interpret the (remap ... ) bit, but yes, this looks 
> right to me as well. I just don't know why mbus window 7 gets picked 
> before 0, but apart from that, it looks nice.

Basically, some windows have an additional capability: they are
"remappable". On Kirkwood, the first 4 windows are remappable, and the
last 4 are not. Therefore, unless you request a remappable window, we
allocate a non-remappable one, which is why window 4 to 7 get used
first. And then, even though we don't need the remappable feature for
the last window, there are no more non-remappable windows available, so
window 0 gets allocated for our second PCIe window.

It matches fine with the expected behavior of the mvebu-mbus driver.

> > Did you check that what you read from BAR0 (which is mapped on the new
> > MBUS window) is really what you expect, and not just the same thing as
> > BAR1 accessible for the big window? I just want to make sure that the
> > hardware indeed properly handles two windows for the same device.
> 
> Yes, there's no way the two BARs could be aliased. It's a fairly complex 
> FPGA design, where BAR1 is the huge address space for a PCI-to-localbus 
> bridge (whose connected devices are recognized correctly) and BAR0 is 
> the control BAR (and its registers are read and written without a problem).

Great, so it means that it really works!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
