Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:37687 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760197Ab2JYUHl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 25 Oct 2012 16:07:41 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ulrich Eckhardt <usb@uli-eckhardt.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	linux-pci@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
Date: Thu, 25 Oct 2012 22:11:37 +0200
Message-ID: <42232189.sLGmN8Uve8@vostro.rjw.lan>
In-Reply-To: <508973CE.8080603@uli-eckhardt.de>
References: <50841CCC.9030809@uli-eckhardt.de> <CAErSpo5cN5w=E8GYyKE=bX0=67Qk0g0wAW4vVFe0QfPGxo=+MA@mail.gmail.com> <508973CE.8080603@uli-eckhardt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, October 25, 2012 07:15:58 PM Ulrich Eckhardt wrote:
> Am 24.10.2012 23:13, schrieb Bjorn Helgaas:
> > On Wed, Oct 24, 2012 at 3:10 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> >> It can be disabled by writing "on" to the controller's
> >> /sys/devices/.../power/control file.
> >
> > Ulrich, if you boot in the working situation and write "on" to the
> > control file as above, can you still reproduce the failure?
> 
> I have done first a cat to the control file which returns already on:
> 
> uli:/ # cat /sys/devices/pci0000\:00/0000\:00\:04.0/power/control
> on
> 
> Writing again on to the file does not change anything.

Yes, and this means that runtime PM is disabled on the controller.

ASPM remains as a possible culprit, then.

Can you please boot with pcie_aspm=off in the kernel command line and see
if this makes a difference?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
