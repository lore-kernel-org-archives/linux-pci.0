Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout1.freenet.de ([195.4.92.91]:45249 "EHLO mout1.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003AbaJYSoI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 25 Oct 2014 14:44:08 -0400
Message-ID: <544B3D14.70907@maya.org>
Date: Sat, 25 Oct 2014 08:03:00 +0200
From: Andreas Hartmann <andihartmann@freenet.de>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Hard and silent lock up since linux 3.14 with PCIe pass
 through (vfio)
References: <20140923210318.498dacbd@dualc.maya.org>				 <1411502866.24563.8.camel@ul30vt.home> <5437A958.3000201@maya.org>				 <CAErSpo5kkk4itqqmCMU=08-XMcDknur8VY++F3A2LajdvTptOA@mail.gmail.com>				 <5437F1F5.3010706@maya.org>				 <CAErSpo6DuWEcJb_gfS=5JnKN8b4DXXV9+u-CRa8m3db0dbzpsQ@mail.gmail.com>				 <543804BC.3080307@maya.org>				 <CAErSpo450czUtAM104o+RS=yOcmP+3MKMH7mYk=UYhVJ2+cfSQ@mail.gmail.com>				 <20141011003219.560cca97@dualc.maya.org>				 <20141010225408.GA24493@google.com> <5438CC1E.3060407@maya.org>				 <1413360267.4202.70.camel@ul30vt.home> <54406B34.1050808@maya.org>				 <1413925580.4202.189.camel@ul30vt.home>			 <1413927152.4202.195.camel@ul30vt.home> <5447D9D9.9030909@maya.org>		 <1414010215.4202.275.camel@ul30vt.home> <54492606.5090308@maya.org>	 <1414082022.27420.39.camel@ul30vt.home> <54493BFA.8010609@maya.org> <1414093023.27420.40.camel@ul30vt.home>
In-Reply-To: <1414093023.27420.40.camel@ul30vt.home>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Alex Williamson wrote:
> On Thu, 2014-10-23 at 19:33 +0200, Andreas Hartmann wrote:
>> Alex Williamson wrote:
>> [...]
>>> If you use Bjorn's previous patch to disable VC save/restore and my
>>> patch to reorder the reset mechanisms, does echo 1 > reset for the sysfs
>>> entry for the device also still cause a hang?
>>
>> Yes - it's hanging too (w/ vfio bound to the device - didn't test other
>> possibilities).
> 
> Does it happen regardless of the slot the card is plugged into?  Thanks,

As I already wrote, it's not possible to plug the device to another
port. But besides that, let me stress some "findings" I made over the
past view weeks I'm now knowing about this problem. Maybe it gives you
an idea about what's going on:


- I did all of the tests in text mode on the console. Normally, there is
a blinking cursor. When doing the echo 1 > reset, the shell doesn't come
back again and the blinking of the cursor gets immediately slower.
Getting slower means: it takes some more time until it is on / off again
again. This way, it "blinks" another not exceeding 2 times until it's
finally dead.
It looks like the machine would have suddenly extremely high load (there
are 8 cores!) - but this seems to be not true, because the cpu fan stays
silent - the rpm isn't changed at all.


- Most of the time, I'm doing tests which fail, I'm having problems
after the hang with USB (it's the Etron device). Problem means: initrd
isn't able to communicate with the device (but bios and grub2 didn't had
any problem, because keyboard worked fine, which is connected via USB
3). At this point, it is necessary to disconnect the mains completely
and wait half a minute until the problem disappears.

Seldom, I too had this problem even on bios stage: the keyboard couldn't
be seen even by the bios any more.


- Sometimes (really seldom - now happened about 3 times), it gets
extremely hard to return to normal operation after that hang. This
means: Since a few weeks, I'm running kernel 3.12.28-3-desktop out of
the box (= as provided by openSUSE). Sometimes now, I got (apparently)
the same problems (= PCIe passthrough hangs the complete machine) w/
3.12.28 as I'm having with stock >= 3.14 after testing. It's even
useless then to reconnect the mains (I experienced this 2 times in
series after one hang yesterday). At this point, I have to run kernel
3.10.x (which runs pretty fine as usual) and only after that, 3.12 works
again as expected (as appeared once yesterday while tests w/ disabled
USB 3 devices via bios).


- I think there is a relationship between how long the hang is active
and the consecutive problems coming up. If the hang is immediately (max
about 1s) reset w/ the reset knob, it is possible, that there is no USB
problem after reboot and the machine works completely fine with 3.12.x
again.


Conclusion (from my point of view):
The broken reset seems to do something really _extreme ugly_ w/ the
hardware, which has the potential to break the hardware "lasting" or the
consecutive software isn't able at all to correctly reconfigure the
system again - even after reconnecting the mains.
Fortunately I'm having an old kernel version (3.10.x), which seems to be
able to "repair" the hardware again. But I have to emphasis that the
situation is really highly questionable and I'm meanwhile fearing to
break my board finally, which is working really _extremely_ stable
besides that.



Out of interest:
Bjorn's patch disables vc save/restore support - and the machine works
fine again. Why is it needed at all if it seems to work perfectly w/o
it? What's the additional benefit? Or in other words: What am I missing
until today :-) ? What would be better? What could I do more?



Thanks,
kind regards,
Andreas
