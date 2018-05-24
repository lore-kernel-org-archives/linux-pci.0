Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:39900 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969433AbeEXVss (ORCPT <rfc822;linux-pci@vger.kernel.org>);
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
Date: Thu, 24 May 2018 15:48:14 -0600
Message-Id: <20180524214816.14485-2-logang@deltatee.com>
In-Reply-To: <20180524214816.14485-1-logang@deltatee.com>
References: <20180524214816.14485-1-logang@deltatee.com>
Subject: [PATCH 1/3] PCI: Make specifying PCI devices in kernel parameters reusable
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Separate out the code to match a PCI device with a string (typically
originating from a kernel parameter) from the
pci_specified_resource_alignment() function into its own helper
function.

While we are at it, this change fixes the kernel style of the function
(fixing a number of long lines and extra parentheses).

Additionally, make the analogous change to the kernel parameter
documentation: Separating the description of how to specify a PCI device
into it's own section at the head of the pci= parameter.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  26 +++-
 drivers/pci/pci.c                               | 153 +++++++++++++++---------
 2 files changed, 120 insertions(+), 59 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28ecdb6d..894aa516ceab 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2982,7 +2982,24 @@
 			See header of drivers/block/paride/pcd.c.
 			See also Documentation/blockdev/paride.txt.
 
-	pci=option[,option...]	[PCI] various PCI subsystem options:
+	pci=option[,option...]	[PCI] various PCI subsystem options.
+
+				Some options herein operate on a specific device
+				or a set of devices (<pci_dev>). These are
+				specified in one of two formats:
+
+				[<domain>:]<bus>:<slot>.<func>
+				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
+
+				Note: the first format specifies a PCI
+				bus/slot/function address which may change
+				if new hardware is inserted, if motherboard
+				firmware changes, or due to changes caused
+				by other kernel parameters. The second format
+				selects devices using IDs from the
+				configuration space which may match multiple
+				devices in the system.
+
 		earlydump	[X86] dump PCI config space before the kernel
 			        changes anything
 		off		[X86] don't probe for the PCI bus
@@ -3111,11 +3128,10 @@
 				window. The default value is 64 megabytes.
 		resource_alignment=
 				Format:
-				[<order of align>@][<domain>:]<bus>:<slot>.<func>[; ...]
-				[<order of align>@]pci:<vendor>:<device>\
-						[:<subvendor>:<subdevice>][; ...]
+				[<order of align>@]<pci_dev>[; ...]
 				Specifies alignment and device to reassign
-				aligned memory resources.
+				aligned memory resources. How to
+				specify the device is described above.
 				If <order of align> is not specified,
 				PAGE_SIZE is used as alignment.
 				PCI-PCI bridge can be specified, if resource
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index dbfe7c4f3776..85fec5e2640b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -183,6 +183,88 @@ void __iomem *pci_ioremap_wc_bar(struct pci_dev *pdev, int bar)
 EXPORT_SYMBOL_GPL(pci_ioremap_wc_bar);
 #endif
 
