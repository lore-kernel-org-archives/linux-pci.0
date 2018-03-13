Return-Path: <SRS0=lEL7=GD=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=lEL7=GD=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
To: Keith Busch <keith.busch@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Oza Pawandeep <poza@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <20180312194236.GA12195@bhelgaas-glaptop.roam.corp.google.com>
 <20180312232626.GI18494@localhost.localdomain>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a52d2e0b-d319-bb34-8610-455d8c7ddad9@codeaurora.org>
Date: Mon, 12 Mar 2018 23:47:12 -0400
MIME-Version: 1.0
In-Reply-To: <20180312232626.GI18494@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 3/12/2018 7:26 PM, Keith Busch wrote:
> On Mon, Mar 12, 2018 at 02:47:30PM -0500, Bjorn Helgaas wrote:
>> [+cc Alex]
>>
>> On Mon, Mar 12, 2018 at 08:25:51AM -0600, Keith Busch wrote:
>>> On Sun, Mar 11, 2018 at 11:03:58PM -0400, Sinan Kaya wrote:
>>>> On 3/11/2018 6:03 PM, Bjorn Helgaas wrote:
>>>>> On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:
>>>>
>>>>> That difference has been there since the beginning of DPC, so it has
>>>>> nothing to do with *this* series EXCEPT for the fact that it really
>>>>> complicates the logic you're adding to reset_link() and
>>>>> broadcast_error_message().
>>>>>
>>>>> We ought to be able to simplify that somehow because the only real
>>>>> difference between AER and DPC should be that DPC automatically
>>>>> disables the link and AER does it in software.
>>>>
>>>> I agree this should be possible. Code execution path should be almost
>>>> identical to fatal error case.
>>>>
>>>> Is there any reason why you went to stop driver path, Keith?
>>>
>>> The fact is the link is truly down during a DPC event. When the link
>>> is enabled again, you don't know at that point if the device(s) on the
>>> other side have changed.
>>
>> When DPC is triggered, the port takes the link down.  When we handle
>> an uncorrectable (nonfatal or fatal) AER event, software takes the
>> link down.
>>
>> In both cases, devices on the other side are at least reset.  Whenever
>> the link goes down, it's conceivable the device could be replaced with
>> a different one before the link comes back up.  Is this why you remove
>> and re-enumerate?  (See tangent [1] below.)
> 
> Yes. Truthfully, DPC events due to changing topologies was the motivating
> use case when we initially developed this. We were also going for
> simplicity (at least initially), and remove + re-enumerate seemed
> safe without concerning this driver with other capability regsiters, or
> coordinating with/depending on other drivers. For example, a successful
> reset may depend on any particular driver calling pci_restore_state from
> a good saved state.

The spec is recommending code to use "Hotplug Surprise" to differentiate
these two cases we are looking for. 

The use case Keith is looking for is for hotplug support. 
The case I and Oza are more interested is for error handling on platforms
with no hotplug support.

According to the spec, if "Hotplug Surprise" is set in slot capabilities,
then hotplug driver handles link up and DPC driver doesn't interfere with
its operation. Hotplug driver observes link up interrupt like it is doing today.
When link up event is observed, hotplug driver will do the enumeration.

If "Hotplug Surprise" bit is not set, it is the job of the DPC driver to
bring up the link. I believe this path should follow the AER driver path
as there is a very well defined error reporting and recovery framework
in the code.

The link comes back up automatically when DPC driver handles its interrupt
very similar to what secondary bus reset does for AER. I don't believe
there is a hotplug possibility under this condition since it is not supported
to begin with.

Should we plumb the "Hotplug Surprise" condition into the code to satisfy
both cases and leave the error handling path according to this code series?

> 
>> The point is that from the device's hardware perspective, these
>> scenarios are the same (it sent a ERR_NONFATAL or ERR_FATAL message
>> and it sees the link go down).  I think we should make them the same
>> on the software side, too: the driver should see the same callbacks,
>> in the same order, whether we're doing AER or DPC.
>>
>> If removing and re-enumerating is the right thing for DPC, I think
>> that means it's also the right thing for AER.
>>
-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
