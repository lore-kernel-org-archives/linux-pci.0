Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:34513 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeAMHO4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Jan 2018 02:14:56 -0500
Date: Sat, 13 Jan 2018 08:14:54 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: Regression (sort of): PCI/portdrv: Turn off PCIe services during
 shutdown
Message-ID: <20180113071454.GA14854@wunner.de>
References: <20180112104929.GA10599@wunner.de>
 <20180112163420.GF27654@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180112163420.GF27654@lahna.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 12, 2018 at 06:34:20PM +0200, Mika Westerberg wrote:
> On Fri, Jan 12, 2018 at 11:49:29AM +0100, Lukas Wunner wrote:
> > I believe Mika has a MacBookPro13,3 with Alpine Ridge (Thunderbolt 3)
> > and could verify if that also has this issue. These MacBook Pros have
> > two Thunderbolt controllers, so if affected, the commit would delay
> > reboot by 16 seconds.
> 
> Checked the MacBook with 2 x AR and it does have NoCompl+ for the
> hotplug downstream ports. Also tried reboot the system and it does not
> take 16s, more like 1-2s.

Yes, as said Alpine Ridge isn't affected, only older Thunderbolt 1 chips.
You mentioned last year that you also have a mac mini with Light Ridge
and a MacBook with Cactus Ridge:
http://lkml.iu.edu/hypermail/linux/kernel/1705.3/00443.html

Install a 4.15 kernel on one of those and reboot to see the 8 second
delay.

I've just sent out a patch which fixes the issue for me, an ack would
be appreciated, barring any objections of course.  Do you have access
to specs for older Thunderbolt 1 chips and if so, could you verify if
they require a delay to be observed after writing to the Slot Control
register?  Is there an errata sheet confirming that the advertised
NoCompl- is bogus?

There are certain Xeons from the same era as the affected Thunderbolt 1
chips which advertise NoCompl- but erroneously only acknowledge Command
Completed for a few specific commands:
- Power Controller Control
- Power Indicator Control
- Attention Indicator Control
- Electromechanical Interlock Control

See erratum CF118 in:
https://www.intel.com/content/www/us/en/processors/xeon/xeon-e7-v2-spec-update.html

I figured that maybe Intel recycled the faulty VHDL files of these Xeon
hotplug ports in Thunderbolt 1 controllers, so I set all of the above
bits on every access to the Slot Control register.  Alas it didn't help,
the behavior stayed the same, no Command Completed event and no Command
Completed indication in the Slot Status register.  (Perhaps unsurprising
since Light Ridge doesn't advertise support for any of the above four
features.)

Thanks,

Lukas
