Return-Path: <SRS0=zZO1=GE=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=zZO1=GE=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
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
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <20180312194236.GA12195@bhelgaas-glaptop.roam.corp.google.com>
 <20180312232626.GI18494@localhost.localdomain>
 <a52d2e0b-d319-bb34-8610-455d8c7ddad9@codeaurora.org>
 <20180314205049.GE29867@localhost.localdomain>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <8553ab27-b805-b995-068b-09857b875967@codeaurora.org>
Date: Wed, 14 Mar 2018 17:00:17 -0400
MIME-Version: 1.0
In-Reply-To: <20180314205049.GE29867@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 3/14/2018 4:50 PM, Keith Busch wrote:
> On Mon, Mar 12, 2018 at 11:47:12PM -0400, Sinan Kaya wrote:
>>
>> The spec is recommending code to use "Hotplug Surprise" to differentiate
>> these two cases we are looking for. 
>>
>> The use case Keith is looking for is for hotplug support. 
>> The case I and Oza are more interested is for error handling on platforms
>> with no hotplug support.
>>
>> According to the spec, if "Hotplug Surprise" is set in slot capabilities,
>> then hotplug driver handles link up and DPC driver doesn't interfere with
>> its operation. Hotplug driver observes link up interrupt like it is doing today.
>> When link up event is observed, hotplug driver will do the enumeration.
>>
>> If "Hotplug Surprise" bit is not set, it is the job of the DPC driver to
>> bring up the link. I believe this path should follow the AER driver path
>> as there is a very well defined error reporting and recovery framework
>> in the code.
>>
>> The link comes back up automatically when DPC driver handles its interrupt
>> very similar to what secondary bus reset does for AER. I don't believe
>> there is a hotplug possibility under this condition since it is not supported
>> to begin with.
>>
>> Should we plumb the "Hotplug Surprise" condition into the code to satisfy
>> both cases and leave the error handling path according to this code series?
> 
> I'm on board with this, but I think you mean "Hotplug Capable" rather
> than "Hotplug Surprise". The former may co-exist with DPC and handles
> the link-ups, leaving DPC responsible for handling the link-down.
> 

Yes, we can go with "Hotplug Capable".

> The "Hotplug Surprise" capability is recommended to not co-exist with DPC
> since that capability may suppress the "surprise link down" notification
> that DPC needs to see in order to trigger.
> 
> If the "Hotplug Capable" bit is not set, detecting the link-up after a
> DPC event would have to fall under a different component's responsibility,
> so I think I'm finally seeing your point.
> 

OK. To simplify our life, we can check if hotplug service is attached to this
device or not and follow two different paths.

We can get rid of re-enumeration and stop devices for the non-hotplug case
and make it behave exactly like AER.

Bjorn, will that work for you?


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
