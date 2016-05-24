Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
Date: Wed, 25 May 2016 01:46:08 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] PCI: Power on bridges before scanning new devices
Message-ID: <20160524234608.GA1093@al>
References: <20160519231234.GB1785@al>
 <1463991648-85051-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160523200042.GB24375@localhost>
 <20160523215015.GA31479@localhost>
 <20160524122357.GA20453@localhost>
 <20160524125323.GE1789@lahna.fi.intel.com>
 <20160524142744.GA1553@al>
 <20160524163848.GB30762@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160524163848.GB30762@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 24, 2016 at 11:38:48AM -0500, Bjorn Helgaas wrote:
> On Tue, May 24, 2016 at 04:27:44PM +0200, Peter Wu wrote:
> > On Tue, May 24, 2016 at 03:53:23PM +0300, Mika Westerberg wrote:
> > > On Tue, May 24, 2016 at 07:23:57AM -0500, Bjorn Helgaas wrote:
> > > > On Mon, May 23, 2016 at 04:50:15PM -0500, Bjorn Helgaas wrote:
> > > > > [+cc Valdis, Dave]
> > > > > 
> > > > > On Mon, May 23, 2016 at 03:00:42PM -0500, Bjorn Helgaas wrote:
> > > > > > On Mon, May 23, 2016 at 11:20:48AM +0300, Mika Westerberg wrote:
> > > > > > > When a PCI device is removed through sysfs interface the upstream bridge
> > > > > > > (PCIe port) can be runtime suspended if it was the last device on that bus.
> > > > > > > Now, if the bridge is in D3 we cannot find devices below the bridge
> > > > > > > anymore. For example following fails to find the removed device again:
> > > > > > > 
> > > > > > >    # echo 1 > /sys/bus/pci/devices/0000:00:01.0/0000:01:00.0/remove
> > > > > > >    # echo 1 > /sys/bus/pci/devices/0000:00:01.0/rescan
> > > > > > > 
> > > > > > > Where 0000:00:01.0 is the bridge device.
> > > > > > > 
> > > > > > > In order to be able to rescan devices below the bridge add
> > > > > > > pm_runtime_get_sync()/pm_runtime_put() calls to pci_scan_bridge(). This
> > > > > > > should keep bridges powered on while their children devices are being
> > > > > > > scanned.
> > > > > > > 
> > > > > > > Reported-by: Peter Wu <peter@lekensteyn.nl>
> > > > > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > > 
> > > > > > This looks like basically the same idea as "ACPI / hotplug / PCI:
> > > > > > Runtime resume bridge before rescan".
> > > > > > 
> > > > > > The hotplug_event() path modified by that patch eventually calls
> > > > > > pci_scan_bridge():
> > > > > > 
> > > > > >   hotplug_event
> > > > > >     enable_slot
> > > > > >       pci_scan_bridge
> > > > > > 
> > > > > > so this patch looks a little more general.  Does it make "ACPI /
> > > > > > hotplug / PCI: Runtime resume bridge before rescan" unnecessary?  
> > > > > > Can I just replace that patch with this one?
> > > > > 
> > > > > I speculatively replaced "ACPI / hotplug / PCI: Runtime resume bridge
> > > > > before rescan" with this one and pushed the result to
> > > > > 
> > > > >   https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/pm
> > > > > 
> > > > > Please take a look, test it, and let me know if I need to add the ACPI
> > > > > patch back.
> > > > > 
> > > > > This branch also includes the fix for the lockdep splat reported by
> > > > > Valdis.  This is what I hope to get into v4.7-rc1.
> > > > 
> > > > Ping?  I'd like to ask Linus to pull this pci/pm branch before v4.7-rc1.
> > > > It currently has these changes:
> > > > 
> > > >   8b71f5652eea PCI: Add runtime PM support for PCIe ports
> > > >   af81f0fa638b PCI: Power on bridges before scanning new devices
> > > >   9741a01c9f55 PCI: Put PCIe ports into D3 during suspend
> > > >   b3a63ff7baf1 PCI: Don't clear d3cold_allowed for PCIe ports
> > > 
> > > Looks good to me. I've also tested those here and seems to work fine.
> > 
> > I have tested these patches for some time now on top of v4.6 (just
> > dropped the ACPI hotplug patch and re-tested just to be sure) and it
> > works for nouveau, but only if that one is patched to avoid calling the
> > device-specific Optimus method. 
> 
> I assume this nouveau issue is a driver problem unrelated to the
> pci/pm changes, and it wouldn't make any difference if I included the
> ACPI hotplug patch.  Right?

