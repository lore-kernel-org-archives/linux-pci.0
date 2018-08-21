Return-Path: <SRS0=brxM=LE=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=brxM=LE=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 21 Aug 2018 21:00:13 +0530
From: poza@codeaurora.org
To: Keith Busch <keith.busch@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sinan Kaya
 <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Thomas Tai
 <thomas.tai@oracle.com>, bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-pci-owner@vger.kernel.org, Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
In-Reply-To: <20180821143751.GA18477@localhost.localdomain>
References: <fe891b63-12c7-61ab-a59a-ae24ad766754@kernel.org>
 <ab5cb5b277f1c1c1362ef597ca7b8c6a2cd32cdf.camel@kernel.crashing.org>
 <908ff33ded8f31830f95a8889d8540f1@codeaurora.org>
 <5027d857bb59edfd33442003aa618ece1bc9cd52.camel@kernel.crashing.org>
 <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
 <a149d9657ca83b41c724b0ddd319c6fb@codeaurora.org>
 <512e0e11c3ba462c1d033f8b0e768fa27489731c.camel@kernel.crashing.org>
 <ad23b16cf7ff1f3b51961fda59533892@codeaurora.org>
 <2742bdba5ae8ccc420234b6e6b0224919367ed4c.camel@kernel.crashing.org>
 <20180821143751.GA18477@localhost.localdomain>
Message-ID: <5839a8643dedd459fc55e327d1ad5217@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-21 20:07, Keith Busch wrote:
> On Tue, Aug 21, 2018 at 04:06:30PM +1000, Benjamin Herrenschmidt wrote:
>> On Tue, 2018-08-21 at 10:44 +0530, poza@codeaurora.org wrote:
>> >
>> > Ok Let me summarize the so far discussed things.
>> >
>> > It would be nice if we all (Bjorn, Keith, Ben, Sinan) can hold consensus
>> > on this.
>> >
>> > 1) Right now AER and DPC both calls pcie_do_fatal_recovery(), I majorly
>> > see DPC as error handling and recovery agent rather than being used for
>> > hotplug.
>> >     so in my opinion, both AER and DPC should have same error handling
>> > and recovery mechanism
>> 
>> Yes.
>> 
>> >     so if there is a way to figure out that in absence of pcihp, if DPC
>> > is being used to support hotplug then we fall back to original DPC
>> > mechanism (which is remove devices)
>> 
>> Not exactly. If the presence detect change indicates it was a hotplug
>> event rather.
> 
> The actions associated with error recovery will trigger link state 
> changes
> for a lot of existing hardware. PCIEHP currently does the same removal
> sequence for both link state change (DLLSC) and presence detect change
> (PDC) events.
> 
> It sounds like you want pciehp to do nothing on the DLLSC events that 
> it
> currently handles, and instead do the board removal only on PDC.  If 
> that
> is the case, is the desire to not remove devices downstream a 
> permanently
> disabled link, or does that responsibility fall onto some other 
> component?

Keith

Are you in agreement with following ?

"
Right now AER and DPC both calls pcie_do_fatal_recovery(), I majorly see 
DPC as error handling and recovery agent rather than being used for 
hotplug.
    so in my opinion, both AER and DPC should have same error handling 
and recovery mechanism

    so if there is a way to figure out that in absence of pcihp, if DPC 
is being used to support hotplug then we fall back to original DPC 
mechanism (which is remove devices)
    otherwise, we fall back to drivers callbacks.

    Spec 6.7.5 Async Removal
    "
    The Surprise Down error resulting from async removal may trigger 
Downstream Port Containment (See Section 6.2.10).
    Downstream Port Containment following an async removal may be 
utilized to hold the Link of a
    Downstream Port in the Disabled LTSSM state while host software 
recovers from the side effects of an async removal.
    "

    I think above is implementation specific. but there has to be some 
way to kow if we are using DPC for hotplug or not !
    otherwise it is assumed to be used for error handling and recovery

    pcie_do_fatal_recovery should take care of above. so that we support 
both error handling and async removal from DPC point of view.
"
