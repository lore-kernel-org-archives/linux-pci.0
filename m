Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
Date: Mon, 30 May 2016 13:23:57 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Emil Velikov <emil.l.velikov@gmail.com>, Lukas Wunner <lukas@wunner.de>
Cc: ML nouveau <nouveau@lists.freedesktop.org>,
	ML dri-devel <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@redhat.com>, linux-pm@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [Nouveau] [PATCH 4/4] drm/nouveau/acpi: fix lockup with PCIe
 runtime PM
Message-ID: <20160530112357.GA1149@al>
References: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
 <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
 <CACvgo514AB=rkRGWrwmPHTX=hhEF8Jhzdg1hQkX1_C4A_zYkzg@mail.gmail.com>
 <20160527213123.GB1777@al>
 <CACvgo50db1KEuH3yZ75K-MtCeKAsQKXJbQQxiXm+82qkjZsvDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACvgo50db1KEuH3yZ75K-MtCeKAsQKXJbQQxiXm+82qkjZsvDA@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 11:48:34AM +0100, Emil Velikov wrote:
> On 27 May 2016 at 22:31, Peter Wu <peter@lekensteyn.nl> wrote:
> > On Fri, May 27, 2016 at 02:01:39PM +0100, Emil Velikov wrote:
> >> Hi Peter,
> >>
> >> On 24 May 2016 at 23:53, Peter Wu <peter@lekensteyn.nl> wrote:
> >> > Since "PCI: Add runtime PM support for PCIe ports", the parent PCIe port
> >> > can be runtime-suspended which disables power resources via ACPI. This
> >> > is incompatible with DSM, resulting in a GPU device which is still in D3
> >> > and locks up the kernel on resume.
> >> >
> >> > Mirror the behavior of Windows 8 and newer[1] (as observed via an AMLi
> >> > debugger trace) and stop using the DSM functions for D3cold when power
> >> > resources are available on the parent PCIe port.
> >> >
> >> >  [1]: https://msdn.microsoft.com/windows/hardware/drivers/bringup/firmware-requirements-for-d3cold
> >> >
> >> > Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> >> > ---
> >> >  drivers/gpu/drm/nouveau/nouveau_acpi.c | 34 ++++++++++++++++++++++++++++++----
> >> >  1 file changed, 30 insertions(+), 4 deletions(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> >> > index df9f73e..e469df7 100644
> >> > --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> >> > +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> >> > @@ -46,6 +46,7 @@ static struct nouveau_dsm_priv {
> >> >         bool dsm_detected;
> >> >         bool optimus_detected;
> >> >         bool optimus_flags_detected;
> >> > +       bool optimus_skip_dsm;
> >> >         acpi_handle dhandle;
> >> >         acpi_handle rom_handle;
> >> >  } nouveau_dsm_priv;
> >> > @@ -212,8 +213,26 @@ static const struct vga_switcheroo_handler nouveau_dsm_handler = {
> >> >         .get_client_id = nouveau_dsm_get_client_id,
> >> >  };
> >> >
> >> > +/* Firmware supporting Windows 8 or later do not use _DSM to put the device into
> >> > + * D3cold, they instead rely on disabling power resources on the parent. */
> >> > +static bool nouveau_pr3_present(struct pci_dev *pdev)
> >> > +{
> >> > +       struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> >> > +       struct acpi_device *ad;
> >> > +
> >> > +       if (!parent_pdev)
> >> > +               return false;
> >> > +
> >> > +       ad = ACPI_COMPANION(&parent_pdev->dev);
> >> > +       if (!ad)
> >> > +               return false;
> >> > +
> >> > +       return ad->power.flags.power_resources;
> >> > +}
> >> > +
> >> >  static void nouveau_dsm_pci_probe(struct pci_dev *pdev, bool *has_mux,
> >> > -                                 bool *has_opt, bool *has_opt_flags)
> >> > +                                 bool *has_opt, bool *has_opt_flags,
> >> > +                                 bool *has_power_resources)
> >> >  {
> >> >         acpi_handle dhandle;
> >> >         bool supports_mux;
> >> > @@ -238,6 +257,7 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, bool *has_mux,
> >> >         *has_mux = supports_mux;
> >> >         *has_opt = !!optimus_funcs;
> >> >         *has_opt_flags = optimus_funcs & (1 << NOUVEAU_DSM_OPTIMUS_FLAGS);
> >> > +       *has_power_resources = false;
> >> >
> >> >         if (optimus_funcs) {
> >> >                 uint32_t result;
> >> > @@ -247,6 +267,8 @@ static void nouveau_dsm_pci_probe(struct pci_dev *pdev, bool *has_mux,
> >> >                          (result & OPTIMUS_ENABLED) ? "enabled" : "disabled",
> >> >                          (result & OPTIMUS_DYNAMIC_PWR_CAP) ? "dynamic power, " : "",
> >> >                          (result & OPTIMUS_HDA_CODEC_MASK) ? "hda bios codec supported" : "");
> >> > +
> >> > +               *has_power_resources = nouveau_pr3_present(pdev);
> >> >         }
> >> >  }
> >> >
> >> > @@ -258,6 +280,7 @@ static bool nouveau_dsm_detect(void)
> >> >         bool has_mux = false;
> >> >         bool has_optimus = false;
> >> >         bool has_optimus_flags = false;
> >> > +       bool has_power_resources = false;
> >> >         int vga_count = 0;
> >> >         bool guid_valid;
> >> >         bool ret = false;
> >> > @@ -273,14 +296,14 @@ static bool nouveau_dsm_detect(void)
> >> >                 vga_count++;
> >> >
> >> >                 nouveau_dsm_pci_probe(pdev, &has_mux, &has_optimus,
> >> > -                                     &has_optimus_flags);
> >> > +                                     &has_optimus_flags, &has_power_resources);
> >> >         }
> >> >
> >> >         while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_3D << 8, pdev)) != NULL) {
> >> >                 vga_count++;
> >> >
> >> >                 nouveau_dsm_pci_probe(pdev, &has_mux, &has_optimus,
> >> > -                                     &has_optimus_flags);
> >> > +                                     &has_optimus_flags, &has_power_resources);
> >> >         }
> >> >
> >> This and earlier patch break things in a subtle way.
> >>
> >> Namely: upon the second (and any later) call into the
> >> nouveau_dsm_pci_probe() function, the had_foo flags are reset. Thus
> >> only the specifics of the _final_ device are being used (at a later
> >> stage). IMHO one should change that to "_any_ device", which will
> >> match the original code and the actual intent further down in the
> >> file.
> >
> > The flags are only reset if any of the MUX or Optimus handles are found.
> > If both are missing, the flags are not overridden. This is from patch 1:
> >
> > +       /* Does not look like a Nvidia device. */
> > +       if (!supports_mux && !supports_opt)
> > +               return;
> >
> This is precisely what I'm saying, and I think it's wrong/strange. If
> you've detected that device A support_{X,Y}, you'll reset the
> support_{X,Y} flag anyway if device B is present... (continues further
> down)