+/**
+ * pci_dev_str_match - test if a string matches a device
+ * @dev:    the PCI device to test
+ * @p:      string to match the device against
+ * @endptr: pointer to the string after the match
+ *
+ * Test if a string (typically from a kernel parameter) matches a
+ * specified. The string may be of one of two forms formats:
+ *
+ *   [<domain>:]<bus>:<slot>.<func>
+ *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
+ *
+ * The first format specifies a PCI bus/slot/function address which
+ * may change if new hardware is inserted, if motherboard firmware changes,
+ * or due to changes caused in kernel parameters.
+ *
+ * The second format matches devices using IDs in the configuration
+ * space which may match multiple devices in the system. A value of 0
+ * for any field will match all devices.
+ *
+ * Returns 1 if the string matches the device, 0 if it does not and
+ * a negative error code if the string cannot be parsed.
+ */
+static int pci_dev_str_match(struct pci_dev *dev, const char *p,
+			     const char **endptr)
+{
+	int ret;
+	int seg, bus, slot, func, count;
+	unsigned short vendor, device, subsystem_vendor, subsystem_device;
+
+	if (strncmp(p, "pci:", 4) == 0) {
+		/* PCI vendor/device (subvendor/subdevice) ids are specified */
+		p += 4;
+		ret = sscanf(p, "%hx:%hx:%hx:%hx%n", &vendor, &device,
+			     &subsystem_vendor, &subsystem_device, &count);
+		if (ret != 4) {
+			ret = sscanf(p, "%hx:%hx%n", &vendor, &device, &count);
+			if (ret != 2)
+				return -EINVAL;
+
+			subsystem_vendor = 0;
+			subsystem_device = 0;
+		}
+
+		p += count;
+
+		if ((!vendor || vendor == dev->vendor) &&
+		    (!device || device == dev->device) &&
+		    (!subsystem_vendor ||
+			    subsystem_vendor == dev->subsystem_vendor) &&
+		    (!subsystem_device ||
+			    subsystem_device == dev->subsystem_device))
+			goto found;
+
+	} else {
+		/* PCI Bus,Slot,Function ids are specified */
+		ret = sscanf(p, "%x:%x:%x.%x%n", &seg, &bus, &slot,
+			     &func, &count);
+		if (ret != 4) {
+			seg = 0;
+			ret = sscanf(p, "%x:%x.%x%n", &bus, &slot,
+				     &func, &count);
+			if (ret != 3)
+				return -EINVAL;
+		}
+
+		p += count;
+
+		if (seg == pci_domain_nr(dev->bus) &&
+		    bus == dev->bus->number &&
+		    slot == PCI_SLOT(dev->devfn) &&
+		    func == PCI_FUNC(dev->devfn))
+			goto found;
+	}
+
+	*endptr = p;
+	return 0;
+
+found:
+	*endptr = p;
+	return 1;
+}
 
 static int __pci_find_next_cap_ttl(struct pci_bus *bus, unsigned int devfn,
 				   u8 pos, int cap, int *ttl)
@@ -5462,10 +5544,10 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
 static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 							bool *resize)
 {
-	int seg, bus, slot, func, align_order, count;
-	unsigned short vendor, device, subsystem_vendor, subsystem_device;
+	int align_order, count;
 	resource_size_t align = pcibios_default_alignment();
-	char *p;
+	const char *p;
+	int ret;
 
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
@@ -5485,58 +5567,21 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 		} else {
 			align_order = -1;
 		}
-		if (strncmp(p, "pci:", 4) == 0) {
-			/* PCI vendor/device (subvendor/subdevice) ids are specified */
-			p += 4;
-			if (sscanf(p, "%hx:%hx:%hx:%hx%n",
-				&vendor, &device, &subsystem_vendor, &subsystem_device, &count) != 4) {
-				if (sscanf(p, "%hx:%hx%n", &vendor, &device, &count) != 2) {
-					printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: pci:%s\n",
-						p);
-					break;
-				}
-				subsystem_vendor = subsystem_device = 0;
-			}
-			p += count;
-			if ((!vendor || (vendor == dev->vendor)) &&
-				(!device || (device == dev->device)) &&
-				(!subsystem_vendor || (subsystem_vendor == dev->subsystem_vendor)) &&
-				(!subsystem_device || (subsystem_device == dev->subsystem_device))) {
-				*resize = true;
-				if (align_order == -1)
-					align = PAGE_SIZE;
-				else
-					align = 1 << align_order;
-				/* Found */
-				break;
-			}
-		}
-		else {
-			if (sscanf(p, "%x:%x:%x.%x%n",
-				&seg, &bus, &slot, &func, &count) != 4) {
-				seg = 0;
-				if (sscanf(p, "%x:%x.%x%n",
-						&bus, &slot, &func, &count) != 3) {
-					/* Invalid format */
-					printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: %s\n",
-						p);
-					break;
-				}
-			}
-			p += count;
-			if (seg == pci_domain_nr(dev->bus) &&
-				bus == dev->bus->number &&
-				slot == PCI_SLOT(dev->devfn) &&
-				func == PCI_FUNC(dev->devfn)) {
-				*resize = true;
-				if (align_order == -1)
-					align = PAGE_SIZE;
-				else
-					align = 1 << align_order;
-				/* Found */
-				break;
-			}
+
+		ret = pci_dev_str_match(dev, p, &p);
+		if (ret == 1) {
+			*resize = true;
+			if (align_order == -1)
+				align = PAGE_SIZE;
+			else
+				align = 1 << align_order;
+			break;
+		} else if (ret < 0) {
+			pr_info("PCI: Can't parse resource_alignment parameter: pci:%s\n",
+				p);
+			break;
 		}
+
 		if (*p != ';' && *p != ',') {
 			/* End of param or invalid format */
 			break;
-- 
2.11.0
