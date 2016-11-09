Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33205 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbcKIQ4S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2016 11:56:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so30437288wmu.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Nov 2016 08:56:17 -0800 (PST)
From: Emil Velikov <emil.l.velikov@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: emil.l.velikov@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: create revision file in sysfs
Date: Wed,  9 Nov 2016 16:56:07 +0000
Message-Id: <20161109165607.26322-1-emil.l.velikov@gmail.com>
In-Reply-To: <20161101154232.6451-1-emil.l.velikov@gmail.com>
References: <20161101154232.6451-1-emil.l.velikov@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Emil Velikov <emil.velikov@collabora.com>

Currently the revision isn't available via sysfs/libudev thus if one
wants to know the value they need to read through the config file.

This in itself wakes/powers up the device, causing unwanted delays.

There are at least two userspace components which could make use the new
file - libpciaccess and libdrm. At the moment the former will wake up
_every_ PCI device for simple invocation of glxinfo [when using Mesa
10.0+ drivers]. While the latter [in association with Mesa 13.0] can
lead to 2-3 second delays while starting firefox, thunderbird or
chromium.

Expose the revision as a separate file, just like we do for the device,
vendor, their subsystem version and class.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Link: https://bugs.freedesktop.org/show_bug.cgi?id=98502
Tested-by: Mauro Santos <registo.mailling@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
v2:
 - Add r-b/t-b tags
 - Slim down CC list
 - Add note about userspace.

As before, please keep me in the CC list. Additionally if there's
anything else I can do to get things going please let me know.

Thanks
Emil
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index bcd10c7..0666287 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -50,6 +50,7 @@ pci_config_attr(vendor, "0x%04x\n");
 pci_config_attr(device, "0x%04x\n");
 pci_config_attr(subsystem_vendor, "0x%04x\n");
 pci_config_attr(subsystem_device, "0x%04x\n");
+pci_config_attr(revision, "0x%02x\n");
 pci_config_attr(class, "0x%06x\n");
 pci_config_attr(irq, "%u\n");
 
@@ -568,6 +569,7 @@ static struct attribute *pci_dev_attrs[] = {
 	&dev_attr_device.attr,
 	&dev_attr_subsystem_vendor.attr,
 	&dev_attr_subsystem_device.attr,
+	&dev_attr_revision.attr,
 	&dev_attr_class.attr,
 	&dev_attr_irq.attr,
 	&dev_attr_local_cpus.attr,
-- 
2.9.3

