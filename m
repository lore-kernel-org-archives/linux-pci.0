Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:47983 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753745AbdBDILK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Feb 2017 03:11:10 -0500
Date: Sat, 4 Feb 2017 09:12:54 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: pciehp is broken from 4.10-rc1
Message-ID: <20170204081254.GA29595@wunner.de>
References: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
 <20170203055200.GA29413@wunner.de>
 <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 03, 2017 at 11:00:19PM -0800, Yinghai Lu wrote:
> On Thu, Feb 2, 2017 at 9:52 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > Could you check if the port above 0000:60:03.2 is runtime suspended
> > when you're trying this, i.e. does its power/runtime_status entry in
> > sysfs say "suspended"?
> 
> yes.

Huh?  That shouldn't happen, the port 0000:60:03.2 should block its
parents from runtime suspending (by way of checking is_hotplug_bridge
in pci_dev_check_d3cold()).

Maybe there's a misunderstanding here.  I was referring to the port
*above* 0000:60:03.2.  I don't know it's device name, it's not apparent
from the logs you've posted so far.

I've opened a bugzilla entry for this:
https://bugzilla.kernel.org/show_bug.cgi?id=193951

Please attach the output of "lspci -vvvvxxxx" and full dmesg output.


> > If you add pm_runtime_get_sync(&ctrl->pcie->port->dev) in
> > drivers/pci/pciehp_ctrl.c:pciehp_enable_slot() before the call to
> > pciehp_get_power_status(), and a corresponding pm_runtime_put()
> > afterwards, does the issue go away?
> 
> Still not working.
> 
> the problem is
> sca05-0a81e0db:~ # echo 0 > /sys/bus/pci/slots/8/power
> [  141.838027] mlx4_core 0000:65:00.0: PME# disabled
> [  143.279434] iommu: Removing device 0000:65:00.0 from group 172
> [  143.292329] pcieport 0000:60:03.2: PME# enabled
> [  143.297431] pciehp 0000:60:03.2:pcie004: Timeout on hotplug command
> 0x11f1 (issued 81476 msec ago)
> [  143.337545] pcieport 0000:60:03.2: PME# disabled
> [  143.380359] pciehp 0000:60:03.2:pcie004: Slot(8): Link Down
> [  143.386735] pciehp 0000:60:03.2:pcie004: Slot(8): Link Down event
> ignored; already powering off
> [  143.445483] pcieport 0000:60:03.2: PME# enabled
> [  143.992915] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up
> [  143.999004] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up event
> queued; currently getting powered off
> [  144.025590] pcieport 0000:60:03.2: PME# disabled
> [  144.133548] pcieport 0000:60:03.2: PME# enabled
> [  144.333603] pciehp 0000:60:03.2:pcie004: Slot(8): Already enabled
> sca05-0a81e0db:~ # [  144.357483] pcieport 0000:60:03.2: PME# disabled
> [  144.465566] pcieport 0000:60:03.2: PME# enabled
> 
> we have extra Link Up event queued, while pm_runtime_get_sync/pm_runtime_put ?
>   [  143.445483] pcieport 0000:60:03.2: PME# enabled
>   [  143.992915] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up

I notice that with 68db9bc81436 applied, PME is repeatedly enabled and
disabled on the port, presumably whenever it switches from D3 to D0
and vice-versa.

Perhaps this port sends an interrupt while PME is enabled and the slot
is actually occupied, despite it having been disabled via sysfs.
That's a case I couldn't test when developing the patch for lack of
PME capable hardware.

If you comment out the calls to __pci_enable_wake() in
drivers/pci/pci.c:pci_finish_runtime_suspend(), does the issue go away?

Thanks,

Lukas