The flags will only be reset when device B supports at least one
function.

> > The reason why later calls override early ones is because some Optimus
> > laptops have the _DSM method on both the Intel GPU (00:02.0) and the
> > Nvidia one (01:00.0).
> >
> I agree with Lukas idea that one could/should be checking for nvidia
> devices (perhaps in nouveau_dsm_pci_probe() or just before calling it
> ?).

That could break PM on at least two Acer laptops. The Acer Travelmate
8472TG from 2011 (acpidump[1]) has two DSM on the Nvidia and Intel ACPI
handles:

 - Nvidia: supports MXM methods only.
 - Intel: supports the older Nvidia UUID (for toggling power and
   possibly other things).

 [1]: https://github.com/Bumblebee-Project/bbswitch/issues/4#issuecomment-219988501

There is also an Acer Aspire 5742G which possibly breaks (linked in the
above issue), but that could be a configuration issue that disabled
Optimus in BIOS (unconfirmed).

If it matters, both of these laptops have a MXMX method (Select Display
Data Channel), but their MXMI (Return Specification Support Level) and
MXMS (Return MXM Structure) functions are disfunctional. There is also a
MXDS function on both ACPI handles, but these are not hooked to the WMI
interface for some reason. No idea of Acer has hacked up some drivers to
work with this, outside these models I do not know others that are also
affected by this issue.

> > The previous detection method would fail in this scenario:
> >  1. One device reports support for X and Y (has_x = 1, has_y = 1). Write
> >     ACPI handle A to nouveau_dsm_priv.dhandle.
> >  2. Another device reports support for X only (has_x = 1). Write
> >     ACPI handle B to nouveau_dsm_priv.dhandle.
> >  3. End result: has_x = 1, has_y = 1, dhandle = B. But ACPI handle B
> >     does not really support Y!
> 
> ...  so to avoid the above case and preserve the original ideas ('do
> not discard earlier device caps' and 'Optimus takes precedence over
> DSM v1') one could do the following:
> 
>  - decouple the "feature check" and "set the dhandle"
> 
>  - pick the 'ideal' one based on the feature set provided. if multiple
> pick one based on $insert_heuristics
>  - set the dhandle
> 
> What do you think ?

The dhandle is only set when at least one valid DSM was found on the
device. The dhandle assignment could indeed be moved to the caller,
making it more obvious that the dhandle is only valid when the
capabilities are detected (this does not have a functional change
though). I'll do it in the next version.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
