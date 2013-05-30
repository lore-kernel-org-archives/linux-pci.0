Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:23925 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967960Ab3E3JlK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2013 05:41:10 -0400
Message-ID: <51A71E9C.5030702@huawei.com>
Date: Thu, 30 May 2013 17:40:44 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Stefan Frings <stefan@stefanfrings.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, <mjg@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	PCI <linux-pci@vger.kernel.org>
Subject: Fwd: Re: 14e4:16bc SD card slot not working on Acer Aspire One 756
References: <51A710A4.1090205@huawei.com>
In-Reply-To: <51A710A4.1090205@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Forget +CC:linux-pci,sorry.

+CC Bjorn,Matthew Garrett.

Stefan found a ASPM related bug in Ubuntu "14e4:16bc SD card slot not working on Acer Aspire One 756"
Link to the Ubuntu Bug report: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1178131
The problem is still present in Kernel 3.10-rc1, rc2 and rc3. Kernels before 3.0.20 are NOT affected by the problem.
Stefan bisect it and found commit 3c07635 (PCI: Rework ASPM disable code) introduced this problem.

Before this patch, during system boot up, once system found ACPI FADT indicates ASPM is not supported, then
ASPM will disable the ASPM L0s L1 state absolutely. So SD card controller can work normally.

After this patch, ASPM will leave this device default ASPM setting. From dmesg provided by stefan, BIOS default enabled ASPM L1 state.

Currently if OS cannot get the _OSC control from BIOS, we will not be permitted to touch the ASPM hardware register (including disable it).

Stefan's platform BIOS had some problem, os cannot do any _OSC operation.
Following is piece of dmesg about _OSC:

[    0.115396] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.115399] ACPI: bus type PCI registered
[    0.115472] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
[    0.115477] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.115479] PCI: Using MMCONFIG for extended config space
[    0.115481] PCI: Using configuration type 1 for base access
.......[snip]..........
[    0.391438] pci 0000:00:1c.2:   bridge window [mem 0xc0400000-0xc04fffff 64bit pref]
[    0.391470] pci_bus 0000:00: on NUMA node 0
[    0.391584] \_SB_.PCI0:_OSC invalid UUID
[    0.391586] _OSC request data:1 1f 0
[    0.391593] acpi PNP0A08:00: ACPI _OSC support notification failed, disabling PCIe ASPM
[    0.391597] acpi PNP0A08:00: Unable to request _OSC control (_OSC support mask: 0x08)

What my concern is, should we introduce some abilities to disable ASPM state in this case (make specific device have ability to disable ASPM absolutely)? Or leave it to BIOS to
correct it ?
Now the only way to disable it is by setpci tool in userspace, device driver have no interface to disable it.

Thanks!
Yijing.


