Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:55021 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdBGGGW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2017 01:06:22 -0500
Date: Tue, 7 Feb 2017 07:08:11 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: pciehp is broken from 4.10-rc1
Message-ID: <20170207060811.GA791@wunner.de>
References: <20170203055200.GA29413@wunner.de>
 <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
 <20170204081254.GA29595@wunner.de>
 <20170204185607.GA29957@wunner.de>
 <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com>
 <20170204233443.GA234@wunner.de>
 <CAE9FiQW5SQsQfRCz9sor4kufogTRVpHXekPHSi8MSi46mvXGLQ@mail.gmail.com>
 <20170205073454.GA253@wunner.de>
 <20170206204249.GA679@wunner.de>
 <CAE9FiQXSmB6Cs55nFtdw3rRrVrivwpDGNTwLwYtvWCEe4nsuHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXSmB6Cs55nFtdw3rRrVrivwpDGNTwLwYtvWCEe4nsuHg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[cc += linux-pci]

On Mon, Feb 06, 2017 at 07:51:08PM -0800, Yinghai Lu wrote:
> On Mon, Feb 6, 2017 at 12:42 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Sun, Feb 05, 2017 at 08:34:54AM +0100, Lukas Wunner wrote:
> >> On Sat, Feb 04, 2017 at 08:22:59PM -0800, Yinghai Lu wrote:
> >> > Wait, Commit 68db9bc still has problem with another server (skylake
> >> > based), and this patch does not help.
> >> [...]
> >> > sca05-0a81fd8d:~ # echo 1 > /sys/bus/pci/slots/11/power
> >> > [  375.376609] pci_hotplug: power_write_file: power = 1
> >> > [  375.382175] pciehp 0000:b3:00.0:pcie004: pciehp_get_power_status: SLOTCTRL a8 value read 17f1
> >> > [  375.392695] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010 from Slot Status
> >> > [  375.401370] pciehp 0000:b3:00.0:pcie004: pciehp_power_on_slot: SLOTCTRL a8 write cmd 0
> >> > [  375.410231] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_blink: SLOTCTRL a8 write cmd 200
> >> > [  375.411071] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010 from Slot Status
> >> > [  375.445222] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010 from Slot Status
> >> > [  377.444400] pciehp 0000:b3:00.0:pcie004: Data Link Layer Link Active not set in 1000 msec
> >> > [  378.960364] pci 0000:b4:00.0 id reading try 50 times with interval 20 ms to get ffffffff
> >> > [  378.969406] pciehp 0000:b3:00.0:pcie004: pciehp_check_link_status: lnk_status = 5001
> >> > [  378.978059] pciehp 0000:b3:00.0:pcie004: link training error: status 0x5001
> >> > [  378.985834] pciehp 0000:b3:00.0:pcie004: Failed to check link status
> >> > [  378.987185] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010 from Slot Status
> >> > [  378.987253] pciehp 0000:b3:00.0:pcie004: pciehp_power_off_slot: SLOTCTRL a8 write cmd 400
> >> > [  380.000409] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_off: SLOTCTRL a8 write cmd 300
> >> > [  380.000674] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010 from Slot Status
> >> > [  380.018020] pciehp 0000:b3:00.0:pcie004: pciehp_set_attention_status: SLOTCTRL a8 write cmd 40
> >> > [  380.019053] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010 from Slot Status
> >>
> >> So on this Skylake machine link training fails after resuming from D3hot
> >> to D0.
> >>
> >> One thing that's a bit fishy is that normally the Link Disable bit is
> >> cleared when powering on the slot.  This results in a debug message
> >> in dmesg containg the string "lnk_ctrl = ", and that line is missing
> >> from the output you've pasted above, suggesting that the machine is
> >> not running a stock v4.10 kernel after all but something else.  Could
> >> you check why this message is not printed?  Could you check with lspci
> >> if the Link Disable bit is set before you invoke "echo 1"?
> >
> > Could you answer the questions above please?
> 
> link is always enabled, except some BIOS disable the link if the the
> card is not present.
> 
> there is one time we disable link when power off the slot., and that
> line get removed
> to support link event.
> 
> now that enable link is once on BIOS have that disabled during booting.
> 
> also i had one local patch:
> during enabling, the function will check if the old value is the same
> as new value.
> if it the same it will not write again.
> 
> void pcie_link_disable_set(struct pci_dev *dev, int bit)
> {
>         u16 lnk_ctrl, old_lnk_ctrl;
> 
>         if (!pci_is_pcie(dev))
>                 return;
> 
>         pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnk_ctrl);
>         old_lnk_ctrl = lnk_ctrl;
> 
>         if (!bit)
>                 lnk_ctrl &= ~PCI_EXP_LNKCTL_LD;
>         else
>                 lnk_ctrl |= PCI_EXP_LNKCTL_LD;
> 
>         if (old_lnk_ctrl == lnk_ctrl)
>                 return;
> 
>         pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctrl);
> 
>         dev_printk(KERN_DEBUG, &dev->dev, "%s: lnk_ctrl = %x\n", __func__,
>                          lnk_ctrl);
> }
> EXPORT_SYMBOL(pcie_link_disable_set);

So you're not even running a stock v4.10 kernel?  The function you've
quoted above is not part of the stock kernel.  Where are you calling
this from?

Please retry with a stock v4.10-rc7 kernel and report back if the issue
persists.

Sorry to be blunt, but I think it's unreasonable and unfair to report
an issue with link training and alleging that it's caused by my patch,
and afterwards coming out of the closet that you're using custom patches
that modify link training, the very part that is failing.

Lukas
