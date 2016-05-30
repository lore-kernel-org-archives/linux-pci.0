Return-Path: <mika.westerberg@linux.intel.com>
Return-Path: <mika.westerberg@linux.intel.com>
Date: Mon, 30 May 2016 16:09:09 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Peter Wu <peter@lekensteyn.nl>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Dave Airlie <airlied@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4/4] drm/nouveau/acpi: fix lockup with PCIe runtime PM
Message-ID: <20160530130909.GA1743@lahna.fi.intel.com>
References: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
 <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
 <20160525135535.GN1789@lahna.fi.intel.com>
 <20160527111037.GA1436@al>
 <20160530095709.GK1789@lahna.fi.intel.com>
 <20160530122010.GB1149@al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160530122010.GB1149@al>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 02:20:10PM +0200, Peter Wu wrote:
> On Mon, May 30, 2016 at 12:57:09PM +0300, Mika Westerberg wrote:
> > +Rafael
> > 
> > On Fri, May 27, 2016 at 01:10:37PM +0200, Peter Wu wrote:
> > > On Wed, May 25, 2016 at 04:55:35PM +0300, Mika Westerberg wrote:
> > > > On Wed, May 25, 2016 at 12:53:01AM +0200, Peter Wu wrote:
> > > > > Since "PCI: Add runtime PM support for PCIe ports", the parent PCIe port
> > > > > can be runtime-suspended which disables power resources via ACPI. This
> > > > > is incompatible with DSM, resulting in a GPU device which is still in D3
> > > > > and locks up the kernel on resume.
> > > > > 
> > > > > Mirror the behavior of Windows 8 and newer[1] (as observed via an AMLi
> > > > > debugger trace) and stop using the DSM functions for D3cold when power
> > > > > resources are available on the parent PCIe port.
> > > > > 
> > > > >  [1]: https://msdn.microsoft.com/windows/hardware/drivers/bringup/firmware-requirements-for-d3cold
> > > > > 
> > > > > Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> > > > > ---
> > > > >  drivers/gpu/drm/nouveau/nouveau_acpi.c | 34 ++++++++++++++++++++++++++++++----
> > > > >  1 file changed, 30 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> > > > > index df9f73e..e469df7 100644
> > > > > --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> > > > > +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> > > > > @@ -46,6 +46,7 @@ static struct nouveau_dsm_priv {
> > > > >  	bool dsm_detected;
> > > > >  	bool optimus_detected;
> > > > >  	bool optimus_flags_detected;
> > > > > +	bool optimus_skip_dsm;
> > > > >  	acpi_handle dhandle;
> > > > >  	acpi_handle rom_handle;
> > > > >  } nouveau_dsm_priv;
> > > > > @@ -212,8 +213,26 @@ static const struct vga_switcheroo_handler nouveau_dsm_handler = {
> > > > >  	.get_client_id = nouveau_dsm_get_client_id,
> > > > >  };
> > > > >  
> > > > > +/* Firmware supporting Windows 8 or later do not use _DSM to put the device into
> > > > > + * D3cold, they instead rely on disabling power resources on the parent. */
> > > > > +static bool nouveau_pr3_present(struct pci_dev *pdev)
> > > > > +{
> > > > > +	struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> > > > > +	struct acpi_device *ad;
> > > > 
> > > > Nit: please call this adev instead of ad.
> > > 
> > > Will do.
> > > 
> > > > > +
> > > > > +	if (!parent_pdev)
> > > > > +		return false;
> > > > > +
> > > > > +	ad = ACPI_COMPANION(&parent_pdev->dev);
> > > > > +	if (!ad)
> > > > > +		return false;
> > > > > +
> > > > > +	return ad->power.flags.power_resources;
> > > > 
> > > > Is this sufficient to tell if the parent device has _PR3? I thought it
> > > > returns true if it has power resources in general, not necessarily _PR3.
> > > > 
> > > > Otherwise this looks okay to me.
> > > 
> > > It is indeed set whenever there is any _PRx method. I wonder if it is
> > > appropriate to access fields directly like this, perhaps this would be
> > > more accurate (based on device_pm.c):
> > > 
> > >     /* Check whether the _PR3 method is available. */
> > >     return adev->power.states[ACPI_STATE_D3_COLD].flags.valid;
> > > 
> > > I am also considering adding a check in case the pcieport driver does
> > > not support D3cold via runtime PM, what do you think of this?
> > > 
> > >     if (!parent_pdev)
> > >         return false;
> > >     /* If the PCIe port does not support D3cold via runtime PM, allow a
> > >      * fallback to the Optimus DSM method to put the device in D3cold. */
> > >     if (parent_pdev->no_d3cold)
> > >         return false;
> > > 
> > > This is needed to avoid the regression reported in the cover letter, but
> > > also allows pre-2015 systems to (still) have the D3cold possibility.
> > 
> > The _DSM method with 0 as index parameter should return a bit field
> > telling which functions are supported. Sane BIOS disables that
> > particular function if it detects Windows 8 and newer. Have you checked
> > if that's the case?
> > 
> > Then you can call _DSM only if it is supported and otherwise expect the
> > parent device's power resources to turn off power when runtime
> > suspended.
> 
> The _DSM methods (for the Nvidia device) are often still included and
> functions are reported as supported. I guess that vendors just check
> whether it is working and do not bother removing legacy functions. The
> Acer case below seems exceptional.
> 
> I suggested the no_d3cold check such that DSM can still be called even
> though the runtime PM on the PCIe port does nothing.

Somehow it does not feel right to poke parent device's fields directly.

What if you just check if it has the method like:

	bool no_dsm = acpi_has_method(parent_adev->handle, "_PR3");

That should follow what Windows is doing.

> > > Out of curiosity I looked up an pre-2015 laptop (found Acer V5-573G,
> > > apparently from November 2013, Windows 8.1) and extracted the ACPI
> > > tables from the BIOS images. BIOS 2.28 (2014/05/13) introduces support
> > > for power resources on the parent devicea(\_SB.PCI0.PEG0._PR3 and a
> > > related NVP3 device) when _OSI("Windows 2013") is true. (This is added
> > > as alternative for the old DSM interface.)
> > > 
> > > Maybe 2014 is also an appropriate cutoff date? I wonder if it is
> > > feasible to detect firmware use of _OSI("Windows 2013") and use that
> > > instead of the BIOS year.
> > 
> > Using BIOS year works even if there is no ACPI available.
> 
> I thought that you need support from ACPI to put a device in D3cold?

It is not just about D3cold but D3 in general (which includes also
D3hot). Yes, you need platform support to put the device into D3cold.

> > What comes to the cutoff date, I discussed with Rafael and it was
> > decided that we use the same year Windows 10 was released to be on the
> > safe side. Reading the links you provided here:
> > 
> > https://msdn.microsoft.com/fi-fi/windows/hardware/drivers/bringup/device-power-management
> > https://msdn.microsoft.com/en-us/library/windows/hardware/hh967709(v=vs.85).aspx
> > 
> > it seems that from Windows 8 they started transitioning devices into
> > D3cold during runtime as well.
> 
> My impression from the ACPI tables I have seen so far is that power
> resources support is enabled for Windows 2012 (Win8) or newer.