On 2013/5/30 2:01, Stefan Frings wrote:
> Hello Yijing,
>> Current kernel has applied my yesterday patch ?
> Oh, I understood you. I thought you wanted get the output of lspci with an unpatched kernel. I used an unpatched Kernel from my Ubuntu Linux (version 3.2).
> 
> Now I did the same with the patched Kernel 3.10-rc3 and attched the new files. Two files have been crated before and one lspci was executed after the setpci command.
> 
> No need to hurry, my workaround works fine.
> 
> ---
> Stefan Frings
> Markenstraße 12
> 40227 Düsseldorf
> 
> Am Mittwoch, den 29.05.2013, 08:05 +0200 schrieb Yijing Wang <wangyijing@huawei.com>:
>> On 2013/5/29 12:28, Stefan Frings wrote:
>>> Hi Yijing,
>>> Yes that's my topology.I attached the output of the command (and some other commands) to this email.
>>>
>>> As we can see, the value was now 0x42 before I ran the setpci command (why that?).
>>
>> Current kernel has applied my yesterday patch ? That patch seems not
>> right solution. I will try to find the root cause.
>>
>>>
>>> I'm pretty sure that I saw 0x43 yesterday. So I thought that the full power cycle made the difference (I normally use the reboot command) but I was not able to reproduce the 0x43 value anymore.
>>>
>>> However, only 0x41 and 0x40 work. The values 0x42 and 0x43 after boot are both not working.
>>
>> Ah, because your platform BIOS dictate NO ASPM should support, so we
>> should disable aspm for sd card controler device, so i think that's
>> why
>> 0x40 is safe for sd card controller.
>>
>>>
>>> I wonder if we should patch the PCI code. Because the ethernet controller works fine, so I think the PCI bus also works fine. Only the memory card reader has a problem. Shouldn't we modify the driver of the memory card reader to disable L1 when it gets loaded?
>>
>> Yes, but first we should confirm PCI core aspm function is ok.
>>
>> I will reply soon after i complete to analyze the aspm code change.
>>
>> Thanks!
>> Yijing.
>>
>>>
>>> ---
>>> Stefan Frings
>>> Markenstraße 12
>>> 40227 Düsseldorf
>>>
>>> Am Mittwoch, den 29.05.2013, 03:43 +0200 schrieb Yijing Wang <wangyijing@huawei.com>:
>>>> Hi Stefan,
>>>>    I'm sorry this patch does not work, I will try to find the real
>>>> cause of the problem.
>>>> I guess your PCI topology is
>>>>
>>>> root bus         bus number 4
>>>> -------+00:1c.2------------+---04:00.0 Ethernet controller
>>>>         root port          |---04:00.1 -----(SD card inert here)
>>>>                            (sd controller)
>>>> Now you can make sd card work by disable root port L1 link state.
>>>>
>>>> Can you  provide the lspci -vvv info as user root ? Currently your
>>>> lspci info cannot find Capabilities message which is show <access
>>>> denied>.
>>>> Provide two lspci -vvv messages one after system boot up and another
>>>> after you setpci 00:1c.2 0x50.B=0x41 may be better.
>>>>
>>>>
>>>> Thanks!
>>>> Yijing.
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> On 2013/5/29 3:07, Stefan Frings wrote:
>>>>> Hello Yijing Wang,
>>>>> the patch does not work, unfortunatley. I enabled debug messages, so we have some more detailed dmesg messages, see below.
>>>>>
>>>>> After booting the patched kernel, the register has value 0x42 (L1 enabled, L0s disabled) but I need the opposite 0x41 (L1 disabled, L0s enabled). So when I issue the command "setpci -s 00:1c.2 0x50.B=0x41", then the memory card gets detected properly.
>>>>>
>>>>> Something has changed because the value was 0x43 before I applied your patch. Now it is 0x42 but it must be 0x41 to get the card reader working. I also checked the wired ethernet interface which is attached to the same PCIe channel. The wired ethernet interface works with all four possible settings 0x40 - 0x43.
>>>>>
>>>>> I attached my boot dmesg file.
>>>>>
>>>>> [  254.810549] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000040
>>>>> [  255.007691] mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
>>>>> [  255.007703] mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width 0 timing 0
>>>>> [  255.027621] mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
>>>>> [  255.043658] mmc0: starting CMD52 arg 00000c00 flags 00000195
>>>>> [  255.044115] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00018000
>>>>> [  255.046192] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
>>>>> [  255.046215] mmc0: starting CMD52 arg 80000c08 flags 00000195
>>>>> [  265.073164] mmc0: Timeout waiting for hardware interrupt.
>>>>> [  265.073179] sdhci: =========== REGISTER DUMP (mmc0)===========
>>>>> [  265.073218] sdhci: Sys addr: 0x00000000 | Version:  0x00001502
>>>>> [  265.073226] sdhci: Blk size: 0x00000000 | Blk cnt:  0x00000000
>>>>> [  265.073234] sdhci: Argument: 0x80000c08 | Trn mode: 0x00000000
>>>>> [  265.073242] sdhci: Present:  0x1eff0001 | Host ctl: 0x00000001
>>>>> [  265.073249] sdhci: Power:    0x0000000f | Blk gap:  0x00000000
>>>>> [  265.073257] sdhci: Wake-up:  0x00000000 | Clock:    0x0000fa07
>>>>> [  265.073264] sdhci: Timeout:  0x00000000 | Int stat: 0x00000000
>>>>> [  265.073273] sdhci: Int enab: 0x00ff0083 | Sig enab: 0x00ff0083
>>>>> [  265.073280] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000000
>>>>> [  265.073288] sdhci: Caps:     0x176ec8b0 | Caps_1:   0x03002177
>>>>> [  265.073296] sdhci: Cmd:      0x0000341a | Max curr: 0x00000000
>>>>> [  265.073301] sdhci: Host ctl2: 0x00000000
>>>>> [  265.073309] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x00000000
>>>>> [  265.073312] sdhci: ===========================================
>>>>> [  265.075415] mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
>>>>> [  265.075486] mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
>>>>> [  265.077570] mmc0: starting CMD0 arg 00000000 flags 000000c0
>>>>>
>>>>> ---
>>>>> Stefan Frings
>>>>> Markenstraße 12
>>>>> 40227 Düsseldorf
>>>>>
>>>>> Am Dienstag, den 28.05.2013, 09:59 +0200 schrieb Yijing Wang <wangyijing@huawei.com>:
>>>>>> According to boot dmesg.
>>>>>> We found "ACPI FADT declares the system doesn't support PCIe ASPM, so
>>>>>> disable it", so FADT dictate no aspm support in this platform.
>>>>>> Matthew pcie_clear_aspm() to acpi_pci_root_add() when
>>>>>> acpi_pci_osc_control_set() return success.
>>>>>> Unfortunately in your machine, acpi_pci_osc_control_set() return
>>>>>> failed, so system missing the pcie_clear_aspm();
>>>>>> So we should move pci_clear_aspm() out of ACPI_SUCCESS() check.
>>>>>>
>>>>>> Stefan, can you help test the attached patch in 3.10-rcx?
>>>>>>
>>>>>> Thanks!
>>>>>> Yijing.
>>>>>>
>>>>>> On 2013/5/28 13:21, Stefan Frings wrote:
>>>>>>> 14e4:16bc SD card slot not working on Acer Aspire One 756
>>>>>>>
>>>>>>> The memory card read (Broadcaom BCM57765) does not work on Aver Aspire One 756 because Linux enabled ASPM L1 on the PCIe channel since a related change in Kernel 3.0.20. Please change the code so that only APSN L0s is enabled on that machine on the PCIe channel 00:1c.2.
>>>>>>>
>>>>>>> Until a solution is available, I use the following command as a workaround: sudo setpci -s 00:1c.2 0x50.B=0x41
>>>>>>>
>>>>>>> Description of the change that introduced the problem: https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/?id=6cac12dfab9c57a4f76821412224b226a9b08dff
>>>>>>>
>>>>>>> The full problem description with log files and result of my bisecting can be found in the Ubuntu Bug L#1178131.
>>>>>>>
>>>>>>> Link to the Ubuntu Bug report: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1178131
>>>>>>>
>>>>>>> The problem is still present in Kernel 3.10-rc1, rc2 and rc3.
>>>>>>> Kernels before 3.0.20 are NOT affected by the problem.
>>>>>>> The first problematic Linux version is 3.0.20.
>>>>>>>
>>>>>>> Steps to reproduce:
>>>>>>>
>>>>>>> - Boot Linux with any Kernel after 3.0.19 (Using Gnome 3 Desktop)
>>>>>>> - Insert any memory card into the card reader
>>>>>>> - Problem: nothing happens
>>>>>>> - Problem: In dmesg, the mmc driver reports communication timeouts for the card reader
>>>>>>> - Remove the memory card
>>>>>>> - Enter sudo setpci -s 00:1c.2 0x50.B=0x41 (This disables ASPM L1)
>>>>>>> - Insert the memory card
>>>>>>> - Result: It gets detected immediately. Gnome pop-ups a related notification window.
>>>>>>> - Remove the memory card
>>>>>>> - Enter sudo setpci -s 00:1c.2 0x50.B=0x43 (this is the value that the Linux Kernel sets during boot)
>>>>>>> - Insert the memory card
>>>>>>> - Problem: The card is not detected
>>>>>>>


-- 
Thanks!
Yijing



