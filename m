Return-Path: <SRS0=3Yil=6Q=redhat.com=alex.williamson@kernel.org>
Return-Path: <SRS0=3Yil=6Q=redhat.com=alex.williamson@kernel.org>
Date: Thu, 13 Jul 2017 15:11:46 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>, Daniel Axtens
 <dja@axtens.net>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>, Rongrong Zou
 <zourongrong@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, Daniel Vetter
 <daniel.vetter@intel.com>
Subject: Re: [PATCH v4] PCI: Support hibmc VGA cards behind a misbehaving
 HiSilicon bridge
Message-ID: <20170713151146.53e9644c@w520.home>
In-Reply-To: <20170713112938.GI4486@bhelgaas-glaptop.roam.corp.google.com>
References: <20170712050811.3620-1-dja@axtens.net>
	<20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
	<EE11001F9E5DDD47B7634E2F8A612F2E40B35F02@FRAEML521-MBX.china.huawei.com>
	<20170713112938.GI4486@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Thu, 13 Jul 2017 06:29:38 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Ben, David, Daniel, Alex]
> 
> On Thu, Jul 13, 2017 at 10:29:25AM +0000, Gabriele Paoloni wrote:
> > Hi Bjorn, Daniel
> > 
> > [...]
> >   
> > > 
> > > Is this quirk useful on any arch other than arm64?  Per
> > > drivers/pci/dwc/Kconfig, CONFIG_PCI_HISI depends on CONFIG_ARM64.
> > > 
> > > Would it make sense to put this quirk in arch/arm64/kernel/pci.c?  
> > 
> > Indeed our host controller depends on ARM64 so maybe it would make
> > sense to move the quirk arch/arm64/kernel/pci.c; however regardless
> > why is it strictly required for a VGA device to be legacy one in order
> > to make it the default boot device?
> > i.e. couldn't we have:
> > 
> > diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> > index 0f5b2dd..a6b606c 100644
> > --- a/drivers/gpu/vga/vgaarb.c
> > +++ b/drivers/gpu/vga/vgaarb.c
> > @@ -667,8 +667,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
> >  	/* Deal with VGA default device. Use first enabled one
> >  	 * by default if arch doesn't have it's own hook
> >  	 */
> > -	if (vga_default == NULL &&
> > -	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
> > +	if (vga_default == NULL) {
> >  		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
> >  		vga_set_default_device(pdev);
> >  	}  


"Legacy" is the breadcrumb we use to try to pick the same device for
default VGA as the system firmware used as the boot VGA.  There can be
multiple VGA devices in the system, the change above would simply make
the first discovered device be the default VGA.  That would break many,
many systems.  If legacy VGA ranges mean nothing on ARM64, then follow
the powerpc lead and make an arch quirk that simply selects the first
enabled VGA device as the default.  VGA routing is part of the PCI spec
though, so the default of selecting the device with routing enabled
makes sense.  Thanks,

Alex
