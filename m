Return-Path: <SRS0=B9Eb=ZJ=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=B9Eb=ZJ=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH] PCI/ASPM: reconfigure ASPM following hotplug
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1485471092-16906-1-git-send-email-okaya@codeaurora.org>
 <20170127170755.GB17251@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <307c5f0f-122d-fc56-8cbf-363a727af75c@codeaurora.org>
Date: Fri, 27 Jan 2017 14:30:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170127170755.GB17251@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
Thanks for the review. Other feedback below.

On 1/27/2017 12:07 PM, Bjorn Helgaas wrote:
> Hi Sinan,
> 
> On Thu, Jan 26, 2017 at 05:51:32PM -0500, Sinan Kaya wrote:
>> When the operating system is booted with the default ASPM policy,
>> the current code is determining the ASPM policy by querying the
>> enable/disable states from ASPM registers.
>>
>> In the case of hotplug removal, the ASPM registers get cleared by
>> calling the exit function.
> 
> I assume you mean pcie_aspm_exit_link_state().  It'd be easier if you
> were specific about that.

Sure, I can do that. 

> 
> But I don't know whether this is relevant anyway.  In a surprise
> removal we won't call pcie_aspm_exit_link_state(), will we?

Let me check. I have tested surprise removal before but
I'm not sure about the ASPM following insertion to a surprise removal. 

According to the specification, a hotplug capable OS needs to handle
surprise removal and uninstall drivers. I have seen this happen before.
I expect to end up in pcie_aspm_exit_link_state again. See the data
link layer interrupt registered in the HPE. It is waiting for link
down and up events regardless of attention button or not.

I'm about to confirm....

pciehp 0000:00:00.0:pcie004:_slot(1):_Link_Down_event
e1000e 0000:01:00.0: Disabling ASPM  L1
e1000e 0000:01:00.0: Refused to change power state, currently in D3
pci 0000:01:00.0: pcie_aspm_exit_link_state:649
pcieport 0000:00:00.0: AER: Device recovery successful

yes, exit gets called.


> 
>> An insertion following remove reads incorrect policy as disabled
>> even though ASPM was enabled during boot.
>>
>> Adding a flag to the struct pci_dev and saving the power up policy
>> in the bridge to be reused during hotplug insertion. Bridge's enable
>> counter is used as a switch to determine when to use saved value.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/pci/pcie/aspm.c | 13 ++++++++++---
>>  include/linux/pci.h     |  1 +
>>  2 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 17ac1dc..32b8a86 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -338,7 +338,9 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>>  	}
>>  }
>>  
>> -static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>> +static
>> +void pcie_aspm_cap_init(struct pci_dev *pdev, struct pcie_link_state *link,
>> +			int blacklist)
>>  {
>>  	struct pci_dev *child, *parent = link->pdev;
>>  	struct pci_bus *linkbus = parent->subordinate;
>> @@ -398,7 +400,12 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>>  	link->latency_dw.l1 = calc_l1_latency(dwreg.latency_encoding_l1);
>>  
>>  	/* Save default state */
>> -	link->aspm_default = link->aspm_enabled;
>> +	if (!atomic_read(&pdev->enable_cnt)) {
>> +		link->aspm_default = link->aspm_enabled;
>> +		pdev->aspm_default = link->aspm_default;
>> +	} else {
>> +		link->aspm_default = pdev->aspm_default;
>> +	}
> 
> This connection with enable_cnt is too obtuse.  There's no obvious
> connection between enabling the device and computing the default ASPM
> state.

I was looking for a way to figure out if this is the first time boot
or insertion. I'm open to suggestions on what a good flag is.

> 
> We're working on the bridge (the upstream end of a link).  If I
> understand correctly, the case of interest here is where the bridge
> stays put and an endpoint below the bridge is removed and re-added.

Correct, the bridge remains in the PCI bus, it is just the endpoint
is getting removed and inserted back. However bridge's ASPM registers
also got cleared while disabling ASPM on the endpoint.


> Why can't we figure out the policy the same way as when we first
> enumerated the bridge?

The difference on first time enumeration and new enumeration is on the
first time, ASPM is setup by the firmware before OS boot. 

In the new enumeration following hotplug insertion, ASPM is disabled
and there is no firmware to set it up.

> 
> In POLICY_PERFORMANCE and POLICY_POWERSAVE, I assume the original BIOS
> configuration doesn't matter.  Maybe the point here is to remember the
> original BIOS configuration for POLICY_DEFAULT?  If so, the patch
> should mention POLICY_DEFAULT somehow to help the reader connect the
> dots.

Right, we want to know the policy set up by BIOS only when POLICY_DEFAULT
is specified. 

POLICY_POWERSAVE option does set things up regardless of what the BIOS says. 
Similarly, POLICY_PERFORMANCE is going to disable ASPM for obvious reasons.

I can add a few words to the commit message. 

> 
>>  	/* Setup initial capable state. Will be updated later */
>>  	link->aspm_capable = link->aspm_support;
>> @@ -599,7 +606,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>>  	 * upstream links also because capable state of them can be
>>  	 * update through pcie_aspm_cap_init().
>>  	 */
>> -	pcie_aspm_cap_init(link, blacklist);
>> +	pcie_aspm_cap_init(pdev, link, blacklist);
> 
> I think "link" is always "pdev->link_state", so we should be able to
> pass only "pdev" here, and pcie_aspm_cap_init() could use
> pdev->link_state internally.

I can do that.

> 
>>  	/* Setup initial Clock PM state */
>>  	pcie_clkpm_cap_init(link, blacklist);
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index e2d1a12..d0ecde6 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -316,6 +316,7 @@ struct pci_dev {
>>  	unsigned int	hotplug_user_indicators:1; /* SlotCtl indicators
>>  						      controlled exclusively by
>>  						      user sysfs */
>> +	unsigned int	aspm_default;	/* aspm policy set by BIOS */
> 
> We already have an #ifdef CONFIG_PCIEASPM above, and this should go
> under that.  "aspm" in English text is an acronym and should be
> capitalized, just like "BIOS".

OK

> 
>>  	unsigned int	d3_delay;	/* D3->D0 transition time in ms */
>>  	unsigned int	d3cold_delay;	/* D3cold->D0 transition time in ms */
>>  
>> -- 
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
