Return-Path: <SRS0=jRHk=46=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=jRHk=46=chromium.org=briannorris@kernel.org>
Date: Wed, 24 May 2017 14:43:50 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: check link status when validating device
Message-ID: <20170524214349.GA22374@google.com>
References: <1495177107-203736-1-git-send-email-shawn.lin@rock-chips.com>
 <20170523194443.GD7241@bhelgaas-glaptop.roam.corp.google.com>
 <c2331eef-b76d-720d-3750-6d754d53710a@rock-chips.com>
 <20170524011507.GA112603@google.com>
 <20170524213353.GB2794@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170524213353.GB2794@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 24, 2017 at 04:33:53PM -0500, Bjorn Helgaas wrote:
> On Tue, May 23, 2017 at 06:15:07PM -0700, Brian Norris wrote:
> > (Since Shawn didn't quite answer this piece)
> > 
> > On Wed, May 24, 2017 at 09:04:33AM +0800, Shawn Lin wrote:
> > > 在 2017/5/24 3:44, Bjorn Helgaas 写道:
> > > >What bad things happen without this patch?
> > 
> > On this SoC, I've seen this sort of behavior (reading the config space
> > when the device isn't responding) yield aborts, which panic the system. 
> 
> Trying to read config space of a device that doesn't exist is an
> essential part of enumeration, and we expect whatever error occurs at
> the hardware level to get turned into 0xffffffff data at the CPU (as
> in pci_bus_read_dev_vendor_id()).

Understood.

> Shawn mentioned some issue with memory read/write as well.  I think we
> need to sort out how to handle both the config space issue and the
> memory issue.

Is the memory space issue actually a problem? I don't see anything in
the spec that says how these should behave when the device is off.

(I mean, it's always nice if there are fewer ways to crash the system.
But I thought mem 0xffffffff was only a convention, not a standard.)

> This patch seems like it papers over part of it and
> reduces the urgency of finding a real solution.

I've been bugging Shawn about this for a while already. It's not clear
there's really a good solution so far, apart from hacking the arch
exception handlers, like you're doing in the imx6 driver:

commit 415b6185c541dc0a21457ff307cdb61950a6eb9f
Author: Lucas Stach <l.stach@pengutronix.de>
Date:   Mon May 22 17:06:30 2017 -0500

    PCI: imx6: Fix config read timeout handling

I don't think the ARM64 maintainers have been fond of adding similar
"hook" code...

> I'm going to drop this for now, pending a more detailed explanation.

Fine with me.

Brian
