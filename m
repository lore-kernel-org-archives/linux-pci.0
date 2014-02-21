Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37078 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932190AbaBUNrM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 08:47:12 -0500
Date: Fri, 21 Feb 2014 14:47:08 +0100
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
Message-ID: <20140221144708.48559045@skate>
In-Reply-To: <53074584.5010202@keymile.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Gerlando Falauto,

On Fri, 21 Feb 2014 13:24:36 +0100, Gerlando Falauto wrote:

> So I restored the total aperture size to 192MB.
> I had to rework your patch a bit because:
> 
> a) I'm running an older kernel and driver
> b) sizes are actually 1-byte offset

Hum, right. This is a bit weird, maybe I should change that, I don't
think the mvebu-mbus driver should accept 1-byte offset sizes.

> Here's the assignment (same as before):
> 
> pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xebffffff]
> pci 0000:01:00.0: BAR 1: assigned [mem 0xe0000000-0xe7ffffff]
> pci 0000:01:00.0: BAR 3: assigned [mem 0xe8000000-0xe87fffff]
> pci 0000:01:00.0: BAR 4: assigned [mem 0xe8800000-0xe8801fff]
> pci 0000:01:00.0: BAR 0: assigned [mem 0xe8802000-0xe8802fff]
> pci 0000:01:00.0: BAR 2: assigned [mem 0xe8803000-0xe8803fff]
> pci 0000:01:00.0: BAR 5: assigned [mem 0xe8804000-0xe8804fff]
> 
> And here's the output I get from:
> 
> # cat /sys/kernel/debug/mvebu-mbus/devices
> [00] 00000000e8000000 - 00000000ec000000 : pcie0.0 (remap 00000000e8000000)
> [01] disabled
> [02] disabled
> [03] disabled
> [04] 00000000ff000000 - 00000000ff010000 : nand
> [05] 00000000f4000000 - 00000000f8000000 : vpcie
> [06] 00000000fe000000 - 00000000fe010000 : dragonite
> [07] 00000000e0000000 - 00000000e8000000 : pcie0.0

This seems correct: we have two windows pointing to the same device,
and they have consecutive addresses.

> I did not get to test the whole address space thoroughly, but all the 
> BARs are still accessible (mainly BAR0 which contains the control space 
> and is mapped on the "new" MBUS window, and BAR1 which is the "big" 
> one). So at least, the issues we had before are now gone.

Did you check that what you read from BAR0 (which is mapped on the new
MBUS window) is really what you expect, and not just the same thing as
BAR1 accessible for the big window? I just want to make sure that the
hardware indeed properly handles two windows for the same device.

> So I'd say this looks like a very promising approach. :-)

Indeed. However, I don't think this approach solves the entire problem,
for two reasons:

 *) For small BARs that are not power-of-two sized, we may not want to
    consume two windows, but instead consume a little bit more address
    space. Using two windows to map a 96 KB BAR would be a waste of
    windows: using a single 128 KB window is much more efficient.

 *) I don't know if the algorithm to split the BAR into multiple
    windows is going to be trivial.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
