Return-Path: <SRS0=sI7x=7N=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=sI7x=7N=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V9 1/2] PCI: handle CRS returned by device after FLR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1502240245-11714-1-git-send-email-okaya@codeaurora.org>
 <20170810215937.GR16580@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <31155fef-1deb-aad7-ee9d-dc5250214e99@codeaurora.org>
Date: Thu, 10 Aug 2017 23:06:32 -0400
MIME-Version: 1.0
In-Reply-To: <20170810215937.GR16580@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/10/2017 5:59 PM, Bjorn Helgaas wrote:
> On Tue, Aug 08, 2017 at 08:57:24PM -0400, Sinan Kaya wrote:
>> Sporadic reset issues have been observed with Intel 750 NVMe drive by
>> writing to the reset file in sysfs in a loop. The sequence of events
>> observed is as follows:
>>
>> - perform a Function Level Reset (FLR)
>> - sleep up to 1000ms total
>> - read ~0 from PCI_COMMAND
>> - warn that the device didn't return from FLR
>> - touch the device before it's ready
>>
>> An endpoint is allowed to issue Configuration Request Retry Status (CRS)
>> following a FLR request to indicate that it is not ready to accept new
>> requests. CRS is defined in PCIe r3.1, sec 2.3.1. Request Handling Rules
>> and CRS usage in FLR context is mentioned in PCIe r3.1a, sec 6.6.2.
>> Function-Level Reset.
> 
> Don't we have a similar issue for other types of reset?  I would think
> conventional reset, e.g., using secondary bus reset, hotplug slot
> power, power management, etc., would have the same situation where a
> device might return CRS status.
> 

Yes, same issue exists on secondary bus reset. V1-V3 of this series tried to
address this but I couldn't find a solution that is not intrusive. 

I was told that hot reset is a broadcast message. Therefore, we need to handle
CRS for every single device in the tree following a bus reset.

Hotplug code is calling the vendor id read function after power on so it doesn't
have this issue.

I picked up this issue between v4..v9 due to an actual bug reported during our
internal testing. Otherwise, this issue was in rest waiting for review feedback.

CRS handling in hot reset is still open. We can move onto that issue once
we close the FLR.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
