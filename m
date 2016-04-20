Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:54653 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbcDTOwc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2016 10:52:32 -0400
Date: Wed, 20 Apr 2016 16:54:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH] PCI: Fix device attach failure handling
Message-ID: <20160420145455.GA15912@wunner.de>
References: <2c01b1a2d7703fbacae133502cbf6fce335077a9.1459423244.git.lukas@wunner.de>
 <20160419232329.GE17863@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160419232329.GE17863@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Tue, Apr 19, 2016 at 06:23:29PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 31, 2016 at 02:57:48PM +0200, Lukas Wunner wrote:
> > Linux 4.5 introduced a behavioral change in device probing during the
> > suspend process with commit 013c074f8642 ("PM / sleep: prohibit devices
> > probing during suspend/hibernation"): It defers device probing during
> > the entire suspend process, starting from the prepare phase and ending
> > with the complete phase. A rule existed before that "we rely on sub-
> > systems not to do any probing once a device is suspended" but it is
> > enforced only now (Alan Stern, https://lkml.org/lkml/2015/9/15/908).
> > 
> > This resulted in a WARN splat if a PCI device (e.g. Thunderbolt) is
> > plugged in while the system is asleep: Upon waking up, pciehp_resume()
> > discovers new devices in the resume phase and immediately tries to bind
> > them to a driver. Since probing is now deferred, device_attach() returns
> > -EPROBE_DEFER, which provoked a WARN in pci_bus_add_device().
> > 
> > Linux 4.6-rc1 aggravates the situation with commit ab1a187bba5c ("PCI:
> > Check device_attach() return value always"): pci_bus_add_device() no
> > longer sets dev->is_added = 1 if device_attach() returned a negative
> > value. This results in a BUG lockup in pci_bus_add_devices().
> 
> If this fixes a BUG() that we introduced in v4.6-rc1, it sounds like we
> should fix it before v4.6-final.  Please confirm.

Affirmative.


> > Fix the latter by not recursing to a child bus if device_attach() failed
> > for the bridge leading to it.
> > 
> > Fix the former by not interpreting -EPROBE_DEFER as failure. The device
> > will be probed eventually and there is proper locking in place to avoid
> > races (e.g. if devices are unplugged again und thus deleted from the
> > system before deferred probing happens, I have tested this). Also, those
> > functions which dereference dev->driver (e.g. pci_pm_*()) do contain
> > proper NULL pointer checks. So it seems safe to ignore -EPROBE_DEFER.
> 
> This looks like two different bug fixes.  Can you split them into
> separate patches, or is there a reason to combine them?

The two bugs are related but the fix can be split in two, which I've
just done and sent to the list as v2.


> > Note that even postponing the code in pciehp_resume() until the
> > complete phase wouldn't avoid these troubles because dpm_complete()
> > calls device_unblock_probing() only after ->complete has been
> > executed for all devices. We lack a pm hook from which it would
> > be safe to check a hotplug port and call device_attach() without
> > risking -EPROBE_DEFER.
> > 
> > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > ---
> >  drivers/pci/bus.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> > index 6c9f546..dd7cdbe 100644
> > --- a/drivers/pci/bus.c
> > +++ b/drivers/pci/bus.c
> > @@ -294,7 +294,7 @@ void pci_bus_add_device(struct pci_dev *dev)
> >  
> >  	dev->match_driver = true;
> >  	retval = device_attach(&dev->dev);
> > -	if (retval < 0) {
> > +	if (retval < 0 && retval != -EPROBE_DEFER) {
> >  		dev_warn(&dev->dev, "device attach failed (%d)\n", retval);
> 
> I would prefer if the dev_warn() made a distinction between
> -EPROBE_DEFER and other failures.  It sounds like the -EPROBE_DEFER
> case will happen in normal operation, and we probably shouldn't treat
> it as a warning.

Both v1 and v2 of my fix do not dev_warn() at all on -EPROBE_DEFER since,
as you've correctly stated above, it happens in normal operation.

If you want I could add a dev_info() specifically for the -EPROBE_DEFER
case but personally I don't think it's necessary, it'll probably just
irritate users.


> >  		pci_proc_detach_device(dev);
> >  		pci_remove_sysfs_dev_files(dev);
> > @@ -324,7 +324,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
> >  	}
> >  
> >  	list_for_each_entry(dev, &bus->devices, bus_list) {
> > -		BUG_ON(!dev->is_added);
> > +		/* Skip if device attach failed */
> > +		if (!dev->is_added)
> > +			continue;
> 
> I assume the "pci_bus_add_devices(child)" will happen *eventually*?
> Can you add a comment about when that is?

At the end of dpm_complete(), device_unblock_probing() is called and
this will reprobe anything that's ended up on the deferred probing list.
In other words, deferred probing happens right after ->complete has
been called for all devices.

I've amended the commit message of patch [2/2] in v2 to clarify this.

Let me know if you want anything else changed. If you send a pull with
these to Linus, please consider including the thunderbolt double-free
patch posted by Andreas Noever with:

    Subject: [PATCH] thunderbolt: Fix double free of drom buffer
    Message-Id: <1460285307-3557-1-git-send-email-andreas.noever@gmail.com>
    Date: Sun, 10 Apr 2016 12:48:27 +0200

Thank you!

Lukas

> >  		child = dev->subordinate;
> >  		if (child)
> >  			pci_bus_add_devices(child);
> > -- 
> > 2.8.0.rc3
