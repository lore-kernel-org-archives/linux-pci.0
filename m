Return-Path: <SRS0=5Xs+=GC=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=5Xs+=GC=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 12 Mar 2018 21:04:47 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Wei
 Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>,
 linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v12 0/6] Address error and recovery for AER and DPC
In-Reply-To: <20180312145823.GC18494@localhost.localdomain>
References: <1519837457-3596-1-git-send-email-poza@codeaurora.org>
 <20180311220337.GA194000@bhelgaas-glaptop.roam.corp.google.com>
 <04ade52e-d1ea-fe67-bb26-246621d159e6@codeaurora.org>
 <20180312142551.GB18494@localhost.localdomain>
 <3e1a2036675de6b8456145a022640f3d@codeaurora.org>
 <20180312145823.GC18494@localhost.localdomain>
Message-ID: <eb2810113f98c2ff8201da1a0f827493@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-03-12 20:28, Keith Busch wrote:
> On Mon, Mar 12, 2018 at 08:16:38PM +0530, poza@codeaurora.org wrote:
>> On 2018-03-12 19:55, Keith Busch wrote:
>> > On Sun, Mar 11, 2018 at 11:03:58PM -0400, Sinan Kaya wrote:
>> > > On 3/11/2018 6:03 PM, Bjorn Helgaas wrote:
>> > > > On Wed, Feb 28, 2018 at 10:34:11PM +0530, Oza Pawandeep wrote:
>> > >
>> > > > That difference has been there since the beginning of DPC, so it has
>> > > > nothing to do with *this* series EXCEPT for the fact that it really
>> > > > complicates the logic you're adding to reset_link() and
>> > > > broadcast_error_message().
>> > > >
>> > > > We ought to be able to simplify that somehow because the only real
>> > > > difference between AER and DPC should be that DPC automatically
>> > > > disables the link and AER does it in software.
>> > >
>> > > I agree this should be possible. Code execution path should be almost
>> > > identical to fatal error case.
>> > >
>> > > Is there any reason why you went to stop driver path, Keith?
>> >
>> > The fact is the link is truly down during a DPC event. When the link
>> > is enabled again, you don't know at that point if the device(s) on the
>> > other side have changed. Calling a driver's error handler for the wrong
>> > device in an unknown state may have undefined results. Enumerating the
>> > slot from scratch should be safe, and will assign resources, tune bus
>> > settings, and bind to the matching driver.
>> >
>> > Per spec, DPC is the recommended way for handling surprise removal
>> > events and even recommends DPC capable slots *not* set 'Surprise'
>> > in Slot Capabilities so that removals are always handled by DPC. This
>> > service driver was developed with that use in mind.
>> 
>> Now it begs the question, that
>> 
>> after DPC trigger
>> 
>> should we enumerate the devices, ?
>> or
>> error handling callbacks, followed by stop devices followed by 
>> enumeration ?
>> or
>> error handling callbacks, followed by enumeration ? (no stop devices)
> 
> I'm not sure I understand. The link is disabled while DPC is triggered,
> so if anything, you'd want to un-enumerate everything below the 
> contained
> port (that's what it does today).
> 
> After releasing a slot from DPC, the link is allowed to retrain. If 
> there
> is a working device on the other side, a link up event occurs. That
> event is handled by the pciehp driver, and that schedules enumeration
> no matter what you do to the DPC driver.

yes, that is what i current, but this patch-set makes DPC aware of error 
handling driver callbacks.

besides, in absence of pciehp there is nobody to do enumeration.

And, I was talking about pci_stop_and_remove_bus_device() in dpc.
if DPC calls driver's error callbacks, is it required to stop the 
devices  ?
