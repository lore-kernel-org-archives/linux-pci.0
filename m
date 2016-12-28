Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 28 Dec 2016 10:41:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        nsekhar@ti.com, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] pci: rename *host* directory to *controller*
Message-ID: <20161228164118.GB19653@bhelgaas-glaptop.roam.corp.google.com>
References: <1482912577-31356-1-git-send-email-kishon@ti.com>
 <20161228092228.GA14025@infradead.org>
 <fa775e80-68cc-0d76-855d-c7e64f8bf1fc@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fa775e80-68cc-0d76-855d-c7e64f8bf1fc@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 28, 2016 at 01:57:13PM +0000, Joao Pinto wrote:
> Às 9:22 AM de 12/28/2016, Christoph Hellwig escreveu:
> > On Wed, Dec 28, 2016 at 01:39:37PM +0530, Kishon Vijay Abraham I wrote:
> >> As discussed during our LPC discussions, I'm posting the rename patch
> >> here. I'll post the rest of EP series before the next merge window.
> >>
> >> There might be hiccups because of this renaming but feel this is
> >> necessary for long-term maintenance.
> > 
> > if we do this rename it would be great to get it to Linus NOW after
> > -rc1 as that minimizes the impact on the 4.11 merge window.
> 
> Rename it to controller is a bit vague I thing since we have the PCI Endpoint IP
> also. Wouldn't be better to name it rc_controller?

I think Kishon's whole goal is to add PCI Endpoint IP, so he wants a
neutral name that can cover both RC and Endpoint.

I'm not a huge fan of "controller" because it feels a little bit long
and while I suppose it technically does include the concept of the PCI
interface of an endpoint, it still suggests more of the host side to
me.

Doesn't USB have a similar situation?  I see there's a
drivers/usb/host/ (probably where we copied from in the first place).
Is a USB gadget the USB analog of what you're doing?  How do they
share code between the master/slave sides?

There's a drivers/ntb/hw/.  I don't know if "hw" is the *best* name,
but it's short and it at least conveys the idea that this code is
hardware-specific, not generic.

> >>  drivers/pci/{host => controller}/Kconfig           |    0
> >>  drivers/pci/{host => controller}/Makefile          |    0
> >>  drivers/pci/{host => controller}/pci-aardvark.c    |    0
> >>  drivers/pci/{host => controller}/pci-dra7xx.c      |    0
> >> ...
