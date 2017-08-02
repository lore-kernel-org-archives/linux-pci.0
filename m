Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V5 2/2] PCI: handle CRS returned by device after FLR
To: Alex Williamson <alex.williamson@redhat.com>
References: <1501645453-22842-1-git-send-email-okaya@codeaurora.org>
 <1501645453-22842-2-git-send-email-okaya@codeaurora.org>
 <20170801224440.3f677a8d@w520.home>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <fc84cb54-1771-45cd-d01f-b88dc833baf2@codeaurora.org>
Date: Wed, 2 Aug 2017 11:42:27 -0400
MIME-Version: 1.0
In-Reply-To: <20170801224440.3f677a8d@w520.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

On 8/2/2017 12:44 AM, Alex Williamson wrote:
> On Tue,  1 Aug 2017 23:44:13 -0400
> Sinan Kaya <okaya@codeaurora.org> wrote:
> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 2ed604a..25c7a83 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3813,14 +3813,16 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>>  
>>  /*
>>   * We should only need to wait 100ms after FLR for virtual functions.
>> - * Wait for up to 1000ms for config space to return something other than -1.
>> - * Intel IGD requires this when an LCD panel is attached.  We read the 2nd
>> - * dword because VFs don't implement the 1st dword.
>> + * Wait for up to 60s for config space to return something other than -1.
>> + * Intel IGD requires 1s when an LCD panel is attached.  We use
>> + * pci_bus_read_dev_vendor_id() for reading the vendor ID as it handles
>> + * CRS gracefully.
> 
> nit, stating that IGD requires 1s with an LCD panel is a
> misinterpretation of the previous comment.  In fact the original commit
> only mentions 300ms.  I think perhaps 1s was simply a nice round
> interval.

I can fix the comment as 300ms to be correct. 

> 
>>   */
>>  static void pci_flr_wait(struct pci_dev *dev)
>>  {
>>  	int i = 0;
>>  	u32 id;
>> +	bool ret;
>>  
>>  	if (dev->is_virtfn) {
>>  		msleep(100);
>> @@ -3828,15 +3830,15 @@ static void pci_flr_wait(struct pci_dev *dev)
>>  	}
>>  
>>  	do {
>> -		msleep(100);
>> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
>> -	} while (i++ < 10 && id == ~0);
>> +		ret = pci_bus_read_dev_vendor_id(dev->bus, dev->devfn, &id,
>> +						 1000);
> 
> Is it a problem that there's now zero delay between the FLR and first
> attempt to read config space?  

I agree, we should wait 100ms before attempting to do anything.

> Seems like there should be a 100ms
> delay before we start trying.  This is also going to print a kernel
> warning 60 times in the course of getting to a 60s timeout, why not let
> pci_bus_read_dev_vendor_id() manage the entire timeout?  

Bjorn was concerned that if a device is taking too long to come out of reset, 
there won't be any visible output on the screen and somebody might be under the
impression that system is frozen even though we are just busy waiting. 

That's why, I tried to introduce some verbosity.

What I can do is instead of polling 60 times, I can follow a similar pattern
in vendor_id() function and sleep 1 second first, followed by 2 seconds, followed
by 4 seconds etc. to be less verbose. 

User will still see a warning on each read loop that failed. At least, we won't 
fill the screen with warning messages.

> Are we only
> trying to preserve the dev_info() below?  Thanks,

Yes and no, we want to see the progress of polling and a final result. 60 seconds
is a very long time.

> 
> Alex
> 
>> +	} while (i++ < 60 && !ret);
>>  
>> -	if (id == ~0)
>> +	if (!ret)
>>  		dev_warn(&dev->dev, "Failed to return from FLR\n");
>>  	else if (i > 1)
>> -		dev_info(&dev->dev, "Required additional %dms to
>> return from FLR\n",
>> -			 (i - 1) * 100);
>> +		dev_info(&dev->dev, "Required additional %ds to
>> return from FLR\n",
>> +			 (i - 1));
>>  }
>>  
>>  /**
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
