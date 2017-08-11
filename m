Return-Path: <SRS0=sI7x=7N=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=sI7x=7N=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V9 1/2] PCI: handle CRS returned by device after FLR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1502240245-11714-1-git-send-email-okaya@codeaurora.org>
 <20170810215218.GQ16580@bhelgaas-glaptop.roam.corp.google.com>
 <74b1fed6-4b3a-6053-2252-063462cffe4e@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <da77e691-d1a1-5c69-c23e-69656a82f8f5@codeaurora.org>
Date: Fri, 11 Aug 2017 12:54:47 -0400
MIME-Version: 1.0
In-Reply-To: <74b1fed6-4b3a-6053-2252-063462cffe4e@codeaurora.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/10/2017 6:32 PM, Sinan Kaya wrote:
>> Alex was concerned that pci_bus_read_dev_vendor_id() could return
>> false ("no device here") with an ID value of ~0 for a functional VF
>> [1].
>>
>> I think that is indeed possible:
>>
>>   - a VF that is ready will return 0xffff as both Vendor ID and Device
>>     ID (SR-IOV r1.1, sec 3.4.1.1, .2), so the very first read in
>>     pci_bus_read_dev_vendor_id() would see 0xffffffff and return
>>     "false".
>>
>>   - a VF that needs more time will return CRS and we'll loop in
>>     pci_bus_read_dev_vendor_id() until it becomes ready, and we'll
>>     return "true".
>>
>> Falling into the code below for the "false" case probably will work,
>> but it's a little bit ugly because (a) we're using two mechanisms to
>> figure out when the device is ready for config requests, and (b) we
>> have to worry about VFs both in pci_bus_read_dev_vendor_id() and here
>> in the caller.
> OK, I'm open to improving the code.
> 
>> Here's an idea to make pci_bus_read_dev_vendor_id() work for both VFs
>> and PFs.  It can't distinguish the 0xffffffff from a VF vs one from a
>> non-existent device, but the caller might be able to pass that
>> information in, e.g., when we're enumerating and don't know whether
>> the device exists, we don't have a pci_dev and would use this:
> How about creating a pci_bus_wait_crs() function with the loop in 
> pci_bus_read_dev_vendor_id() and calling it from both places?
> 

I prototyped both of the options. I found pci_bus_wait_crs() to be cleaner
due to this. 

is_vf looked like another hack like mine to tap into the CRS handling
inside the pci_bus_read_dev_vendor_id().

I think the right thing is to make CRS handling a first class citizen rather
than hiding it and overriding functions with unnecessary parameters.

I'll post V10 in a minute. It passed my testing.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
