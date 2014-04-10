Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40027 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758589AbaDJQVK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Apr 2014 12:21:10 -0400
Date: Thu, 10 Apr 2014 18:19:53 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Fixing PCIe issues on Armada XP
Message-ID: <20140410181953.50ccfcc3@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello all,

This is an e-mail that attempts to summarize the situation in terms of
Armada XP PCIe issues.

At
https://github.com/MISL-EBU-System-SW/mainline-public/commits/3.14/pci-debug,
I've pushed a branch based on top of v3.14 that contains:

 * 2 backports for the igb driver, needed to get the igb driver to work
   in situations where MSI-X support is not available. These patches
   are already in mainline (post v3.14), and I've sent a mail to the
   maintainers and the netdev@ mailing list to ask for these patches to
   be pushed to 3.14 stable.

 * 3 backports of patches that use the 0xf1000000 internal register
   address for Armada XP development boards. These are needed for me
   because I have a recent Marvell bootloader. You may or may not want
   to apply these patches depending on which Marvell board you're
   using, and which version of the bootloader you have.

 * 3 patches on the irq-armada-370-xp driver, to fix the MSI support.
   One from Neil Greatorex, two from me.

 * 2 patches on the mvebu-mbus driver. One from Jason Gunthorpe which
   adds loud warnings when a non power-of-two window size is requested,
   and one from me to allow the creation of several windows having the
   same target and attribute values, which is needed if we want to
   create multiple windows to describe a single PCI BAR.

 * 2 patches on the pci-mvebu driver. One from Willy Tarreau to fix the
   off by one on the sizes. And another one from me which splits the
   PCI BAR into power-of-two sized chunks, in order to create valid
   MBus windows. I've tested this with my IGB card which needs a 9 MB
   BAR (so 8 MB + 1 MB needed), and I've also faked the code to code to
   simulate a 11.5 MB BAR (so 8 + 2 + 1 + 0.5 MB), and it worked. I
   also checked that if we have an error when creating one of the
   windows, then all the previous windows needed for the current BAR
   are properly removed.

Can you test this stack of patches on your system and configuration, and
let me know if that works for you? Of course, please do not include any
other PCI related fix: the goal is to be aware of *all* the issues, and
fix them in mainline.

Gerlando: I remember you also had a power-of-two related issues, that
you reported a while ago. This patch series should fix it. Would it be
possible for you to test this patch series?

Remaining issues:

 * The link up problem. Unfortunately, I tried to reproduce it today,
   and didn't manage to. It's weird, because I'm sure I was able to
   produce it in the past, but I'm no longer able to, I don't know.
   Therefore, it's not easy for me to work on this topic. Neil, Jason,
   do you think this is a topic you could potentially handle?

 * On my Armada XP DB board, if I plug 5 PCIe cards, the IGB card for
   some reason isn't able to read data from its non-volatile memory. So
   the window points to something, but it doesn't seem to patch what
   the igb driver expects. I've double checked the MBus windows, and
   they look correct. I haven't tested this PCIe configuration with the
   Marvell LSP though, so maybe I'm hitting an unrelated hardware
   problem or something.

Thanks a lot for your feedback and participation around these PCIe
issues!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
