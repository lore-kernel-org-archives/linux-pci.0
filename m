Return-Path: <SRS0=12iv=HT=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=12iv=HT=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH 3/6] PCI: Introduce devm_of_pci_get_host_bridge_resources
To: Bjorn Helgaas <helgaas@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <cover.1524582822.git.jan.kiszka@siemens.com>
 <e387d04ea235c9a4879a897bb730adc383a96635.1524582822.git.jan.kiszka@siemens.com>
 <20180427222427.GB73638@bhelgaas-glaptop.roam.corp.google.com>
 <869a8ad9-dd2f-8462-c0c4-2d8a62d74185@siemens.com>
 <20180430184007.GC95643@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5e218659-b512-b622-25e0-5bb5a8f4b87d@codeaurora.org>
Date: Mon, 30 Apr 2018 14:43:08 -0400
MIME-Version: 1.0
In-Reply-To: <20180430184007.GC95643@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 4/30/2018 2:40 PM, Bjorn Helgaas wrote:
> On Sat, Apr 28, 2018 at 09:28:47AM +0200, Jan Kiszka wrote:
>> On 2018-04-28 00:24, Bjorn Helgaas wrote:
>>> On Tue, Apr 24, 2018 at 05:13:39PM +0200, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> of_pci_get_host_bridge_resources allocates the resource structures it
>>>> fills dynamically, but none of its callers care to release them so far.
>>>> Rather than requiring everyone to do this explicitly, introduce a
>>>> managed version of that service. This differs API-wise only in taking a
>>>> reference to the associated device, rather than to the device tree node.
>>>>
>>>> As of_pci_get_host_bridge_resources is an exported interface, we cannot
>>>> simply drop it at this point. After converting all in-tree users to the
>>>> new API, we could phase out the unmanaged one over some grace period.
>>>
>>> It looks like it might be possible to split this into three or four
>>> patches:
>>>
>>>   1) Factor __of_pci_get_host_bridge_resources() out of
>>>      of_pci_get_host_bridge_resources()
>>>
>>>   2) Add struct device * argument
>>>
>>>   3) Convert pr_info() to dev_info()
>>>
>>>   4) Add devm_of_pci_get_host_bridge_resources()
>>
>> Will do. I'm even considering
>>
>> 5) mark of_pci_get_host_bridge_resources() __deprecated, due to the leak
>>    and no remaining in-tree user - what do you think?
> 
> Sounds good.
> 
> It'd be nice if we had some guideline about deprecation -- whether we
> actually need to mark things __deprecated, and then how long to wait
> before actually removing them, but I don't see anything in
> Documentation/.

I'm under the impression that we don't quite care about out-of-tree drivers.
I have seen many times out-of-tree drivers to be broken due to API changes,
renames or even parameter meaning change. 

If the plan is to remove the API, just remove the API today.

> 
> Looks like it was added by cbe4097f8ae6 ("of/pci: Add support for
> parsing PCI host bridge resources from DT") in v3.18, so it's been
> around for a while and I guess it would be nice to have a grace period
> before removing it.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
