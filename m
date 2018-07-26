Return-Path: <SRS0=wylM=KK=oracle.com=thomas.tai@kernel.org>
Return-Path: <SRS0=wylM=KK=oracle.com=thomas.tai@kernel.org>
Subject: Re: [PATCH V3, 1/1] PCI/AER: fix use-after-free in
 pcie_do_fatal_recovery
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, keith.busch@intel.com, linux-pci@vger.kernel.org,
        poza@codeaurora.org
References: <1532030555-7177-1-git-send-email-thomas.tai@oracle.com>
 <1532030555-7177-2-git-send-email-thomas.tai@oracle.com>
 <20180725202420.GA173328@bhelgaas-glaptop.roam.corp.google.com>
 <90c59775-a344-c58a-89c3-511a44839365@oracle.com>
 <20180726171853.GC173328@bhelgaas-glaptop.roam.corp.google.com>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <a7e1676c-b9aa-ec93-7ab8-bf7a47ce3d53@oracle.com>
Date: Thu, 26 Jul 2018 13:23:05 -0400
MIME-Version: 1.0
In-Reply-To: <20180726171853.GC173328@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>


On 07/26/2018 01:18 PM, Bjorn Helgaas wrote:
> On Thu, Jul 26, 2018 at 10:29:18AM -0400, Thomas Tai wrote:
>> [ ... ]>
>>> I know I suggested this strategy, but I think this ended up being more
>>> complicated than it's worth.
>>>
>>> The problem code in pcie_do_fatal_recovery() essentially looks like
>>> this:
>>>
>>>     pcie_do_fatal_recovery(dev)
>>>       pci_stop_and_remove_bus_device(dev);
>>>       reset_link(dev);
>>>       pci_cleanup_aer_uncorrect_error_status(dev);
>>>       pcie_wait_for_link(dev, ...);
>>>       pci_uevent_ers(dev, ...);
>>>       pci_info(dev, ...);
>>>
>>> Some of this depends on the device type (bridge vs. endpoint) and the
>>> caller (AER vs. DPC), but given the right conditions, we can exercise
>>> all the above calls.
>>>
>>> I think it is just broken that we keep doing things with "dev" after
>>> removing it.  IMHO this code should be restructured to avoid that.
>>>
>>> I think fiddling with the refcount as in this patch adds too much
>>> complexity and makes it look like the current structure of
>>> pcie_do_fatal_recovery() is reasonable when it really isn't.
>>>
>>> But restructuring pcie_do_fatal_recovery() is too big a project to do
>>> before v4.18, and we need to fix this problem.  I propose that we
>>> merge your v2 patch for now, so at least the band-aid is in the
>>> function that I think is broken.
>>>
>>> I *would* like to reduce the scope of the get/put as in the patch
>>> below, though, so it is contained inside the rescan_remove lock.
>>> Could you try it and make sure it's still enough to avoid the problem?
>>> If it is, I'll add your sign-off and get this in v4.18.
>>
>> Hi Bjorn,
>> Thank you for your review and the details analysis. Sure, let's do the work
>> around for now. I retested your patch below and works fine. You are welcome
>> to add my signed-off and get this in v4.18.
> 
> OK, I added your signed-off-by and put the patch below on my for-linus
> branch for v4.18.

Cool. Thank you Bjorn.

> 
>> As far as reworking the pcie_do_fatal_recovery() goes, would you think I can
>> help out in any way? May be I can try rework the code to not use the dev
>> after it is removed.
> 
> That'd be great!  I expect Oza and Keith will have useful insight
> there, too, so keep them in the loop.

Sure, I will keep Oza and Keith in the loop too.

Thank you,
Thomas


> 
>>> commit 277ce38f2ed6a4310acf3bd541fb3aee4ec27dee
>>> Author: Thomas Tai <thomas.tai@oracle.com>
>>> Date:   Tue Jul 24 16:47:59 2018 -0500
>>>
>>>       PCI/AER: Work around use-after-free in pcie_do_fatal_recovery()
>>>       When an fatal error is received by a non-bridge device, the device is
>>>       removed, and pci_stop_and_remove_bus_device() deallocates the device
>>>       structure.  The freed device structure is used by subsequent code to send
>>>       uevents and print messages.
>>>       Hold a reference on the device until we're finished using it.  This is not
>>>       an ideal fix because pcie_do_fatal_recovery() should not use the device at
>>>       all after removing it, but that's too big a project for right now.
>>>       #
>>>       [bhelgaas: changelog, reduce get/put coverage]
>>>       Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>> index fdbcc555860d..674984a9277a 100644
>>> --- a/drivers/pci/pcie/err.c
>>> +++ b/drivers/pci/pcie/err.c
>>> @@ -291,6 +291,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
>>>    	parent = udev->subordinate;
>>>    	pci_lock_rescan_remove();
>>> +	pci_dev_get(dev);
>>>    	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
>>>    					 bus_list) {
>>>    		pci_dev_get(pdev);
>>> @@ -325,6 +326,7 @@ void pcie_do_fatal_recovery(struct pci_dev *dev, u32 service)
>>>    		pci_info(dev, "Device recovery from fatal error failed\n");
>>>    	}
>>> +	pci_dev_put(dev);
>>>    	pci_unlock_rescan_remove();
>>>    }
>>>
>>>> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
>>>> ---
>>>>    drivers/pci/pcie/aer.c | 27 +++++++++++++++++++++++++--
>>>>    1 file changed, 25 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index a2e8838..6e5e6a5 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -657,6 +657,10 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
>>>>    static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>>>>    {
>>>>    	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
>>>> +		/* increment reference count to keep the dev
>>>> +		 * around until remove_source_device()
>>>> +		 */
>>>> +		pci_dev_get(dev);
>>>>    		e_info->dev[e_info->error_dev_num] = dev;
>>>>    		e_info->error_dev_num++;
>>>>    		return 0;
>>>> @@ -665,6 +669,21 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>>>>    }
>>>>    /**
>>>> + * remove_source_device -remove error devices from the e_info
>>>> + * @e_info: pointer to error info
>>>> + */
>>>> +static void remove_source_device(struct aer_err_info *e_info)
>>>> +{
>>>> +	struct pci_dev *dev;
>>>> +
>>>> +	while (e_info->error_dev_num > 0) {
>>>> +		e_info->error_dev_num--;
>>>> +		dev = e_info->dev[e_info->error_dev_num];
>>>> +		pci_dev_put(dev);
>>>> +	}
>>>> +}
>>>> +
>>>> +/**
>>>>     * is_error_source - check whether the device is source of reported error
>>>>     * @dev: pointer to pci_dev to be checked
>>>>     * @e_info: pointer to reported error info
>>>> @@ -976,8 +995,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>>>>    			e_info->multi_error_valid = 0;
>>>>    		aer_print_port_info(pdev, e_info);
>>>> -		if (find_source_device(pdev, e_info))
>>>> +		if (find_source_device(pdev, e_info)) {
>>>>    			aer_process_err_devices(e_info);
>>>> +			remove_source_device(e_info);
>>>> +		}
>>>>    	}
>>>>    	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
>>>> @@ -995,8 +1016,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>>>>    		aer_print_port_info(pdev, e_info);
>>>> -		if (find_source_device(pdev, e_info))
>>>> +		if (find_source_device(pdev, e_info)) {
>>>>    			aer_process_err_devices(e_info);
>>>> +			remove_source_device(e_info);
>>>> +		}
>>>>    	}
>>>>    }
>>>> -- 
>>>> 1.8.3.1
>>>>
