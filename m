Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:35070 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbaD1UfL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 28 Apr 2014 16:35:11 -0400
Date: Mon, 28 Apr 2014 14:35:01 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 01/10] PCI: host: rcar: Add Renesas R-Car PCIe driver
Message-ID: <20140428203501.GA3016@obsidianresearch.com>
References: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
 <1396261856-22465-2-git-send-email-phil.edworthy@renesas.com>
 <20140424191901.GE29593@google.com>
 <9b8bedae9d604383ac7ec22fd0f62fdb@HKXPR06MB168.apcprd06.prod.outlook.com>
 <CAErSpo6Autto4n4A4wHtXQNJzD3RKevkVcLZHUods-2-eiRDYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6Autto4n4A4wHtXQNJzD3RKevkVcLZHUods-2-eiRDYQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 28, 2014 at 01:11:08PM -0600, Bjorn Helgaas wrote:

> >> That bus number should be a property of the host bridge, i.e.,
> >> it's either hard-wired into the bridge, or it's programmable somewhere.
> >> But root_bus_nr comes from sys->busnr, which is apparently from some
> >> generic code that knows nothing about this particular host bridge.

> > The manual for this hardware says that the HW doesn't care what the bus number
> > is set to. The only thing the HW needs to know is that when sending config
> > accesses, we need to indicate whether it's a TYPE0 or TYPE1 header; so we use
> > root_bus_nr to determine this. The generic code that sets up sys->busnr (ARM
> > bios32 in this case), just increments bus number for each controller.

I went back and looked at the lspci posted for this hardware and this
use of busnr is kinda sketch..

You should use use bus 0 as the root complex integrated bus number and
ensure every instance of your driver creates a new PCI domain, and
generally use 0-> FF as the subordinate bus number range.

FWIW, your HW does care, and does have a programmable field for
this.

You set the value of the integrated bus based on the bus number in the
TYPE0 accesses the driver performs and it shows up in the PCI config
space of the root port bridge:

root@koelsch:~# lspci -vv
00:00.0 PCI bridge: Renesas Technology Corp. Device 001f (prog-if 00
[Normal decode])
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0

The value here will be also be exported on-the-wire in certain PCI-E
TLPs.

So it is important, and must be set properly.

> Yeah, I guess.  If the HW really doesn't look at the bus number at
> all, it sounds like the range is effectively 00-ff, and each host
> bridge should be in its own domain.

This is where some of the other implementations have used some SW to
route config space in a single domain to the proper controller
per-port register set.

But, IMHO, that is mainly worth doing if the HW can implement the PCI
bridge windows according to the spec, and it looks like rcar requires
a 128MB alignment on the bridge windows, which makes it fairly
pointless.

Jason
