Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:33775 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827Ab3COCmJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Mar 2013 22:42:09 -0400
Message-ID: <51428A72.2060602@huawei.com>
Date: Fri, 15 Mar 2013 10:41:54 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: 3.9-rc1: pciehp and eSATA card SiI 3132, no XHCI
References: <513E7E1E.80508@fold.natur.cuni.cz> <513FE7AD.2020408@huawei.com> <5141145E.4020300@fold.natur.cuni.cz> <51417C28.40402@huawei.com> <5141C9D7.9040706@fold.natur.cuni.cz>
In-Reply-To: <5141C9D7.9040706@fold.natur.cuni.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+CC Huang Ying <ying.huang@intel.com>
>> As you mentioned before
>> cold boot 0040 -> eject 0100 hotplug insert -> 0140 eject -> 0100 hotplug insert -> 0140 eject -> 0100
>> cold boot(PCIe card detected in slot)-->eject(Data Link state changed detected)-->.....
>> detail info reference at PCIe Spec 3.0  7.8.11
> 
> So doesn't pciehp/acpiphp complain when values 0000, 0108, 0138, 0148 appear?

I think the slot status changes is ok. The most important bit here is Presence Detect state
and Presence Detect Changed bits. And as your diff info, it seems ok.

> 
>>
>>>
>> I guess these memory ranges disabled because the original MMIO(coldplug boot) is still in system after eject device,
>> the new device insert cannot get the needed MMIO in system.

Sorry, my fault. I scan the lspci source code, and found the "[disable]" means memory/ioport decoding disabled.
This shows that the device maybe not enabled by driver.

[virtual] meaning /* Reported by the OS, but not by the device */
I also doubt this comment.

> 
> But then some driver is stupid and should loudly complain. Looks nobody even knows
> why lspci prints those "[disabled]" and "[virtual]" strings in its output.
> What are the normal cases of "virtual" ROMs and "disabled" ranges? What *functional*
> devices have them and why are they disabled? Is this like a disabled BOOT ROM on a network
> card or what?
> 


> # diff -u -w iomem.txt iomem_ejected.txt 
> # diff -u -w dmesg_ejected.txt dmesg_ejected_rmmod_sata_sil24.txt 
> --- dmesg_ejected.txt   2013-03-14 11:03:42.000000000 +0100
> +++ dmesg_ejected_rmmod_sata_sil24.txt  2013-03-14 11:05:00.000000000 +0100
> @@ -824,3 +824,173 @@
>  [   38.223082] r8169 0000:05:00.0 eth0: link up
>  [   39.471099] r8169 0000:05:00.0 eth0: link down
>  [   41.857999] r8169 0000:05:00.0 eth0: link up
> +[  270.090796] sata_sil24: IRQ status == 0xffffffff, PCI fault or device removal?
> +[  270.091728] pcieport 0000:00:1c.7: PME# enabled
> +[  270.972562] pcieport 0000:00:1c.7: PME# disabled
> +[  270.982338] pcieport 0000:00:1c.7: PME# enabled
> +[  271.022611] pcieport 0000:00:1c.7: PME# disabled
> +[  271.032560] pcieport 0000:00:1c.7: PME# enabled
> +[  272.053850] pcieport 0000:00:1c.7: PME# disabled
> +[  272.063619] pcieport 0000:00:1c.7: PME# enabled
> +[  272.103916] pcieport 0000:00:1c.7: PME# disabled
> +[  272.113838] pcieport 0000:00:1c.7: PME# enabled
> +[  273.145186] pcieport 0000:00:1c.7: PME# disabled
> +[  273.156282] pcieport 0000:00:1c.7: PME# enabled
> +[  273.195718] pcieport 0000:00:1c.7: PME# disabled
> +[  273.205228] pcieport 0000:00:1c.7: PME# enabled
> +[  274.226918] pcieport 0000:00:1c.7: PME# disabled
> [cut] repeated forever
> 

I added Huang Ying <ying.huang@intel.com> to cc list, Rafael and Huang Ying.
Both of them are familiar with PM. Obviously, this is an unnormal phenomenon.



-- 
Thanks!
Yijing

