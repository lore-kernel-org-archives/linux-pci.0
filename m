Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56045 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759282AbbCDUCo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 4 Mar 2015 15:02:44 -0500
Subject: [PATCH 1/5] vfio-pci: Allow PCI IDs to be specified as module
 options
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com, kvm@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2015 13:02:43 -0700
Message-ID: <20150304200243.26766.556.stgit@gimli.home>
In-Reply-To: <20150304194711.26766.75450.stgit@gimli.home>
References: <20150304194711.26766.75450.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This copies the same support from pci-stub for exactly the same
purpose, enabling a set of PCI IDs to be automatically added to the
driver's dynamic ID table at module load time.  The code here is
pretty simple and both vfio-pci and pci-stub are fairly unique in
being meta drivers, capable of attaching to any device, so there's no
attempt made to generalize the code into pci-core.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c |   46 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index f8a1863..b3bae4c 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -32,6 +32,10 @@
 #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
 #define DRIVER_DESC     "VFIO PCI - User Level meta-driver"
 
+static char ids[1024] __initdata;
+module_param_string(ids, ids, sizeof(ids), 0);
+MODULE_PARM_DESC(ids, "Initial PCI IDs to add to the vfio driver, format is \"vendor:device[:subvendor[:subdevice[:class[:class_mask]]]]\" and multiple comma separated entries can be specified");
+
 static bool nointxmask;
 module_param_named(nointxmask, nointxmask, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(nointxmask,
@@ -1034,6 +1038,46 @@ static void __exit vfio_pci_cleanup(void)
 	vfio_pci_uninit_perm_bits();
 }
 
+static void __init vfio_pci_fill_ids(void)
+{
+	char *p, *id;
+	int rc;
+
+	/* no ids passed actually */
+	if (ids[0] == '\0')
+		return;
+
+	/* add ids specified in the module parameter */
+	p = ids;
+	while ((id = strsep(&p, ","))) {
+		unsigned int vendor, device, subvendor = PCI_ANY_ID,
+			subdevice = PCI_ANY_ID, class = 0, class_mask = 0;
+		int fields;
+
+		if (!strlen(id))
+			continue;
+
+		fields = sscanf(id, "%x:%x:%x:%x:%x:%x",
+				&vendor, &device, &subvendor, &subdevice,
+				&class, &class_mask);
+
+		if (fields < 2) {
+			pr_warn("vfio-pci: invalid id string \"%s\"\n", id);
+			continue;
+		}
+
+		pr_info("vfio-pci: add %04X:%04X sub=%04X:%04X cls=%08X/%08X\n",
+			vendor, device, subvendor, subdevice,
+			class, class_mask);
+
+		rc = pci_add_dynid(&vfio_pci_driver, vendor, device,
+				   subvendor, subdevice, class, class_mask, 0);
+		if (rc)
+			pr_warn("vfio-pci: failed to add dynamic id (%d)\n",
+				rc);
+	}
+}
+
 static int __init vfio_pci_init(void)
 {
 	int ret;
@@ -1053,6 +1097,8 @@ static int __init vfio_pci_init(void)
 	if (ret)
 		goto out_driver;
 
+	vfio_pci_fill_ids();
+
 	return 0;
 
 out_driver:

