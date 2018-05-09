Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 9 May 2018 07:57:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Paul Menzel <pmenzel+linux-pci@molgen.mpg.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>
Subject: Re: pciehp 0000:00:1c.0:pcie004: Timeout on hotplug command 0x1038
 (issued 65284 msec ago)
Message-ID: <20180509125752.GA234395@bhelgaas-glaptop.roam.corp.google.com>
References: <8770820b-85a0-172b-7230-3a44524e6c9f@molgen.mpg.de>
 <20180427192207.GG8199@bhelgaas-glaptop.roam.corp.google.com>
 <20180509114124.GA20639@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180509114124.GA20639@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 09, 2018 at 01:41:24PM +0200, Lukas Wunner wrote:
> On Fri, Apr 27, 2018 at 02:22:07PM -0500, Bjorn Helgaas wrote:
> > Sinan mooted the idea of using a "no-wait" path of sending the "don't
> > generate hotplug interrupts" command.  I think we should work on this
> > idea a little more.  If we're shutting down the whole system, I can't
> > believe there's much value in *anything* we do in the pciehp_remove()
> > path.
> > 
> > Maybe we should just get rid of pciehp_remove() (and probably
> > pcie_port_remove_service() and the other service driver remove methods)
> > completely.  That dates from when the service drivers could be modules that
> > could be potentially unloaded, but unloading them hasn't been possible for
> > years.
> 
> Every Thunderbolt device contains a PCIe switch with at least one
> (downstream) hotplug port, so pciehp_remove() is executed on unplug
> of a Thunderbolt device and the assumption that it's unnecessary
> simply because it's builtin isn't correct.

I agree that simply being builtin isn't a sufficient argument for getting
rid of pciehp_remove().

But if we do need pciehp_remove(), we should be able to make a rational
case for why that is.  If we're about to turn off the power, it's not
obvious why we would need to deallocate memory, remove sysfs stuff, etc.
If we need to configure the hardware to make it easier for a kexec'd
kernel, that's a possible argument but we should make it explicit.

Bjorn
