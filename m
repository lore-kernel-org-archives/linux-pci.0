Return-Path: <SRS0=J3+B=LD=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=J3+B=LD=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 20 Aug 2018 18:56:27 +0530
From: poza@codeaurora.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
 keith.busch@intel.com, linux-pci@vger.kernel.org,
 linux-pci-owner@vger.kernel.org, Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
In-Reply-To: <2ecd1fd6d763810d45697f846fa876b58a193b1b.camel@kernel.crashing.org>
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
Message-ID: <a149d9657ca83b41c724b0ddd319c6fb@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-20 16:52, Benjamin Herrenschmidt wrote:
> On Mon, 2018-08-20 at 13:26 +0530, poza@codeaurora.org wrote:
>>  now, I've sent a revert patch for the Documentation/ bit to
>> > Bjorn, and I have no (not yet at least) beef in what you do in
>> > drivers/pci/* ... however, that said, I think it would be great to move
>> > EEH toward having a bulk of the policy use common code as well.
>> >
>> 
>> In my opinion, I think revert patch can wait, because again we might
>> need to change it according to improvements we bring.
> 
> I doubt it will differ much from what's there ... anyway...
> 
>> > It will be long road, in part due to the historical crappyness of our
>> > EEH code, so my thinking is we should:
>> >
>> >  - First agree on what we want the policy to be. I need to read a bit
>> > more about DPC since that's new to me, it seems to be similar to what
>> > our EEH does, with slighty less granularity (we can freeze access to
>> > individual functions for example).
>> >
>> >  - Rework err.c to implement that policy with the existing AER and DPC
>> > code.
>> >
>> 
>> I went through eeh-pci-error-recovery.txt
>> If I pick up folowing
>> 
>> "
>> If the OS or device driver suspects that a PCI slot has been
>> EEH-isolated, there is a firmware call it can make to determine if 
>> this
>> is the case. If so, then the device driver should put itself into a
>> consistent state (given that it won't be able to complete any pending
>> work) and start recovery of the card.  Recovery normally would consist
>> of resetting the PCI device (holding the PCI #RST line high for two
>> seconds), followed by setting up the device config space (the base
>> address registers (BAR's), latency timer, cache line size, interrupt
>> line, and so on).  This is followed by a reinitialization of the 
>> device
>> driver.  In a worst-case scenario, the power to the card can be 
>> toggled,
>> at least on hot-plug-capable slots.  In principle, layers far above 
>> the
>> device driver probably do not need to know that the PCI card has been
>> "rebooted" in this way; ideally, there should be at most a pause in
>> Ethernet/disk/USB I/O while the card is being reset.
> 
> This verbiage is a bit old :-) A bunch of it predates PCIe.
> 
>> If the card cannot be recovered after three or four resets, the
>> kernel/device driver should assume the worst-case scenario, that the
>> card has died completely, and report this error to the sysadmin. In
>> addition, error messages are reported through RTAS and also through
>> syslogd (/var/log/messages) to alert the sysadmin of PCI resets. The
>> correct way to deal with failed adapters is to use the standard PCI
>> hotplug tools to remove and replace the dead card.
>> "
>> 
>> some differences: I find is:
>> Current framework does not attempt recovery 3-4 times.
>> 
>> Besides If I grasp eeh-pci-error-recovery.txt correctly, (although I
>> could be easily wrong),
>> mainly the difference is coming how we reset the device.
> 
> See below
> 
>> Linux uses SBR, while EEH seems to be using #PERST.
>> PERST signal implementation might be board specific, e.g. we have
>> io-port-expander sitting on i2c to drive #PERST.
>> we rely on SBR. and SBR also should be a good way to bring hotreset of
>> device.
>> "All Lanes in the configured Link transmit TS1 Ordered Sets with the 
>> Hot
>> Reset bit 15 asserted and the configured Link and Lane numbers."
>> although I am not sure between #PERST and SBR is there is any subtle
>> differences such as some sticky bits might not be affected by SBR.
>> but so far SBR has served well for us.
>> 
>> Also I see that eeh-pci-error-recovery.txt does not seem to 
>> distinguish
>> between fatal and nonfatal errors, is the behavior same for both type 
>> of
>> errors in EEH ?
> 
> Yeah so...
> 
>> I would like to mention is that there should nto be any need to reset
>> the card in case of NONFATAL because by definition link is functional,
>> only the particular transaction
>> had a problem. so not sure how EEH deals with ERR_NONFATAL.
> 
> As I believe I said earlier... NONFATAL means the link is still usable.
> It doesn't mean *anything* as far as the state of the device itself is
> concerned. The device microcode could have crashed for example etc...
> 
> That is why it's important to honor a driver requesting a reset.
> 
> Ignoring the verbiage in the documents for a minute, think of the big
> picture... the idea is that on error, there could be many actors
> involved in the recovery. The brigde, the link itself (NONFATAL vs.
> FATAL matters here), the device, the driver ....
> 
> So the design is that it's always permitted to perform a "deeper"
> action than strictly necessary. IE: If the link is ok, the device might
> still require a reset. If the device is ok, the platform might still
> enforce a reset....
> 
> There can be multiple devices or drivers involved in a recovery
> operation (for example if the error came from a switch).
> 
> The difference between FATAL and NON_FATAL is PCIe specific and only
> really matters from the perspective that if it's FATAL the core will
> require a reset. It doens't mean some other agent can't request one too
> when NON_FATAL errors occur.
> 
> As for EEH, *any* error that isn't purely informational results in the
> adapter being isolated physcially by some dedicated HW. It's possible
> to selectively un-isolate but the policy has generally been to just go
> through the reset sequence as it was generally deemed safer.
> 
> It's hard enough to properly test and validate recovery path, it's
> almost impossible to test and verify every way the HW can recover from
> a all type of non-fatal errors.
> 
> Thus by enforcing that on any error we simply reset the adapter provide
> a slower but much more robust recovery mechanism that is also a lot
> more testable.

Hi Ben,

I get the idea and get your points. and when I started implementation of 
this, I did ask these questions to myself.
but then we all fell aligned to what DPC was doing, because thats how 
the driver was dealing with ERR_FATAL.

I can put together a patch adhering to the idea, and modify err.c.
let me know if you are okay with that.
I have both DPC and AER capable root port, so I can easily validate the 
changes as we improve upon this.

besides We have to come to some common ground on policy.
1) if device driver dictates the reset we should agree to do SBR. 
(irrespective of the type of error)
2) under what circumstances framework will impose the reset, even if 
device driver did not !

probably changes might be simpler; although it will require to exercise 
some tests cases for both DPC and AER.
let me know if anything I missed here, but let me attempt to make patch 
and we can go form there.

Let me know you opinion.

Regards,
Oza.

> 
>> Also I am very much interested in knowing original intention of DPC
>> driver to unplug/plug devices,
>> all I remember in some conversation was:
>> hotplug capable bridge might have see devices changed, so it is safer 
>> to
>> remove/unplug the devices and during which .shutdown methods of driver
>> is called, in case of ERR_FATAL.
> 
> The device being "swapped" during an error recovery operation is ...
> unlikely. Do the bridges have a way to latch that the presence detect
> changed ?
> 
>> although DPC is HW recovery while AER is sw recovery both should
>> fundamentally act in the same way as far as device drivers callbacks 
>> are
>> concerned.
>> (again I really dont know real motivation behind this)
> 
> The main problem with unplug/replug (as I mentioned earlier) is that it
> just does NOT work for storage controllers (or similar type of
> devices). The links between the storage controller and the mounted
> filesystems is lost permanently, you'll most likely have to reboot the
> machine.
> 
> With our current EEH implementation we can successfully recover from
> fatal errors with the storage controller by resetting it.
> 
> Finally as for PERST vs. Hot Reset, this is an implementation detail.
> Not all our platforms can control PERST on all devices either, we
> generally prefer PERST as it provides a more reliable reset mechanism
> in practice (talking from experience) but will fallback to hot reset.
> 
> Cheers,
> Ben.
> 
>> 
>> Regards,
>> Oza.
>> 
>> >  - Figure out what hooks might be needed to be able to plumb EEH into
>> > it, possibly removing a bunch of crap in arch/powerpc (yay !)
>> >
>> > I don't think having a webex will be that practical with the timezones
>> > involved. I'm trying to get approval to go to Plumbers in which case we
>> > could setup a BOF but I have no guarantee at this point that I can make
>> > it happen.
>> >
>> > So let's try using email as much possible for now.
>> >
>> > Cheers,
>> > Ben.
