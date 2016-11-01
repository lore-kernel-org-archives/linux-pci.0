Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35265 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750696AbcKAPmm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2016 11:42:42 -0400
From: Emil Velikov <emil.l.velikov@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: emil.l.velikov@gmail.com, Jammy Zhou <Jammy.Zhou@amd.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: create revision file in sysfs
Date: Tue,  1 Nov 2016 15:42:32 +0000
Message-Id: <20161101154232.6451-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Emil Velikov <emil.velikov@collabora.com>

Currently the revision isn't available via sysfs/libudev thus if one
wants to know the value they need to read through the config file.

This in itself wakes/powers up the device, causing unwanted delay
since it can be quite costly.

Expose the revision as a separate file, just like we do for the device,
vendor, their subsystem version and class.

Cc: Jammy Zhou <Jammy.Zhou@amd.com>
Cc: Michel Dänzer <michel.daenzer@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Emil Velikov <emil.velikov@collabora.com>
---
Gents, I'm not subscribed to the mailing list so please keep me in the
CC chain.

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

