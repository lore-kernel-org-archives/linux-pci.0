Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:44152
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbeHEJJC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 5 Aug 2018 05:09:02 -0400
Subject: Re: [PATCH v5] PCI: Check for PCIe downtraining conditions
To: "Alex G." <mr.nuke.me@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
        "austin_bolen@dell.com" <austin_bolen@dell.com>,
        "shyam_iyer@dell.com" <shyam_iyer@dell.com>,
        "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "ariel.elior@cavium.com" <ariel.elior@cavium.com>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        "ganeshgr@chelsio.com" <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "mike.marciniszyn@intel.com" <mike.marciniszyn@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180718215359.GG128988@bhelgaas-glaptop.roam.corp.google.com>
 <20180723200339.23943-1-mr.nuke.me@gmail.com>
 <20180723140143.1a46902f@cakuba.netronome.com>
 <b9a6b3b8-56cf-8bb5-2568-071ccd8a4f28@mellanox.com>
 <fc04618a-3b3b-58bd-edd5-cbde11638d7b@mellanox.com>
 <1b914780-e342-6aee-ffb2-ef81ac3ddd29@gmail.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <7424c5ba-ae44-3d8d-9dd5-360e17b6e3b9@mellanox.com>
Date: Sun, 5 Aug 2018 10:05:10 +0300
MIME-Version: 1.0
In-Reply-To: <1b914780-e342-6aee-ffb2-ef81ac3ddd29@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/31/2018 6:10 PM, Alex G. wrote:
> On 07/31/2018 01:40 AM, Tal Gilboa wrote:
> [snip]
>>>>> @@ -2240,6 +2258,9 @@ static void pci_init_capabilities(struct 
>>>>> pci_dev *dev)
>>>>>       /* Advanced Error Reporting */
>>>>>       pci_aer_init(dev);
>>>>> +    /* Check link and detect downtrain errors */
>>>>> +    pcie_check_upstream_link(dev);
>>>
>>> This is called for every PCIe device right? Won't there be a 
>>> duplicated print in case a device loads with lower PCIe bandwidth 
>>> than needed?
>>
>> Alex, can you comment on this please?
> 
> Of course I can.
> 
> There's one print at probe() time, which happens if bandwidth < max. I 
> would think that's fine. There is a way to duplicate it, and that is if 
> the driver also calls print_link_status(). A few driver maintainers who 
> call it have indicated they'd be fine with removing it from the driver, 
> and leaving it in the core PCI.

We would be fine with that as well. Please include the removal in your 
patches.

> 
> Should the device come back at low speed, go away, then come back at 
> full speed we'd still only see one print from the first probe. Again, if 
> driver doesn't also call the function.
> There's the corner case where the device come up at < max, goes away, 
> then comes back faster, but still < max. There will be two prints, but 
> they won't be true duplicates -- each one will indicate different BW.

This is fine.

> 
> Alex
> 
>>>>> +
>>>>>       if (pci_probe_reset_function(dev) == 0)
>>>>>           dev->reset_fn = 1;
>>>>>   }
>>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>>> index abd5d5e17aee..15bfab8f7a1b 100644
>>>>> --- a/include/linux/pci.h
>>>>> +++ b/include/linux/pci.h
>>>>> @@ -1088,6 +1088,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
>>>>>   u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev 
>>>>> **limiting_dev,
>>>>>                    enum pci_bus_speed *speed,
>>>>>                    enum pcie_link_width *width);
>>>>> +void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
>>>>>   void pcie_print_link_status(struct pci_dev *dev);
>>>>>   int pcie_flr(struct pci_dev *dev);
>>>>>   int __pci_reset_function_locked(struct pci_dev *dev);
>>>>
