Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:33891 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934045AbaGXHOZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 03:14:25 -0400
Message-ID: <53D0B24A.30100@huawei.com>
Date: Thu, 24 Jul 2014 15:14:18 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: John <john.fadel@gmail.com>, <linux-pci@vger.kernel.org>
Subject: Re: PCIe IOMEM Resource Allocation
References: <loom.20140724T083447-909@post.gmane.org>
In-Reply-To: <loom.20140724T083447-909@post.gmane.org>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/7/24 14:35, John wrote:
> Hi
> I am trying to write a PCIe linux device driver to handle PCIe switches and
> endpoints that show up after the Redhat 6.4 linux is already up and running.
> 
> If I try to allocate the resources of the PCIe switches & endpoints between
> 0xF4000000 and 0xF47FFFFF everything works fine .. But this range is quite
> full with other devices, so I tried to extend this range to start from
> 0xF0000000, or from 0xD0000000 the allocation works fine, but I am unable to
> access devices in the extended range
> 
> Anybody has idea why I am unable to use the complete 3G - 4G address range ?
> Is it related to some ACPI boot configuration that need to be changed, I can
> see in my dmesg
> 
> pci_root PNP0A08:00: host bridge window [mem 0xf4000000-0xf7ffffff]
> pci_root PNP0A08:00: host bridge window [io 0x1000-0x7fff]
> pci_root PNP0A08:00: host bridge window [io 0x0000-0x03af]
> pci_root PNP0A08:00: host bridge window [io 0x03e0-0x0cf7]
> pci_root PNP0A08:00: host bridge window [io 0x0d00-0x0fff]
> pci_root PNP0A08:00: host bridge window [mem 0xfed00000-0xfed03fff]
> pci_root PNP0A08:00: host bridge window [mem 0xfed40000-0xfed44fff]
> pci_root PNP0A08:00: host bridge window [io 0x03b0-0x03bb]
> pci_root PNP0A08:00: host bridge window [io 0x03c0-0x03df]
> pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
> pci_root PNP0A08:01: host bridge window [mem 0xf8000000-0xfbffffff]
> pci_root PNP0A08:01: host bridge window [io 0x8000-0xffff]
> 
> Is there a reason for this limited range ? Is it processor dependant ?

Yes, you should use the resource range in host bridge window, or you won't
request resource success. PCI hostbridge retrieve the host bridge window
from ACPI _CRS method, if _CRS is not exist, PCI may use global resource
iomem_resource and ioport_resource as its hostbridge window.

BIOS is responsible for the _CRS resource range report.

BTW, you can append the pci=nocrs in command line and try again.


Thanks!
Yijing.


> 
> Thanks 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Thanks!
Yijing

