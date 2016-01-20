Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 Jan 2016 16:01:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Veal, Bryan E." <bryan.e.veal@intel.com>
Cc: Keith Busch <keith.busch@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCHv8 0/5] Driver for new "VMD" device
Message-ID: <20160120220111.GE7973@localhost>
References: <1452629890-17542-1-git-send-email-keith.busch@intel.com>
 <20160115181938.GA5296@localhost>
 <20160115193103.GA2249@intel.com>
 <20160115214902.GA10272@localhost>
 <20160116221937.GA31482@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160116221937.GA31482@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jan 16, 2016 at 02:19:38PM -0800, Veal, Bryan E. wrote:
> On Fri, Jan 15, 2016 at 03:49:02PM -0600, Bjorn Helgaas wrote:
> > Even though you found this issue before posting the RFC code, I assume
> > the issue is still relevant in the current code, and you still want to
> > clear IORESOURCE_MEM_64, right?
> 
> Yes.
> 
> > This is where I get confused.  IORESOURCE_MEM_64 *should* mean "the
> > hardware register associated with this resource can accommodate a
> > 64-bit value."  If we're using IORESOURCE_MEM_64 to decide whether to
> > use a prefetchable vs. a non-prefetchable window, that sounds broken.
> > 
> > Can you point me to the relevant code, and maybe give an example?  I'm
> > pretty sure the code doesn't completely match the spec, and maybe this
> > is a case where we have to set the flags non-intuitively to get the
> > desired result.
> > 
> > > Below the port, the "prefetchable" propoerty
> > > *is* restrictive: the addresses can't be used for non-prefetchable BARs.
> > > 
> > > Thus, in the specific case where a 64-bit non-prefetchable VMD bar happens
> > > to contain a 32-bit address, removing the IORESOURCE_MEM_64 flag allows
> > > the address resource to be used for *any* non-prefetchable BARs (32-bit or
> > > 64-bit) downstream.  
> > 
> > If I understand correctly, these VMD BARs (VMD_MEMBAR1 and
> > VMD_MEMBAR2) effectively become the host bridge windows available for
> > devices below the VMD.
> > 
> > I infer that if the VMD host bridge window is non-prefetchable and has
> > IORESOURCE_MEM_64 set, we won't put a 32-bit non-prefetchable BAR in
> > that window.  That sounds like a bug, but let me be the first to admit
> > that I don't understand our PCI resource allocation code.
> 
> I don't think anything is broken. You are correct that the MEMBARs are
> used as a host bridge window. The reason to clear the flag is a side
> effect of that.
> 
> For BARs, the flags describe capabilities. For resources, they are
> interpreted as restrictions.
> 
> If VMD has a 32-bit resource in a 64-bit non-prefetchable BAR, without
> clearing the flag, it yields a host bridge resource, and thus root bus
> resource, with IORESOURCE_MEM_64 set.
> 
> Downstream of VMD, the root port's 32-bit non-prefetchable base/limit
> registers can't handle the 64-bit resource, but the 64-bit prefetchable
> window can, so that's where it ends up. (See pci_bus_alloc_resource().)

OK, I think I finally found the critical comment, which is in
__pci_assign_resource():

  Even if a 64-bit prefetchable bridge window is below 4GB, we can't
  put a 32-bit prefetchable resource in it because pbus_size_mem()
  assumes a 64-bit window will contain no 32-bit resources.  If we
  assign things differently than they were sized, not everything will
  fit.

There's no reason we can't put a Root Port's 32-bit non-prefetchable
window inside a 64-bit VMD window that happens to be below 4GB,
*except* for the fact that pbus_size_mem() assumes we won't do that.

The VMD code needs a reference to that comment.

I guess you're relying on BIOS to assign your non-prefetchable VMD BAR
below 4GB even though it's a 64-bit BAR?  If Linux assigned that BAR,
e.g., after a hot-add of a VMD, we might put it above 4GB, and then
Root Ports downstream from the VMD would not be able to use any
non-prefetchable space.

Bjorn
