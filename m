Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:65458 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934045AbaGXIDP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 04:03:15 -0400
Message-ID: <53D0BDB8.3030706@huawei.com>
Date: Thu, 24 Jul 2014 16:03:04 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: John Fadel <john.fadel@gmail.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: PCIe IOMEM Resource Allocation
References: <loom.20140724T083447-909@post.gmane.org>	<53D0B24A.30100@huawei.com> <CAEYyDAt-PHsB9wrfCiNnd1_RFq3xUQNXWeh5QR9nJVZKho_0JQ@mail.gmail.com>
In-Reply-To: <CAEYyDAt-PHsB9wrfCiNnd1_RFq3xUQNXWeh5QR9nJVZKho_0JQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/7/24 15:30, John Fadel wrote:
> I already tried pci=nocrs and I have exactly the same behaviour ..
> 
> Is there any way to extend this range after linux is up ?
> How can I access _CRS method to extend this range ?
> Is there a way to force larger range during the boot of linux ?
> 

First you should guarantee the extend resource range is free in your system,
you can check this from cat /proc/iomem;
Then if you add the pci=nocrs and still fail to use the extend resource range,
this is not a OS problem, and maybe BIOS does not allow OS to use extend resource out of default hostbridge
window.

There is no other way to extend the _CRS from OS.

Thanks!
Yijing.


> 
> 
> 
> On Thu, Jul 24, 2014 at 9:14 AM, Yijing Wang <wangyijing@huawei.com <mailto:wangyijing@huawei.com>> wrote:
> 
>     On 2014/7/24 14:35, John wrote:
>     > Hi
>     > I am trying to write a PCIe linux device driver to handle PCIe switches and
>     > endpoints that show up after the Redhat 6.4 linux is already up and running.
>     >
>     > If I try to allocate the resources of the PCIe switches & endpoints between
>     > 0xF4000000 and 0xF47FFFFF everything works fine .. But this range is quite
>     > full with other devices, so I tried to extend this range to start from
>     > 0xF0000000, or from 0xD0000000 the allocation works fine, but I am unable to
>     > access devices in the extended range
>     >
>     > Anybody has idea why I am unable to use the complete 3G - 4G address range ?
>     > Is it related to some ACPI boot configuration that need to be changed, I can
>     > see in my dmesg
>     >
>     > pci_root PNP0A08:00: host bridge window [mem 0xf4000000-0xf7ffffff]
>     > pci_root PNP0A08:00: host bridge window [io 0x1000-0x7fff]
>     > pci_root PNP0A08:00: host bridge window [io 0x0000-0x03af]
>     > pci_root PNP0A08:00: host bridge window [io 0x03e0-0x0cf7]
>     > pci_root PNP0A08:00: host bridge window [io 0x0d00-0x0fff]
>     > pci_root PNP0A08:00: host bridge window [mem 0xfed00000-0xfed03fff]
>     > pci_root PNP0A08:00: host bridge window [mem 0xfed40000-0xfed44fff]
>     > pci_root PNP0A08:00: host bridge window [io 0x03b0-0x03bb]
>     > pci_root PNP0A08:00: host bridge window [io 0x03c0-0x03df]
>     > pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
>     > pci_root PNP0A08:01: host bridge window [mem 0xf8000000-0xfbffffff]
>     > pci_root PNP0A08:01: host bridge window [io 0x8000-0xffff]
>     >
>     > Is there a reason for this limited range ? Is it processor dependant ?
> 
>     Yes, you should use the resource range in host bridge window, or you won't
>     request resource success. PCI hostbridge retrieve the host bridge window
>     from ACPI _CRS method, if _CRS is not exist, PCI may use global resource
>     iomem_resource and ioport_resource as its hostbridge window.
> 
>     BIOS is responsible for the _CRS resource range report.
> 
>     BTW, you can append the pci=nocrs in command line and try again.
> 
> 
>     Thanks!
>     Yijing.
> 
> 
>     >
>     > Thanks
>     >
>     > --
>     > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>     > the body of a message to majordomo@vger.kernel.org <mailto:majordomo@vger.kernel.org>
>     > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>     >
>     >
> 
> 
>     --
>     Thanks!
>     Yijing
> 
> 


-- 
Thanks!
Yijing

