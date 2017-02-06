Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751001AbdBFSKM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Feb 2017 13:10:12 -0500
Date: Mon, 6 Feb 2017 12:10:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pciehp is broken from 4.10-rc1
Message-ID: <20170206181007.GB15565@bhelgaas-glaptop.roam.corp.google.com>
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
> On Sat, Feb 04, 2017 at 08:22:59PM -0800, Yinghai Lu wrote:
> > On Sat, Feb 4, 2017 at 3:34 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Sat, Feb 04, 2017 at 01:44:34PM -0800, Yinghai Lu wrote:
> > >> On Sat, Feb 4, 2017 at 10:56 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > >> > On Sat, Feb 04, 2017 at 09:12:54AM +0100, Lukas Wunner wrote:
> > >> > Section 6.7.3.4 of the PCIe Base spec seems to support the theory above,
> > >> > so here's a tentative patch.
> > >> >
> > >> > -- >8 --
> > >> > Subject: [PATCH] PCI: pciehp: Don't enable PME on runtime suspend
> > >>
> > >> it works:
> > >
> > > Thanks a lot for the report and for testing the patch!
> > 
> > Wait, Commit 68db9bc still has problem with another server (skylake
> > based), and this patch does not help.
> [...]
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
> 
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

I think we're prematurely leaping to the conclusion that this is a
hardware erratum.  I don't have nearly the confidence that pciehp is
handling this correctly that you seem to have.

If this is a hardware erratum, we should be able to turn off
CONFIG_HOTPLUG_PCI_PCIE and drive through this scenario manually with
setpci.  That sequence would be immensely helpful to any hardware
engineers who want to investigate this.

I'm hesitant to add a quirk until we have a better understanding of
what's going on.  Yinghai tripped over this one broken case, but I
don't have any reason to believe that's the only one.

Bjorn