This is a nouveau-specific driver problem that is triggered by the
adding runtime PM support for PCIe ports.

> > Without that patch (WIP below, I plan to
> > rebase it on a refactoring patch), the nvidia card stays disabled even
> > after the bridge returns into D0:
> > 
> >     nouveau 0000:01:00.0: power state changed by ACPI to D0
> >     nouveau 0000:01:00.0: Refused to change power state, currently in D3
> >     nouveau 0000:01:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x1ff)
> >     nouveau 0000:01:00.0: restoring config space at offset 0x38 (was 0xffffffff, writing 0x0)
> >     nouveau 0000:01:00.0: restoring config space at offset 0x34 (was 0xffffffff, writing 0x60)
> >     nouveau 0000:01:00.0: restoring config space at offset 0x30 (was 0xffffffff, writing 0xdf000000)
> >     ...
> >     INFO: rcu_sched self-detected stall on CPU
> > 
> > A workaround (until nouveau is fixed) is to disable runtime PM on the
> > bridge (or on nouveau with nouveau.runpm=0):
> > 
> >     # echo on > /sys/bus/pci/devices/0000:00:01.0/power/control
> > 
> > This was tested on a Clevo P651RA laptop (with acpi_osi="!Windows 2013",
> > there is a weird PCIe PM issue for which I will fill a report later).
> 
> This seems like a pretty significant problem: if we enable runtime PM
> on bridges by default, and Nvidia cards stay disabled when the bridge
> returns to D0, that sounds like a bad regression.  I don't think I
> could ask Linus to pull these changes with a known issue like that.
> Or am I misunderstanding something?

That would indeed be a regression, please see this nouveau patch series
for a suggestion:
https://lists.freedesktop.org/archives/nouveau/2016-May/025116.html

