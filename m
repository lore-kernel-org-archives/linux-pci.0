Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34334 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754440AbdBGSIP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2017 13:08:15 -0500
Received: by mail-vk0-f65.google.com with SMTP id r136so10152330vke.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Feb 2017 10:08:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170207060811.GA791@wunner.de>
References: <20170203055200.GA29413@wunner.de> <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
 <20170204081254.GA29595@wunner.de> <20170204185607.GA29957@wunner.de>
 <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com>
 <20170204233443.GA234@wunner.de> <CAE9FiQW5SQsQfRCz9sor4kufogTRVpHXekPHSi8MSi46mvXGLQ@mail.gmail.com>
 <20170205073454.GA253@wunner.de> <20170206204249.GA679@wunner.de>
 <CAE9FiQXSmB6Cs55nFtdw3rRrVrivwpDGNTwLwYtvWCEe4nsuHg@mail.gmail.com> <20170207060811.GA791@wunner.de>
From: Yinghai Lu <yinghai@kernel.org>
Date: Tue, 7 Feb 2017 10:08:13 -0800
Message-ID: <CAE9FiQUxAfzLvd1icaJr=i8n_cQs5PL2q3y3PW9HYpaaPq8zZw@mail.gmail.com>
Subject: Re: pciehp is broken from 4.10-rc1
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 6, 2017 at 10:08 PM, Lukas Wunner <lukas@wunner.de> wrote:
> Please retry with a stock v4.10-rc7 kernel and report back if the issue
> persists.

sca05-0a81fd7f:~ # echo 0 > /sys/bus/pci/slots/7/power
[  454.072658] pciehp 0000:73:00.0:pcie004: pciehp_get_power_status:
SLOTCTRL a8 value read 11f1
[  454.082194] pciehp 0000:73:00.0:pcie004: pciehp_unconfigure_device:
domain:bus:dev = 0000:74:00
[  454.091931] mlx4_core 0000:74:00.0: PME# disabled
[  455.418084] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  455.426802] pciehp 0000:73:00.0:pcie004: pciehp_power_off_slot:
SLOTCTRL a8 write cmd 400
[  455.490381] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0108
from Slot Status
[  455.498938] pciehp 0000:73:00.0:pcie004: Slot(7): Link Down
[  455.505426] pciehp 0000:73:00.0:pcie004: Slot(7): Link Down event
ignored; already powering off
[  456.440169] pciehp 0000:73:00.0:pcie004: pciehp_green_led_off:
SLOTCTRL a8 write cmd 300
[  456.441181] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
from Slot Status
sca05-0a81fd7f:~ # echo 1 > /sys/bus/pci/slots/7/power
[  470.356464] pciehp 0000:73:00.0:pcie004: pciehp_get_power_status:
SLOTCTRL a8 value read 17f1
[  470.366662] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  470.375339] pciehp 0000:73:00.0:pcie004: pciehp_power_on_slot:
SLOTCTRL a8 write cmd 0
[  470.384199] pciehp 0000:73:00.0:pcie004: __pciehp_link_set: lnk_ctrl = 40
[  470.391789] pciehp 0000:73:00.0:pcie004: pciehp_green_led_blink:
SLOTCTRL a8 write cmd 200
[  470.391966] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  470.428791] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  472.428147] pciehp 0000:73:00.0:pcie004: Data Link Layer Link
Active not set in 1000 msec
[  473.944158] pci 0000:74:00.0 id reading try 50 times with interval
20 ms to get ffffffff
[  473.953209] pciehp 0000:73:00.0:pcie004: pciehp_check_link_status:
lnk_status = 5001
[  473.961861] pciehp 0000:73:00.0:pcie004: link training error: status 0x5001
[  473.969642] pciehp 0000:73:00.0:pcie004: Failed to check link status
[  473.970721] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  473.970818] pciehp 0000:73:00.0:pcie004: pciehp_power_off_slot:
SLOTCTRL a8 write cmd 400
[  475.000272] pciehp 0000:73:00.0:pcie004: pciehp_green_led_off:
SLOTCTRL a8 write cmd 300
[  475.000880] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  475.017879] pciehp 0000:73:00.0:pcie004:
pciehp_set_attention_status: SLOTCTRL a8 write cmd 40
[  475.018386] pciehp 0000:73:00.0:pcie004: pending interrupts 0x0010
from Slot Status
-bash: echo: write error: Operation not permitted
