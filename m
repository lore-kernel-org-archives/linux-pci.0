Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62900 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932328AbaJVUhE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Oct 2014 16:37:04 -0400
Message-ID: <1414010215.4202.275.camel@ul30vt.home>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass through
 (vfio)
From: Alex Williamson <alex.williamson@redhat.com>
To: Andreas Hartmann <andihartmann@freenet.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Date: Wed, 22 Oct 2014 14:36:55 -0600
In-Reply-To: <5447D9D9.9030909@maya.org>
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
	 <1413927152.4202.195.camel@ul30vt.home> <5447D9D9.9030909@maya.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-10-22 at 18:22 +0200, Andreas Hartmann wrote:
> Alex Williamson wrote:
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3308,15 +3308,15 @@ static int __pci_dev_reset(struct pci_dev *dev, int prob
> >         if (rc != -ENOTTY)
> >                 goto done;
> >  
> > -       rc = pci_pm_reset(dev, probe);
> > +       rc = pci_dev_reset_slot_function(dev, probe);
> >         if (rc != -ENOTTY)
> >                 goto done;
> >  
> > -       rc = pci_dev_reset_slot_function(dev, probe);
> > +       rc = pci_parent_bus_reset(dev, probe);
> >         if (rc != -ENOTTY)
> >                 goto done;
> >  
> > -       rc = pci_parent_bus_reset(dev, probe);
> > +       rc = pci_pm_reset(dev, probe);
> >  done:
> >         return rc;
> >  }
> 
> This way it's crashing with echo 1 > reset, too.

Ok, so it's somehow related to doing a bus reset with virtual channel
save/restore while PM reset with VC save/restore works ok as apparently
does bus reset without VC save/restore.  Let's try to do a manual bus
reset so we can look at the post reset state of the device before the
kernel tries to restore it.

First bind the target device 03:00.0 to pci-stub or vfio-pci so that we
know it's not being used.

Next capture lspci -xxxx -s 3:00.0 so we have the starting state.

Then we'll do a bus reset using setpci:
# setpci -s 00:05.0 3e.w=40:40
<if you script this, wait at least 2ms here>
# setpci -s 00:05.0 3e.w=00:40
<wait 1 second here>

Now re-capture lspci -xxxx -s 3:00.0

The interesting lines for your device are 140: and 150:, so if you want
to avoid sending massive emails you can just send those for the before
and after.  You'll need to reboot the system before you do anything else
with this device since it's now in an uninitialized state.  Based on
what the lspci output reports (or whether you experience a hang simply
from this), we may want to try writing additional bits with setpci to
mimic the VC restore behavior.  Thanks,

Alex

