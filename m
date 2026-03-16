Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF303CF68B;
	Mon, 16 Mar 2026 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682095; cv=none; b=JMR/O5oIEwv1jiPhil9RwV8tFznqpJr46dvY4Ip6wTTQJHb4T0ePzHlm+HzmHVTjIQO118DwBKJJs3/yRIa5lr0u13CuIxG1oSeW5uc4WxG3rt8uk09T2pN6BcAVlSUMfpJ7K0Z/BuZpNXmU/fQZ4STgBLxFseBB72TGTCI9Yxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682095; c=relaxed/simple;
	bh=TFMOlwytdbmOT1F3ThDnlrmc0PPTATZDc4i+RzpAp9o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9xsGUVE6DOKct+u8h+ydt9bagdULj/wrtFtfPt0Oy+/ZBWt84vf3UrjEtLteIfkO9eqmetBm7ddBd1VdnG4/8AtPjhLytNYgNtnzbX7ykHu7lF+yFKLMmDS4bOPRNHjcR2gow0treIWoSRq3p/XVntHvhBtTsTNK+tFXCDTOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fZMTt6wFszJ46D8;
	Tue, 17 Mar 2026 01:27:14 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id B45E140569;
	Tue, 17 Mar 2026 01:28:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 16 Mar
 2026 17:28:08 +0000
Date: Mon, 16 Mar 2026 17:28:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Vishal Aslot <vaslot@nvidia.com>
CC: Srirangan Madhavan <smadhavan@nvidia.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Alex Williamson
	<alwilliamson@nvidia.com>, Jeshua Smith <jeshuas@nvidia.com>, Vikram Sethi
	<vsethi@nvidia.com>, "Sai Yashwanth Reddy Kancherla" <skancherla@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, Manish Honap
	<mhonap@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Jiandi An
	<jan@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Derek Schumacher
	<dschumacher@nvidia.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] PCI/CXL: Save and restore CXL DVSEC and HDM state
 across resets
Message-ID: <20260316172807.00000abc@huawei.com>
In-Reply-To: <SA3PR12MB9131917FA823F0F659BEBDB6BB40A@SA3PR12MB9131.namprd12.prod.outlook.com>
References: <20260306080026.116789-1-smadhavan@nvidia.com>
	<20260312123419.00003aca@huawei.com>
	<SA3PR12MB9131917FA823F0F659BEBDB6BB40A@SA3PR12MB9131.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 16 Mar 2026 13:59:59 +0000
Vishal Aslot <vaslot@nvidia.com> wrote:

> Hi Jonathan,
>           Replying on behalf of Srirangan. Srirangan, feel free to add to this.

Hi Vishal,

