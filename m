Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH for-rc v2 3/3] IB/hfi1: Prefer new
 __pci_reset_function_locked() API with reset type
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Dennis Dalessandro <dennis.dalessandro@intel.com>,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20180905160805.5680-1-okaya@kernel.org>
 <20180905160805.5680-3-okaya@kernel.org>
 <20180912010929.GA118330@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <c0f524c3-5b3f-f796-6a6b-3040db4462a3@kernel.org>
Date: Tue, 11 Sep 2018 21:23:31 -0400
MIME-Version: 1.0
In-Reply-To: <20180912010929.GA118330@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 9/11/2018 9:09 PM, Bjorn Helgaas wrote:
> On Wed, Sep 05, 2018 at 04:08:05PM +0000, Sinan Kaya wrote:
>> pci_reset_bus() is being called from the probe context and causes
>> a deadlock since pci_reset_bus() also tries to obtain kernel lock.
> 
> This doesn't tell me what the deadlock is.

Sorry, let me try to set the context.

Driver probe routine is being called with pci_dev_lock() held.

pci_reset_bus() tries to obtain the pci_dev_lock() via this path one
more time while holding the lock.

pci_dev_lock()
	enter driver probe()
	pci_reset_bus()
		 __pci_reset_bus()
			pci_bus_save_and_disable()
				pci_dev_lock()

	exit driver probe()
pci_dev_unlock()


> 
>> Use __pci_reset_function_locked() that provides locking guarantees.
> 
> And the previous patch that adds the "reset_type" parameter doesn't
> tell me anything about what locking guarantees it provides.

This is sort of implied.

As the name of the function is __pci_reset_function_locked(), it is
assumed that the caller is responsible for obtaining the necessary
locks before calling this function.

> 
> I want to merge minimal changes for v4.19 to fix the known problems.
> 
> It's not clear to me what actually broke hfi1.  You mention a deadlock
> above, so I assume some locking change broke it, but 811c5cb37df4 isn't
> obviously related to locking.

Previous code was calling secondary bus reset function directly. With the
generalization of the code, we are going through device save and restore
as follows:

1. obtain device lock
2. save device state
3. release device lock
4. perform secondary bus reset
5. obtain device lock
6. restore device state
7. release device lock

We have introduced the locks in step #1, #3, #5 and #7 into the existing
code path.

> 
> It's obvious that 811c5cb37df4 tested the return value of
> pci_probe_reset_slot() incorrectly, so there's no problem with patch 1/1.
> 

yup.

> But patches 2 & 3:
> 
>    PCI: Request reset type as part of function reset
>    IB/hfi1: Prefer new __pci_reset_function_locked() API with reset type
> 
> do not connect the dots for me.

I hope the above explanation helps. The consensus after conversation with Alex
was to reuse the locked API but add masks so that requester can selectively
request a slot reset without any locks.

> 
>> Fixes: 811c5cb37df4 ("PCI: Unify try slot and bus reset API")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200985
>> Signed-off-by: Sinan Kaya <okaya@kernel.org>
>> ---
>>   drivers/infiniband/hw/hfi1/pcie.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
>> index eec83757d55f..13162289b748 100644
>> --- a/drivers/infiniband/hw/hfi1/pcie.c
>> +++ b/drivers/infiniband/hw/hfi1/pcie.c
>> @@ -900,7 +900,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
>>   	 * delay after a reset is required.  Per spec requirements,
>>   	 * the link is either working or not after that point.
>>   	 */
>> -	return pci_reset_bus(dev);
>> +	return __pci_reset_function_locked(dev, PCI_RESET_LINK);
>>   }
>>   
>>   /*
>> -- 
>> 2.18.0
>>
> 
