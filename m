Return-Path: <SRS0=nOzk=6Q=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=nOzk=6Q=kernel.crashing.org=benh@kernel.org>
Message-ID: <1499980882.2865.65.camel@kernel.crashing.org>
Subject: Re: [PATCH v4] PCI: Support hibmc VGA cards behind a misbehaving
 HiSilicon bridge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas
	 <helgaas@kernel.org>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Daniel Axtens
 <dja@axtens.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Liuxinliang (Matthew Liu)" <z.liuxinliang@hisilicon.com>,
        Rongrong Zou
 <zourongrong@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will
 Deacon <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>
Date: Fri, 14 Jul 2017 07:21:22 +1000
In-Reply-To: <20170713151146.53e9644c@w520.home>
References: <20170712050811.3620-1-dja@axtens.net>
	 <20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
	 <EE11001F9E5DDD47B7634E2F8A612F2E40B35F02@FRAEML521-MBX.china.huawei.com>
	 <20170713112938.GI4486@bhelgaas-glaptop.roam.corp.google.com>
	 <20170713151146.53e9644c@w520.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2017-07-13 at 15:11 -0600, Alex Williamson wrote:
> > >       */
> > > -   if (vga_default == NULL &&
> > > -       ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
> > > +   if (vga_default == NULL) {
> > >              vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
> > >              vga_set_default_device(pdev);
> > >      }  
> 
> 
> "Legacy" is the breadcrumb we use to try to pick the same device for
> default VGA as the system firmware used as the boot VGA.  There can be
> multiple VGA devices in the system, the change above would simply make
> the first discovered device be the default VGA.  That would break many,
> many systems.  If legacy VGA ranges mean nothing on ARM64, then follow
> the powerpc lead and make an arch quirk that simply selects the first
> enabled VGA device as the default.  VGA routing is part of the PCI spec
> though, so the default of selecting the device with routing enabled
> makes sense.  Thanks,

"Legacy" there iirc also means that it has decoding enabled at boot. If
you pick the first one you may pick a device that doesn't and hasn't
been initialized by any driver (good old BIOS-initialized text mode).

Cheers,
Ben.
