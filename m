Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:39926 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966099AbeEXVss (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 May 2018 17:48:48 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 24 May 2018 15:48:15 -0600
Message-Id: <20180524214816.14485-3-logang@deltatee.com>
In-Reply-To: <20180524214816.14485-1-logang@deltatee.com>
References: <20180524214816.14485-1-logang@deltatee.com>
Subject: [PATCH 2/3] PCI: Allow specifying devices using a base bus and path of devfns
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

path:[<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]

The path can be any segment within the PCI hierarchy of any length and
determined through the use of 'lspci -t'. When specified this way, it is
less likely that a renumbered bus will result in a valid device specification
and the tweak won't be applied to the wrong device.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  12 ++-
 drivers/pci/pci.c                               | 106 +++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 894aa516ceab..519ab95bb418 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2986,9 +2986,10 @@
 
 				Some options herein operate on a specific device
 				or a set of devices (<pci_dev>). These are
-				specified in one of two formats:
+				specified in one of three formats:
 
 				[<domain>:]<bus>:<slot>.<func>
+				path:[<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]
 				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
 
 				Note: the first format specifies a PCI
@@ -2996,9 +2997,12 @@
 				if new hardware is inserted, if motherboard
 				firmware changes, or due to changes caused
 				by other kernel parameters. The second format
-				selects devices using IDs from the
-				configuration space which may match multiple
-				devices in the system.
+				specifies a path from a device through
+				a path of multiple slot/function addresses
+				(this is more robust against renumbering
+				issues). The third format selects devices using
+				IDs from the configuration space which may match
+				multiple devices in the system.
 
 		earlydump	[X86] dump PCI config space before the kernel
 			        changes anything
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 85fec5e2640b..53ea0d7b02ce 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -184,22 +184,116 @@ EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
 #endif
 
 /**
+ * pci_dev_str_match_path - test if a path string matches a device
+ * @dev:    the PCI device to test
+ * @p:      string to match the device against
+ * @endptr: pointer to the string after the match
+ *
+ * Test if a string (typically from a kernel parameter) formated as a
+ * path of slot/function addresses matches a PCI device. The string must
+ * be of the form:
+ *
+ *   [<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]
+ *
+ * A path for a device can be obtained using 'lspci -t'. Using a path
+ * is more robust against renumbering of devices than using only
+ * a single bus, slot and function address.
+ *
+ * Returns 1 if the string matches the device, 0 if it does not and
+ * a negative error code if it fails to parse the string.
+ */
+static int pci_dev_str_match_path(struct pci_dev *dev, const char *p,
+				  const char **endptr)
+{
+	int ret;
+	int seg, bus, slot, func, count;
+	u8 *devfn_path;
+	int num_devfn = 0;
+	struct pci_dev *tmp;
+
+	ret = sscanf(p, "%x:%x:%x.%x%n", &seg, &bus, &slot,
+		     &func, &count);
+	if (ret != 4) {
+		seg = 0;
+		ret = sscanf(p, "%x:%x.%x%n", &bus, &slot,
+			     &func, &count);
+		if (ret != 3)
+			return -EINVAL;
+	}
+
+	p += count;
+
+	devfn_path = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	devfn_path[num_devfn++] = PCI_DEVFN(slot, func);
+
+	while (*p && *p != ',' && *p != ';') {
+		ret = sscanf(p, "/%x.%x%n", &slot, &func, &count);
+		if (ret != 2) {
+			ret = -EINVAL;
+			goto free_and_exit;
+		}
+
+		p += count;
+		devfn_path[num_devfn++] = PCI_DEVFN(slot, func);
+		if (num_devfn >= PAGE_SIZE) {
+			ret = -EINVAL;
+			goto free_and_exit;
+		}
+	}
+
+	*endptr = p;
+	ret = 0;
+
+	if (seg != pci_domain_nr(dev->bus))
+		goto free_and_exit;
+
+	pci_dev_get(dev);
+	while (num_devfn > 0 && dev) {
+		num_devfn--;
+
+		if (devfn_path[num_devfn] != dev->devfn)
+			goto put_and_exit;
+
+		if (num_devfn == 0 && bus == dev->bus->number) {
+			ret = 1;
+			goto put_and_exit;
+		}
+
+		tmp = pci_dev_get(pci_upstream_bridge(dev));
+		pci_dev_put(dev);
+		dev = tmp;
+	}
+
+put_and_exit:
+	pci_dev_put(dev);
+free_and_exit:
+	kfree(devfn_path);
+	return ret;
+}
+
+/**
  * pci_dev_str_match - test if a string matches a device
  * @dev:    the PCI device to test
  * @p:      string to match the device against
  * @endptr: pointer to the string after the match
  *
  * Test if a string (typically from a kernel parameter) matches a
- * specified. The string may be of one of two forms formats:
+ * specified. The string may be of one of three formats:
  *
  *   [<domain>:]<bus>:<slot>.<func>
+ *   path:[<domain>:]<bus>:<slot>.<func>/<slot>.<func>[/ ...]
  *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
  *
  * The first format specifies a PCI bus/slot/function address which
  * may change if new hardware is inserted, if motherboard firmware changes,
  * or due to changes caused in kernel parameters.
  *
- * The second format matches devices using IDs in the configuration
+ * The second format specifies a PCI bus/slot/function root address and
+ * a path of slot/function addresses to the specific device from the root.
+ * The path for a device can be determined through the use of 'lspci -t'.
+ * This format is more robust against renumbering issues than the first format.
+
+ * The third format matches devices using IDs in the configuration
  * space which may match multiple devices in the system. A value of 0
  * for any field will match all devices.
  *
@@ -236,7 +330,15 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
 		    (!subsystem_device ||
 			    subsystem_device == dev->subsystem_device))
 			goto found;
+	} else if (strncmp(p, "path:", 5) == 0) {
+		/* PCI Root Bus and a path of Slot,Function IDs */
+		p += 5;
 
+		ret = pci_dev_str_match_path(dev, p, &p);
+		if (ret < 0)
+			return ret;
+		else if (ret)
+			goto found;
 	} else {
 		/* PCI Bus,Slot,Function ids are specified */
 		ret = sscanf(p, "%x:%x:%x.%x%n", &seg, &bus, &slot,
-- 
2.11.0
