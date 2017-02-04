Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36847 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753685AbdBDHAU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Feb 2017 02:00:20 -0500
Received: by mail-vk0-f65.google.com with SMTP id n19so3145904vkd.3
        for <linux-pci@vger.kernel.org>; Fri, 03 Feb 2017 23:00:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170203055200.GA29413@wunner.de>
References: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
 <20170203055200.GA29413@wunner.de>
From: Yinghai Lu <yinghai@kernel.org>
Date: Fri, 3 Feb 2017 23:00:19 -0800
Message-ID: <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
Subject: Re: pciehp is broken from 4.10-rc1
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 2, 2017 at 9:52 PM, Lukas Wunner <lukas@wunner.de> wrote:
> [cc += Mika]
>
> On Thu, Feb 02, 2017 at 08:11:48PM -0800, Yinghai Lu wrote:
>> 4.9 is  working,
> [...]
>> sca05-0a81e0db:~ # echo 1 > /sys/bus/pci/slots/8/power
>> [  175.771846] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up
>> [  175.777898] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up event
>> ignored; already powering on
>> [  175.956632] pci 0000:65:00.0: [15b3:1003] type 00 class 0x0c0600
> [...]
>> sca05-0a81e0db:~ # echo 1 > /sys/bus/pci/slots/8/power
>> [  221.041664] pciehp 0000:60:03.2:pcie004: Slot(8): Already enabled
>
> Could you check if the port above 0000:60:03.2 is runtime suspended
> when you're trying this, i.e. does its power/runtime_status entry in
> sysfs say "suspended"?

yes.

>
> Normally the hotplug slot should keep its parents awake so that config
> space accesses work.  And the hotplug port's config space should be
> accessible in D3 per the spec.
>
> If you add pm_runtime_get_sync(&ctrl->pcie->port->dev) in
> drivers/pci/pciehp_ctrl.c:pciehp_enable_slot() before the call to
> pciehp_get_power_status(), and a corresponding pm_runtime_put()
> afterwards, does the issue go away?

Still not working.

the problem is
sca05-0a81e0db:~ # echo 0 > /sys/bus/pci/slots/8/power
[  141.838027] mlx4_core 0000:65:00.0: PME# disabled
[  143.279434] iommu: Removing device 0000:65:00.0 from group 172
[  143.292329] pcieport 0000:60:03.2: PME# enabled
[  143.297431] pciehp 0000:60:03.2:pcie004: Timeout on hotplug command
0x11f1 (issued 81476 msec ago)
[  143.337545] pcieport 0000:60:03.2: PME# disabled
[  143.380359] pciehp 0000:60:03.2:pcie004: Slot(8): Link Down
[  143.386735] pciehp 0000:60:03.2:pcie004: Slot(8): Link Down event
ignored; already powering off
[  143.445483] pcieport 0000:60:03.2: PME# enabled
[  143.992915] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up
[  143.999004] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up event
queued; currently getting powered off
[  144.025590] pcieport 0000:60:03.2: PME# disabled
[  144.133548] pcieport 0000:60:03.2: PME# enabled
[  144.333603] pciehp 0000:60:03.2:pcie004: Slot(8): Already enabled
sca05-0a81e0db:~ # [  144.357483] pcieport 0000:60:03.2: PME# disabled
[  144.465566] pcieport 0000:60:03.2: PME# enabled

we have extra Link Up event queued, while pm_runtime_get_sync/pm_runtime_put ?
  [  143.445483] pcieport 0000:60:03.2: PME# enabled
  [  143.992915] pciehp 0000:60:03.2:pcie004: Slot(8): Link Up


Thanks

Yinghai
