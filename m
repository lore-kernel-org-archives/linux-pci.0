Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:36701 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbbHCXYo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 19:24:44 -0400
Received: by ioeg141 with SMTP id g141so668909ioe.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2015 16:24:43 -0700 (PDT)
Date: Mon, 3 Aug 2015 18:24:39 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"Jayachandran C." <jchandra@broadcom.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Ming Lei <ming.lei@canonical.com>, agraf@suse.de
Subject: Re: [PATCH v3 1/2] PCI: generic: remove dependency on hw_pci
Message-ID: <20150803232439.GD11144@google.com>
References: <1438183681-30519-1-git-send-email-jchandra@broadcom.com>
 <20150730133521.GA12999@red-moon>
 <20150731160654.GB31408@jayachandranc.netlogicmicro.com>
 <20150731162716.GA7182@red-moon>
 <20150803131131.GF10501@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150803131131.GF10501@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 03, 2015 at 02:11:32PM +0100, Will Deacon wrote:
> Hi Jayachandran, Bjorn,
> 
> On Fri, Jul 31, 2015 at 05:27:16PM +0100, Lorenzo Pieralisi wrote:
> > On Fri, Jul 31, 2015 at 05:07:01PM +0100, Jayachandran C. wrote:
> > > On Thu, Jul 30, 2015 at 02:35:21PM +0100, Lorenzo Pieralisi wrote:
> > > > On Wed, Jul 29, 2015 at 04:28:00PM +0100, Jayachandran C wrote:
> > > > > -	pci_common_init_dev(dev, &hw);
> > > > > +	/* do not reassign resource if probe only */
> > > > > +	if (!pci_has_flag(PCI_PROBE_ONLY))
> > > > > +		pci_add_flags(PCI_REASSIGN_ALL_RSRC);
> > > > 
> > > > You should add PCI_REASSIGN_ALL_BUS here. As I said in patch 2 comment,
> > > 
> > > The idea is to do exactly what pci_common_init_dev does on ARM. There is
> > > not need to change behavior on ARM and deal with the fallout in this
> > > patchset.
> > 
> > You are enabling this driver on ARM64, and on ARM64 that flag does
> > make a difference, it does not on ARM as far as I can tell, but you do
> > not seem to care.
> > 
> > Actually Rob asked you to put together a function since most of
> > this code is replicated across ARM drivers eg:
> > 
> > drivers/pci/host/pci-versatile.c
> > 
> > Leave the code as it is and I will consolidate the code later.
> > 
> > > > please enable setup-irq.c in an explicit commit, re-sequence the
> > > > series and fold the Kconfig ARM64 enablement in this patch.
> > > 
> > > I would think that the Makefile and Kconfig changes should be
> > > togethter as the arm64 enablement patch. The previous patch is
> > > to update the gen_pci driver, and it really makes sense in that
> > > order.  I am not sure why you suggest this change.
> > 
> > Because this is not the only driver that requires compiling
> > drivers/pci/setup-irq.c on ARM64, I thought it made more sense
> > to do it in a separate patch to make that change standalone.
> > 
> > If for any reason we have to revert your patch that enables
> > PCI host generic on ARM64 (and we remove with it the compilation
> > of setup-irq.c) we would break other ARM64 PCI hosts that require it,
> > right ?
> > 
> > I leave the decision to Bjorn since I am away next week, I am fine
> > with the code as it is so please go ahead.
> 
> In the interest of getting something merged, can I suggest you
> (Jayachandran) repost the patches with Lorenzo's suggestions to reorder
> the series and split up the setup-irq compilation into a separate patch?
> 
> You can also add his ack to this patch.
> 
> It's a pity that the code isn't quite how we'd like it to end up, but
> this at least enables people for 4.3 and I know that Lorenzo is working
> on tidying up the loose ends as additional patches (but he's on holiday
> this week). That includes removal of the PROBE_ONLY bodge that I've got
> queued in arch/arm64/kernel/pci.c.
> 
> Bjorn, does that sound ok to you? I'm keen to have something working, as
> I'm starting to get beaten up about the lack of generic PCI on arm64.

Sounds good to me.
