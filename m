Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bgl-iport-2.cisco.com ([72.163.197.26]:6563 "EHLO
        bgl-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeIRASg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 20:18:36 -0400
Subject: Re: PCI: Enforce bus address limits in resource allocation
From: Daniel Walker <danielwa@cisco.com>
To: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com>
Message-ID: <2c531aca-1e16-ddc1-541a-3a8942d50944@cisco.com>
Date: Mon, 17 Sep 2018 11:39:56 -0700
MIME-Version: 1.0
In-Reply-To: <abb9aa39-3128-3a4d-01f7-d0614d63f37e@cisco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


This problem exists identically on 4.19-rc4 (the lastest as of today).



On 09/14/2018 08:16 AM, Daniel Walker wrote:
> 
> Hi,
> 
> Please forgive my ignorance of PCI. I know very little about it, but 
> I'll try to convey the issue I'm seeing.
> 
> I have a powerpc system with PCI, and some devices attached to the PCI 
> bus. In 3.10 everything worked fine, then we moved to 4.9 and we had 
> some issues. I was able to bisect the issue down to the patch in the 
> subject line.
> 
> f75b99d PCI: Enforce bus address limits in resource allocation
> 
> 
>  From 3.10 here is part of the PCI initialization,
> 
> |pci 0001:0e:00.0: BAR 0: assigned [mem 0xfc0000000-0xfc00fffff pref]|
> |pci 0001:07:09.0: PCI bridge to [bus 0e]|
> |pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]|
> |||In this section the memory resource for the bridge is 64bit, and the 
> device "BAR 0" gets a 64bit range. However, it seems the device is 32bit.|
> ||
> |Now fast forward to 4.9 we get this,|
> 
> ||
> |
> pci 0001:0e:00.0: BAR 0: no space for [mem size 0x00100000 pref]
> pci 0001:0e:00.0: BAR 0: failed to assign [mem size 0x00100000 pref]
> pci 0001:07:09.0: PCI bridge to [bus 0e]
> pci 0001:07:09.0: bridge window [mem 0xfc0000000-0xfc00fffff 64bit pref]
> 
> |
> |Here it seems to have a larger size, I'm not sure where the size is 
> coming from. I was able to work around the issue by setting 
> IORESOURCE_MEM_64 on the resource for this device. I also was able to 
> work around it by setting "max = avail.end" to "max = (-1);" inside 
> pci_bus_alloc_resource(). |
> ||
> ||I don't know if the problem is the patch, or something else inside our 
> system, but any thoughts are appreciated.
> 
> Daniel
> ||
> 
> ||
> 
> ||
> 
