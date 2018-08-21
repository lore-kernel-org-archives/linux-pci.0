Return-Path: <SRS0=z17J=LE=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=z17J=LE=kernel.crashing.org=benh@kernel.org>
Message-ID: <2742bdba5ae8ccc420234b6e6b0224919367ed4c.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: poza@codeaurora.org
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org, Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue, 21 Aug 2018 16:06:30 +1000
In-Reply-To: <ad23b16cf7ff1f3b51961fda59533892@codeaurora.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
	 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
	 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
	 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
	 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
	 <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
	 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
	 <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
	 <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
	 <fe891b63-12c7-61ab-a59a-ae24ad766754@kernel.org>
	 <ab5cb5b277f1c1c1362ef597ca7b8c6a2cd32cdf.camel@kernel.crashing.org>
	 <908ff33ded8f31830f95a8889d8540f1@codeaurora.org>
	 <5027d857bb59edfd33442003aa618ece1bc9cd52.camel@kernel.crashing.org>
	 <b2e2ac5c92d8a91d00606754d1046578@codeaurora.org>
	 <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
	 <a149d9657ca83b41c724b0ddd319c6fb@codeaurora.org>
	 <512e0e11c3ba462c1d033f8b0e768fa27489731c.camel@kernel.crashing.org>
	 <ad23b16cf7ff1f3b51961fda59533892@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-08-21 at 10:44 +0530, poza@codeaurora.org wrote:
> 
> Ok Let me summarize the so far discussed things.
> 
> It would be nice if we all (Bjorn, Keith, Ben, Sinan) can hold consensus 
> on this.
> 
> 1) Right now AER and DPC both calls pcie_do_fatal_recovery(), I majorly 
> see DPC as error handling and recovery agent rather than being used for 
> hotplug.
>     so in my opinion, both AER and DPC should have same error handling 
> and recovery mechanism

Yes.

>     so if there is a way to figure out that in absence of pcihp, if DPC 
> is being used to support hotplug then we fall back to original DPC 
> mechanism (which is remove devices)

Not exactly. If the presence detect change indicates it was a hotplug
event rather.

>     otherwise, we fall back to drivers callbacks.

Driver callback should be the primary mechanism unless we think there's
a chance the device was removed (or the driver has no callbacks)

>     Spec 6.7.5 Async Removal
>     "
>     The Surprise Down error resulting from async removal may trigger 
> Downstream Port Containment (See Section 6.2.10).
>     Downstream Port Containment following an async removal may be 
> utilized to hold the Link of a
>     Downstream Port in the Disabled LTSSM state while host software 
> recovers from the side effects of an async removal.
>     "
> 
>     I think above is implementation specific. but there has to be some 
> way to kow if we are using DPC for hotplug or not !
>     otherwise it is assumed to be used for error handling and recovery
> 
>     pcie_do_fatal_recovery should take care of above. so that we support 
> both error handling and async removal from DPC point of view.
> 
> 
> 2) It is left to driver first to determine whether it wants to requests 
> the reset of device or not based on sanity of link (e.g. if it is 
> reading 0xffffffff back !)

The need to reset is the logical OR of the driver wanting a reset and
the framework wanting a reset. If *either* wants a reset, then we do a
reset. Typically the framework would request one for ERR_FATAL.

Actually this is a bit more convoluted than that. There can be more
than one driver involved in a given error event, for example because
the device might have multiple functions, or because the error could
have been reported by an upstream bridge.

So the need to reset is actually the logical OR of *any driver*
involved returning PCI_ERS_RESULT_NEED_RESET with the framework wanting
to reset.

>     pci_channel_io_frozen is the one which should be used from framework 
> to communicate driver that this is ERR_FATAL.

Maybe, not sure ... on EEH we have special HW that freezes on all non-
corrected errors but maybe for AER/DPC that's the way to go.

> 3) @Ben, although I am not very clear that if there is an ERR_FATAL, in 
> what circumstances driver will deny the reset but framework will impose 
> reset ?

The driver doesn't "deny" the reset. The driver just says it can
recover without one. 

The driver doesn't necessarily need to care  as to whether the error
was fatal or not, it cares about whether its device seems functional.
The driver can check some diagnostic registers, makes sure the firmware
hasn't crashed etc... and might want to request a reset if it's unhappy
with the state of the device for example.

The framework will impose a reset on ERR_FATAL  typcally (or because
platform policy is to always reset which might be our choice on pwoerpc
with EEH, I'll have to think about it).

> 4) Sinan's patch is going to ignore link states if it finds ERR_FATAL,so 
> that pcihp will not trigger and unplug the devices.

I would suggest checking the prsence detect change latch if it's
supported rather. If not supported, maybe ERR_FATAL is a good fallback.

> 5) pcie_do_nonfatal_recovery; we sould actually reset the link e.g. SBR 
> if driver requests the reset of link.  (there is already TDO note 
> anyway).
>     if (status == PCI_ERS_RESULT_NEED_RESET) {
> 		/*
> 		 * TODO: Should call platform-specific
> 		 * functions to reset slot before calling
> 		 * drivers' slot_reset callbacks?
> 		 */
> 		status = broadcast_error_message(dev,
> 				state,
> 				"slot_reset",
> 				report_slot_reset);
> 	}
> 

Yes.

> Let me know how this sounds, if we all agree on behavior I can go ahead 
> with the changes.

> ps: although I need input on point-1.

Ideally we would like to look at making EEH use the generic framework
as well, though because of subtle differences on how our HW freezes
stuff etc... we might have to add a few quirks to it.

Cheers,
Ben.

> Regards,
> Oza.
> 
> > > > 
> > > > > 
> > > > > Regards,
> > > > > Oza.
> > > > > 
> > > > > >  - Figure out what hooks might be needed to be able to plumb EEH into
> > > > > > it, possibly removing a bunch of crap in arch/powerpc (yay !)
> > > > > > 
> > > > > > I don't think having a webex will be that practical with the timezones
> > > > > > involved. I'm trying to get approval to go to Plumbers in which case we
> > > > > > could setup a BOF but I have no guarantee at this point that I can make
> > > > > > it happen.
> > > > > > 
> > > > > > So let's try using email as much possible for now.
> > > > > > 
> > > > > > Cheers,
> > > > > > Ben.
