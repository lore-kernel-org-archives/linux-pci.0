Return-Path: <SRS0=fKP7=HB=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=fKP7=HB=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <1523284914-2037-7-git-send-email-poza@codeaurora.org>
 <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
 <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
 <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
 <20180412143954.GB4810@localhost.localdomain>
 <20180412150231.GD4810@localhost.localdomain>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ea977780-6f90-af5a-442f-575536038307@codeaurora.org>
Date: Thu, 12 Apr 2018 12:27:20 -0400
MIME-Version: 1.0
In-Reply-To: <20180412150231.GD4810@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 4/12/2018 11:02 AM, Keith Busch wrote:
> On Thu, Apr 12, 2018 at 08:39:54AM -0600, Keith Busch wrote:
>> On Thu, Apr 12, 2018 at 10:34:37AM -0400, Sinan Kaya wrote:
>>> On 4/12/2018 10:06 AM, Bjorn Helgaas wrote:
>>>>
>>>> I think the scenario you are describing is two systems that are
>>>> identical except that in the first, the endpoint is below a hotplug
>>>> bridge, while in the second, it's below a non-hotplug bridge.  There's
>>>> no physical hotplug (no drive removed or inserted), and DPC is
>>>> triggered in both systems.
>>>>
>>>> I suggest that DPC should be handled identically in both systems:
>>>>
>>>>   - The PCI core should have the same view of the endpoint: it should
>>>>     be removed and re-added in both cases (or in neither case).
>>>>
>>>>   - The endpoint itself should not be able to tell the difference: it
>>>>     should see a link down event, followed by a link retrain, followed
>>>>     by the same sequence of config accesses, etc.
>>>>
>>>>   - The endpoint driver should not be able to tell the difference,
>>>>     i.e., we should be calling the same pci_error_handlers callbacks
>>>>     in both cases.
>>>>
>>>> It's true that in the non-hotplug system, pciehp probably won't start
>>>> re-enumeration, so we might need an alternate path to trigger that.
>>>>
>>>> But that's not what we're doing in this patch.  In this patch we're
>>>> adding a much bigger difference: for hotplug bridges, we stop and
>>>> remove the hierarchy below the bridge; for non-hotplug bridges, we do
>>>> the AER-style flow of calling pci_error_handlers callbacks.
>>>
>>> Our approach on V12 was to go to AER style recovery for all DPC events
>>> regardless of hotplug support or not. 
>>>
>>> Keith was not comfortable with this approach. That's why, we special cased
>>> hotplug.
>>>
>>> If we drop 6/6 on this patch on v13, we achieve this. We still have to
>>> take care of Keith's inputs on individual patches.
>>>
>>> we have been struggling with the direction for a while.
>>>
>>> Keith, what do you think?
>>
>> My only concern was for existing production environments that use DPC
>> for handling surprise removal, and I don't wish to break the existing
>> uses.
> 
> Also, I thought the plan was to keep hotplug and non-hotplug the same,
> except for the very end: if not a hotplug bridge, initiate the rescan
> automatically after releasing from containment, otherwise let pciehp
> handle it when the link reactivates.
> 

Hmm...

AER driver doesn't do stop and rescan approach for fatal errors. AER driver
makes an error callback followed by secondary bus reset and finally driver
the resume callback on the endpoint only if link recovery is successful.
Otherwise, AER driver bails out with recovery unsuccessful message.

Why do we need an additional rescan in the DPC driver if the link is up
and driver resumes operation?

If hotplug is supported and somebody removed the device, link won't come up.
The AER error recovery sequence will fail after timeout.

When the drive is inserted, hotplug driver observes a link up interrupt,
Hotplug driver does a rescan. Drive is functional one more time. 

This should satisfy both use cases, right?


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