I've more hacked the thread to make it more readable going forwards
(it's tricky to spot replies in plain text otherwise!) If you can
persuade your email client to do quoting in similar fashion that would
be great.

>           
> >  In general I think  
> > we have a problem if a driver is relying on the bios having set up the
> > decoders and simply doesn't function if the bios didn't do it (and
> > that applies in this reset case as well).
> 

> The issue for us (and possibly for other devices as well) is that it
> is possible to reset a device without the device driver being loaded
> at all. One usecase is in-band fw update followed by reset to cause
> the device to go through its own secure boot. Now, arguably the
> device driver can restore DVSEC + HDM decoder + whatever else once it
> loads. If the driver is not loaded, it is not possible to use the
> device anyway. The main thing here is that without the driver
> present, reset_prep() and reset_done() cannot be handled, so we
> wanted this to be restored by the kernel itself.


Understood the use case. I'm just concerned on how vague the spec
leaves things.

I think we maybe need to go get some specification clarifications
or we are going to end up with a long running quirk list for when
this is safe to do restoration.  One thing I did think about is
restoring the stuff the bios setup with the exception of some of
the 'enables'. That might be not turning on mem.enable or something
similar (maybe not committing the decoders). Thus 'safe' but
retaining info in the hardware state.

Dan mentioned in another thread that he was looking at how we retain
some information on bios config over resets - that might help as well. 

We can probably also 'steal' info from the RP assuming it's not
do a single RP hostbridge with pass through. The host window is
visible there for instance.
> 
> There is a virtualization as well as confidential computing angle
> here as well but I am not fully versed in that path to comment.

That's messy as well as we need to extract some data, but also reset
to a clean state.  Confidential compute is more fun in general as I'm
not sure we can restore TSP after a reset. Certainly nowhere near doing
so today.

> 
> > I'm thinking the reset flow is a good deal more complex than simply
> >  
> > putting the bios programmed values back.  In some cases that might
> > be a very bad idea as autonomous traffic can hit the type 2 device
> > the moment these decoders are enabled and I'm guessing that may be
> > before the device has fully recovered. 
> 
> Yes, completely agree. In fact for our GPUs it's a combinatin of
> kernel-first and firmware-first. But we, at least, for our use-case
> ensure that the device will not be used before reset is completed by
> means outside of the OS control.

I'm curious on this.  How?  Do you mean the device is safe to be hit
with CPU side prefetchers afterc cachelines from CXL.mem immediately
after reset? Or the checks in here are good enough for that to be safe?

> 
> > Note it would be good to document what is restored ....more clearly
> >  
> I agree. Srirangan, could you please list out the DVSECs and
> capabilities that you are saving and restoring? In general, we should
> be saving and restoring anything that was locked but possibly got
> unlocked or was set back to its reset value. Things like mem.enable,
> cache.enable in DVSEC 0, range registers, HDM decoders would be at
> least unlocked if no wiped out, etc.
> ________________________________________ From: Jonathan Cameron
> <jonathan.cameron@huawei.com> Sent: Thursday, March 12, 2026 7:34 AM
> To: Srirangan Madhavan Cc: bhelgaas@google.com;
> dan.j.williams@intel.com; dave.jiang@intel.com; ira.weiny@intel.com;
> vishal.l.verma@intel.com; alison.schofield@intel.com;
> dave@stgolabs.net; Alex Williamson; Jeshua Smith; Vikram Sethi; Sai
> Yashwanth Reddy Kancherla; Vishal Aslot; Shanker Donthineni; Manish
> Honap; Vidya Sagar; Jiandi An; Matt Ochs; Derek Schumacher;
> linux-cxl@vger.kernel.org; linux-pci@vger.kernel.org;
> linux-kernel@vger.kernel.org Subject: Re: [PATCH 0/5] PCI/CXL: Save
> and restore CXL DVSEC and HDM state across resets
> 
> External email: Use caution opening links or attachments
> 
> 
> On Fri, 6 Mar 2026 08:00:14 +0000
> smadhavan@nvidia.com wrote:
> 
> > From: Srirangan Madhavan <smadhavan@nvidia.com>
> >
> > CXL devices could lose their DVSEC configuration and HDM decoder
> > programming after multiple reset methods (whenever link
> > disable/enable). This means a device that was fully configured —
> > with DVSEC control/range registers set and HDM decoders committed —
> > loses that state after reset. In cases where these are programmed
> > by firmware, downstream drivers are unable to re-initialize the
> > device because CXL memory ranges are no longer mapped.  
> 
> Hi Srirangan,
> 
> Firstly this might be because I'm behind on patch review and there is
> a lot going on right now!  So this might be addressed in a different
> series.
> 
> I'd like to understand the whole use case + flow here.  In general I
> think we have a problem if a driver is relying on the bios having set
> up the decoders and simply doesn't function if the bios didn't do it
> (and that applies in this reset case as well). For starters, no
> hotplug. Anyhow, that's a different issue, so we can leave that for
> now.
> 
> I'm thinking the reset flow is a good deal more complex than simply
> putting the bios programmed values back.  In some cases that might
> be a very bad idea as autonomous traffic can hit the type 2 device
> the moment these decoders are enabled and I'm guessing that may be
> before the device has fully recovered. There are very few spec rules
> about this that I can recall. On the setup path the BIOS presumably
> got the device into a state where enabling such traffic was fine
> and hopefully the driver bind doesn't break that state.
> 
> I think you are restoring CXL.mem as well so that gate isn't
> going to save us.  Note it would be good to document what is restored
> and why more clearly.  Sure we can figure it out from the code, but
> a document might make life easier.
> 
> A device might handle this mess for us, but I doubt that this is
> universal. For type 3 devices, I'm not sure what we want to do on
> reset in general.
> 
> Anyhow, this is really a request for a more detailed description of
> the expected reset flow that goes into what the spec constrains and
> what it doesn't.  Probably something worthy of going in Documentation.
> 
> Thanks,
> 
> Jonathan
> 
> >
> > This series adds CXL state save/restore logic to the PCI core so
> > that DVSEC and HDM decoder state is preserved across any PCI reset
> > path that calls pci_save_state() / pci_restore_state(), for a CXL
> > capable device.
> >
> > HDM decoder defines and the cxl_register_map infrastructure are
> > moved from internal CXL driver headers to a new public
> > include/cxl/pci.h, allowing drivers/pci/cxl.c to use them.
> > This layout aligns with Alejandro Lucero's CXL Type-2 device series
> > [1] to minimize conflicts when both land. When he rebases to
> > 7.0-rc2, I can move my changes on top of his.
> >
> > These patches were previously part of the CXL reset series and have
> > been split out [2] to allow independent review and merging. Review
> > feedback on the save/restore portions from v4 has been addressed.
> >
> > Tested on a CXL Type-2 device. DVSEC and HDM state is correctly
> > saved before reset and restored after, with decoder commit
> > confirmed via the COMMITTED status bit. Type-3 device testing is in
> > progress.
> >
> > This series is based on v7.0-rc1.
> >
> > [1] https://lore.kernel.org/linux-cxl/20260201155438.2664640-1-alejandro.lucero-palau@amd.com/
> > [2] https://lore.kernel.org/linux-cxl/aa8d4f6a-e7bd-4a20-8d34-4376ea314b8f@intel.com/T/#m825c6bdd1934022123807e86d235358a63b08dbc
> >
> > Srirangan Madhavan (5):
> >   PCI: Add CXL DVSEC control, lock, and range register definitions
> >   cxl: Move HDM decoder and register map definitions to
> >     include/cxl/pci.h
> >   PCI: Add virtual extended cap save buffer for CXL state
> >   PCI: Add cxl DVSEC state save/restore across resets
> >   PCI/CXL: Add HDM decoder state save/restore
> >
> >  drivers/cxl/cxl.h             | 107 +-------
> >  drivers/cxl/cxlpci.h          |  10 -
> >  drivers/pci/Kconfig           |   4 +
> >  drivers/pci/Makefile          |   1 +
> >  drivers/pci/cxl.c             | 468
> > ++++++++++++++++++++++++++++++++++ drivers/pci/pci.c             |
> > 23 ++ drivers/pci/pci.h             |  18 ++
> >  include/cxl/pci.h             | 129 ++++++++++
> >  include/uapi/linux/pci_regs.h |   6 +
> >  9 files changed, 650 insertions(+), 116 deletions(-)
> >  create mode 100644 drivers/pci/cxl.c
> >  create mode 100644 include/cxl/pci.h
> >
> > base-commit: 6de23f81a5e0
> > --
> > 2.43.0
> >
> >  
> 
> 
> 

