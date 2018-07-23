Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr30075.outbound.protection.outlook.com ([40.107.3.75]:63482
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727765AbeGWGVM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Jul 2018 02:21:12 -0400
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To: "Alex G." <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
 <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
 <628346bc-b455-05f2-2051-35a807076ea0@mellanox.com>
 <25e4f647-f830-e1cc-bffc-0cc894885667@gmail.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <9d752b75-eab2-6fd1-f9da-09985966436c@mellanox.com>
Date: Mon, 23 Jul 2018 08:21:32 +0300
MIME-Version: 1.0
In-Reply-To: <25e4f647-f830-e1cc-bffc-0cc894885667@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/19/2018 6:49 PM, Alex G. wrote:
> 
> 
> On 07/18/2018 08:38 AM, Tal Gilboa wrote:
>> On 7/16/2018 5:17 PM, Bjorn Helgaas wrote:
>>> [+cc maintainers of drivers that already use pcie_print_link_status()
>>> and GPU folks]
> [snip]
>>>
>>>> +    /* Multi-function PCIe share the same link/status. */
>>>> +    if ((PCI_FUNC(dev->devfn) != 0) || dev->is_virtfn)
>>>> +        return;
>>>> +
>>>> +    pcie_print_link_status(dev);
>>>> +}
>>
>> Is this function called by default for every PCIe device? What about 
>> VFs? We make an exception for them on our driver since a VF doesn't 
>> have access to the needed information in order to provide a meaningful 
>> message.
> 
> I'm assuming VF means virtual function. pcie_print_link_status() doesn't 
> care if it's passed a virtual function. It will try to do its job. 
> That's why I bail out three lines above, with 'dev->is_virtfn' check.
> 
> Alex

That's the point - we don't want to call pcie_print_link_status() for 
virtual functions. We make the distinction in our driver. If you want to 
change the code to call this function by default it shouldn't affect the 
current usage.
