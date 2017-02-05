Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170204233443.GA234@wunner.de>
References: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
 <20170203055200.GA29413@wunner.de> <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
 <20170204081254.GA29595@wunner.de> <20170204185607.GA29957@wunner.de>
 <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com> <20170204233443.GA234@wunner.de>
From: Yinghai Lu <yinghai@kernel.org>
Date: Sat, 4 Feb 2017 20:22:59 -0800
Message-ID: <CAE9FiQW5SQsQfRCz9sor4kufogTRVpHXekPHSi8MSi46mvXGLQ@mail.gmail.com>
Subject: Re: pciehp is broken from 4.10-rc1
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 4, 2017 at 3:34 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Sat, Feb 04, 2017 at 01:44:34PM -0800, Yinghai Lu wrote:
>> On Sat, Feb 4, 2017 at 10:56 AM, Lukas Wunner <lukas@wunner.de> wrote:
>> > On Sat, Feb 04, 2017 at 09:12:54AM +0100, Lukas Wunner wrote:
>> > Section 6.7.3.4 of the PCIe Base spec seems to support the theory above,
>> > so here's a tentative patch.
>> >
>> >
>> > -- >8 --
>> > Subject: [PATCH] PCI: pciehp: Don't enable PME on runtime suspend
>>
>> it works:
>
> Thanks a lot for the report and for testing the patch!

Wait, Commit 68db9bc still has problem with another server (skylake
based), and this patch does not help.


sca05-0a81fd8d:~ # echo 0 > /sys/bus/pci/slots/11/power
[  362.721197] pci_hotplug: power_write_file: power = 0
[  362.726887] pciehp 0000:b3:00.0:pcie004: pciehp_get_power_status:
SLOTCTRL a8 value read 11f1
[  362.736431] pciehp 0000:b3:00.0:pcie004: pciehp_unconfigure_device:
domain:bus:dev = 0000:b4:00
[  362.746160] mlx4_core 0000:b4:00.0: PME# disabled
[  364.494033] pcieport 0000:b3:00.0:   root_bridge ACPI_HANDLE
ffff9e56b8811550 : pci0000:b3
[  364.503274] pcieport 0000:b3:00.0:  pciehp is native
[  364.508863] pci 0000:b4:00.0: freeing pci_dev info
[  364.514718] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  364.523443] pciehp 0000:b3:00.0:pcie004: pciehp_power_off_slot:
SLOTCTRL a8 write cmd 400
[  364.587047] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0108
from Slot Status
[  364.595592] pciehp 0000:b3:00.0:pcie004: Slot(11): Link Down
[  364.602325] pciehp 0000:b3:00.0:pcie004: Slot(11): Link Down event
ignored; already powering off
[  365.568415] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_off:
SLOTCTRL a8 write cmd 300
[  365.569338] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status

sca05-0a81fd8d:~ # echo 1 > /sys/bus/pci/slots/11/power
[  375.376609] pci_hotplug: power_write_file: power = 1
[  375.382175] pciehp 0000:b3:00.0:pcie004: pciehp_get_power_status:
SLOTCTRL a8 value read 17f1
[  375.392695] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  375.401370] pciehp 0000:b3:00.0:pcie004: pciehp_power_on_slot:
SLOTCTRL a8 write cmd 0
[  375.410231] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_blink:
SLOTCTRL a8 write cmd 200
[  375.411071] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  375.445222] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  377.444400] pciehp 0000:b3:00.0:pcie004: Data Link Layer Link
Active not set in 1000 msec
[  378.960364] pci 0000:b4:00.0 id reading try 50 times with interval
20 ms to get ffffffff
[  378.969406] pciehp 0000:b3:00.0:pcie004: pciehp_check_link_status:
lnk_status = 5001
[  378.978059] pciehp 0000:b3:00.0:pcie004: link training error: status 0x5001
[  378.985834] pciehp 0000:b3:00.0:pcie004: Failed to check link status
[  378.987185] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  378.987253] pciehp 0000:b3:00.0:pcie004: pciehp_power_off_slot:
SLOTCTRL a8 write cmd 400
[  380.000409] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_off:
SLOTCTRL a8 write cmd 300
[  380.000674] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  380.018020] pciehp 0000:b3:00.0:pcie004:
pciehp_set_attention_status: SLOTCTRL a8 write cmd 40
[  380.019053] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
-bash: echo: write error: Operation not permitted

revert commit 68db9bc, also make it working again.


Thanks


Yinghai
