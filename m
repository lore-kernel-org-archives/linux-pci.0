Return-Path: <SRS0=5qSp=FT=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=5qSp=FT=h08.hostsharing.net=foo00@kernel.org>
Date: Sun, 25 Feb 2018 09:59:00 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Peter Wu <peter@lekensteyn.nl>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dave Airlie <airlied@redhat.com>, nouveau@lists.freedesktop.org,
	Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>,
	"moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>,
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
	Linux PM <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Pierre Moreau <pierre.morrow@free.fr>,
	Bastien Nocera <hadess@hadess.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/7] PCI: Restore BARs on runtime resume despite being
 unbound
Message-ID: <20180225085900.GA923@wunner.de>
References: <cover.1518941072.git.lukas@wunner.de>
 <20180220212922.GC32228@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0h+qipaKKDxxFFpkwUKgMjnoaUB8_p+FRDb+fSM_v+wBw@mail.gmail.com>
 <6131920.sr0PL0JerP@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6131920.sr0PL0JerP@aspire.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 21, 2018 at 01:39:34PM +0100, Rafael J. Wysocki wrote:
> On Wednesday, February 21, 2018 10:57:14 AM CET Rafael J. Wysocki wrote:
> > So if pci_pm_runtime_suspend() is modified to call pci_save_state()
> > before returning 0 in the !dev->driver case, we can just move the
> > pci_restore_standard_config() invocation in pci_pm_runtime_resume() up
> > to the very top and check dev->driver later.
> 
> I mean something like the patch below, overall (untested).
> 
> Tentatively-signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Okay I've tested this successfully now.  I'll have to respin the series
at least one more time to address the unnecessary initialization Bjorn
spotted in patch [5/7] and will then replace patch [1/7] with this one.

I'll wait a few more days before respinning to allow for further
comments, in particular I'm hoping for feedback from Takashi and
someone testing this on Optimus/ATPX.

Thanks!

Lukas

> ---
>  drivers/pci/pci-driver.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -1224,11 +1224,14 @@ static int pci_pm_runtime_suspend(struct
>  	int error;
>  
>  	/*
> -	 * If pci_dev->driver is not set (unbound), the device should
> -	 * always remain in D0 regardless of the runtime PM status
> +	 * If pci_dev->driver is not set (unbound), the device may go to D3cold,
> +	 * but only if the bridge above it is suspended.  In case that happens,
> +	 * save its config space.
>  	 */
> -	if (!pci_dev->driver)
> +	if (!pci_dev->driver) {
> +		pci_save_state(pci_dev);
>  		return 0;
> +	}
>  
>  	if (!pm || !pm->runtime_suspend)
>  		return -ENOSYS;
> @@ -1276,16 +1279,17 @@ static int pci_pm_runtime_resume(struct
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
>  	/*
> -	 * If pci_dev->driver is not set (unbound), the device should
> -	 * always remain in D0 regardless of the runtime PM status
> +	 * Regardless of whether or not the driver is there, the device might
> +	 * have been put into D3cold as a result of suspending the bridge above
> +	 * it, so restore the config spaces of all devices here.
>  	 */
> +	pci_restore_standard_config(pci_dev);
>  	if (!pci_dev->driver)
>  		return 0;
>  
>  	if (!pm || !pm->runtime_resume)
>  		return -ENOSYS;
>  
> -	pci_restore_standard_config(pci_dev);
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  	pci_enable_wake(pci_dev, PCI_D0, false);
>  	pci_fixup_device(pci_fixup_resume, pci_dev);
> 
