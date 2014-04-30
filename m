Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:60398 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757983AbaD3KdO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 30 Apr 2014 06:33:14 -0400
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 01/10] PCI: host: rcar: Add Renesas R-Car PCIe driver
Date: Wed, 30 Apr 2014 10:33:08 +0000
Message-ID: <ac795ce3bb6349708e2e96686e19d24f@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
 <1396261856-22465-2-git-send-email-phil.edworthy@renesas.com>
 <20140424191901.GE29593@google.com>
 <9b8bedae9d604383ac7ec22fd0f62fdb@HKXPR06MB168.apcprd06.prod.outlook.com>
 <CAErSpo6Autto4n4A4wHtXQNJzD3RKevkVcLZHUods-2-eiRDYQ@mail.gmail.com>
 <20140428203501.GA3016@obsidianresearch.com>
In-Reply-To: <20140428203501.GA3016@obsidianresearch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jason,

On 28 April 2014 21:35, Jason wrote:
> On Mon, Apr 28, 2014 at 01:11:08PM -0600, Bjorn Helgaas wrote:
> 
> > >> That bus number should be a property of the host bridge, i.e.,
> > >> it's either hard-wired into the bridge, or it's programmable somewhere.
> > >> But root_bus_nr comes from sys->busnr, which is apparently from
> some
> > >> generic code that knows nothing about this particular host bridge.
> 
> > > The manual for this hardware says that the HW doesn't care what the bus
> number
> > > is set to. The only thing the HW needs to know is that when sending
> config
> > > accesses, we need to indicate whether it's a TYPE0 or TYPE1 header; so
> we use
> > > root_bus_nr to determine this. The generic code that sets up sys->busnr
> (ARM
> > > bios32 in this case), just increments bus number for each controller.
> 
> I went back and looked at the lspci posted for this hardware and this
> use of busnr is kinda sketch..
> 
> You should use use bus 0 as the root complex integrated bus number and
> ensure every instance of your driver creates a new PCI domain, and
> generally use 0-> FF as the subordinate bus number range.
> 
> FWIW, your HW does care, and does have a programmable field for
> this.
> 
> You set the value of the integrated bus based on the bus number in the
> TYPE0 accesses the driver performs and it shows up in the PCI config
> space of the root port bridge:
> 
> root@koelsch:~# lspci -vv
> 00:00.0 PCI bridge: Renesas Technology Corp. Device 001f (prog-if 00
> [Normal decode])
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 
> The value here will be also be exported on-the-wire in certain PCI-E
> TLPs.
> 
> So it is important, and must be set properly.
I am not so sure about this... 

There are three things we need to consider:
1) talking to the host bridge itself
2) talking to immediate device (connected directly to host bridge)
3) talking to other devices

The PCI standard tells us we use type 1's for 3) and type 0's for 2). The driver uses root_bus_nr to make this decision.
For 1), there is a note in the driver that the hardware cannot target itself. The driver has code in rcar_pcie_config_access() to check if it's an access to the host bridge, and if so, use I/O (readl/writel) to perform the config access.

> > Yeah, I guess.  If the HW really doesn't look at the bus number at
> > all, it sounds like the range is effectively 00-ff, and each host
> > bridge should be in its own domain.
> 
> This is where some of the other implementations have used some SW to
> route config space in a single domain to the proper controller
> per-port register set.
> 
> But, IMHO, that is mainly worth doing if the HW can implement the PCI
> bridge windows according to the spec, and it looks like rcar requires
> a 128MB alignment on the bridge windows, which makes it fairly
> pointless.
> 
> Jason

Thanks
Phil
