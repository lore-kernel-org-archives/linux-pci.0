Return-Path: <SRS0=uwJQ=KD=gmail.com=mr.nuke.me@kernel.org>
Return-Path: <SRS0=uwJQ=KD=gmail.com=mr.nuke.me@kernel.org>
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To: Tal Gilboa <talgi@mellanox.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, alex_gagniuc@dellteam.com, austin_bolen@dell.com,
 shyam_iyer@dell.com, keith.busch@intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Ariel Elior <ariel.elior@cavium.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Ganesh Goudar <ganeshgr@chelsio.com>, Tariq Toukan <tariqt@mellanox.com>,
 Jakub Kicinski <jakub.kicinski@netronome.com>,
 Dave Airlie <airlied@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com>
 <20180716211706.GB12391@bhelgaas-glaptop.roam.corp.google.com>
 <628346bc-b455-05f2-2051-35a807076ea0@mellanox.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <25e4f647-f830-e1cc-bffc-0cc894885667@gmail.com>
Date: Thu, 19 Jul 2018 10:49:55 -0500
MIME-Version: 1.0
In-Reply-To: <628346bc-b455-05f2-2051-35a807076ea0@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 07/18/2018 08:38 AM, Tal Gilboa wrote:
> On 7/16/2018 5:17 PM, Bjorn Helgaas wrote:
>> [+cc maintainers of drivers that already use pcie_print_link_status()
>> and GPU folks]
[snip]
>>
>>> +    /* Multi-function PCIe share the same link/status. */
>>> +    if ((PCI_FUNC(dev->devfn) != 0) || dev->is_virtfn)
>>> +        return;
>>> +
>>> +    pcie_print_link_status(dev);
>>> +}
> 
> Is this function called by default for every PCIe device? What about 
> VFs? We make an exception for them on our driver since a VF doesn't have 
> access to the needed information in order to provide a meaningful message.

I'm assuming VF means virtual function. pcie_print_link_status() doesn't 
care if it's passed a virtual function. It will try to do its job. 
That's why I bail out three lines above, with 'dev->is_virtfn' check.

Alex
