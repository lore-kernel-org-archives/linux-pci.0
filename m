Return-Path: <SRS0=cmb1=IS=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=cmb1=IS=linux.intel.com=mika.westerberg@kernel.org>
Date: Thu, 31 May 2018 09:58:52 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, Mario.Limonciello@dell.com,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8 2/7] PCI: Introduce shpchp_is_native()
Message-ID: <20180531065852.GV15419@lahna.fi.intel.com>
References: <20180528124756.78512-1-mika.westerberg@linux.intel.com>
 <20180528124756.78512-3-mika.westerberg@linux.intel.com>
 <20180530202343.GO39853@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180530202343.GO39853@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 30, 2018 at 03:23:43PM -0500, Bjorn Helgaas wrote:
> > +{
> > +	const struct pci_host_bridge *host;
> > +
> > +	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> > +		return false;
> > +
> > +	if (!pci_find_capability(bridge, PCI_CAP_ID_SHPC))
> > +		return false;
> > +
> > +	host = pci_find_host_bridge(bridge->bus);
> > +	return host->native_shpc_hotplug;
> > +}
> 
> This is sort-of-but-not-exactly the same as is_shpc_capable().
> 
> For PCI_DEVICE_ID_AMD_GOLAM_7450, is_shpc_capable() will return true
> and shpchp will claim the device, but shpchp_is_native() will return
> false because there's no SHPC capability.
> 
> At least that's my interpretation of the AMD GOLAM stuff.  I don't
> have a spec for it, but if GOLAM did have an SHPC capability, I assume
> is_shpc_capable() would look for it *before* testing for GOLAM.

Most probably it did not have SHPC capability because I find it hard to
explain the check otherwise.

> So I think these two things need to be reconciled somehow.  I
> mentioned this before, but it was buried at the bottom of a long
> email, sorry about that.

No it wasn't. I read it and did exactly what you wanted. Now there is no
duplication in these two functions. is_shpc_capable() calls
acpi_get_hp_hw_control_from_firmware() which calls shpchp_is_native().
In fact I don't think is_shpc_capable() warrants to exist at all and it
should be removed (but in another separate cleanup patch).

> I wish we had a spec or details about the erratum.  It looks like
> it's been there "forever": https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/drivers/pci/hotplug/shpchp.h?id=c16b4b14d9806e639f4afefa2d651a857a212afe
> 
> But neither GOLAM (0x7450) nor POGO (0x7458) is in the PCI database at
> https://pci-ids.ucw.cz/read/PC/1002, so who knows if those chips ever
> even saw the light of day.  I'll cc the author of
> 
>   53044f357448 ("[PATCH] PCI Hotplug: shpchp: AMD POGO errata fix")
> 
> But that was 12 years ago, so the email address may not even work any
> more.

Ín any case even if somehow the original patch from 2006 was wrong, I
don't have absolutely any idea why it needs to be fixed now in this
patch series? Given that there are two real fixes in this series that
fix real issues on real contemporary hardware, I don't really understand
why you are stalling them. Yes, it is good to do cleanups because it
makes the code easier to understand and thus more maintainable but
that's something typically not priorized as high as fixes for real
problems.

These fixes have been out there since february virtually unchanged, so
you would think they have had enough review already. If not please point
out what exactly I need to fix and I'll do that. Otherwise please
consider taking the series for v4.18.
