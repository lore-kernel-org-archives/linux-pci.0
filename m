Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 9 Mar 2015 22:52:38 +0100
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Petri Hodju <petrihodju@yahoo.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	linux-pci@vger.kernel.org
Subject: Re: [Patch v2 resend] apple-gmux: lock iGP IO to protect from
 vgaarb changes
Message-ID: <20150309225238.0b9ced4e@neptune.home>
In-Reply-To: <20150307011546.0050279d@neptune.home>
References: <20150223215155.18444386@neptune.home>
	<20150303172753.GF83894@vmdeb7>
	<20150305232038.1873d380@neptune.home>
	<20150306174254.GB19001@vmdeb7>
	<20150307011546.0050279d@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

As GMUX depends on IO for iGP to be enabled and active, lock the IO at
vgaarb level. This should prevent GPU driver for dGPU to disable IO for
iGP while it tries to own legacy VGA IO.

This fixes usage of backlight control combined with closed nvidia
driver on some Apple dual-GPU (intel/nvidia) systems.

On those systems loading nvidia driver disables intel IO decoding,
disabling the gmux backlight controls as a side effect.
Prior to commits moving boot_vga from (optional) efifb to less optional
vgaarb this mis-behavior could be avoided by using right kernel config
(efifb enabled but vgaarb disabled).

This patch explicitly does not try to trigger vgaarb changes in order
to avoid confusing already running graphics drivers. If IO has been
mis-configured by vgaarb gmux will thus fail to probe.
It is expected to load/probe gmux prior to graphics drivers.

Fixes: ce027dac592c0ada241ce0f95ae65856828ac450 # nvidia interaction
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=86121
Reported-by: Petri Hodju <petrihodju@yahoo.com>
Tested-by: Petri Hodju <petrihodju@yahoo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>
Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
---
Resending v2 in the hope Darren won't hit quoted-printable.
Also adding linux-pci on CC by Bjorn's request in bugzilla.

Changes since v1:
- Dropped repeat of gmux in pr_info/pr_err calls
- Mention PCI device we tried to lock IO for in case of error


 drivers/platform/x86/apple-gmux.c | 43 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index b9429fb..22da6a3 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/pci.h>
 #include <linux/vga_switcheroo.h>
+#include <linux/vgaarb.h>
 #include <acpi/video.h>
 #include <asm/io.h>
 
@@ -31,6 +32,7 @@ struct apple_gmux_data {
 	bool indexed;
 	struct mutex index_lock;
 
+	struct pci_dev *pdev;
 	struct backlight_device *bdev;
 
 	/* switcheroo data */
@@ -415,6 +417,22 @@ static int gmux_resume(struct device *dev)
 	return 0;
 }
 
+static struct pci_dev *gmux_find_pdev(void)
+{
+	struct pci_dev *pdev = NULL;
+	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev))) {
+		u16 cmd;
+
+		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+		if (!(cmd & PCI_COMMAND_IO))
+			continue;
+
+		return pdev;
+	}
+
+	return NULL;
+}
+
 static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 {
 	struct apple_gmux_data *gmux_data;
@@ -425,6 +443,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	int ret = -ENXIO;
 	acpi_status status;
 	unsigned long long gpe;
+	struct pci_dev *pdev = NULL;
 
 	if (apple_gmux_data)
 		return -EBUSY;
@@ -475,7 +494,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 			ver_minor = (version >> 16) & 0xff;
 			ver_release = (version >> 8) & 0xff;
 		} else {
-			pr_info("gmux device not present\n");
+			pr_info("gmux device not present or IO disabled\n");
 			ret = -ENODEV;
 			goto err_release;
 		}
@@ -483,6 +502,23 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major, ver_minor,
 		ver_release, (gmux_data->indexed ? "indexed" : "classic"));
 
+	/*
+	 * Apple systems with gmux are EFI based and normally don't use
+	 * VGA. In addition changing IO+MEM ownership between IGP and dGPU
+	 * disables IO/MEM used for backlight control on some systems.
+	 * Lock IO+MEM to GPU with active IO to prevent switch.
+	 */
+	pdev = gmux_find_pdev();
+	if (pdev && vga_tryget(pdev,
+			       VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM)) {
+		pr_err("IO+MEM vgaarb-locking for PCI:%s failed\n",
+			pci_name(pdev));
+		ret = -EBUSY;
+		goto err_release;
+	} else if (pdev)
+		pr_info("locked IO for PCI:%s\n", pci_name(pdev));
+	gmux_data->pdev = pdev;
+
 	memset(&props, 0, sizeof(props));
 	props.type = BACKLIGHT_PLATFORM;
 	props.max_brightness = gmux_read32(gmux_data, GMUX_PORT_MAX_BRIGHTNESS);
@@ -574,6 +609,7 @@ err_enable_gpe:
 err_notify:
 	backlight_device_unregister(bdev);
 err_release:
+	pci_dev_put(pdev);
 	release_region(gmux_data->iostart, gmux_data->iolen);
 err_free:
 	kfree(gmux_data);
@@ -593,6 +629,11 @@ static void gmux_remove(struct pnp_dev *pnp)
 					   &gmux_notify_handler);
 	}
 
+	if (gmux_data->pdev) {
+		vga_put(gmux_data->pdev,
+			VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM);
+		pci_dev_put(gmux_data->pdev);
+	}
 	backlight_device_unregister(gmux_data->bdev);
 
 	release_region(gmux_data->iostart, gmux_data->iolen);
