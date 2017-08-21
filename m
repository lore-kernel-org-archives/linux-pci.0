Return-Path: <SRS0=rPrl=7X=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=rPrl=7X=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V10 2/3] PCI: handle CRS returned by device after FLR
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 alex.williamson@redhat.com, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org
References: <1502470596-4112-1-git-send-email-okaya@codeaurora.org>
 <1502470596-4112-2-git-send-email-okaya@codeaurora.org>
 <20170818210134.GO28977@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <4da26c10-3426-e752-4a59-25bb59cde8cd@codeaurora.org>
Date: Mon, 21 Aug 2017 09:44:09 -0400
MIME-Version: 1.0
In-Reply-To: <20170818210134.GO28977@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 8/18/2017 5:01 PM, Bjorn Helgaas wrote:
> On Fri, Aug 11, 2017 at 12:56:35PM -0400, Sinan Kaya wrote:
>> Sporadic reset issues have been observed with Intel 750 NVMe drive while
>> assigning the physical function to the guest machine. The sequence of
>> events observed is as follows:
>>
>> - perform a Function Level Reset (FLR)
>> - sleep up to 1000ms total
>> - read ~0 from PCI_COMMAND
>> - warn that the device didn't return from FLR
>> - touch the device before it's ready
>> - drop register read and writes performing register settings restore
>> - incomplete reset operation and partial register restoration
>> - second time device probe fails in the guest machine as HW is left in
>> limbo.
> 
> Pardon me while I think out loud for a while.  It's taking me a while
> to untangle my confusion about how CRS works.
> 

no problem,

> Prior to this patch, you saw the "Failed to return from FLR" warning.
> That means we did this:
> 
>      0ms  assert FLR
>    100ms  read PCI_COMMAND, get ~0 (i == 0)
>    200ms  read PCI_COMMAND, get ~0 (i == 1)
>    ...
>   1000ms  read PCI_COMMAND, get ~0 (i == 9)
> 
> If we did not get completions for those config reads, the root port
> would complete the read as a failed transaction and probably
> synthesize ~0 data.  

That's correct. This root port returns ~0 when destination is unreachable.

> But if that were the case, this patch would make
> no difference: it reads PCI_VENDOR_ID instead of PCI_COMMAND the first
> time around, that would also be a failed transaction, and we wouldn't
> interpret it as a CRS status, so the sequence would be exactly the
> above except the first read would be of PCI_VENDOR_ID, not
> PCI_COMMAND.
> 
> Since this patch *does* make a difference, CRS Software Visibility
> must be supported and enabled, and we must have gotten completions
> with CRS status for the PCI_COMMAND reads.  

That's right, CRS visibility is supported and enabled. Root port returns
0xFFFF0001 when vendor ID is read as per the spec.

> Per the completion
> handling rules in sec 2.3.2, the root complex should transparently
> retry the read (since we're not reading PCI_VENDOR_ID, CRS Software
> Visibility doesn't apply, so this is invisible to software).  But the
> root complex *is* allowed to limit the number of retries and if the
> limit is reached, complete the request as a failed transaction.

This version of the root port doesn't support retry mechanism. This is a
TO-DO for the hardware team. This root port returns ~0 for all accesses
other than vendor id. This means we waited 1 seconds and the device
was not accessible. Command register was not reachable at the end of
1 seconds.

> 
> That must be what happened before this patch.  If that's the case, we
> should see an error logged from the failed transaction.  We should be
> able to verify this if we collected "lspci -vv" output for the system
> before and after the FLR.
> 

See above.

> If CRS SV is not present (or not enabled), the PCI_VENDOR_ID read will
> still get a CRS completion, but the root port will retry it instead of
> returning the 0x0001 ID.  When we hit the retry limit, the root port
> will synthesize ~0 data to complete the read.

This is what is missing from the HW. I'm trying to get this corrected
to be complete.

> 
> That means we won't call pci_bus_wait_crs() at all, and we'll fall
> back to the original PCI_COMMAND reads.  That path will only wait
> 1000ms, just like the original code before this patch.  So I *think*
> that if you disable CRS SV on this system (or if you put the device in
> a system that doesn't support CRS SV), you'll probably see the same
> "failed to return from FLR" warning.
> 
> You could easily test this by using setpci to turn off
> PCI_EXP_RTCTL_CRSSVE in the root port leading to the NVMe device
> before the FLR.
> 
> I think the implication is that we need to generalize
> pci_bus_wait_crs() to be more of a "wait for device ready" interface
> that can use CRS SV (if supported and enabled) or something like the
> PCI_COMMAND loop (if no CRS SV).  It should use the same timeout
> either way, since CRS SV is a property of the root port, not of the
> device we're waiting for.

I saw your comment about timeout. I was trying not to change the behavior
for systems that do not support CRS visibility. we can certainly increase
the timeout if you think it is better.

I saw your V11, I'll review them in a minute.

> 
> It's "interesting" that the PCI core error handling code doesn't look
> at the Master Abort bit at all, even though it's pretty fundamental to
> conventional PCI error reporting.  I suspect Master Abort gets set
> whenever a root port synthesizes ~0 data, but (with the exception of
> some arch code) we never look at it and never clear it.
> 
>> An endpoint is allowed to issue Configuration Request Retry Status (CRS)
>> following a FLR request to indicate that it is not ready to accept new
>> requests. CRS is defined in PCIe r3.1, sec 2.3.1. Request Handling Rules
>> and CRS usage in FLR context is mentioned in PCIe r3.1, sec 6.6.2.
>> Function-Level Reset.
>>
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
>>  drivers/pci/pci.c | 23 +++++++++++++++++++++--
>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index af0cc34..c853551 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3821,17 +3821,36 @@ static void pci_flr_wait(struct pci_dev *dev)
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
>> +	if (pci_bus_read_config_dword(dev->bus, dev->devfn, PCI_VENDOR_ID,
>> +				      &id))
>> +		return;
>> +
>> +	/* See if we can find a device via CRS first. */
>> +	if ((id & 0xffff) == 0x0001) {
>> +		ret = pci_bus_wait_crs(dev->bus, dev->devfn, &id, 60000);
>> +		if (ret)
>> +			return;
>> +	}
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
>> -- 
>> 1.9.1
>>
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
