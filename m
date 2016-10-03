Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH V2 3/5] PCI: save and restore bus on parent bus reset
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
 <1474056395-21843-4-git-send-email-okaya@codeaurora.org>
 <20160929214942.GD20897@localhost>
 <8dbad89c-2646-773a-e114-42d21ce14cc7@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org,
 alex.williamson@redhat.com, vikrams@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <3bca2bc1-bc7e-ad71-eb66-b74f6e0b381b@codeaurora.org>
Date: Sun, 2 Oct 2016 23:34:13 -0400
MIME-Version: 1.0
In-Reply-To: <8dbad89c-2646-773a-e114-42d21ce14cc7@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 9/29/2016 7:50 PM, Sinan Kaya wrote:
> Hi Bjorn,
> 
> On 9/29/2016 5:49 PM, Bjorn Helgaas wrote:
>>> +	}
>> This pattern of "unlock, do something, relock" needs some
>> justification.  In general it's unsafe because the lock is protecting
>> *something*, and you have to assume that something can change as soon
>> as you unlock.  Maybe you know it's safe in this situation, and if so,
>> the explanation of why it's safe is what I'm looking for.
> 
> Agreed. 
> 
> The problem is that save and restore routines obtain the lock again and
> they fails as the lock is already held.
> 
> The alternative is to change the dev_locks in save and restore to try_lock
> so that it will work if locks were previously obtained or not. 
> 
>>
>> Also, you're now calling pci_reset_bridge_secondary_bus() with the dev
>> unlocked, where we called it with the dev locked before.  Some (but
>> worryingly, not all) of the other pci_reset_bridge_secondary_bus()
>> callers also have the dev locked.  I didn't look long enough to figure
>> out if there is a strategy there or if these inconsistencies are
>> latent bugs.
>>
> 
> The goal of this routine is to reset the device not the bridge and the code
> will use FLR or others if available. Therefore, it makes perfect sense to
> obtain the device lock while doing this. 
> 
> The code tries to reset the bus if none of the other resets work. This is
> where the problem is. It destroys the context for other devices.
> 
> I can fix get rid of this unlock, do something and then lock again business
> by rewriting the locks in save and restore.
> 
> Sinan
> 

I looked at the code a little bit more. I missed the fact pci_parent_bus_reset
will only work if there is only PCI device on the bus and that device is the
reset requesting device.

I'll drop this patch as well as the infiniband version for the same reason.




-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
