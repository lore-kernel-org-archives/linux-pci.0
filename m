Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:32329 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbdBFKhK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Feb 2017 05:37:10 -0500
Date: Mon, 6 Feb 2017 12:37:06 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pciehp is broken from 4.10-rc1
Message-ID: <20170206103706.GE19313@lahna.fi.intel.com>
References: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
 <20170203055200.GA29413@wunner.de>
 <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
 <20170204081254.GA29595@wunner.de>
 <20170204185607.GA29957@wunner.de>
 <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com>
 <20170204233443.GA234@wunner.de>
 <CAE9FiQW5SQsQfRCz9sor4kufogTRVpHXekPHSi8MSi46mvXGLQ@mail.gmail.com>
 <20170205073454.GA253@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170205073454.GA253@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 05, 2017 at 08:34:54AM +0100, Lukas Wunner wrote:
> > sca05-0a81fd8d:~ # echo 1 > /sys/bus/pci/slots/11/power
> > [  375.376609] pci_hotplug: power_write_file: power = 1
> > [  375.382175] pciehp 0000:b3:00.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 17f1
> > [  375.392695] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010 from Slot Status
> > [  375.401370] pciehp 0000:b3:00.0:pcie004: pciehp_power_on_slot: SLOTCTRL a8 write cmd 0
> > [  375.410231] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_blink: SLOTCTRL a8 write cmd 200
> > [  375.411071] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010 from Slot Status
> > [  375.445222] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010 from Slot Status
> > [  377.444400] pciehp 0000:b3:00.0:pcie004: Data Link Layer Link Active not set in 1000 msec
> > [  378.960364] pci 0000:b4:00.0 id reading try 50 times with interval 20 ms to get ffffffff
> > [  378.969406] pciehp 0000:b3:00.0:pcie004: pciehp_check_link_status: lnk_status = 5001
> > [  378.978059] pciehp 0000:b3:00.0:pcie004: link training error: status 0x5001
> > [  378.985834] pciehp 0000:b3:00.0:pcie004: Failed to check link status
> > [  378.987185] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010 from Slot Status
> > [  378.987253] pciehp 0000:b3:00.0:pcie004: pciehp_power_off_slot: SLOTCTRL a8 write cmd 400
> > [  380.000409] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_off: SLOTCTRL a8 write cmd 300
> > [  380.000674] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010 from Slot Status
> > [  380.018020] pciehp 0000:b3:00.0:pcie004: pciehp_set_attention_status: SLOTCTRL a8 write cmd 40
> > [  380.019053] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010 from Slot Status

It would be good to see the output when 68db9bc is reverted. Yinghai,
can you attach that to the bugzilla but as well?

> So on this Skylake machine link training fails after resuming from D3hot
> to D0.
> 
> One thing that's a bit fishy is that normally the Link Disable bit is
> cleared when powering on the slot.  This results in a debug message
> in dmesg containg the string "lnk_ctrl = ", and that line is missing
> from the output you've pasted above, suggesting that the machine is
> not running a stock v4.10 kernel after all but something else.  Could
> you check why this message is not printed?  Could you check with lspci
> if the Link Disable bit is set before you invoke "echo 1"?
> 
> This is the call stack:
> pciehp_sysfs_enable_slot()
>   pciehp_enable_slot()
>     board_added()
>       pciehp_power_on_slot()
>         pciehp_link_enable()
>           __pciehp_link_set()
> 
> Another theory is that the link is generally unreliable on this machine
> since the Link Bandwidth Management Status bit is set in the Link Status
> Register ("lnk_status = 5001"), which according to the spec means:
> 
> "Hardware has changed Link speed or width to attempt to correct unreliable
> Link operation, either through an LTSSM timeout or a higher level process.
> This bit must be set if the Physical Layer reports a speed or width change
> was initiated by the Downstream component that was not indicated as an
> autonomous change."
> 
> In this case it would be good to know which hardware exactly we're dealing
> with so that we might quirk it to not runtime suspend the port.  To that
> end, could you attach a full dmesg log to the bugzilla entry I've created?
> https://bugzilla.kernel.org/show_bug.cgi?id=193951
> 
> @Mika, Rafael: Are you aware of Skylake machines with unreliable link
> training, or perhaps errata of Skylake chips related to link training
> on hotplug ports?

According to the 100-series (the chipset used with Skylake) errata
below, I don't see any mentions related to PCIe link training issues.

http://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/100-series-chipset-spec-update.pdf
