Return-Path: <SRS0=5vAC=IL=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=5vAC=IL=codeaurora.org=okaya@kernel.org>
Subject: Re: pci=earlydump on ARM
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Linux PCI <linux-pci@vger.kernel.org>
References: <bug-199671-164391@https.bugzilla.kernel.org/>
 <bug-199671-164391-E4Mtn0How4@https.bugzilla.kernel.org/>
 <9756cf4c-0cec-00f7-3cc6-f09e34177cf9@codeaurora.org>
 <20180523195322.GC150632@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <c92b7445-9e6f-8b82-da0a-2f50ed9baaa5@codeaurora.org>
Date: Thu, 24 May 2018 07:54:53 -0400
MIME-Version: 1.0
In-Reply-To: <20180523195322.GC150632@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 5/23/2018 3:53 PM, Bjorn Helgaas wrote:
> On Wed, May 23, 2018 at 03:10:39PM -0400, Sinan Kaya wrote:
>>> If that doesn't work or you'd rather brute-force it, you could try
>>> doing something like "pci=earlydump".  This is currently only
>>> implemented for x86, so it would be some work to implement something
>>> similar for arm64.  It would be a nice upstream addition if you *did*
>>> implement it.
>>>
>>> In the earlydump output I would be looking for clues about the power
>>> state of 03:00.0 to try to figure out if the bootloader left it powered
>>> off or if Linux is doing something to turn it off.
>>>
>>
>> Is it really possible to implement a generic version of this?
>>
>> PCI on ARM64 is not really unified. There are several host bridge drivers
>> for different types of access. 
>>
>> If we limit the functionality to ACPI, the answer is still maybe if we
>> can pass the base address of the MMCONFIG region. 
>>
>> All products use a different MMCONFIG region.
> 
> On x86, early dump is implemented off to the side, outside the PCI
> core, and it takes advantage of arch-specific knowledge about ways to
> perform config accesses.
> 
> But I could imagine something in the pci_scan_device() area, where we
> have the normal config accessors but we haven't yet touched the
> device.  I think we could get 99% of the early dump utility in a
> completely generic way.
> 
> There might be a few hand-crafted arch-specific quirks that touch PCI
> devices even before that point, but those should be pretty rare.

I see, you just want to dump the config space of each device as code is
walking the bus while scanning. This should be doable.

I'll see what I can do.

> 
> Bjorn
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
