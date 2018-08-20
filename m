Return-Path: <SRS0=HZd4=LD=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=HZd4=LD=kernel.crashing.org=benh@kernel.org>
Message-ID: <512e0e11c3ba462c1d033f8b0e768fa27489731c.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: poza@codeaurora.org
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
        keith.busch@intel.com, linux-pci@vger.kernel.org,
        linux-pci-owner@vger.kernel.org, Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue, 21 Aug 2018 07:02:44 +1000
In-Reply-To: <a149d9657ca83b41c724b0ddd319c6fb@codeaurora.org>
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
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2018-08-20 at 18:56 +0530, poza@codeaurora.org wrote:
> Hi Ben,
> 
> I get the idea and get your points. and when I started implementation of 
> this, I did ask these questions to myself.
> but then we all fell aligned to what DPC was doing, because thats how 
> the driver was dealing with ERR_FATAL.
> 
> I can put together a patch adhering to the idea, and modify err.c.
> let me know if you are okay with that.
> I have both DPC and AER capable root port, so I can easily validate the 
> changes as we improve upon this.
> 
> besides We have to come to some common ground on policy.
> 1) if device driver dictates the reset we should agree to do SBR. 
> (irrespective of the type of error)

It's not just "the driver dictates the reset". It's a combination of
all agents. Either the driver or the framework, *both* can request a
reset. Also if you have multiple devices involved (for example multiple
functions), then any of the drivers can request the reset.

> 2) under what circumstances framework will impose the reset, even if 
> device driver did not !

Well ERR_FATAL typically would be one. Make it an argument to the
framework, it's possible that EEH might always do, I have to look into
it.

> probably changes might be simpler; although it will require to exercise 
> some tests cases for both DPC and AER.
> let me know if anything I missed here, but let me attempt to make patch 
> and we can go form there.
> 
> Let me know you opinion.

I agree. Hopefully Sam will have a chance to chime in (he's caught up
with something else at the moment) as well.

Cheers,
Ben.

> Regards,
> Oza.
> 
> > 
> > > Also I am very much interested in knowing original intention of DPC
> > > driver to unplug/plug devices,
> > > all I remember in some conversation was:
> > > hotplug capable bridge might have see devices changed, so it is safer 
> > > to
> > > remove/unplug the devices and during which .shutdown methods of driver
> > > is called, in case of ERR_FATAL.
> > 
> > The device being "swapped" during an error recovery operation is ...
> > unlikely. Do the bridges have a way to latch that the presence detect
> > changed ?
> > 
> > > although DPC is HW recovery while AER is sw recovery both should
> > > fundamentally act in the same way as far as device drivers callbacks 
> > > are
> > > concerned.
> > > (again I really dont know real motivation behind this)
> > 
> > The main problem with unplug/replug (as I mentioned earlier) is that it
> > just does NOT work for storage controllers (or similar type of
> > devices). The links between the storage controller and the mounted
> > filesystems is lost permanently, you'll most likely have to reboot the
> > machine.
> > 
> > With our current EEH implementation we can successfully recover from
> > fatal errors with the storage controller by resetting it.
> > 
> > Finally as for PERST vs. Hot Reset, this is an implementation detail.
> > Not all our platforms can control PERST on all devices either, we
> > generally prefer PERST as it provides a more reliable reset mechanism
> > in practice (talking from experience) but will fallback to hot reset.
> > 
> > Cheers,
> > Ben.
> > 
> > > 
> > > Regards,
> > > Oza.
> > > 
> > > >  - Figure out what hooks might be needed to be able to plumb EEH into
> > > > it, possibly removing a bunch of crap in arch/powerpc (yay !)
> > > > 
> > > > I don't think having a webex will be that practical with the timezones
> > > > involved. I'm trying to get approval to go to Plumbers in which case we
> > > > could setup a BOF but I have no guarantee at this point that I can make
> > > > it happen.
> > > > 
> > > > So let's try using email as much possible for now.
> > > > 
> > > > Cheers,
> > > > Ben.
