Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:64517 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757491AbbIXRhx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 24 Sep 2015 13:37:53 -0400
MIME-Version: 1.0
Message-ID: <trinity-8ba3da91-51c4-496e-8c40-91bbecacd141-1443116266781@3capp-webde-bs43>
From: "Roland Weber" <r-o-l@web.de>
To: linux-usb@vger.kernel.org
Cc: "Mathias Nyman" <mathias.nyman@intel.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2015 19:37:46 +0200
In-Reply-To: <Pine.LNX.4.44L0.1509231058110.1670-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1509231058110.1670-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

> > Frankly, I don't dare to upgrade the BIOS right now.
> 
> All right.  Maybe at some point in the future.  The thing is, I don't 
> want to patch the kernel only to find that the problem has already been 
> fixed in a newer BIOS.

Fair enough. I'll see if I can make time for setting things up over
the next few weeks. Andrew's report on this matter is encouraging.

> The unavoidable conclusion is that your system doesn't work right when 
> this root hub is suspended.  (I still think it's the BIOS's fault.)

I've been using the machine in legacy BIOS mode ever since I wasted
three days trying to get an installed Linux booting in UEFI mode. I'm
planning a clean installation anyway, this weekend or early next week.
I'll give UEFI mode (without secure boot) another chance. Maybe it
works when I get rid of the factory boot entries in that menu.
At the very least, I can boot a Linux live disk with UEFI to see
if that one freezes, and what the EHCI registers have to say.

> Which suggests yet another test: Under a kernel with CONFIG_PM and
> CONFIG_PM_SLEEP enabled, what happens when you suspend the system
> (i.e., suspend-to-RAM) and then wake it up?

Well, there's the second big problem I have with the machine. It has
an eMMC rather than a real hard disk or SSD. AIUI, the Linux MMC driver
has no way of distinguishing removable from non-removable MMC media.
So it treats all MMC as removable and expects that the disk contents
may have changed while it was asleep. Kind of an unmount on sleep or so.
Which means that when the machine wakes up, the root filesystem is gone.
IIRC, it did wake up but then hung up when I entered a command. It's
been a while since I tried.
There is a boot parameter to tell the MMC driver that all media are to
be treated as non-removable. I gave it a try back then and it didn't work.
But I'll give it another try a.s.a.p. Maybe I just had the prefix wrong.

Thanks a lot, Alan. I'll provide more information as soon as I can
gather it.

cheers,
  Roland
