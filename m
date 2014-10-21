Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933458AbaJUVci (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Oct 2014 17:32:38 -0400
Message-ID: <1413927152.4202.195.camel@ul30vt.home>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through
 (vfio)
From: Alex Williamson <alex.williamson@redhat.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Date: Tue, 21 Oct 2014 15:32:32 -0600
In-Reply-To: <1413925580.4202.189.camel@ul30vt.home>
References: <20140923210318.498dacbd@dualc.maya.org>
	 <1411502866.24563.8.camel@ul30vt.home> <5437A958.3000201@maya.org>
	 <CAErSpo5kkk4itqqmCMU=08-XMcDknur8VY++F3A2LajdvTptOA@mail.gmail.com>
	 <5437F1F5.3010706@maya.org>
	 <CAErSpo6DuWEcJb_gfS=5JnKN8b4DXXV9+u-CRa8m3db0dbzpsQ@mail.gmail.com>
	 <543804BC.3080307@maya.org>
	 <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>
	 <20141011003219.560cca97@dualc.maya.org>
	 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org>
	 <1413360267.4202.70.camel@ul30vt.home> <54406B34.1050808@maya.org>
	 <1413925580.4202.189.camel@ul30vt.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2014-10-21 at 15:06 -0600, Alex Williamson wrote:
> Hi Andreas,
> 
> On Fri, 2014-10-17 at 03:04 +0200, Andreas Hartmann wrote:
> > Hello Alex,
> > 
> > Alex Williamson wrote:
> > > Hi Andreas,
> > [...]
> > > Sorry for the breakage.  Is it possible to run lspci on the device in a
> > > loop from the host and capture whether we're failing to restore some of
> > > the VC bits to their previous state? 
> > 
> > > Does the problem also occur if you
> > > unbind from host driver,
> > 
> > The machine is booted w/ blacklisted ath9k. Then, the device is bound to
> > vfio:
> > 
> > echo "168c 0030" > /sys/bus/pci/drivers/vfio-pci/new_id
> > echo 0000:03:00.0 > /sys/bus/pci/devices/0000:03:00.0/driver/unbind
> > echo 0000:03:00.0 > /sys/bus/pci/drivers/vfio-pci/bind
> > 
> > afterwards the VM is started -> hang.
> > 
> > W/o starting th VM, I can bind it to vfio and unbind it from vfio w/o
> > any problem.
> > 
> > > echo 1 > reset in pci-sysfs,
> > 
> > echo 1 > /sys/bus/pci/devices/0000:03:00.0 works w/o any problem while
> > bound to vfio. Even after unbinding from vfio and rebinding to vfio
> > again ... .
> > 
> > > and re-bind to the
> > 
> > Do you mean loading ath9k in host system after unbinding from vfio? If
> > yes: Works w/o any problem. It's even possible to reset it or do a
> > ifconfig wlan0 up, ifconfig wlan0 down, rmmod ath9k, bind it to vfio
> > again and reset it, ....
> > 
> > Looks like the hang only is triggered by qemu-system_x86_64 on startup
> > the VM.

Also, this might be because QEMU since 1.7 will favor doing a bus reset
for a device over PM reset while the sysfs reset interface will only do
a bus reset if there are no other methods available and there are no
other devices on the bus.  Can you reproduce the hang using the sysfs
reset interface without QEMU if you modify the kernel like this:

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3308,15 +3308,15 @@ static int __pci_dev_reset(struct pci_dev *dev, int prob
        if (rc != -ENOTTY)
                goto done;
 
-       rc = pci_pm_reset(dev, probe);
+       rc = pci_dev_reset_slot_function(dev, probe);
        if (rc != -ENOTTY)
                goto done;
 
-       rc = pci_dev_reset_slot_function(dev, probe);
+       rc = pci_parent_bus_reset(dev, probe);
        if (rc != -ENOTTY)
                goto done;
 
-       rc = pci_parent_bus_reset(dev, probe);
+       rc = pci_pm_reset(dev, probe);
 done:
        return rc;
 }



> > > host?  I'll also try to reproduce on my 990fx system, but I won't be
> > > able to do that until next week due to travel.  Thanks,
> 
> Could you send me the lspci -vvvxxxx for the device and parent root
> port?  Thanks,
> 
> Alex
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



