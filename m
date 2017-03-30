Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935059AbdC3VmX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Mar 2017 17:42:23 -0400
Date: Thu, 30 Mar 2017 16:42:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Having problems resetting a PCI device
Message-ID: <20170330214219.GB28207@bhelgaas-glaptop.roam.corp.google.com>
References: <DM2PR12MB00780139E84F5B961AD4AB6CFE350@DM2PR12MB0078.namprd12.prod.outlook.com>
 <20170329205446.GB31007@bhelgaas-glaptop.roam.corp.google.com>
 <DM2PR12MB00789662208FE959FCBD7AD6FE350@DM2PR12MB0078.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DM2PR12MB00789662208FE959FCBD7AD6FE350@DM2PR12MB0078.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 29, 2017 at 09:41:48PM +0000, Zytaruk, Kelly wrote:
> 
> 
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Wednesday, March 29, 2017 4:55 PM
> > To: Zytaruk, Kelly
> > Cc: linux-pci@vger.kernel.org; Alex Williamson
> > Subject: Re: Having problems resetting a PCI device
> > 
> > Hi Kelly,
> > 
> > On Wed, Mar 29, 2017 at 08:03:33PM +0000, Zytaruk, Kelly wrote:
> > > I have a PCI device that is sitting behind a bridge.
> > >
> > > Under certain reproducible circumstances the PCI device will become
> > > inactive. Reading the PCI config space returns all 0xFFFFFFFF.
> > >
> > > The bridge appears to still be functional. Reading the status from the
> > > bridge I see a Fatal Error due to a Surprise Down event.
> > 
> > Just to be specific, is this the "Surprise Down Error" in the AER uncorrectable
> > error status register?  "lspci -vv" probably decodes all that for you.
> > 
> > > I am trying to figure out how to bring the device back online.
> > >
> > > I tried toggling the secondary bus reset bit of the Bridge Control
> > > Register but it doesn't appear to make any difference. I still see
> > > 0xFFFFFFFF in the device config space.
> > 
> > Are you calling pci_reset_function() or doing this by hand?
> > pci_reset_function() tries several different strategies, one of which is toggling
> > the secondary bus reset bit.
> 
> I just read the documentation for the call and this could be a problem
> "The PCI device must be responsive  to PCI config space in order to use this function."
> 
> In my case reading PCI config space returns all 0xFFFFFFFF

I think Surprise Down means the link is down, so you won't be able to
reach the device at all until it gets reset.

But the secondary bus reset is done by the switch port immediately
upstream from the device, so that should still work.  If the device
still doesn't work after doing a secondary bus reset, maybe there's a
device defect related to reset.

That port (a Root Port or Switch Downstream Port) is probably where
the Surprise Down error was logged.  If you have CONFIG_PCIEAER turned
on, I think the kernel should log some stuff in dmesg, hopefully
including the error type and something that identifies the link.  Do
you see any of that?

If you don't have CONFIG_PCIEAER turned on, you should be able to use
lspci to look at what's logged in the AER capability.  Unfortunately,
lspci doesn't know how to decode everything, but you can use
"lspci -xxxx" to look at it and decode things manually.

> > > I provided a pci_error_handler but the error_detected() function is
> > > not getting called.
> > 
> > Do you have CONFIG_PCIEAER turned on?  I would naively expect AER to log
> > something and call your error_detected() function if this error occurs (but I
> > haven't looked at the code for a long time).


> > > Given that these two methods are not helping me out what other choices
> > > do I have to either reset the PCI device or hot-plug the device from a
> > > kernel driver. Or some other method of bring the device back to life.

You should be able to "echo 1 > /sys/bus/pci/devices/.../remove" to
hot-unplug the device, then "echo 1 > /sys/bus/pci/rescan" to
rediscover it.

Bjorn
