Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 Feb 2016 08:42:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: "Veal, Bryan E." <bryan.e.veal@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160225144219.GB8726@localhost>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost>
 <20160115193103.GA2249@intel.com>
 <20160115214902.GA10272@localhost>
 <20160116221937.GA31482@intel.com>
 <20160120220111.GE7973@localhost>
 <20160222221024.GA20879@localhost>
 <20160223182359.GA20250@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160223182359.GA20250@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 23, 2016 at 06:24:00PM +0000, Keith Busch wrote:
> On Mon, Feb 22, 2016 at 04:10:24PM -0600, Bjorn Helgaas wrote:
> > I'm not sure how to deal with the question of a hot-added VMD.  Maybe
> > all we can do now is add a comment to the effect that we assume BIOS
> > has assigned the non-prefetchable BAR below 4GB, and if Linux assigns
> > that BAR for hot-added VMDs, that assumption will likely break.
> 
> Yes, we can assume BIOS always assigns. There are other BIOS dependencies
> in order for the host to see the h/w as a VMD endpoint.
> 
> > diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> > index d57e480..7554722 100644
> > --- a/arch/x86/pci/vmd.c
> > +++ b/arch/x86/pci/vmd.c
> > @@ -532,6 +532,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd)
> >  		.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
> >  	};
> >  
> > +	/*
> > +	 * If the window is below 4GB, clear IORESOURCE_MEM_64 so we can
> > +	 * put 32-bit resources in the window.
> > +	 *
> > +	 * There's no hardware reason why a 64-bit window *couldn't*
> > +	 * contain a 32-bit resource, but pbus_size_mem() computes the
> > +	 * bridge window size assuming a 64-bit window will contain no
> > +	 * 32-bit resources.  __pci_assign_resource() enforces that
> > +	 * artificial restriction to make sure everything will fit.
> > +	 */
> 
> This sounds good to me. Thanks!
> 
> >  	res = &vmd->dev->resource[VMD_MEMBAR1];
> >  	upper_bits = upper_32_bits(res->end);
> >  	flags = res->flags & ~IORESOURCE_SIZEALIGN;

Can you prepare a patch, that adds both comments, please?  (The one
about how we assume BIOS assigns the BAR below 4GB, and the one I
drafted above.)

Bjorn
