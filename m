Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:2792 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbaFTBXX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jun 2014 21:23:23 -0400
Message-ID: <53A38CFE.1000807@huawei.com>
Date: Fri, 20 Jun 2014 09:23:10 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: <jon.baker@viasat.com>, <linux-pci@vger.kernel.org>
CC: "Gogineni, Naveen" <Naveen.Gogineni@viasat.com>
Subject: Re: PCI rescan issue
References: <53A23DF7.60104@viasat.com> <53A2664B.3040300@huawei.com> <53A2E71D.9060208@viasat.com>
In-Reply-To: <53A2E71D.9060208@viasat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/6/19 21:35, Jon Baker wrote:
> 
> On 06/19/2014 12:25 AM, Yijing Wang wrote:
>> On 2014/6/19 9:33, Jon Baker wrote:
>>> I am trying to find a solution to a Linux PCI rescan problem.
>>>
>>> I have CentOS 6.5
>>>
>>>     [jbaker@server0 ~]$ uname -a
>>>     Linux server0 2.6.32-431.5.1.el6.x86_64 #1 SMP Wed Feb 12 00:41:43 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
>> Can you test it in the latest kernel?
> 
> Not easily, this is a system shared amongst several developers and containing some specific tools and applications. And unfortunately we know this works with a 3.X kernel on an embedded target used by another group at our company. - Jon
>>
>>> I have an Altera FPGA PCIe protoboard I am trying to test in a TYAN FT77A-B7059.
>>>
>>> We are trying to solve some hotplug/FPGA reload issues; when we reload the FPGA the PCI interface reloads confusing linux pci code.
>>>
>>> After bootup the board is seen by the kernel; lscpi shows Altera FPGA PCIe protoboard settings and config space.  We can load our driver and all is well.
>>>
>>> When we reload the FPGA lscpi display shows all "ff" for config space.  As root I tried
>> What happened during you reload the FPGA? reset PCI device or other anything?
> I do not know, we have not monitored this.  The PCI interface is contained within the FPGA so I don't really know for sure how that behaves on reload. - Jon

If you find lspci PCI device return all ff after FPGA reload, and you do nothing during reload. I think the PCI device can not found after
your FPAG reload, as I mentioned, maybe the PCI device power or link has problems. I think this is not a Linux problem.

You can try this:
1. echo 1 > /sys/bus/pci/devices/0000:8a:00.0/remove
2. Reload FPGA board.
3. echo 1 > /sys/bus/pci/rescan
4. lspci to show your PCI device

Here make your device removed before FPGA board reload, avoid some stall device info in OS.

or

You can go to /sys/bus/pci/slots/ to find whether your PCI device support hotplug.
If yes, you can
echo 0 > /sys/bus/pci/slots/$device/power
echo 1 > /sys/bus/pci/slots/$device/power
reset the PCI device, then lspci show device whether is found.

>>
>>>     echo 1 > /sys/bus/pci/rescan
>>>
>>> But no change to lspci output.
>>>
>>> I tried some variants
>>>
>>>     echo 1 > /sys/bus/pci/devices/0000:8a:00.0/rescan
>>>
>>> no change to lspci output.
>>>
>>>     echo 1 > /sys/bus/pci/devices/0000:8a:00.0/remove
>>>     echo 1 > /sys/bus/pci/rescan
>> I guess the device link to your board was disconnect. Maybe the power to device is off or link error. So OS
>> can not access pci device config space and return nothing found.
>>
>> If you provide more detailed info is better. like lspci -vvvxxx, dmesg etc. before and after your operations.
> 
> I have logged this...
> 
> After system power up (case where everything works expected):
> 
>     $ lspci -vvv -xx -s 13:00.0
>     13:00.0 Non-VGA unclassified device: Device 1b83:f002 (rev 01)
>             Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
>             Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>             Latency: 0, Cache Line Size: 64 bytes
>             Interrupt: pin A routed to IRQ 11
>             Region 0: Memory at dcc00000 (32-bit, non-prefetchable) [size=256K]
>             Region 1: Memory at dcb00000 (32-bit, non-prefetchable) [size=1M]
>             Capabilities: <access denied>
>     00: 83 1b 02 f0 06 00 10 00 01 00 00 00 10 00 00 00
>     10: 00 00 c0 dc 00 00 b0 dc 00 00 00 00 00 00 00 00
>     20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 00 00

Can you show the upstream port device lspci info ? If 13:00.0 device support hotplug, upstream device got a register
to control the slot power.


> 
> 
> After FPGA reload:
> 
>     $ lspci -vvv -xx -s 13:00.0
>     13:00.0 Non-VGA unclassified device: Device 1b83:f002 (rev ff) (prog-if ff)
>             !!! Unknown header type 7f
>     00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>     10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>     20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>     30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> 
> - Jon
> 
>>
>>> This removed the device and it did not show up again in lscpi.
>>>
>>> Kernel has PCI HOTPLUG enabled:
>>>
>>>     [jbaker@server0 ~]$ cat /boot/config-2.6.32-431.el6.x86_64 | grep HOTPLUG
>>>     CONFIG_HOTPLUG=y
>>>     CONFIG_MEMORY_HOTPLUG=y
>>>     CONFIG_MEMORY_HOTPLUG_SPARSE=y
>>>     CONFIG_HOTPLUG_CPU=y
>>>     CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>>>     CONFIG_ACPI_HOTPLUG_CPU=y
>>>     CONFIG_ACPI_HOTPLUG_MEMORY=y
>>>     CONFIG_ACPI_HOTPLUG_MEMORY_AUTO_ONLINE=y
>>>     CONFIG_HOTPLUG_PCI_PCIE=y
>>>     CONFIG_HOTPLUG_PCI=y
>>>     CONFIG_HOTPLUG_PCI_FAKE=m
>>>     CONFIG_HOTPLUG_PCI_ACPI=y
>>>     CONFIG_HOTPLUG_PCI_ACPI_IBM=m
>>>     # CONFIG_HOTPLUG_PCI_CPCI is not set
>>>     CONFIG_HOTPLUG_PCI_SHPC=m
>>>     [jbaker@server0 ~]$
>>>
>>> The kernel has pciehp module loaded, I see pciehp messages in /var/log/messages.
>>>
>>> In other distros, on other platforms, echo 1 > /sys/bus/pci/rescan has worked but does not appear to work here for CentOS 6.5 on this hardware.
>>>
>>> This problem is much discussed on the web but I have yet to see a solution discussed. I am thinking the 2.6.32-431.5.1.el6.x86_64 kernel may require a patch(es).  The rescan may not be resetting the PCIe card?
>>>
>>> Any ideas how to get rescan to work?
>>>
>>> Thank you,
>>>
>>> Jon Baker
>>>
>>
> 
> -- 
> ===================================
> Jon Baker
> Software Engineer
> ViaSat Inc.
> Cleveland OH
> 216-706-7800
> jon.baker@viasat.com
> www.viasat.com
> ===================================
> 


-- 
Thanks!
Yijing

