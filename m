Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44622 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729689AbeGQRf7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jul 2018 13:35:59 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 17 Jul 2018 11:02:02 -0600
Message-Id: <20180717170204.30470-3-logang@deltatee.com>
In-Reply-To: <20180717170204.30470-1-logang@deltatee.com>
References: <20180717170204.30470-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v7 2/4] PCI: Allow specifying devices using a base bus and path of devfns
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When specifying PCI devices on the kernel command line using a
BDF, the bus numbers can change when adding or replacing a device,
changing motherboard firmware, or applying kernel parameters like
pci=assign-buses. When this happens, it is usually undesirable to
apply whatever command line tweak to the wrong device.

Therefore, it is useful to be able to specify devices with a base
bus number and the path of devfns needed to get to it. (Similar to
the "device scope" structure in the Intel VT-d spec, Section 8.3.1.)

Thus, we add an option to specify devices in the following format:

[<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*

The path can be any segment within the PCI hierarchy of any length and
determined through the use of 'lspci -t'. When specified this way, it is
less likely that a renumbered bus will result in a valid device specification
and the tweak won't be applied to the wrong device.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |   8 +-
 drivers/pci/pci.c                               | 117 ++++++++++++++++++++----
 2 files changed, 103 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5cc215870ee1..1fdd1ef03984 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3000,7 +3000,7 @@
 				or a set of devices (<pci_dev>). These are
 				specified in one of the following formats:
 
-				[<domain>:]<bus>:<slot>.<func>
+				[<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*
 				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
 
 				Note: the first format specifies a PCI
@@ -3009,7 +3009,11 @@
 				firmware changes, or due to changes caused
 				by other kernel parameters. If the
 				domain is left unspecified, it is
-				taken to be zero. The second format
+				taken to be zero. Optionally, a path
+				to a device through multiple slot/function
+				addresses can be specified after the base
+				address (this is more robust against
+				renumbering issues). The second format
 				selects devices using IDs from the
 				configuration space which may match multiple
 				devices in the system.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6127155d4170..59638075b4df 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -192,6 +192,89 @@ EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
 #endif
 
 /**
+ * pci_dev_str_match_path - test if a path string matches a device
+ * @dev:    the PCI device to test
+ * @p:      string to match the device against
+ * @endptr: pointer to the string after the match
+ *
+ * Test if a string (typically from a kernel parameter) formatted as a
+ * path of slot/function addresses matches a PCI device. The string must
+ * be of the form:
+ *
+ *   [<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*
+ *
+ * A path for a device can be obtained using 'lspci -t'. Using a path
+ * is more robust against bus renumbering than using only a single bus,
+ * slot and function address.
+ *
+ * Returns 1 if the string matches the device, 0 if it does not and
+ * a negative error code if it fails to parse the string.
+ */
+static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
+				  const char **endptr)
+{
+	int ret;
+	int seg, bus, slot, func;
+	char *wpath, *p;
+	char end;
+
+	*endptr = strchrnul(path, ';');
+
+	wpath = kmemdup_nul(path, *endptr - path, GFP_KERNEL);
+	if (!wpath)
+		return -ENOMEM;
+
+	while (1) {
+		p = strrchr(wpath, '/');
+		if (!p)
+			break;
+		ret = sscanf(p, "/%x.%x%c", &slot, &func, &end);
+		if (ret != 2) {
+			ret = -EINVAL;
+			goto free_and_exit;
+		}
+
+		if (dev->devfn != PCI_DEVFN(slot, func)) {
+			ret = 0;
+			goto free_and_exit;
+		}
+
+		/*
+		 * Note: we don't need to get a reference to the upstream
+		 * bridge because we hold a reference to the top level
+		 * device which should hold a reference to the bridge,
+		 * and so on.
+		 */
+		dev = pci_upstream_bridge(dev);
+		if (!dev) {
+			ret = 0;
+			goto free_and_exit;
+		}
+
+		*p = 0;
+	}
+
+	ret = sscanf(wpath, "%x:%x:%x.%x%c", &seg, &bus, &slot,
+		     &func, &end);
+	if (ret != 4) {
+		seg = 0;
+		ret = sscanf(wpath, "%x:%x.%x%c", &bus, &slot, &func, &end);
+		if (ret != 3) {
+			ret = -EINVAL;
+			goto free_and_exit;
+		}
+	}
+
+	ret = (seg == pci_domain_nr(dev->bus) &&
+	       bus == dev->bus->number &&
+	       dev->devfn == PCI_DEVFN(slot, func));
+
+free_and_exit:
+	kfree(wpath);
+	return ret;
+}
+
+/**
  * pci_dev_str_match - test if a string matches a device
  * @dev:    the PCI device to test
  * @p:      string to match the device against
@@ -200,13 +283,16 @@ EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
  * Test if a string (typically from a kernel parameter) matches a specified
  * PCI device. The string may be of one of the following formats:
  *
- *   [<domain>:]<bus>:<slot>.<func>
+ *   [<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*
  *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
  *
  * The first format specifies a PCI bus/slot/function address which
  * may change if new hardware is inserted, if motherboard firmware changes,
  * or due to changes caused in kernel parameters. If the domain is
- * left unspecified, it is taken to be 0.
+ * left unspecified, it is taken to be 0. In order to be robust against
+ * bus renumbering issues, a path of PCI slot/function numbers may be used
+ * to address the specific device. The path for a device can be determined
+ * through the use of 'lspci -t'.
  *
  * The second format matches devices using IDs in the configuration
  * space which may match multiple devices in the system. A value of 0
@@ -222,7 +308,7 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 			     const char **endptr)
 {
 	int ret;
-	int seg, bus, slot, func, count;
+	int count;
 	unsigned short vendor, device, subsystem_vendor, subsystem_device;
 
 	if (strncmp(p, "pci:", 4) == 0) {
@@ -248,25 +334,16 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 		    (!subsystem_device ||
 			    subsystem_device == dev->subsystem_device))
 			goto found;
-
 	} else {
-		/* PCI Bus,Slot,Function ids are specified */
-		ret = sscanf(p, "%x:%x:%x.%x%n", &seg, &bus, &slot,
-			     &func, &count);
-		if (ret != 4) {
-			seg = 0;
-			ret = sscanf(p, "%x:%x.%x%n", &bus, &slot,
-				     &func, &count);
-			if (ret != 3)
-				return -EINVAL;
-		}
-
-		p += count;
+		/*
+		 * PCI Bus,Slot,Function ids are specified
+		 *  (optionally, may include a path of devfns following it)
+		 */
 
-		if (seg == pci_domain_nr(dev->bus) &&
-		    bus == dev->bus->number &&
-		    slot == PCI_SLOT(dev->devfn) &&
-		    func == PCI_FUNC(dev->devfn))
+		ret = pci_dev_str_match_path(dev, p, &p);
+		if (ret < 0)
+			return ret;
+		else if (ret)
 			goto found;
 	}
 
-- 
2.11.0
