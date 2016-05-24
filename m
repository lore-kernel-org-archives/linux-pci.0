Return-Path: <peter@lekensteyn.nl>
Return-Path: <peter@lekensteyn.nl>
Date: Tue, 24 May 2016 16:27:44 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] PCI: Power on bridges before scanning new devices
Message-ID: <20160524142744.GA1553@al>
References: <20160519231234.GB1785@al>
 <1463991648-85051-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160523200042.GB24375@localhost>
 <20160523215015.GA31479@localhost>
 <20160524122357.GA20453@localhost>
 <20160524125323.GE1789@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160524125323.GE1789@lahna.fi.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 24, 2016 at 03:53:23PM +0300, Mika Westerberg wrote:
> On Tue, May 24, 2016 at 07:23:57AM -0500, Bjorn Helgaas wrote:
> > On Mon, May 23, 2016 at 04:50:15PM -0500, Bjorn Helgaas wrote:
> > > [+cc Valdis, Dave]
> > > 
> > > On Mon, May 23, 2016 at 03:00:42PM -0500, Bjorn Helgaas wrote:
> > > > On Mon, May 23, 2016 at 11:20:48AM +0300, Mika Westerberg wrote:
> > > > > When a PCI device is removed through sysfs interface the upstream bridge
> > > > > (PCIe port) can be runtime suspended if it was the last device on that bus.
> > > > > Now, if the bridge is in D3 we cannot find devices below the bridge
> > > > > anymore. For example following fails to find the removed device again:
> > > > > 
> > > > >    # echo 1 > /sys/bus/pci/devices/0000:00:01.0/0000:01:00.0/remove
> > > > >    # echo 1 > /sys/bus/pci/devices/0000:00:01.0/rescan
> > > > > 
> > > > > Where 0000:00:01.0 is the bridge device.
> > > > > 
> > > > > In order to be able to rescan devices below the bridge add
> > > > > pm_runtime_get_sync()/pm_runtime_put() calls to pci_scan_bridge(). This
> > > > > should keep bridges powered on while their children devices are being
> > > > > scanned.
> > > > > 
> > > > > Reported-by: Peter Wu <peter@lekensteyn.nl>
> > > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > 
> > > > This looks like basically the same idea as "ACPI / hotplug / PCI:
> > > > Runtime resume bridge before rescan".
> > > > 
> > > > The hotplug_event() path modified by that patch eventually calls
> > > > pci_scan_bridge():
> > > > 
> > > >   hotplug_event
> > > >     enable_slot
> > > >       pci_scan_bridge
> > > > 
> > > > so this patch looks a little more general.  Does it make "ACPI /
> > > > hotplug / PCI: Runtime resume bridge before rescan" unnecessary?  
> > > > Can I just replace that patch with this one?
> > > 
> > > I speculatively replaced "ACPI / hotplug / PCI: Runtime resume bridge
> > > before rescan" with this one and pushed the result to
> > > 
> > >   https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/pm
> > > 
> > > Please take a look, test it, and let me know if I need to add the ACPI
> > > patch back.
> > > 
> > > This branch also includes the fix for the lockdep splat reported by
> > > Valdis.  This is what I hope to get into v4.7-rc1.
> > 
> > Ping?  I'd like to ask Linus to pull this pci/pm branch before v4.7-rc1.
> > It currently has these changes:
> > 
> >   8b71f5652eea PCI: Add runtime PM support for PCIe ports
> >   af81f0fa638b PCI: Power on bridges before scanning new devices
> >   9741a01c9f55 PCI: Put PCIe ports into D3 during suspend
> >   b3a63ff7baf1 PCI: Don't clear d3cold_allowed for PCIe ports
> 
> Looks good to me. I've also tested those here and seems to work fine.

I have tested these patches for some time now on top of v4.6 (just
dropped the ACPI hotplug patch and re-tested just to be sure) and it
works for nouveau, but only if that one is patched to avoid calling the
device-specific Optimus method. Without that patch (WIP below, I plan to
rebase it on a refactoring patch), the nvidia card stays disabled even
after the bridge returns into D0:

    nouveau 0000:01:00.0: power state changed by ACPI to D0
    nouveau 0000:01:00.0: Refused to change power state, currently in D3
    nouveau 0000:01:00.0: restoring config space at offset 0x3c (was 0xffffffff, writing 0x1ff)
    nouveau 0000:01:00.0: restoring config space at offset 0x38 (was 0xffffffff, writing 0x0)
    nouveau 0000:01:00.0: restoring config space at offset 0x34 (was 0xffffffff, writing 0x60)
    nouveau 0000:01:00.0: restoring config space at offset 0x30 (was 0xffffffff, writing 0xdf000000)
    ...
    INFO: rcu_sched self-detected stall on CPU

A workaround (until nouveau is fixed) is to disable runtime PM on the
bridge (or on nouveau with nouveau.runpm=0):

    # echo on > /sys/bus/pci/devices/0000:00:01.0/power/control

This was tested on a Clevo P651RA laptop (with acpi_osi="!Windows 2013",
there is a weird PCIe PM issue for which I will fill a report later).

Kind regards,
Peter

