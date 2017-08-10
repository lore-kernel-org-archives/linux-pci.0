Return-Path: <SRS0=m5Nd=7M=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=m5Nd=7M=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V9 1/2] PCI: handle CRS returned by device after FLR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <1502240245-11714-1-git-send-email-okaya@codeaurora.org>
 <20170810215218.GQ16580@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <74b1fed6-4b3a-6053-2252-063462cffe4e@codeaurora.org>
Date: Thu, 10 Aug 2017 18:32:30 -0400
MIME-Version: 1.0
In-Reply-To: <20170810215218.GQ16580@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/10/2017 5:52 PM, Bjorn Helgaas wrote:
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
> 
> What's the driver-visible or user-visible effect of touching the
> device before it's ready?  This sequence is sort of like the joke
> without the punch line :)

The issue was first reported as a sporadic failure to assign NVMe
physical function to the guest machine and observing NVMe drive
initialization failures in the guest machine. I then repeated the problem
by creating a reset loop.

"NVMe (non-volatile memory) is not passing through to Virtual machine. 
NVMe is listed using lspci, however, the device is not listed using lsblk and 
fdisk -l. dmesg from virtual machine shows

root@null-8cfdf006971f:~# dmesg | grep nvme
[ 1.648842] nvme nvme0: pci function 0000:02:01.0
[ 1.650176] nvme 0000:02:01.0: enabling device (0000 -> 0002)
[ 2.547091] [<ffff000000a4c8e0>] nvme_irq [nvme]
[ 70.795558] nvme nvme0: I/O 203 QID 0 timeout, disable controller
[ 70.904369] nvme nvme0: Removing after probe failure status: -4"

I can include this into the commit message. 

> 
>> An endpoint is allowed to issue Configuration Request Retry Status (CRS)
>> following a FLR request to indicate that it is not ready to accept new
>> requests. CRS is defined in PCIe r3.1, sec 2.3.1. Request Handling Rules
>> and CRS usage in FLR context is mentioned in PCIe r3.1a, sec 6.6.2.
>> Function-Level Reset.
> 
> You reference both PCIe r3.1 and r3.1a.  Is there something new in
> r3.1a in this area?  If not, just reference r3.1 for both cases.

I can use r3.1. I have r3.1a. I'm not sure if the chapter numbers match or not.

> 
>> A CRS indication will only be given if the address to be read is vendor ID
>> register. pci_bus_read_dev_vendor_id() knows how to deal with CRS returned
>> 0xFFFF0001 value and will continue polling until a value other than
>> 0xFFFF0001 is returned within a given timeout.
>>
>> Try to discover device presence via CRS first. If device is not found, fall
>> through to old behavior.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/pci/pci.c | 26 ++++++++++++++++++++++++--
>>  1 file changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index af0cc34..4366299 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3821,17 +3821,39 @@ static void pci_flr_wait(struct pci_dev *dev)
>>  {
>>  	int i = 0;
>>  	u32 id;
>> +	bool ret;
>> +
>> +	/*
>> +	 * Don't touch the HW before waiting 100ms. HW has to finish
>> +	 * within 100ms according to PCI Express Base Specification
>> +	 * Revision 3.1 Section 6.6.2: Function-Level Reset (FLR).
>> +	 */
>> +	msleep(100);
>> +
>> +	/*
>> +	 * See if we can find a device via CRS first. Physical functions
>> +	 * return from here if found, Virtual functions fall through as
>> +	 * they return ~0 on vendor id read once CRS is completed.
>> +	 */
>> +	ret = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
>> +					 60000);
>> +	if (ret)
>> +		return;
> 
> Alex was concerned that pci_bus_read_dev_vendor_id() could return
> false ("no device here") with an ID value of ~0 for a functional VF
> [1].
> 
> I think that is indeed possible:
> 
>   - a VF that is ready will return 0xffff as both Vendor ID and Device
>     ID (SR-IOV r1.1, sec 3.4.1.1, .2), so the very first read in
>     pci_bus_read_dev_vendor_id() would see 0xffffffff and return
>     "false".
> 
>   - a VF that needs more time will return CRS and we'll loop in
>     pci_bus_read_dev_vendor_id() until it becomes ready, and we'll
>     return "true".
> 
> Falling into the code below for the "false" case probably will work,
> but it's a little bit ugly because (a) we're using two mechanisms to
> figure out when the device is ready for config requests, and (b) we
> have to worry about VFs both in pci_bus_read_dev_vendor_id() and here
> in the caller.

OK, I'm open to improving the code.

> 
> Here's an idea to make pci_bus_read_dev_vendor_id() work for both VFs
> and PFs.  It can't distinguish the 0xffffffff from a VF vs one from a
> non-existent device, but the caller might be able to pass that
> information in, e.g., when we're enumerating and don't know whether
> the device exists, we don't have a pci_dev and would use this:

How about creating a pci_bus_wait_crs() function with the loop in 
pci_bus_read_dev_vendor_id() and calling it from both places?

> 
>   pci_bus_read_dev_vendor_id(bus, devfn, &l, 60000, 0)
> 
> While places where we do have a pci_dev and expect the device to exist
> (e.g., waiting after a reset), would do this:
> 
>   pci_bus_read_dev_vendor_id(bus, devfn, &l, 60000, dev->is_virtfn)
> 
> And we would skip the 0xffffffff check for VFs, e.g.,
> 
>   bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>                                   int crs_timeout, int is_vf)
>   {
>     if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
>       return false;
> 
>     if (!is_vf &&
>         (*l == 0xffffffff || *l == 0x00000000 ||
>          *l == 0x0000ffff || *l == 0xffff0000))
>         return false;
> 
>     while ((*l & 0xffff) == 0x0001) {
>       ...
>       if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
> 	return false;
>     }
> 
>     return true;
>   }
> 
> Would that work?
> 
> I don't know if this would be the best solution.  This is a messy
> area.  We're relying on the host bridge to fabricate the 0xffff data
> for non-existent devices, and most (maybe all) do that, but I don't
> think that's actually in the spec.

AFAIK, returning 0xFFFFFFFF is a very typical practice. I don't know
the spec reference either.

> 
>> +	pci_read_config_dword(dev, PCI_COMMAND, &id);
>> +	if (id != ~0)
>> +		return;
>>  
>>  	do {
>>  		msleep(100);
>>  		pci_read_config_dword(dev, PCI_COMMAND, &id);
>> -	} while (i++ < 10 && id == ~0);
>> +	} while (i++ < 9 && id == ~0);
>>
>>  	if (id == ~0)
>>  		dev_warn(&dev->dev, "Failed to return from FLR\n");
>>  	else if (i > 1)
>>  		dev_info(&dev->dev, "Required additional %dms to return from FLR\n",
>> -			 (i - 1) * 100);
>> +			 i * 100);
>>  }
>>  
>>  /**
> 
> [1] http://lkml.kernel.org/r/20170221135138.791ba4e2@t450s.home
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
