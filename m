Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:39581 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756425Ab3EVOzf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 May 2013 10:55:35 -0400
Date: Wed, 22 May 2013 16:55:29 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/4] pci: mvebu: emulate an empty capability list
Message-ID: <20130522165529.64174e06@skate>
In-Reply-To: <CAErSpo6gFf9ou-VtZ=F0+1GqcSoPS_dDMGphhgv=8mD602=BRA@mail.gmail.com>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1369228358-32580-4-git-send-email-thomas.petazzoni@free-electrons.com>
	<CAErSpo6gFf9ou-VtZ=F0+1GqcSoPS_dDMGphhgv=8mD602=BRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Wed, 22 May 2013 08:39:03 -0600, Bjorn Helgaas wrote:

> > emulation to emulate an empty capability list. It might be later
> > extended to expose things like the PCI Express Capability header, but
> > an empty capability list is sufficient for now.
> >
> > lspci -v now shows the much nicer:
> >
> >   Capabilities: [40] #00 [0000]
> 
> It'd be even better if you could make the Capabilities List bit in the
> Device Status register be zero.  Then lspci wouldn't even try to read
> the Capabilities Pointer at 0x34, and you wouldn't have to deal with
> reads of 0x40.

The Device Status register is emulated with an initial value of zero.
Then, whenever the Linux PCI core writes into it, those writes are
preserved. So to me, it looks like the Linux PCI core might be setting
this Capabilities List bit, and later re-reads it and finds it to be
set to 1.

Should this bit be emulated as a read-only bit (it's not made explicit
for this particular bit in the PCI-to-PCI bridge specification that I
have in front of me) ? Or even the entire Device Status register ?

Thanks for your comments!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
