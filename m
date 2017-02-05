Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAE9FiQW5SQsQfRCz9sor4kufogTRVpHXekPHSi8MSi46mvXGLQ@mail.gmail.com>
References: <CAE9FiQVCMCa7iVyuwp9z6VrY0cE7V_xghuXip28Ft52=8QmTWw@mail.gmail.com>
 <20170203055200.GA29413@wunner.de> <CAE9FiQWs0H9vqEo2ZYnWWBW0Ao-hx4WYHQ69cyR32nFQ9yV9rw@mail.gmail.com>
 <20170204081254.GA29595@wunner.de> <20170204185607.GA29957@wunner.de>
 <CAE9FiQUuFJHMScyFgnHbs5r-SzTiRiBZ2JcpUYJhg0ft75-OBQ@mail.gmail.com>
 <20170204233443.GA234@wunner.de> <CAE9FiQW5SQsQfRCz9sor4kufogTRVpHXekPHSi8MSi46mvXGLQ@mail.gmail.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Sat, 4 Feb 2017 21:20:52 -0800
Message-ID: <CAE9FiQUQ2+1DiM91m+OnxBST83Wf_Bpr1px_KqHg514UefjkwA@mail.gmail.com>
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

On Sat, Feb 4, 2017 at 8:22 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Sat, Feb 4, 2017 at 3:34 PM, Lukas Wunner <lukas@wunner.de> wrote:
>> On Sat, Feb 04, 2017 at 01:44:34PM -0800, Yinghai Lu wrote:
>>> On Sat, Feb 4, 2017 at 10:56 AM, Lukas Wunner <lukas@wunner.de> wrote:
>>> > On Sat, Feb 04, 2017 at 09:12:54AM +0100, Lukas Wunner wrote:
>>> > Section 6.7.3.4 of the PCIe Base spec seems to support the theory above,
>>> > so here's a tentative patch.
>>> >
>>> >
>>> > -- >8 --
>>> > Subject: [PATCH] PCI: pciehp: Don't enable PME on runtime suspend
>>>
>>> it works:
>>
>> Thanks a lot for the report and for testing the patch!
>
> Wait, Commit 68db9bc still has problem with another server (skylake
> based), and this patch does not help.
>
>
> sca05-0a81fd8d:~ # echo 0 > /sys/bus/pci/slots/11/power
> [  362.721197] pci_hotplug: power_write_file: power = 0
> [  362.726887] pciehp 0000:b3:00.0:pcie004: pciehp_get_power_status:
> SLOTCTRL a8 value read 11f1
> [  362.736431] pciehp 0000:b3:00.0:pcie004: pciehp_unconfigure_device:
> domain:bus:dev = 0000:b4:00
> [  362.746160] mlx4_core 0000:b4:00.0: PME# disabled
> [  364.494033] pcieport 0000:b3:00.0:   root_bridge ACPI_HANDLE
> ffff9e56b8811550 : pci0000:b3
> [  364.503274] pcieport 0000:b3:00.0:  pciehp is native
> [  364.508863] pci 0000:b4:00.0: freeing pci_dev info
> [  364.514718] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> [  364.523443] pciehp 0000:b3:00.0:pcie004: pciehp_power_off_slot:
> SLOTCTRL a8 write cmd 400
> [  364.587047] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0108
> from Slot Status
> [  364.595592] pciehp 0000:b3:00.0:pcie004: Slot(11): Link Down
> [  364.602325] pciehp 0000:b3:00.0:pcie004: Slot(11): Link Down event
> ignored; already powering off
> [  365.568415] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_off:
> SLOTCTRL a8 write cmd 300
> [  365.569338] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
>
> sca05-0a81fd8d:~ # echo 1 > /sys/bus/pci/slots/11/power
> [  375.376609] pci_hotplug: power_write_file: power = 1
> [  375.382175] pciehp 0000:b3:00.0:pcie004: pciehp_get_power_status:
> SLOTCTRL a8 value read 17f1
> [  375.392695] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> [  375.401370] pciehp 0000:b3:00.0:pcie004: pciehp_power_on_slot:
> SLOTCTRL a8 write cmd 0
> [  375.410231] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_blink:
> SLOTCTRL a8 write cmd 200
> [  375.411071] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> [  375.445222] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> [  377.444400] pciehp 0000:b3:00.0:pcie004: Data Link Layer Link
> Active not set in 1000 msec
> [  378.960364] pci 0000:b4:00.0 id reading try 50 times with interval
> 20 ms to get ffffffff
> [  378.969406] pciehp 0000:b3:00.0:pcie004: pciehp_check_link_status:
> lnk_status = 5001
> [  378.978059] pciehp 0000:b3:00.0:pcie004: link training error: status 0x5001
> [  378.985834] pciehp 0000:b3:00.0:pcie004: Failed to check link status
> [  378.987185] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> [  378.987253] pciehp 0000:b3:00.0:pcie004: pciehp_power_off_slot:
> SLOTCTRL a8 write cmd 400
> [  380.000409] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_off:
> SLOTCTRL a8 write cmd 300
> [  380.000674] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> [  380.018020] pciehp 0000:b3:00.0:pcie004:
> pciehp_set_attention_status: SLOTCTRL a8 write cmd 40
> [  380.019053] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
> from Slot Status
> -bash: echo: write error: Operation not permitted
>
> revert commit 68db9bc, also make it working again.

output after reverting 68db9bc

