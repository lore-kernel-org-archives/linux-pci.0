Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout2.freenet.de ([195.4.92.92]:58039 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322AbaJQBLe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 16 Oct 2014 21:11:34 -0400
Message-ID: <54406B34.1050808@maya.org>
Date: Fri, 17 Oct 2014 03:04:52 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass
 through (vfio)
References: <20140923210318.498dacbd@dualc.maya.org>	 <1411502866.24563.8.camel@ul30vt.home> <5437A958.3000201@maya.org>	 <CAErSpo5kkk4itqqmCMU=08-XMcDknur8VY++F3A2LajdvTptOA@mail.gmail.com>	 <5437F1F5.3010706@maya.org>	 <CAErSpo6DuWEcJb_gfS=5JnKN8b4DXXV9+u-CRa8m3db0dbzpsQ@mail.gmail.com>	 <543804BC.3080307@maya.org>	 <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>	 <20141011003219.560cca97@dualc.maya.org>	 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org> <1413360267.4202.70.camel@ul30vt.home>
In-Reply-To: <1413360267.4202.70.camel@ul30vt.home>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Alex,

Alex Williamson wrote:
> Hi Andreas,
[...]
> Sorry for the breakage.  Is it possible to run lspci on the device in a
> loop from the host and capture whether we're failing to restore some of
> the VC bits to their previous state? 

> Does the problem also occur if you
> unbind from host driver,

The machine is booted w/ blacklisted ath9k. Then, the device is bound to
vfio:

echo "168c 0030" > /sys/bus/pci/drivers/vfio-pci/new_id
echo 0000:03:00.0 > /sys/bus/pci/devices/0000:03:00.0/driver/unbind
echo 0000:03:00.0 > /sys/bus/pci/drivers/vfio-pci/bind

afterwards the VM is started -> hang.

W/o starting th VM, I can bind it to vfio and unbind it from vfio w/o
any problem.

> echo 1 > reset in pci-sysfs,

echo 1 > /sys/bus/pci/devices/0000:03:00.0 works w/o any problem while
bound to vfio. Even after unbinding from vfio and rebinding to vfio
again ... .

> and re-bind to the

Do you mean loading ath9k in host system after unbinding from vfio? If
yes: Works w/o any problem. It's even possible to reset it or do a
ifconfig wlan0 up, ifconfig wlan0 down, rmmod ath9k, bind it to vfio
again and reset it, ....

Looks like the hang only is triggered by qemu-system_x86_64 on startup
the VM.

> host?  I'll also try to reproduce on my 990fx system, but I won't be
> able to do that until next week due to travel.  Thanks,


Regards,
Andreas
