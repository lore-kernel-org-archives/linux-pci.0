Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:33731 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbbHYOoO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2015 10:44:14 -0400
Received: by obbhe7 with SMTP id he7so143844961obb.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2015 07:44:14 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 25 Aug 2015 09:44:14 -0500
Message-ID: <CAC1AzdcoZHpRJ3NpW2UQnp9frEYn6pAf5cPyDx4zPXT3TUiULA@mail.gmail.com>
Subject: [PATCH 1/3] PCI: Move MPS configuration check to pci_configure_device()
From: Jordan Hargrave <jharg93@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>Previously we checked for invalid MPS settings, i.e., a device with MPS
>different than its upstream bridge, in pcie_bus_detect_mps().  We only did
>this if the arch or hotplug driver called pcie_bus_configure_settings(),
>and then only if PCIe bus tuning was disabled (PCIE_BUS_TUNE_OFF).
>
>Move the MPS checking code to pci_configure_device(), so we do it in the
>pci_device_add() path for every device.
>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>---
> drivers/pci/probe.c |   43 ++++++++++++++++++++++++-------------------
> 1 file changed, 24 insertions(+), 19 deletions(-)
>
>diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>index 9ff4df0..eb32395 100644
>--- a/drivers/pci/probe.c
>+++ b/drivers/pci/probe.c
>@@ -1275,6 +1275,27 @@ int pci_setup_device(struct pci_dev *dev)
>     return 0;
> }
>
>+static void pci_configure_mps(struct pci_dev *dev)
>+{
>+    struct pci_dev *bridge = pci_upstream_bridge(dev);
>+    int mps, p_mps;
>+
>+    if (!pci_is_pcie(dev) || !bridge || !pci_is_pcie(bridge))
>+        return;
>+
>+    mps = pcie_get_mps(dev);
>+    p_mps = pcie_get_mps(bridge);
>+
>+    if (mps == p_mps)
>+        return;
>+
>+    if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
>+        dev_warn(&dev->dev, "Max Payload Size %d, but upstream %s set to %d; if necessary, \
>use \"pci=pcie_bus_safe\" and report a bug\n", +             mps, pci_name(bridge), p_mps);
>+        return;
>+    }
>+}
>+
> static struct hpp_type0 pci_default_type0 = {
>     .revision = 1,
>     .cache_line_size = 8,
>@@ -1396,6 +1417,8 @@ static void pci_configure_device(struct pci_dev *dev)
>     struct hotplug_params hpp;
>     int ret;
>
>+    pci_configure_mps(dev);
>+
>     memset(&hpp, 0, sizeof(hpp));
>     ret = pci_get_hp_params(dev, &hpp);
>     if (ret)
>@@ -1791,22 +1814,6 @@ static void pcie_write_mrrs(struct pci_dev *dev)
>         dev_err(&dev->dev, "MRRS was unable to be configured with a safe value.  If \
>problems are experienced, try running with pci=pcie_bus_safe\n");  }
>
>-static void pcie_bus_detect_mps(struct pci_dev *dev)
>-{
>-    struct pci_dev *bridge = dev->bus->self;
>-    int mps, p_mps;
>-
>-    if (!bridge)
>-        return;
>-
>-    mps = pcie_get_mps(dev);
>-    p_mps = pcie_get_mps(bridge);
>-
>-    if (mps != p_mps)
>-        dev_warn(&dev->dev, "Max Payload Size %d, but upstream %s set to %d; if necessary, \
>                use \"pci=pcie_bus_safe\" and report a bug\n",
>-             mps, pci_name(bridge), p_mps);
>-}
>-
> static int pcie_bus_configure_set(struct pci_dev *dev, void *data)
> {
>     int mps, orig_mps;
>@@ -1814,10 +1821,8 @@ static int pcie_bus_configure_set(struct pci_dev *dev, void \
>*data)  if (!pci_is_pcie(dev))
>         return 0;
>
>-    if (pcie_bus_config == PCIE_BUS_TUNE_OFF) {
>-        pcie_bus_detect_mps(dev);
>+    if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
>         return 0;
>-    }
>
>     mps = 128 << *(u8 *)data;
>     orig_mps = pcie_get_mps(dev);
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

I have tested the patch and it is working on our PCIE SSD devices.

This is basically reimplementing a patch I introduced several years
ago that was reverted.
http://marc.info/?l=linux-pci&m=130100586722666&w=2

+/* Program PCIE MaxPayload setting on device: ensure parent
maxpayload <= device */
+static int pci_set_payload(struct pci_dev *dev)
+{
+ int pos, ppos;
+ u16 pctl, psz;
+ u16 dctl, dsz, dcap, dmax;
+ struct pci_dev *parent;
+
+ parent = dev->bus->self;
+ pos = pci_find_capability(dev, PCI_CAP_ID_EXP);
+ if (!pos)
+ return 0;
+
+ /* Read Device MaxPayload capability and setting */
+ pci_read_config_word(dev, pos + PCI_EXP_DEVCTL, &dctl);
+ pci_read_config_word(dev, pos + PCI_EXP_DEVCAP, &dcap);
+ dsz = (dctl & PCI_EXP_DEVCTL_PAYLOAD) >> 5;
+ dmax = (dcap & PCI_EXP_DEVCAP_PAYLOAD);
+
+ /* Read Parent MaxPayload setting */
+ ppos = pci_find_capability(parent, PCI_CAP_ID_EXP);
+ if (!ppos)
+ return 0;
+ pci_read_config_word(parent, ppos + PCI_EXP_DEVCTL, &pctl);
+ psz = (pctl &  PCI_EXP_DEVCTL_PAYLOAD) >> 5;
+
+ /* If parent payload > device max payload -> error
+ * If parent payload > device payload -> set speed
+ * If parent payload <= device payload -> do nothing
+ */
+ if (psz > dmax)
+ return -1;
+ else if (psz > dsz) {
+ dev_info(&dev->dev, "Setting MaxPayload to %d\n", 128 << psz);
+ pci_write_config_word(dev, pos + PCI_EXP_DEVCTL,
+      (dctl & ~PCI_EXP_DEVCTL_PAYLOAD) +
+      (psz << 5));
+ }
+ return 0;
+}
+




One thing is you are not checking if the max possible payload of the
inserted device is less than the payload setting of the parent.  If
the bridge is set at 512 MPS for example, and the inserted device only
supports a MPS of 256, it should error out and disable the PCI device.
