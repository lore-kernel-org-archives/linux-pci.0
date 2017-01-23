Return-Path: <SRS0=UZpj=ZF=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=UZpj=ZF=codeaurora.org=okaya@kernel.org>
Subject: Re: ASPM after Hotplug Question
To: Bjorn Helgaas <helgaas@kernel.org>
References: <7fea039c-5921-0c12-c7b4-991b4c27778f@codeaurora.org>
 <20170122144810.GD6619@bhelgaas-glaptop.roam.corp.google.com>
 <13ae3a56-76d5-e069-1c6c-67092c586029@codeaurora.org>
 <8dd6d5da-bab0-8f77-11b6-9982b02134ed@codeaurora.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <3fcde45d-47e4-3424-398f-5af6687fb6b1@codeaurora.org>
Date: Mon, 23 Jan 2017 10:35:06 -0500
MIME-Version: 1.0
In-Reply-To: <8dd6d5da-bab0-8f77-11b6-9982b02134ed@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 1/22/2017 2:08 PM, Sinan Kaya wrote:
> [snip]
> 
>>>
>>> Bjorn
>>>
>>
>> / # lspci
>> 03:00:00.0 Class 0604: 17cb:0401
>> 03:01:00.0 Class 0200: 8086:1572
>> 03:01:00.1 Class 0200: 8086:1572
>>
>>
>> It looks like ASPM is only getting configured for the root port following
>> insertion.
>>
>> Removal:
>> [   32.142474] pci 0003:01:00.1: pcie_aspm_exit_link_state:662
>> [   34.142378] pci 0003:01:00.0: pcie_aspm_exit_link_state:659
>>
>> Insertion:
>> [   35.910342] pcieport 0003:00:00.0: pcie_aspm_init_link_state:565
>> [   35.931227] pcieport 0003:00:00.0: pcie_aspm_init_link_state:617
>>

it looks like this is what is happening.

hotplug insertion
	pcie_aspm_init_link_state
		pcie_config_aspm_path
			default policy, do nothing


[  128.691521] pcieport 0003:00:00.0: pcie_aspm_init_link_state:570
[  128.712402] pcie_config_aspm_link:439 state=0


430 static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
431 {
432         u32 upstream = 0, dwstream = 0;
433         struct pci_dev *child, *parent = link->pdev;
434         struct pci_bus *linkbus = parent->subordinate;
435
436         /* Nothing to do if the link is already in the requested state */
437         state &= (link->aspm_capable & ~link->aspm_disable);
438         if (link->aspm_enabled == state) {
439                 pr_info("%s:%d state=%d\n", __func__, __LINE__, state);
440                 return;
441         }


Should we add a new policy that comes through the hotplug insertion path?

Regarding your question on why this is not being done in configure_device,
probably the reason is that L0s and L1 needs to be enabled in a specific
order before enabling on the root port. 

That must be the reason for attaching this code behavior. 

I think the real problem is the assumption default policy on the hotplug
insertion path.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
