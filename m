Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mta-us-west-01.viasat.com ([199.106.191.81]:40053 "EHLO
	mta-us-west-01.viasat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbaFSCb3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jun 2014 22:31:29 -0400
Received: from pps.filterd (VCASPAM01.hq.corp.viasat.com [127.0.0.1])
	by VCASPAM01.hq.corp.viasat.com (8.14.5/8.14.5) with SMTP id s5J1VVwY007874
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2014 18:33:44 -0700
Message-ID: <53A23DF7.60104@viasat.com>
Date: Wed, 18 Jun 2014 21:33:43 -0400
From: Jon Baker <jon.baker@viasat.com>
Reply-To: <jon.baker@viasat.com>
MIME-Version: 1.0
To: <linux-pci@vger.kernel.org>
CC: "Gogineni, Naveen" <Naveen.Gogineni@viasat.com>
Subject: PCI rescan issue
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I am trying to find a solution to a Linux PCI rescan problem.

I have CentOS 6.5

     [jbaker@server0 ~]$ uname -a
     Linux server0 2.6.32-431.5.1.el6.x86_64 #1 SMP Wed Feb 12 00:41:43 
UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

I have an Altera FPGA PCIe protoboard I am trying to test in a TYAN 
FT77A-B7059.

We are trying to solve some hotplug/FPGA reload issues; when we reload 
the FPGA the PCI interface reloads confusing linux pci code.

After bootup the board is seen by the kernel; lscpi shows Altera FPGA 
PCIe protoboard settings and config space.  We can load our driver and 
all is well.

When we reload the FPGA lscpi display shows all "ff" for config space.  
As root I tried

     echo 1 > /sys/bus/pci/rescan

But no change to lspci output.

I tried some variants

     echo 1 > /sys/bus/pci/devices/0000:8a:00.0/rescan

no change to lspci output.

     echo 1 > /sys/bus/pci/devices/0000:8a:00.0/remove
     echo 1 > /sys/bus/pci/rescan

This removed the device and it did not show up again in lscpi.

Kernel has PCI HOTPLUG enabled:

     [jbaker@server0 ~]$ cat /boot/config-2.6.32-431.el6.x86_64 | grep 
HOTPLUG
     CONFIG_HOTPLUG=y
     CONFIG_MEMORY_HOTPLUG=y
     CONFIG_MEMORY_HOTPLUG_SPARSE=y
     CONFIG_HOTPLUG_CPU=y
     CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
     CONFIG_ACPI_HOTPLUG_CPU=y
     CONFIG_ACPI_HOTPLUG_MEMORY=y
     CONFIG_ACPI_HOTPLUG_MEMORY_AUTO_ONLINE=y
     CONFIG_HOTPLUG_PCI_PCIE=y
     CONFIG_HOTPLUG_PCI=y
     CONFIG_HOTPLUG_PCI_FAKE=m
     CONFIG_HOTPLUG_PCI_ACPI=y
     CONFIG_HOTPLUG_PCI_ACPI_IBM=m
     # CONFIG_HOTPLUG_PCI_CPCI is not set
     CONFIG_HOTPLUG_PCI_SHPC=m
     [jbaker@server0 ~]$

The kernel has pciehp module loaded, I see pciehp messages in 
/var/log/messages.

In other distros, on other platforms, echo 1 > /sys/bus/pci/rescan has 
worked but does not appear to work here for CentOS 6.5 on this hardware.

This problem is much discussed on the web but I have yet to see a 
solution discussed. I am thinking the 2.6.32-431.5.1.el6.x86_64 kernel 
may require a patch(es).  The rescan may not be resetting the PCIe card?

Any ideas how to get rescan to work?

Thank you,

Jon Baker

-- 
===================================
Jon Baker
Software Engineer
ViaSat Inc.
Cleveland OH
216-706-7800
jon.baker@viasat.com
www.viasat.com
===================================

