Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:49466 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbdISBxu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2017 21:53:50 -0400
Received: by mail-io0-f173.google.com with SMTP id 21so6614674iof.6
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2017 18:53:50 -0700 (PDT)
To: bhelgaas@google.com, linux-pci@vger.kernel.org
From: Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: SR-IOV & virtfn/physfn sysfs links
Message-ID: <d3328861-2da2-918d-c3db-cc0795ab1586@gmail.com>
Date: Mon, 18 Sep 2017 20:53:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn et al,

I'm hoping to enhance network device naming in systemd to parse sysfs "virtfn%u" and "physfn" links, so it understands virtual devices.

I've noticed that the udev event which triggers the systemd/biosdevname network device naming--the udev "add" event for the network device, which happens within pci_bus_add_device() when the network driver's probe function calls register_netdev()--occurs before the sysfs links "physfn" and "virtfn%u" are created.  This creates a race when the network naming code tries to look at those links (something biosdevname already does).

Is there any reason why we couldn't switch the order of those calls to eliminate the race, as shown in the patch below?  I couldn't think of any, since those links apply to the pci subsystem devices in sysfs (which are already created), not the net subsystem devices.  I'd be happy to submit a patch if that looks ok.

Thank you,
Stuart


--- linux-4.14-rc1/drivers/pci/iov.c.orig	2017-09-18 15:00:43.168255665 -0500
+++ linux-4.14-rc1/drivers/pci/iov.c	2017-09-18 15:07:04.792280999 -0500
@@ -162,7 +162,6 @@ int pci_iov_add_virtfn(struct pci_dev *d
 
 	pci_device_add(virtfn, virtfn->bus);
 
-	pci_bus_add_device(virtfn);
 	sprintf(buf, "virtfn%u", id);
 	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
 	if (rc)
@@ -173,6 +172,8 @@ int pci_iov_add_virtfn(struct pci_dev *d
 
 	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
 
+	pci_bus_add_device(virtfn);
+
 	return 0;
 
 failed2:


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
