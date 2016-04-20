Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35794 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbcDTTsO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Apr 2016 15:48:14 -0400
Date: Wed, 20 Apr 2016 14:48:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH] PCI: Fix device attach failure handling
Message-ID: <20160420194807.GA22802@localhost>
References: <2c01b1a2d7703fbacae133502cbf6fce335077a9.1459423244.git.lukas@wunner.de>
 <20160419232329.GE17863@localhost>
 <20160420145455.GA15912@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160420145455.GA15912@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 20, 2016 at 04:54:55PM +0200, Lukas Wunner wrote:
> Hi Bjorn,
> 
> On Tue, Apr 19, 2016 at 06:23:29PM -0500, Bjorn Helgaas wrote:
> > On Thu, Mar 31, 2016 at 02:57:48PM +0200, Lukas Wunner wrote:
> > > Linux 4.5 introduced a behavioral change in device probing during the
> > > suspend process with commit 013c074f8642 ("PM / sleep: prohibit devices
> > > probing during suspend/hibernation"): It defers device probing during
> > > the entire suspend process, starting from the prepare phase and ending
> > > with the complete phase. A rule existed before that "we rely on sub-
> > > systems not to do any probing once a device is suspended" but it is
> > > enforced only now (Alan Stern, https://lkml.org/lkml/2015/9/15/908).
> > > 
> > > This resulted in a WARN splat if a PCI device (e.g. Thunderbolt) is
> > > plugged in while the system is asleep: Upon waking up, pciehp_resume()
> > > discovers new devices in the resume phase and immediately tries to bind
> > > them to a driver. Since probing is now deferred, device_attach() returns
> > > -EPROBE_DEFER, which provoked a WARN in pci_bus_add_device().
> > > 
> > > Linux 4.6-rc1 aggravates the situation with commit ab1a187bba5c ("PCI:
> > > Check device_attach() return value always"): pci_bus_add_device() no
> > > longer sets dev->is_added = 1 if device_attach() returned a negative
> > > value. This results in a BUG lockup in pci_bus_add_devices().

What is the connection here?  013c074f8642 causes device_attach() to
return -EPROBE_DEFER, and your patch makes pci_bus_add_device() treat
that as success, so it continues on and sets dev->is_added.

Since we will now set dev->is_added even for -EPROBE_DEFER, why do we
need to change the "BUG_ON(!dev->is_added)" in pci_bus_add_devices()?

I agree that device_attach() might fail for reasons other than
-EPROBE_DEFER, and it might be nice to avoid the BUG_ON then.  It just
seems like those scenarios are different from the -EPROBE_DEFER one.

Sorry I'm being so dense here.  I'm not very familiar with
suspend/resume, so I'm having a hard time following everything.

> > > @@ -294,7 +294,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> > >  
> > >          dev->match_driver = true;
> > >          retval = device_attach(&dev->dev);
> > > -        if (retval < 0) {
> > > +        if (retval < 0 && retval != -EPROBE_DEFER) {
> > >                  dev_warn(&dev->dev, "device attach failed (%d)\n", retval);
> > 
> > I would prefer if the dev_warn() made a distinction between
> > -EPROBE_DEFER and other failures.  It sounds like the -EPROBE_DEFER
> > case will happen in normal operation, and we probably shouldn't treat
> > it as a warning.
> 
> Both v1 and v2 of my fix do not dev_warn() at all on -EPROBE_DEFER since,
> as you've correctly stated above, it happens in normal operation.
> 
> If you want I could add a dev_info() specifically for the -EPROBE_DEFER
> case but personally I don't think it's necessary, it'll probably just
> irritate users.

You're right; sorry, I just wasn't reading your code clearly.  I don't
think we need an extra message.  We should already have messages for
detecting the new device and its BARs, and those should be enough.

Bjorn