> > I dropped "ACPI / hotplug / PCI: Runtime resume bridge before rescan"
> > on the assumption that "PCI: Power on bridges before scanning new
> > devices" is sufficient to cover both the ACPI and the generic PCi
> > rescan cases, but I'd like some reassurance about that.
> 
> I agree with your reasoning that the patch should not be needed anymore.
> However, I have the machine which needed that patch at home so I'm not
> able to test it now. I'll do that later today when I get back home.
> 
> One thing I noticed, though. When a bridge is transitioned to D0 we only
> wait for 10ms which is requirement for PCI functions. However, PCI PM
> specification 1.2 (chapter 4.2) requires that for buses to transition
> from B2 to B0 we need to wait minimum of 50ms before accessing a
> function on that bus.
> 
> We even have PCI_PM_BUS_WAIT defined in include/linux/pci.h but it is
> not used anywhere. Maybe it was not needed originally because we never
> powered down bridges anyway but now when we do, I think it is good idea
> to do what the spec requires.
> 
> What do you think? We could add a separate patch doing something like
> below to make sure the spec is followed.
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e785dc260e72..b3b794caa380 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2361,7 +2361,12 @@ void pci_pm_init(struct pci_dev *dev)
>  	}
>  
>  	dev->pm_cap = pm;
> -	dev->d3_delay = PCI_PM_D3_WAIT;
> +	/*
> +	 * PCI PM 1.2 specification requires minimum of 50ms before any
> +	 * function on the bus is accessed after the bus is transitioned
> +	 * from B2 to B0.
> +	 */
> +	dev->d3_delay = pci_is_bridge(dev) ? PCI_PM_BUS_WAIT : PCI_PM_D3_WAIT;
>  	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
>  	dev->bridge_d3 = pci_bridge_d3_possible(dev);
>  	dev->d3cold_allowed = true;

---
diff --git a/drivers/gpu/drm/nouveau/nouveau_acpi.c b/drivers/gpu/drm/nouveau/nouveau_acpi.c
index cdf5227..531d6be 100644
--- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
+++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
@@ -45,6 +45,7 @@
 static struct nouveau_dsm_priv {
 	bool dsm_detected;
 	bool optimus_detected;
+	bool use_pr3;
 	acpi_handle dhandle;
 	acpi_handle rom_handle;
 } nouveau_dsm_priv;
@@ -246,6 +247,28 @@ static int nouveau_dsm_pci_probe(struct pci_dev *pdev)
 	return retval;
 }
 
+/* Windows 8/8.1/10 do not use DSM to put the device in D3cold state,
+ * instead it disables power resources on the parent PCIe port device. */
+static bool nouveau_check_pr3(struct pci_dev *dis_dev)
+{
+	acpi_handle parent_handle;
+	struct acpi_device *ad = NULL;
+
+	if (ACPI_FAILURE(acpi_get_parent(nouveau_dsm_priv.dhandle,
+					 &parent_handle))) {
+		pr_warn("Failed to obtain the parent device\n");
+		return false;
+	}
+
+	acpi_bus_get_device(parent_handle, &ad);
+	if (!ad) {
+		pr_warn("Failed to obtain an ACPI device for handle\n");
+		return false;
+	}
+
+	return ad->power.flags.power_resources;
+}
+
 static bool nouveau_dsm_detect(void)
 {
 	char acpi_method_name[255] = { 0 };
@@ -253,6 +276,7 @@ static bool nouveau_dsm_detect(void)
 	struct pci_dev *pdev = NULL;
 	int has_dsm = 0;
 	int has_optimus = 0;
+	int has_pr3 = 0;
 	int vga_count = 0;
 	bool guid_valid;
 	int retval;
@@ -271,8 +295,10 @@ static bool nouveau_dsm_detect(void)
 		retval = nouveau_dsm_pci_probe(pdev);
 		if (retval & NOUVEAU_DSM_HAS_MUX)
 			has_dsm |= 1;
-		if (retval & NOUVEAU_DSM_HAS_OPT)
+		if (retval & NOUVEAU_DSM_HAS_OPT) {
 			has_optimus = 1;
+			has_pr3 |= nouveau_check_pr3(pdev);
+		}
 	}
 
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_3D << 8, pdev)) != NULL) {
@@ -281,8 +307,10 @@ static bool nouveau_dsm_detect(void)
 		retval = nouveau_dsm_pci_probe(pdev);
 		if (retval & NOUVEAU_DSM_HAS_MUX)
 			has_dsm |= 1;
-		if (retval & NOUVEAU_DSM_HAS_OPT)
+		if (retval & NOUVEAU_DSM_HAS_OPT) {
 			has_optimus = 1;
+			has_pr3 |= nouveau_check_pr3(pdev);
+		}
 	}
 
 	/* find the optimus DSM or the old v1 DSM */
@@ -292,6 +320,10 @@ static bool nouveau_dsm_detect(void)
 		printk(KERN_INFO "VGA switcheroo: detected Optimus DSM method %s handle\n",
 			acpi_method_name);
 		nouveau_dsm_priv.optimus_detected = true;
+		if (has_pr3) {
+			pr_info("detected PR3 support\n");
+			nouveau_dsm_priv.use_pr3 = 1;
+		}
 		ret = true;
 	} else if (vga_count == 2 && has_dsm && guid_valid) {
 		acpi_get_name(nouveau_dsm_priv.dhandle, ACPI_FULL_PATHNAME,
@@ -321,7 +353,7 @@ void nouveau_register_dsm_handler(void)
 void nouveau_switcheroo_optimus_dsm(void)
 {
 	u32 result = 0;
-	if (!nouveau_dsm_priv.optimus_detected)
+	if (!nouveau_dsm_priv.optimus_detected || nouveau_dsm_priv.use_pr3)
 		return;
 
 	nouveau_optimus_dsm(nouveau_dsm_priv.dhandle, NOUVEAU_DSM_OPTIMUS_FLAGS,
