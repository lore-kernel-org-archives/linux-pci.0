Return-Path: <SRS0=/y4y=FP=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=/y4y=FP=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, dri-devel <dri-devel@lists.freedesktop.org>, Peter Wu <peter@lekensteyn.nl>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>, Hans de Goede <hdegoede@redhat.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Pierre Moreau <pierre.morrow@free.fr>, Bastien Nocera <hadess@hadess.net>, Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/7] PCI: Restore BARs on runtime resume despite being unbound
Date: Wed, 21 Feb 2018 13:39:34 +0100
Message-ID: <6131920.sr0PL0JerP@aspire.rjw.lan>
In-Reply-To: <CAJZ5v0h+qipaKKDxxFFpkwUKgMjnoaUB8_p+FRDb+fSM_v+wBw@mail.gmail.com>
References: <cover.1518941072.git.lukas@wunner.de> <20180220212922.GC32228@bhelgaas-glaptop.roam.corp.google.com> <CAJZ5v0h+qipaKKDxxFFpkwUKgMjnoaUB8_p+FRDb+fSM_v+wBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, February 21, 2018 10:57:14 AM CET Rafael J. Wysocki wrote:
> On Tue, Feb 20, 2018 at 10:29 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sun, Feb 18, 2018 at 09:38:32AM +0100, Lukas Wunner wrote:
> >> PCI devices not bound to a driver are supposed to stay in D0 during
> >> runtime suspend.
> >
> > Doesn't "runtime suspend" mean an individual device is suspended while
> > the rest of the system remains active?
> >
> > If so, maybe it would be more direct to say "PCI devices not bound to
> > a driver cannot be runtime suspended"?
> >
> > (It's a separate question not relevant to this patch, but I'm not
> > convinced that "PCI devices without a driver cannot be suspended"
> > should be accepted as a rule.  If it is a rule, we should be able to
> > deduce it from the specs.)
> >
> >> But they may have a parent which is bound and can be
> >> transitioned to D3cold at runtime.  Once the parent goes to D3cold, the
> >> unbound child may go to D3cold as well.  When the child comes out of
> >> D3cold, its BARs are uninitialized and thus inaccessible when a driver
> >> tries to probe.
> >>
> >> One example are recent hybrid graphics laptops which cut power to the
> >> discrete GPU when the root port above it goes to ACPI power state D3.
> >> Users may provoke this by unbinding the GPU driver and allowing runtime
> >> PM on the GPU via sysfs:  The PM core will then treat the GPU as
> >> "suspended", which in turn allows the root port to runtime suspend,
> >> causing the power resources listed in its _PR3 object to be powered off.
> >> The GPU's BARs will be uninitialized when a driver later probes it.
> >>
> >> Another example are hybrid graphics laptops where the GPU itself (rather
> >> than the root port) is capable of runtime suspending to D3cold.  If the
> >> GPU's integrated HDA controller is not bound and the GPU's driver
> >> decides to runtime suspend to D3cold, the HDA controller's BARs will be
> >> uninitialized when a driver later probes it.
> >>
> >> Fix by restoring the BARs on runtime resume if the device is not bound.
> >> This is sufficient to fix the above-mentioned use cases.  Other use
> >> cases might require a full-blown pci_save_state() / pci_restore_state()
> >> or execution of fixups.  We can add that once use cases materialize,
> >> let's not inflate the code unnecessarily.
> >
> > Why would we not do a full-blown restore?  With this patch, I think
> > some configuration done during enumeration, e.g., ASPM and MPS, will
> > be lost.  "lspci -vv" of the HDA before and after the suspend may show
> > different things, which seems counter-intuitive.
> 
> Right.
> 
> > I wouldn't think of a full-blown restore as "inflating the code"; I
> > would think of it as "having fewer special cases", i.e., we always use
> > the same restore path instead of having the main one plus a special
> > one for unbound devices.
> 
> That is a fair point, but if you look at pci_pm_runtime_suspend(), it
> doesn't actually save anything for devices without drivers, so we'd
> just restore the original initial state for them every time.
> 
> If we are to restore the entire state on runtime resume,
> pci_pm_runtime_suspend() should be changed to call pci_save_state()
> before returning 0 in the !dev->driver case AFAICS.
> 
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> >> ---
> >>  drivers/pci/pci-driver.c | 8 ++++++--
> >>  drivers/pci/pci.c        | 2 +-
> >>  drivers/pci/pci.h        | 1 +
> >>  3 files changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >> index 3bed6beda051..51b11cbd48f6 100644
> >> --- a/drivers/pci/pci-driver.c
> >> +++ b/drivers/pci/pci-driver.c
> >> @@ -1277,10 +1277,14 @@ static int pci_pm_runtime_resume(struct device *dev)
> >>
> >>       /*
> >>        * If pci_dev->driver is not set (unbound), the device should
> >> -      * always remain in D0 regardless of the runtime PM status
> >> +      * always remain in D0 regardless of the runtime PM status.
> >> +      * But if its parent can go to D3cold, this device may have
> >> +      * been in D3cold as well and require restoration of its BARs.
> >>        */
> >> -     if (!pci_dev->driver)
> >> +     if (!pci_dev->driver) {
> >> +             pci_restore_bars(pci_dev);
> >
> > If we do decide not to do a full-blown restore, how do we decide
> > whether to use pci_restore_bars() or pci_restore_config_space()?
> >
> > I'm not sure why we have both.
> 
> Me neither.
> 
> > The pci_restore_bars() path looks a
> > little smarter in that it is more careful when updating 64-bit BARs
> > that can't be updated atomically.
> >
> >>               return 0;
> >> +     }
> >>
> >>       if (!pm || !pm->runtime_resume)
> >>               return -ENOSYS;
> 
> So if pci_pm_runtime_suspend() is modified to call pci_save_state()
> before returning 0 in the !dev->driver case, we can just move the
> pci_restore_standard_config() invocation in pci_pm_runtime_resume() up
> to the very top and check dev->driver later.

I mean something like the patch below, overall (untested).

Tentatively-signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-driver.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -1224,11 +1224,14 @@ static int pci_pm_runtime_suspend(struct
 	int error;
 
 	/*
-	 * If pci_dev->driver is not set (unbound), the device should
-	 * always remain in D0 regardless of the runtime PM status
+	 * If pci_dev->driver is not set (unbound), the device may go to D3cold,
+	 * but only if the bridge above it is suspended.  In case that happens,
+	 * save its config space.
 	 */
-	if (!pci_dev->driver)
+	if (!pci_dev->driver) {
+		pci_save_state(pci_dev);
 		return 0;
+	}
 
 	if (!pm || !pm->runtime_suspend)
 		return -ENOSYS;
@@ -1276,16 +1279,17 @@ static int pci_pm_runtime_resume(struct
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
 	/*
-	 * If pci_dev->driver is not set (unbound), the device should
-	 * always remain in D0 regardless of the runtime PM status
+	 * Regardless of whether or not the driver is there, the device might
+	 * have been put into D3cold as a result of suspending the bridge above
+	 * it, so restore the config spaces of all devices here.
 	 */
+	pci_restore_standard_config(pci_dev);
 	if (!pci_dev->driver)
 		return 0;
 
 	if (!pm || !pm->runtime_resume)
 		return -ENOSYS;
 
-	pci_restore_standard_config(pci_dev);
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 	pci_enable_wake(pci_dev, PCI_D0, false);
 	pci_fixup_device(pci_fixup_resume, pci_dev);
