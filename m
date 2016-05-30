Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
Date: Mon, 30 May 2016 18:13:51 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Dave Airlie <airlied@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4/4] drm/nouveau/acpi: fix lockup with PCIe runtime PM
Message-ID: <20160530161351.GA1355@al>
References: <1464130381-4797-1-git-send-email-peter@lekensteyn.nl>
 <1464130381-4797-5-git-send-email-peter@lekensteyn.nl>
 <20160525135535.GN1789@lahna.fi.intel.com>
 <20160527111037.GA1436@al>
 <20160530095709.GK1789@lahna.fi.intel.com>
 <20160530122010.GB1149@al>
 <20160530130909.GA1743@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160530130909.GA1743@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 30, 2016 at 04:09:09PM +0300, Mika Westerberg wrote:
...
> > > > > > +
> > > > > > +	if (!parent_pdev)
> > > > > > +		return false;
> > > > > > +
> > > > > > +	ad = ACPI_COMPANION(&parent_pdev->dev);
> > > > > > +	if (!ad)
> > > > > > +		return false;
> > > > > > +
> > > > > > +	return ad->power.flags.power_resources;
> > > > > 
> > > > > Is this sufficient to tell if the parent device has _PR3? I thought it
> > > > > returns true if it has power resources in general, not necessarily _PR3.
> > > > > 
> > > > > Otherwise this looks okay to me.
> > > > 
> > > > It is indeed set whenever there is any _PRx method. I wonder if it is
> > > > appropriate to access fields directly like this, perhaps this would be
> > > > more accurate (based on device_pm.c):
> > > > 
> > > >     /* Check whether the _PR3 method is available. */
> > > >     return adev->power.states[ACPI_STATE_D3_COLD].flags.valid;
> > > > 
> > > > I am also considering adding a check in case the pcieport driver does
> > > > not support D3cold via runtime PM, what do you think of this?
> > > > 
> > > >     if (!parent_pdev)
> > > >         return false;
> > > >     /* If the PCIe port does not support D3cold via runtime PM, allow a
> > > >      * fallback to the Optimus DSM method to put the device in D3cold. */
> > > >     if (parent_pdev->no_d3cold)
> > > >         return false;
> > > > 
> > > > This is needed to avoid the regression reported in the cover letter, but
> > > > also allows pre-2015 systems to (still) have the D3cold possibility.
> > > 
> > > The _DSM method with 0 as index parameter should return a bit field
> > > telling which functions are supported. Sane BIOS disables that
> > > particular function if it detects Windows 8 and newer. Have you checked
> > > if that's the case?
> > > 
> > > Then you can call _DSM only if it is supported and otherwise expect the
> > > parent device's power resources to turn off power when runtime
> > > suspended.
> > 
> > The _DSM methods (for the Nvidia device) are often still included and
> > functions are reported as supported. I guess that vendors just check
> > whether it is working and do not bother removing legacy functions. The
> > Acer case below seems exceptional.
> > 
> > I suggested the no_d3cold check such that DSM can still be called even
> > though the runtime PM on the PCIe port does nothing.
> 
> Somehow it does not feel right to poke parent device's fields directly.
> 
> What if you just check if it has the method like:
> 
> 	bool no_dsm = acpi_has_method(parent_adev->handle, "_PR3");
> 
> That should follow what Windows is doing.

Checking for _PR3 was the intention, but it seems that the ACPI core
does not really store it somewhere. Your check should be simple enough,
I'll use that in the next version.

Do you have any suggestions for the case where the pcieport driver
refuses to put the bridge in D3 (because the BIOS is too old)? In that
case the nouveau driver needs to fallback to the DSM method (but not
when runtime PM is deliberately disabled by writing control=on).
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
