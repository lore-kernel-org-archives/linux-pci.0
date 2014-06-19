Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:44892 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbaFSEZ7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jun 2014 00:25:59 -0400
Message-ID: <53A2664B.3040300@huawei.com>
Date: Thu, 19 Jun 2014 12:25:47 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: <jon.baker@viasat.com>, <linux-pci@vger.kernel.org>
CC: "Gogineni, Naveen" <Naveen.Gogineni@viasat.com>
Subject: Re: PCI rescan issue
References: <53A23DF7.60104@viasat.com>
In-Reply-To: <53A23DF7.60104@viasat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/6/19 9:33, Jon Baker wrote:
> I am trying to find a solution to a Linux PCI rescan problem.
> 
> I have CentOS 6.5
> 
>     [jbaker@server0 ~]$ uname -a
>     Linux server0 2.6.32-431.5.1.el6.x86_64 #1 SMP Wed Feb 12 00:41:43 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

Can you test it in the latest kernel?

> 
> I have an Altera FPGA PCIe protoboard I am trying to test in a TYAN FT77A-B7059.
> 
> We are trying to solve some hotplug/FPGA reload issues; when we reload the FPGA the PCI interface reloads confusing linux pci code.
> 
> After bootup the board is seen by the kernel; lscpi shows Altera FPGA PCIe protoboard settings and config space.  We can load our driver and all is well.
> 
> When we reload the FPGA lscpi display shows all "ff" for config space.  As root I tried

What happened during you reload the FPGA? reset PCI device or other anything?

> 
>     echo 1 > /sys/bus/pci/rescan
> 
> But no change to lspci output.
> 
> I tried some variants
> 
>     echo 1 > /sys/bus/pci/devices/0000:8a:00.0/rescan
> 
> no change to lspci output.
> 
>     echo 1 > /sys/bus/pci/devices/0000:8a:00.0/remove
>     echo 1 > /sys/bus/pci/rescan

I guess the device link to your board was disconnect. Maybe the power to device is off or link error. So OS
can not access pci device config space and return nothing found.

If you provide more detailed info is better. like lspci -vvvxxx, dmesg etc. before and after your operations.

> 
> This removed the device and it did not show up again in lscpi.
> 
> Kernel has PCI HOTPLUG enabled:
> 
>     [jbaker@server0 ~]$ cat /boot/config-2.6.32-431.el6.x86_64 | grep HOTPLUG
>     CONFIG_HOTPLUG=y
>     CONFIG_MEMORY_HOTPLUG=y
>     CONFIG_MEMORY_HOTPLUG_SPARSE=y
>     CONFIG_HOTPLUG_CPU=y
>     CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>     CONFIG_ACPI_HOTPLUG_CPU=y
>     CONFIG_ACPI_HOTPLUG_MEMORY=y
>     CONFIG_ACPI_HOTPLUG_MEMORY_AUTO_ONLINE=y
>     CONFIG_HOTPLUG_PCI_PCIE=y
>     CONFIG_HOTPLUG_PCI=y
>     CONFIG_HOTPLUG_PCI_FAKE=m
>     CONFIG_HOTPLUG_PCI_ACPI=y
>     CONFIG_HOTPLUG_PCI_ACPI_IBM=m
>     # CONFIG_HOTPLUG_PCI_CPCI is not set
>     CONFIG_HOTPLUG_PCI_SHPC=m
>     [jbaker@server0 ~]$
> 
> The kernel has pciehp module loaded, I see pciehp messages in /var/log/messages.
> 
> In other distros, on other platforms, echo 1 > /sys/bus/pci/rescan has worked but does not appear to work here for CentOS 6.5 on this hardware.
> 
> This problem is much discussed on the web but I have yet to see a solution discussed. I am thinking the 2.6.32-431.5.1.el6.x86_64 kernel may require a patch(es).  The rescan may not be resetting the PCIe card?
> 
> Any ideas how to get rescan to work?
> 
> Thank you,
> 
> Jon Baker
> 


-- 
Thanks!
Yijing

