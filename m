Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us02smtp1.synopsys.com ([198.182.60.75]:42882 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab2BHUnw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2012 15:43:52 -0500
From: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
To: "balbi@ti.com" <balbi@ti.com>
CC: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date: Wed, 8 Feb 2012 12:43:51 -0800
Subject: RE: [PATCH 4/4] usb: dwc3: second part of hibernation support
Message-ID: <F6C4814A9B336243ABC3D1FB44E08AE801D5678673@US01WXMBX1.internal.synopsys.com>
References: <cover.1328582753.git.paulz@synopsys.com>
 <9c4ee1f156d28640bc43dee647e3470b9e1b9f37.1328582753.git.paulz@synopsys.com>
 <20120207070322.GB3707@legolas.emea.dhcp.ti.com>
 <F6C4814A9B336243ABC3D1FB44E08AE801D5677E3A@US01WXMBX1.internal.synopsys.com>
 <20120207201742.GA10970@legolas.emea.dhcp.ti.com>
 <F6C4814A9B336243ABC3D1FB44E08AE801D5677FC6@US01WXMBX1.internal.synopsys.com>
 <20120208061452.GF3707@legolas.emea.dhcp.ti.com>
In-Reply-To: <20120208061452.GF3707@legolas.emea.dhcp.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Tuesday, February 07, 2012 10:15 PM
> 
> On Tue, Feb 07, 2012 at 02:19:49PM -0800, Paul Zimmerman wrote:
> > >
> > > OK, I will poke around and see if I can find an existing driver to use as
> > > an example.
> >
> > Hi Felipe,
> >
> > Can you explain a little about how the runtime_pm stuff will work in
> > the DWC3 driver, disregarding the HAPS platform for now.
> >
> > For example, if the device is a PCI device, won't the PM ops need to
> > be part of the struct pci_driver in the dwc3-pci module?
> >
> > If so, how will they be able to communicate with the routines in the
> > dwc3 module? Or if not, how will that work exactly?
> 
> Ok, the way it works is that the e.g. PCI device is a parent device to
> the DWC3. So, in fact, you will end up with two pm ops: one that only
> knows about DWC3 and one that only knows about PCI.
> 
> The pm core guarantees that parent's e.g. runtime_suspend(), will only
> be called after all children (in this case, only one) are suspended.
> Likewise for resume.
> 
> So, what we need to do is to make one pm ops that knows everything the
> power management features on DWC3 and another which knows about PCI,
> then hook them up properly and whenever pm usage counter reaches zero,
> dwc3's runtime_suspend() is called, then after that dwc3-pci's
> runtime_suspend() will be called.

Thank you! That was the piece of the puzzle that was missing. OK,
I'll take a crack at implementing the pm ops for dwc3 and dwc3-pci.

> Just keep in mind that glue layer also needs to keep track of its own
> usage counters, what I mean by that, is that on dwc3-pci probe you
> should probably call pm_runtime_get_sync() and right before returning
> from probe, you call pm_runtime_put(). This will make sure that the PCIe
> device is powered up when you need and can be autosuspended when you
> don't need it anymore.

I see that Alan had a correction to this part in a later email.

-- 
Paul

