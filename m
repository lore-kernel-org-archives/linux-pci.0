Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8046 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1171997AbdDXXGo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2017 19:06:44 -0400
Subject: Re: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
To: Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1492706123-22913-1-git-send-email-haiyangz@exchange.microsoft.com>
 <CAErSpo4iFS05Kk3Km54fFmpMf11XCoaPmGxSzqE3QuA5P=T6=Q@mail.gmail.com>
 <BLUPR03MB1412F7A0A693B67685D5FE9FCA1B0@BLUPR03MB1412.namprd03.prod.outlook.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <8ff72ec3-d61e-07d9-8c9d-92951195b67d@nvidia.com>
Date: Mon, 24 Apr 2017 16:06:37 -0700
MIME-Version: 1.0
In-Reply-To: <BLUPR03MB1412F7A0A693B67685D5FE9FCA1B0@BLUPR03MB1412.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/20/2017 11:37 AM, Haiyang Zhang wrote:
>> -----Original Message-----
>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> Sent: Thursday, April 20, 2017 2:33 PM
>> To: Haiyang Zhang <haiyangz@microsoft.com>
>> Cc: linux-pci@vger.kernel.org; KY Srinivasan <kys@microsoft.com>;
>> Stephen Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de;
>> vkuznets@redhat.com; driverdev-devel@linuxdriverproject.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH] pci-hyperv: Use only 16 bit integer for PCI domain
>>
>> On Thu, Apr 20, 2017 at 11:35 AM, Haiyang Zhang
>> <haiyangz@exchange.microsoft.com> wrote:
>>> From: Haiyang Zhang <haiyangz@microsoft.com>
>>>
>>> This patch uses the lower 16 bits of the serial number as PCI
>>> domain, otherwise some drivers may not be able to handle it.
>>
>> Can you give any more details about this?  Which drivers, for
>> instance?  Why do drivers care about the domain at all?  Can we or
>> should we make this more explicit and consistent in the PCI core,
>> e.g., pci_domain_nr() is currently defined to return "int"; maybe it
>> should be u32?  (Although I think "int" is the same size as "u32" on
>> all arches anyway).
> 
> It's Nvidia driver.
> 
> Piotr, could you explain why the driver expects 16 bit domain number?

Hi Haiyang and all,

First, a tiny nit about the patch: it would be good to add "Fixing a problem that was introduced 
with commit <4a9b0933bdfc>", in the patch commit message.

Piotr and I just now worked through both the driver and the ACPI/PCI history a little bit, and it 
brings up an interesting question: would it be better for the kernel, long-term, if we changed 
pci_domain_nr() and its callers to use 16 bit values (it's a mini-project, but not too hard)? I ask, 
because:

    a) the ACPI specification[1] says that PCI domains ("PCI Segment Groups") are 16 bits. The other 
16 bits are reserved. I'm concerned that if we don't clamp these to 16 bits in the kernel, virtual 
machines and other experimenters may continue to do things that cause problems--especially if 
ACPI/PCI ever tries to use those reserved 16 bits.

    b) A whirlwind survey of a few non-x86 arches shows that they are casting or truncating the PCI 
domain to 16 bits (here, if other, real linux-pci experts have some input, that would help!)

    c) Looking back at the original commit that added PCI domain support, Linux has specified the 
storage size as 32 bits, right from the start...but it looks like merely a convenience, rather than 
an exact match for a specification.

Please, let me emphasize that the driver can be changed to use 32 bits as well, no problem. But I 
really do want the kernel to have the most accurate and correct code, too, and it really looks (so 
far) like it wants to be 16 bits.

Also...it would be nice if we could use Haiyang's patch as at least a temporary fix, because distros 
are just today releasing the previous code, and HyperV will start breaking "occasionally", depending 
on whether the 32-bit virtual (fake) PCI domain fits within 16 bits. (If not, then we can rush out a 
driver update to fix it, but there will be a window of time with some breakage there.)


[1] http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf , seciton 6.5.6, page 397

thanks,

--
John Hubbard
NVIDIA

> 
> Thanks,
> - Haiyang
> 
