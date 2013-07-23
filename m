Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:64905 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933709Ab3GWSIQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 14:08:16 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so10670002obb.39
        for <linux-pci@vger.kernel.org>; Tue, 23 Jul 2013 11:08:15 -0700 (PDT)
Subject: [PATCH] PCI: pciehp: Convert pciehp to be builtin only, not modular
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>
Date: Tue, 23 Jul 2013 12:08:14 -0600
Message-ID: <20130723180001.19616.72450.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I originally intended to merge this patch for v3.12.

However, Yinghai is working on a regression fix ("PCI: Separate stop and
remove devices in pciehp") that needs to go into v3.11, and his fix will be
simpler if we remove the module option for pciehp in v3.11.  That will mean
he won't have to export pci_stop_bus_device() and pci_remove_bus_device()
for use by modules.

I think this will be pretty safe because we already supported pciehp
being built-in and RHEL6 and Ubuntu 12.10 already make it built-in.

Therefore, I propose to put this in my for-linus branch and merge it
for v3.11.

---

Bjorn Helgaas (1):
      PCI: pciehp: Convert pciehp to be builtin only, not modular


 drivers/pci/pcie/Kconfig |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
