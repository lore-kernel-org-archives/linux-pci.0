Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Sat, 28 May 2016 14:27:01 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Peter Wu <peter@lekensteyn.nl>
Cc: Emil Velikov <emil.l.velikov@gmail.com>,
	ML nouveau <nouveau@lists.freedesktop.org>,
	ML dri-devel <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@redhat.com>, linux-pm@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [Nouveau] [PATCH 4/4] drm/nouveau/acpi: fix lockup with PCIe
 runtime PM
Message-ID: <20160528122701.GA11464@wunner.de>
References: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
 <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
 <CACvgo514AB=rkRGWrwmPHTX=hhEF8Jhzdg1hQkX1_C4A_zYkzg@mail.gmail.com>
 <20160527213123.GB1777@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160527213123.GB1777@al>
List-ID: <linux-pci.vger.kernel.org>

Hi Peter,

On Fri, May 27, 2016 at 11:31:23PM +0200, Peter Wu wrote:
> On Fri, May 27, 2016 at 02:01:39PM +0100, Emil Velikov wrote:
> > On 24 May 2016 at 23:53, Peter Wu <peter@lekensteyn.nl> wrote:
[snip]
> > > @@ -273,14 +296,14 @@ static bool nouveau_dsm_detect(void)
> > >                 vga_count++;
> > >
> > >                 nouveau_dsm_pci_probe(pdev, &has_mux, &has_optimus,
> > > -                                     &has_optimus_flags);
> > > +                                     &has_optimus_flags, &has_power_resources);
> > >         }
> > >
> > >         while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_3D << 8, pdev)) != NULL) {
> > >                 vga_count++;
> > >
> > >                 nouveau_dsm_pci_probe(pdev, &has_mux, &has_optimus,
> > > -                                     &has_optimus_flags);
> > > +                                     &has_optimus_flags, &has_power_resources);
> > >         }
> > >
> > This and earlier patch break things in a subtle way.
> > 
> > Namely: upon the second (and any later) call into the
> > nouveau_dsm_pci_probe() function, the had_foo flags are reset. Thus
> > only the specifics of the _final_ device are being used (at a later
> > stage). IMHO one should change that to "_any_ device", which will
> > match the original code and the actual intent further down in the
> > file.
> 
> The flags are only reset if any of the MUX or Optimus handles are found.
> If both are missing, the flags are not overridden. This is from patch 1:
> 
> +       /* Does not look like a Nvidia device. */
> +       if (!supports_mux && !supports_opt)
> +               return;
> 
> The reason why later calls override early ones is because some Optimus
> laptops have the _DSM method on both the Intel GPU (00:02.0) and the
> Nvidia one (01:00.0).

Sounds like you may want to check for pdev->vendor == PCI_VENDOR_ID_NVIDIA
or export pci_get_dev_by_id() and use that to match for class and vendor.

Best regards,

Lukas
