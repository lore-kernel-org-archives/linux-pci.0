Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Check for PCIe downtraining conditions
To: Sinan Kaya <okaya@codeaurora.org>, bhelgaas@google.com
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180601150129.10486-1-mr.nuke.me@gmail.com>
 <35a67b5b-5f37-c779-64a3-eb5e21362e9c@codeaurora.org>
 <c677b42a-f5f0-474e-c9ce-da05ced45b23@gmail.com>
 <321c6d7d-b8e6-9b8d-91e5-a4f748acaa8e@codeaurora.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <4ffb153a-c26e-8762-df86-9d84dc726fa4@gmail.com>
Date: Fri, 1 Jun 2018 10:50:39 -0500
MIME-Version: 1.0
In-Reply-To: <321c6d7d-b8e6-9b8d-91e5-a4f748acaa8e@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 06/01/2018 10:10 AM, Sinan Kaya wrote:
> On 6/1/2018 11:06 AM, Alex G. wrote:
>> On 06/01/2018 10:03 AM, Sinan Kaya wrote:
>>> On 6/1/2018 11:01 AM, Alexandru Gagniuc wrote:
>>>> +	/* Multi-function PCIe share the same link/status. */
>>>> +	if (PCI_FUNC(dev->devfn) != 0)
>>>> +		return;
>>>
>>> How about virtual functions?
>>
>> I have almost no clue about those. Is your concern that we might end up
>> printing more than our fair share of link statuses?
> 
> Yes, struct pci_dev also has a flag called is_virtfn that you should bail out
> here too. 

Will be fixed in v3.

Thanks,
Alex

>>
>> Alex
>>
>>
> 
> 
