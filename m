Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:12645 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbcFHGOT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2016 02:14:19 -0400
From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"bhelgaas@kernel.org" <bhelgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"hjk@hansjkoch.de" <hjk@hansjkoch.de>
Subject: Re: [PATCH] Extending kernel option pci=resource_alignment to be able
 to specify PCI device/vendor IDs
Date: Wed, 8 Jun 2016 06:14:16 +0000
Message-ID: <c2861d5d0f534854b8fb7ced8820791b@FE-MBX1012.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Greg,

> > Signed-off-by: Mathias Koehrer <mathias.koehrer@etas.com>
> >
> > ---
> >  Documentation/kernel-parameters.txt |    2 +
> >  drivers/pci/pci.c                   |   66 +++++++++++++++++++++++++-----------
> >  2 files changed, 49 insertions(+), 19 deletions(-)
> 
> This looks better, but wow, messy.  I'll defer to the PCI maintainer and
> developers now, this is in their camp, not mine :)
It looks messy as I had to change the indentation of existing code...
A "diff -u -w" on pci.c delivers a much simpler diff:

--- pci.c.orig	2016-05-29 16:29:24.000000000 +0000
+++ pci.c	2016-06-08 06:08:05.000000000 +0000
@@ -4755,6 +4755,7 @@
 static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 {
 	int seg, bus, slot, func, align_order, count;
+	unsigned short vendor, device, subsystem_vendor, subsystem_device;
 	resource_size_t align = 0;
 	char *p;
 
@@ -4768,6 +4769,32 @@
 		} else {
 			align_order = -1;
 		}
+		if (strncmp(p, "pci:", 4) == 0) {
+			/* PCI vendor/device (subvendor/subdevice) ids are specified */
+			p += 4;
+			if (sscanf(p, "%hx:%hx:%hx:%hx%n",
+				&vendor, &device, &subsystem_vendor, &subsystem_device, &count) != 4) {
+				if (sscanf(p, "%hx:%hx%n", &vendor, &device, &count) != 2) {
+					printk(KERN_ERR "PCI: Can't parse resource_alignment parameter: pci:%s\n",
+						p);
+					break;
+				}
+				subsystem_vendor = subsystem_device = 0;
+			}
+			p += count;
+			if ((!vendor || (vendor == dev->vendor)) &&
+				(!device || (device == dev->device)) &&
+				(!subsystem_vendor || (subsystem_vendor == dev->subsystem_vendor)) &&
+				(!subsystem_device || (subsystem_device == dev->subsystem_device))) {
+				if (align_order == -1)
+					align = PAGE_SIZE;
+				else
+					align = 1 << align_order;
+				/* Found */
+				break;
+			}
+		}
+		else {
 		if (sscanf(p, "%x:%x:%x.%x%n",
 			&seg, &bus, &slot, &func, &count) != 4) {
 			seg = 0;
@@ -4791,6 +4818,7 @@
 			/* Found */
 			break;
 		}
+		}
 		if (*p != ';' && *p != ',') {
 			/* End of param or invalid format */
 			break;


Best regards

Mathias
