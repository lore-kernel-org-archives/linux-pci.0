Return-Path: <SRS0=/SZl=FR=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=/SZl=FR=h08.hostsharing.net=foo00@kernel.org>
Date: Fri, 23 Feb 2018 10:51:47 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dave Airlie <airlied@redhat.com>, nouveau@lists.freedesktop.org,
	Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
	linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Pierre Moreau <pierre.morrow@free.fr>,
	Bastien Nocera <hadess@hadess.net>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/7] vga_switcheroo: Use device link for HDA controller
Message-ID: <20180223095147.GB17092@wunner.de>
References: <cover.1518941072.git.lukas@wunner.de>
 <99358da18f1c61b226678c7c70240e4407ac575b.1518941073.git.lukas@wunner.de>
 <20180220222059.GD32228@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180220222059.GD32228@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 20, 2018 at 04:20:59PM -0600, Bjorn Helgaas wrote:
> On Sun, Feb 18, 2018 at 09:38:32AM +0100, Lukas Wunner wrote:
> > The device link is added in a PCI quirk rather than in hda_intel.c.
> > It is therefore legal for the GPU to runtime suspend to D3cold even if
> > the HDA controller is not bound to a driver or if CONFIG_SND_HDA_INTEL
> > is not enabled, for accesses to the HDA controller will cause the GPU to
> > wake up regardless if they're occurring outside of hda_intel.c (think
> > config space readout via sysfs).
> 
> I guess this GPU wakeup happens *if* the path accessing the HDA
> controller calls pm_runtime_get_sync() or similar, right?

Right.

> We do have
> that in the sysfs config accessors via pci_config_pm_runtime_get(),
> but not in the sysfs mmap paths.  I think that's a latent PCI core
> defect independent of this series.

Yes, there may be a few places where the parent of the device is
erroneously not runtime resumed when sysfs files are accessed.
I've never used the sysfs mmap feature, so never witnessed issues
with it.

> We also don't have that in PCI core config accessors.  That maybe
> doesn't matter because the core probably shouldn't be touching devices
> after enumeration (although there might be holes there for things like
> ASPM where a sysfs file can cause reconfiguration of several devices).

I assume with PCI core config accessors you're referring to
pci_read_config_word() and friends?  Those are arguably hotpaths
where we wouldn't want the overhead to check runtime PM status
everytime.  They might also be called from atomic context, I'm
not sure, and the runtime PM callbacks may sleep by default
(unless pm_runtime_irq_safe() was called).

> > +static void quirk_gpu_hda(struct pci_dev *hda)
> > +{
> > +	struct pci_dev *gpu = NULL;
> > +
> > +	if (PCI_FUNC(hda->devfn) != 1)
> > +		return;
> > +
> > +	gpu = pci_get_domain_bus_and_slot(pci_domain_nr(hda->bus),
> 
> Unnecessary initialization.

Thanks for spotting this, it's a remnant of an earlier version of the
patch which called pci_dev_put(gpu) in the (PCI_FUNC(hda->devfn) != 1)
case.

Best regards,

Lukas