By the way, there is also currently a RPM refcounting issue in nouveau
(possibly fixed by
https://lists.freedesktop.org/archives/nouveau/2016-May/025107.html)
which resulted in the following problem:

 1. Initially RPM refcount is 1 when no driver is loaded for a device.
 2. Load nouveau which will RPM suspend the device. refcount becomes 0.
 3. Unload nouveau (bug: refcount stays 0).
 4. As a result, the PCIe ports are runtime suspended (should probably
    not happen as there is no bound driver).
 5. When nouveau is loaded again, the power resources are enabled again,
    *but* it does not put the device into D0 (it expected that this was
    already the case). (with ACPI debugging on I see that _PS0 is not
    called).
 6. As a result, reading registers failed, "unknown chipset (ffffffff)"
    is printed to dmesg and the probe fails.

(Maybe the PCI core should have a WARN when the RPM is "auto" and the
refcount drops below 1 after remove is called with no driver left?)

Kind regards,
Peter Wu

> > ---
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> > index cdf5227..531d6be 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
> > @@ -45,6 +45,7 @@
> >  static struct nouveau_dsm_priv {
> >  	bool dsm_detected;
> >  	bool optimus_detected;
> > +	bool use_pr3;
> >  	acpi_handle dhandle;
> >  	acpi_handle rom_handle;
> >  } nouveau_dsm_priv;
> > @@ -246,6 +247,28 @@ static int nouveau_dsm_pci_probe(struct pci_dev *pdev)
> >  	return retval;
> >  }
> >  
> > +/* Windows 8/8.1/10 do not use DSM to put the device in D3cold state,
> > + * instead it disables power resources on the parent PCIe port device. */
> > +static bool nouveau_check_pr3(struct pci_dev *dis_dev)
> > +{
> > +	acpi_handle parent_handle;
> > +	struct acpi_device *ad = NULL;
> > +
> > +	if (ACPI_FAILURE(acpi_get_parent(nouveau_dsm_priv.dhandle,
> > +					 &parent_handle))) {
> > +		pr_warn("Failed to obtain the parent device\n");
> > +		return false;
> > +	}
> > +
> > +	acpi_bus_get_device(parent_handle, &ad);
> > +	if (!ad) {
> > +		pr_warn("Failed to obtain an ACPI device for handle\n");
> > +		return false;
> > +	}
> > +
> > +	return ad->power.flags.power_resources;
> > +}
> > +
> >  static bool nouveau_dsm_detect(void)
> >  {
> >  	char acpi_method_name[255] = { 0 };
> > @@ -253,6 +276,7 @@ static bool nouveau_dsm_detect(void)
> >  	struct pci_dev *pdev = NULL;
> >  	int has_dsm = 0;
> >  	int has_optimus = 0;
> > +	int has_pr3 = 0;
> >  	int vga_count = 0;
> >  	bool guid_valid;
> >  	int retval;
> > @@ -271,8 +295,10 @@ static bool nouveau_dsm_detect(void)
> >  		retval = nouveau_dsm_pci_probe(pdev);
> >  		if (retval & NOUVEAU_DSM_HAS_MUX)
> >  			has_dsm |= 1;
> > -		if (retval & NOUVEAU_DSM_HAS_OPT)
> > +		if (retval & NOUVEAU_DSM_HAS_OPT) {
> >  			has_optimus = 1;
> > +			has_pr3 |= nouveau_check_pr3(pdev);
> > +		}
> >  	}
> >  
> >  	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_3D << 8, pdev)) != NULL) {
> > @@ -281,8 +307,10 @@ static bool nouveau_dsm_detect(void)
> >  		retval = nouveau_dsm_pci_probe(pdev);
> >  		if (retval & NOUVEAU_DSM_HAS_MUX)
> >  			has_dsm |= 1;
> > -		if (retval & NOUVEAU_DSM_HAS_OPT)
> > +		if (retval & NOUVEAU_DSM_HAS_OPT) {
> >  			has_optimus = 1;
> > +			has_pr3 |= nouveau_check_pr3(pdev);
> > +		}
> >  	}
> >  
> >  	/* find the optimus DSM or the old v1 DSM */
> > @@ -292,6 +320,10 @@ static bool nouveau_dsm_detect(void)
> >  		printk(KERN_INFO "VGA switcheroo: detected Optimus DSM method %s handle\n",
> >  			acpi_method_name);
> >  		nouveau_dsm_priv.optimus_detected = true;
> > +		if (has_pr3) {
> > +			pr_info("detected PR3 support\n");
> > +			nouveau_dsm_priv.use_pr3 = 1;
> > +		}
> >  		ret = true;
> >  	} else if (vga_count == 2 && has_dsm && guid_valid) {
> >  		acpi_get_name(nouveau_dsm_priv.dhandle, ACPI_FULL_PATHNAME,
> > @@ -321,7 +353,7 @@ void nouveau_register_dsm_handler(void)
> >  void nouveau_switcheroo_optimus_dsm(void)
> >  {
> >  	u32 result = 0;
> > -	if (!nouveau_dsm_priv.optimus_detected)
> > +	if (!nouveau_dsm_priv.optimus_detected || nouveau_dsm_priv.use_pr3)
> >  		return;
> >  
> >  	nouveau_optimus_dsm(nouveau_dsm_priv.dhandle, NOUVEAU_DSM_OPTIMUS_FLAGS,
