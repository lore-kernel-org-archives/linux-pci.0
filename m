Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
Date: Fri, 27 May 2016 23:31:23 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: ML nouveau <nouveau@lists.freedesktop.org>,
	ML dri-devel <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@redhat.com>, linux-pm@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [Nouveau] [PATCH 4/4] drm/nouveau/acpi: fix lockup with PCIe
 runtime PM
Message-ID: <20160527213123.GB1777@al>
References: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
 <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
 <CACvgo514AB=rkRGWrwmPHTX=hhEF8Jhzdg1hQkX1_C4A_zYkzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACvgo514AB=rkRGWrwmPHTX=hhEF8Jhzdg1hQkX1_C4A_zYkzg@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 27, 2016 at 02:01:39PM +0100, Emil Velikov wrote:
> Hi Peter,
> 
> On 24 May 2016 at 23:53, Peter Wu <peter@lekensteyn.nl> wrote:
> > Since "PCI: Add runtime PM support for PCIe ports", the parent PCIe port
> > can be runtime-suspended which disables power resources via ACPI. This
> > is incompatible with DSM, resulting in a GPU device which is still in D3
> > and locks up the kernel on resume.
> >
> > Mirror the behavior of Windows 8 and newer[1] (as observed via an AMLi
> > debugger trace) and stop using the DSM functions for D3cold when power
> > resources are available on the parent PCIe port.
> >
> >  [1]: https://msdn.microsoft.com/windows/hardware/drivers/bringup/firmware-requirements-for-d3cold
> >
> > Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> > ---
> >  drivers/gpu/drm/nouveau/nouveau_acpi.c | 34 ++++++++++++++++++++++++++++++----
> >  1 file changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> > index df9f73e..e469df7 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> > @@ -46,6 +46,7 @@ static struct nouveau_dsm_priv {
> >         bool dsm_detected;
> >         bool optimus_detected;
> >         bool optimus_flags_detected;
> > +       bool optimus_skip_dsm;
> >         acpi_handle dhandle;
> >         acpi_handle rom_handle;
> >  } nouveau_dsm_priv;
> > @@ -212,8 +213,26 @@ static const struct vga_switcheroo_handler nouveau_dsm_handler = {
> >         .get_client_id = nouveau_dsm_get_client_id,
> >  };
> >
> > +/* Firmware supporting Windows 8 or later do not use _DSM to put the device into
> > + * D3cold, they instead rely on disabling power resources on the parent. */
> > +static bool nouveau_pr3_present(struct pci_dev *pdev)
> > +{
> > +       struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> > +       struct acpi_device *ad;
> > +
> > +       if (!parent_pdev)
> > +               return false;
> > +
> > +       ad = ACPI_COMPANION(&parent_pdev->dev);
> > +       if (!ad)
> > +               return false;
> > +
> > +       return ad->power.flags.power_resources;
> > +}
> > +
> >  static void nouveau_dsm_pci_probe(struct pci_dev *pdev, bool *has_mux,
> > -                                 bool *has_opt, bool *has_opt_flags)
> > +                                 bool *has_opt, bool *has_opt_flags,
> > +                                 bool *has_power_resources)
> >  {
> >         acpi_handle dhandle;
> >         bool supports_mux;
> > @@ -238,6 +257,7 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, bool *has_mux,
> >         *has_mux = supports_mux;
> >         *has_opt = !!optimus_funcs;
> >         *has_opt_flags = optimus_funcs & (1 << NOUVEAU_DSM_OPTIMUS_FLAGS);
> > +       *has_power_resources = false;
> >
> >         if (optimus_funcs) {
> >                 uint32_t result;
> > @@ -247,6 +267,8 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, bool *has_mux,
> >                          (result & OPTIMUS_ENABLED) ? "enabled" : "disabled",
> >                          (result & OPTIMUS_DYNAMIC_PWR_CAP) ? "dynamic power, " : "",
> >                          (result & OPTIMUS_HDA_CODEC_MASK) ? "hda bios codec supported" : "");
> > +
> > +               *has_power_resources = nouveau_pr3_present(pdev);
> >         }
> >  }
> >
> > @@ -258,6 +280,7 @@ static bool nouveau_dsm_detect(void)
> >         bool has_mux = false;
> >         bool has_optimus = false;
> >         bool has_optimus_flags = false;
> > +       bool has_power_resources = false;
> >         int vga_count = 0;
> >         bool guid_valid;
> >         bool ret = false;
> > @@ -273,14 +296,14 @@ static bool nouveau_dsm_detect(void)
> >                 vga_count++;
> >
> >                 nouveau_dsm_pci_probe(pdev, &has_mux, &has_optimus,
> > -                                     &has_optimus_flags);
> > +                                     &has_optimus_flags, &has_power_resources);
> >         }
> >
> >         while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_3D << 8, pdev)) != NULL) {
> >                 vga_count++;
> >
> >                 nouveau_dsm_pci_probe(pdev, &has_mux, &has_optimus,
> > -                                     &has_optimus_flags);
> > +                                     &has_optimus_flags, &has_power_resources);
> >         }
> >
> This and earlier patch break things in a subtle way.
> 
> Namely: upon the second (and any later) call into the
> nouveau_dsm_pci_probe() function, the had_foo flags are reset. Thus
> only the specifics of the _final_ device are being used (at a later
> stage). IMHO one should change that to "_any_ device", which will
> match the original code and the actual intent further down in the
> file.

The flags are only reset if any of the MUX or Optimus handles are found.
If both are missing, the flags are not overridden. This is from patch 1:

+       /* Does not look like a Nvidia device. */
+       if (!supports_mux && !supports_opt)
+               return;

The reason why later calls override early ones is because some Optimus
laptops have the _DSM method on both the Intel GPU (00:02.0) and the
Nvidia one (01:00.0).

The previous detection method would fail in this scenario:
 1. One device reports support for X and Y (has_x = 1, has_y = 1). Write
    ACPI handle A to nouveau_dsm_priv.dhandle.
 2. Another device reports support for X only (has_x = 1). Write
    ACPI handle B to nouveau_dsm_priv.dhandle.
 3. End result: has_x = 1, has_y = 1, dhandle = B. But ACPI handle B
    does not really support Y!
This is theoretical since I don't think that such firmware occurs in
practice, but then imo it would be better to enforce in code that the
case cannot occur (as is done in patch 1). Unless the MUX DSM has some
magic I am not aware of.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
