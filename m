Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:48077 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189Ab3AYJIt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2013 04:08:49 -0500
Message-ID: <51024A2F.2000005@huawei.com>
Date: Fri, 25 Jan 2013 17:02:39 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yu Zhao <yu.zhao@intel.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Scott Murray <scott@spiteful.org>,
	Yinghai Lu <yinghai@kernel.org>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	Jack Steiner <steiner@sgi.com>
Subject: Re: [PATCH -v3 0/7] ARI device hotplug support
References: <1358219542-16880-1-git-send-email-wangyijing@huawei.com> <CAErSpo6NaQK-BcoadBbVS4LTFzDdDu_JWWGpb8QAFUJ0aU3+gw@mail.gmail.com>
In-Reply-To: <CAErSpo6NaQK-BcoadBbVS4LTFzDdDu_JWWGpb8QAFUJ0aU3+gw@mail.gmail.com>
Content-Type: multipart/mixed;
	boundary="------------030009070904060705010900"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--------------030009070904060705010900
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On 2013/1/25 6:45, Bjorn Helgaas wrote:
Hi Bjorn,
   Thanks for your review and great work for this series patches!
> 
> I applied this series on the pci/yijing-ari branch in my git tree,
> with the following changes:
> 
>   - Updated changelogs for readability
>   - Reworked next_fn() and made it static
>   - Updated the unconfigure/disable paths for cpcihp, sgihp, shpchp
>   - Check PCI_SLOT for non-PCIe drivers in case a bus has several slots
>   - Reset "Author:" to Yijing (since you wrote the original patches)
> 
> Please review the changes I made and test the parts you can.  I need
> your acknowledgement before putting these in "next" with  your
> Signed-off-by because I changed them so much.

I reviewed the changes and tested this series again in my hotplug machine.
Most of the changes looks good to me except [PATCH 3/7] PCI: Consolidate "next-function" functions.

Currently, if parameter "dev" is passed as NULL (pci_scan_single_device() return NULL), next_fn
will return 0, so pci_scan_slot() will stop scanning rest function devices in this slot.
According to PCI 3.0 Spec "Multi-function devices require to always implement function 0
in the device. Implementing other functions is optional and maybe assigned in any order".
So we will miss some function devices when scanning pci slot. I tested this patch in my machine and found it boot failed,
because some usb devices can not found.

+static unsigned next_fn(struct pci_bus *bus, struct pci_dev *dev, unsigned fn)
 {
-	u16 cap;
-	unsigned pos, next_fn;
+	int pos;
+	u16 cap = 0;
+	unsigned next_fn;

 	if (!dev)
 		return 0;

lspci info:
00:16.0 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.1 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.2 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.3 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.4 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.5 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.6 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.7 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:1a.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #4
00:1a.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #5
00:1a.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #6
00:1a.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #2

I fixed this problem with [PATCH 3/7] PCI: Consolidate "next-function" functions.
And attach this refreshed patch at the end. This patch has been tested, and result is ok in my machine.

> 
> I think there are really two defects you're fixing here:
> 
>   (1) If you hot-remove an ARI device and replace it with a non-ARI
> multi-function device, we find only function 0 of the new device
> because the upstream bridge still has ARI enabled, and next_ari_fn()
> only returns function 0 for non-ARI devices.  Patch [1/7] fixes this.
> I think this is the issue shown by your dmesg quotes above.
> 
>   (2) If you hot-add an ARI device, the PCI core enumerates all the
> functions, but pciehp only initializes functions 0-7, and other
> functions don't work correctly.  Additionally, if you hot-remove the
> device, pciehp only removes functions 0-7, leaving stale pci_dev
> structures around.  Patch [4/7] fixes this.
> 
> If my understanding is correct, I'll update the commit logs to mention
> these scenarios explicitly.

Yes, exactly.

Thanks!
Yijing.

> 
> Bjorn
> 
> .
> 


-- 
Thanks!
Yijing

--------------030009070904060705010900
Content-Type: text/x-patch;
	name="0001-PCI-Consolidate-next-function-functions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-PCI-Consolidate-next-function-functions.patch"

>From 440b930c73d41328c2e355ce989d0e26ee69a50e Mon Sep 17 00:00:00 2001
From: Yijing Wang <wangyijing@huawei.com>
Date: Tue, 15 Jan 2013 11:12:18 +0800
Subject: [PATCH] PCI: Consolidate "next-function" functions

There are several next_fn functions (no_next_fn, next_trad_fn,
next_ari_fn); consolidate them in next_fn() to simplify the code.

[bhelgaas: rework code, make next_fn() static, remove NULL checks]
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   47 ++++++++++++++++++++---------------------------
 1 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 7b9e691..75721a2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1349,31 +1349,30 @@ struct pci_dev *__ref pci_scan_single_device(struct pci_bus *bus, int devfn)
 }
 EXPORT_SYMBOL(pci_scan_single_device);
 
-static unsigned next_ari_fn(struct pci_dev *dev, unsigned fn)
+static unsigned next_fn(struct pci_bus *bus, struct pci_dev *dev, unsigned fn)
 {
-	u16 cap;
-	unsigned pos, next_fn;
+	int pos;
+	u16 cap = 0;
+	unsigned next_fn;
 
-	if (!dev)
-		return 0;
+	if (pci_ari_enabled(bus)) {
+		if (!dev)
+			return 0;
+		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
+		if (!pos)
+			return 0;
 
-	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI);
-	if (!pos)
-		return 0;
-	pci_read_config_word(dev, pos + 4, &cap);
-	next_fn = cap >> 8;
-	if (next_fn <= fn)
-		return 0;
-	return next_fn;
-}
+		pci_read_config_word(dev, pos + PCI_ARI_CAP, &cap);
+		next_fn = PCI_ARI_CAP_NFN(cap);
+		if (next_fn <= fn)
+			return 0;	/* protect against malformed list */
 
-static unsigned next_trad_fn(struct pci_dev *dev, unsigned fn)
-{
-	return (fn + 1) % 8;
-}
+		return next_fn;
+	}
 
-static unsigned no_next_fn(struct pci_dev *dev, unsigned fn)
-{
+	if (!dev || dev->multifunction)
+		return (fn + 1) % 8;
+
 	return 0;
 }
 
@@ -1406,7 +1405,6 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 {
 	unsigned fn, nr = 0;
 	struct pci_dev *dev;
-	unsigned (*next_fn)(struct pci_dev *, unsigned) = no_next_fn;
 
 	if (only_one_child(bus) && (devfn > 0))
 		return 0; /* Already scanned the entire slot */
@@ -1417,12 +1415,7 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
 	if (!dev->is_added)
 		nr++;
 
-	if (pci_ari_enabled(bus))
-		next_fn = next_ari_fn;
-	else if (dev->multifunction)
-		next_fn = next_trad_fn;
-
-	for (fn = next_fn(dev, 0); fn > 0; fn = next_fn(dev, fn)) {
+	for (fn = next_fn(bus, dev, 0); fn > 0; fn = next_fn(bus, dev, fn)) {
 		dev = pci_scan_single_device(bus, devfn + fn);
 		if (dev) {
 			if (!dev->is_added)
-- 
1.7.1


--------------030009070904060705010900--
