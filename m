Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43599 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab3J3DWZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2013 23:22:25 -0400
Received: by mail-pb0-f46.google.com with SMTP id un4so760181pbc.19
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2013 20:22:24 -0700 (PDT)
From: Chang Liu <cl91tp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Chang Liu <cl91tp@gmail.com>
Subject: [PATCH] PCI: Blacklist certain hardware from clearing Bus Master bit
Date: Wed, 30 Oct 2013 11:22:11 +0000
Message-Id: <1383132131-1096-1-git-send-email-cl91tp@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a blacklist that prevents pci device shutdown code
from clearing Bus Master bit on certain hardware that cannot tolerate it.

Clearing Bus Master bit was originally added in commit b566a22 to address
the issue of some PCI device breaking kexec by continuing to do DMA
after having been signaled to shutdown. However, this introduced a
regression (https://bugzilla.kernel.org/show_bug.cgi?id=63861) that
hangs the machine on kernel power off path.

It has been pointed out previously (https://lkml.org/lkml/2012/6/6/545)
that clearing Bus Master bit during PCI shutdown may have surprising
consequences as some devices may not tolerate this, and may hang the
system indefinitely. However, not doing so may break kexec. Since only
one bug report has come up since the introduction of b566a22, therefore
indicating that these misbehaving devices are in the minority, the
logical way to fix the hang while not breaking kexec is to blacklist
these devices from having their Bus Master bit cleared during the PCI
shutdown routine.

Signed-off-by: Chang Liu <cl91tp@gmail.com>
---
This fixes the above mentioned bug https://bugzilla.kernel.org/show_bug.cgi?id=63861

As Alan Cox has warned in https://lkml.org/lkml/2012/6/6/545, some device
will break if we clear bus master bit on shutdown. So sooner or later
we will need to blacklist some device if we are to keep Bus Master being cleared
as the default behavior. Now with the first (as I have been aware) device
that breaks under this default behavior has surfaced, we might as well
add the infrastructure code now in case some other devices break down
in the future. These devices may not be many so a blacklist likely won't
add much maintainance overhead. And we should keep the blacklist here in
the pci shutdown code instead of in individual device drivers since this
is the most direct way and will likely aid future debug process.

Regarding the kexec issue which the original commit b566a22c was trying to address:
kexec doesn't work on this machine, even before the patch was applied (ie. in
earlier kernels, I tested 3.11.6 and 3.12-rc7). Possibly because some devices
won't reinitialize themselves properly. On 3.11.6, kexec -e triggers an immediate
reboot. On 3.12-rc7, both with and without this patch applied, kexec -e can get it
halfway into booting the new kernel but then a reboot is also triggered. I'm not sure
if this patch has helped the kexec situation in this machine or not, but since it
has no effects on machines without this defective SATA controller (and/or its firmware),
I would say it is unlikely to negatively affect kexec on other machines.

 drivers/pci/pci-driver.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 98f7b9b..1744ebf 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -376,6 +376,29 @@ static int pci_device_remove(struct device * dev)
 	return 0;
 }
 
+/*
+ * Blacklisting certain hardware from having their Bus Master bit cleared
+ * during device shutdown. This is to workaround certain hardware's issue
+ * with clearing Bus Master bit that hangs the entire system.
+ */
+struct {
+	unsigned short vendor;
+	unsigned short device;
+} pci_bus_master_blacklist[] = {
+	{ 0x8086, 0x9c03 },	/* Intel Corporation Lynx Point-LP SATA Controller */
+};
+
+static bool pci_should_clear_master(struct pci_dev *pdev)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(pci_bus_master_blacklist); i++) {
+		if (pdev->vendor == pci_bus_master_blacklist[i].vendor
+		    && pdev->device == pci_bus_master_blacklist[i].device)
+			return false;
+	}
+	return true;
+}
+
 static void pci_device_shutdown(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -391,9 +414,18 @@ static void pci_device_shutdown(struct device *dev)
 	/*
 	 * Turn off Bus Master bit on the device to tell it to not
 	 * continue to do DMA. Don't touch devices in D3cold or unknown states.
+	 * This is useful for proper kexec. However, a number of hardware
+	 * aren't happy with this. At the slightest, some hardware simply
+	 * ignore the bus master bit. For some other hardware, clearing
+	 * the bit on shutdown path hangs the entire system.
+	 * This is likely to be a firmware or hardware problem, but
+	 * we can workaround it here by blacklisting these hardware
+	 * from having their bus master bit cleared during device shutdown.
 	 */
-	if (pci_dev->current_state <= PCI_D3hot)
+	if (pci_should_clear_master(pci_dev)
+	    && pci_dev->current_state <= PCI_D3hot) {
 		pci_clear_master(pci_dev);
+	}
 }
 
 #ifdef CONFIG_PM
-- 
1.8.4.1