sca05-0a81fd8d:~ # echo 0 > /sys/bus/pci/slots/11/power
[  359.966115] pci_hotplug: power_write_file: power = 0
[  359.971759] pciehp 0000:b3:00.0:pcie004: pciehp_get_power_status:
SLOTCTRL a8 value read 11f1
[  359.981284] pciehp 0000:b3:00.0:pcie004: pciehp_unconfigure_device:
domain:bus:dev = 0000:b4:00
[  359.991017] mlx4_core 0000:b4:00.0: PME# disabled
[  361.579571] pci 0000:b4:00.0: freeing pci_dev info
[  361.585390] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  361.594116] pciehp 0000:b3:00.0:pcie004: pciehp_power_off_slot:
SLOTCTRL a8 write cmd 400
[  361.657705] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0108
from Slot Status
[  361.666268] pciehp 0000:b3:00.0:pcie004: Slot(11): Link Down
[  361.673076] pciehp 0000:b3:00.0:pcie004: Slot(11): Link Down event
ignored; already powering off
[  362.621894] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_off:
SLOTCTRL a8 write cmd 300
[  362.622499] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
sca05-0a81fd8d:~ #
sca05-0a81fd8d:~ # echo 1 > /sys/bus/pci/slots/11/power
[  368.797970] pci_hotplug: power_write_file: power = 1
[  368.803544] pciehp 0000:b3:00.0:pcie004: pciehp_get_power_status:
SLOTCTRL a8 value read 17f1
[  368.813743] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  368.822410] pciehp 0000:b3:00.0:pcie004: pciehp_power_on_slot:
SLOTCTRL a8 write cmd 0
[  368.831280] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_blink:
SLOTCTRL a8 write cmd 200
[  368.832115] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  369.455188] pciehp 0000:b3:00.0:pcie004: pciehp_check_link_active:
lnk_status = f083
[  369.463844] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0108
from Slot Status
[  369.465786] pciehp 0000:b3:00.0:pcie004: pciehp_check_link_active:
lnk_status = f083
[  369.481042] pciehp 0000:b3:00.0:pcie004: Slot(11): Link Up
[  369.487219] pciehp 0000:b3:00.0:pcie004: Slot(11): Link Up event
ignored; already powering on
[  369.573787] pciehp 0000:b3:00.0:pcie004: pciehp_check_link_status:
lnk_status = f083
[  369.582664] pci 0000:b4:00.0: [15b3:1003] type 00 class 0x0c0600
[  369.589626] pci 0000:b4:00.0: reg 0x10: [mem 0x00000000-0x000fffff 64bit]
[  369.597359] pci 0000:b4:00.0: reg 0x18: [mem 0x00000000-0x07ffffff
64bit pref]
[  369.605749] pci_bus 0000:b4:   bridge ACPI_HANDLE ffff9c2fb8817780
: 0000:b3:00.0
[  369.615407] pci 0000:b4:00.0: reg 0x134: [mem 0x00000000-0x07ffffff
64bit pref]
[  369.623571] pci 0000:b4:00.0: VF(n) BAR2 space: [mem
0x00000000-0x1ffffffff 64bit pref] (contains BAR2 for 64 VFs)
[  369.638820] pci 0000:b4:00.0: on_all_pcie_path: 1
[  369.644445] pci 0000:b4:00.0: BAR 2: assigned [mem
0x396ff8000000-0x396fffffffff 64bit pref]
[  369.654012] pci 0000:b4:00.0: BAR 9: assigned [mem
0x396df8000000-0x396ff7ffffff 64bit pref]
[  369.663489] pci 0000:b4:00.0: BAR 0: [mem size 0x00100000 64bit] + pref
[  369.670879] pci 0000:b4:00.0: BAR 0: assigned [mem
0xddf00000-0xddffffff 64bit]
[  369.679171] pcieport 0000:b3:00.0: PCI bridge to [bus b4-b7]
[  369.685495] pcieport 0000:b3:00.0:   bridge window [io  0xf000-0xffff]
[  369.692791] pcieport 0000:b3:00.0:   bridge window [mem
0xdd000000-0xddffffff]
[  369.700857] pcieport 0000:b3:00.0:   bridge window [mem
0x396df8000000-0x396fffffffff 64bit pref]
[  369.710778] pcieport 0000:b3:00.0: Max Payload Size set to  256/
256 (was  256), Max Read Rq  128
[  369.720776] pci 0000:b4:00.0: Max Payload Size set to  256/ 256
(was  128), Max Read Rq  512
[  369.730231] pci 0000:b4:00.0: calling
mellanox_check_broken_intx_masking+0x0/0x130
[  369.738691] calling  mellanox_check_broken_intx_masking+0x0/0x130 @
40613 for 0000:b4:00.0
[  369.747913] pci fixup mellanox_check_broken_intx_masking+0x0/0x130
returned after 0 usecs for 0000:b4:00.0
[  369.759192] mlx4_core: Initializing 0000:b4:00.0
[  369.764398] mlx4_core 0000:b4:00.0: enabling device (0000 -> 0002)
[  369.771854]   alloc irq_desc for 71 on node 5
[  369.776904] IOAPIC[31]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1
Redir_hint:1 Trig_Mode:0 Dlvry_Mode:1 Avail:0 Vector:D7 Dest:00143FFF
SID:B32C SQ:0 SVT:1)
[  369.792059] IOAPIC[24]: Set routing entry (31-0 -> 0xd7 -> IRQ 71
Mode:1 Active:1 Dest:1327103)
...

[  377.032574] pciehp 0000:b3:00.0:pcie004: pciehp_green_led_on:
SLOTCTRL a8 write cmd 100
[  377.032802] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
[  377.050076] pciehp 0000:b3:00.0:pcie004:
pciehp_set_attention_status: SLOTCTRL a8 write cmd c0
[  377.050328] pciehp 0000:b3:00.0:pcie004: pending interrupts 0x0010
from Slot Status
