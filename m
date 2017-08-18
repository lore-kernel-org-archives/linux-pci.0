Return-Path: <SRS0=obu3=7U=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=obu3=7U=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V10 1/3] PCI: introduce pci_bus_wait_crs() function
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org
References: <1502470596-4112-1-git-send-email-okaya@codeaurora.org>
 <20170818030009.GK28977@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <255545a4-0481-e77a-63ad-260d02a43131@codeaurora.org>
Date: Fri, 18 Aug 2017 09:33:11 -0400
MIME-Version: 1.0
In-Reply-To: <20170818030009.GK28977@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/17/2017 11:00 PM, Bjorn Helgaas wrote:
> On Fri, Aug 11, 2017 at 12:56:34PM -0400, Sinan Kaya wrote:
>> Kernel is hiding Configuration Request Retry Status (CRS) inside
>> pci_bus_read_dev_vendor_id() function. We are looking to add support for
>> Function Level Reset (FLR) where vendor id read returns ~0.
>>
>> Move CRS handling into its own function so that it can be called from other
>> places as well.
> 
> I think this is a much better idea than what I proposed.  I still have
> a few questions proposals.  I'll post a v11 to show what I'm thinking.
> 

Sure, let me know. I can test it.

>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/pci/pci.h   |  2 ++
>>  drivers/pci/probe.c | 44 ++++++++++++++++++++++++++++++--------------
>>  2 files changed, 32 insertions(+), 14 deletions(-)
>>

>>  		msleep(delay);
>>  		delay *= 2;
>>  		if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
>> @@ -1858,6 +1846,34 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>>  			       PCI_FUNC(devfn));
>>  			return false;
> 
> While staring at this, I think I found a pre-existing bug in
> pci_bus_read_dev_vendor_id().  It looks like this:
> 
>   while ((*l & 0xffff) == 0x0001) {
>     pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l);
>     if (delay > crs_timeout)
>       return false;
>   }
> 
> The problem is that the config read may have *succeeded* that last
> time before we time out.  I think the correct sequence is:
> 
>   - check for timeout
>   - read PCI_VENDOR_ID
>   - check for CRS
> 

Yeah, it makes sense.

>>  		}
>> +	} while ((*l & 0xffff) == 0x0001);
>> +
>> +	return true;
>> +}
>> +EXPORT_SYMBOL(pci_bus_wait_crs);
> 
> I don't think we need EXPORT_SYMBOL here, do we?

copy/paste mistake. 

> 
>> +bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>> +				int crs_timeout)
>> +{
>> +	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
>> +		return false;
>> +
>> +	/* some broken boards return 0 or ~0 if a slot is empty: */
>> +	if (*l == 0xffffffff || *l == 0x00000000 ||
>> +	    *l == 0x0000ffff || *l == 0xffff0000)
>> +		return false;
>> +
>> +	/*
>> +	 * Configuration Request Retry Status.  Some root ports return the
>> +	 * actual device ID instead of the synthetic ID (0xFFFF) required
>> +	 * by the PCIe spec.  Ignore the device ID and only check for
>> +	 * (vendor id == 1).
>> +	 */
>> +	if ((*l & 0xffff) == 0x0001) {
>> +		if (!crs_timeout)
>> +			return false;
> 
> One thing I don't like is that every caller of pci_bus_wait_crs() has
> to know about the 0x0001 value.

Another helper function? I was trying to poll for CRS completion only
if we know that we are observing CRS.

> 
>> +		return pci_bus_wait_crs(bus, devfn, l, crs_timeout);
>>  	}
>>  
>>  	return true;
>> -- 
>> 1.9.1
>>
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
