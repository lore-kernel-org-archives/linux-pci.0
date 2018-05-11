Return-Path: <SRS0=c+aK=H6=alien8.de=bp@kernel.org>
Return-Path: <SRS0=c+aK=H6=alien8.de=bp@kernel.org>
Date: Fri, 11 May 2018 21:08:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci/aer: Get rid of aer_recover_work_func() forward
 declaration
Message-ID: <20180511190842.GJ12705@pd.tnic>
References: <20180511163923.22116-1-bp@alien8.de>
 <20180511190013.GI190385@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180511190013.GI190385@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2018 at 02:00:13PM -0500, Bjorn Helgaas wrote:
> On Fri, May 11, 2018 at 06:39:23PM +0200, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > Just move the actual function up so that it is visible to its user
> > aer_recover_queue().
> 
> Good idea.
> 
> Not *directly* related, but I'm really tired of the clutter of all these
> separate files, and I'm thinking of squashing
> 
>   drivers/pci/pcie/aer/*       => drivers/pci/pcie/aer.c
>   drivers/pci/pcie/portdrv*    => drivers/pci/pcie/portdrv.c
>   drivers/pci/hotplug/pciehp*  => drivers/pci/hotplug/pciehp.c
>   drivers/pci/hotplug/shpchp*  => drivers/pci/hotplug/shpchp.c
>   etc.
> 
> That would let us make many more things static and (more importantly,
> IMO), make it easier to browse the code.

Yeah, it probably is of no use to have separate compilation units like

aerdriver-objs := aerdrv_errprint.o aerdrv_core.o aerdrv.o

for example, which practically get always built together.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
