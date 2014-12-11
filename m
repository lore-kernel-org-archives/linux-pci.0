Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43250 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934422AbaLKRev (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Dec 2014 12:34:51 -0500
Received: by mail-qa0-f46.google.com with SMTP id n8so3895475qaq.33
        for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2014 09:34:51 -0800 (PST)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 11 Dec 2014 10:34:30 -0700
Message-ID: <CAErSpo4iZCUZgqNi-fX+YX=sKV=Ae5z8kn8-++E0Cgft9unmBg@mail.gmail.com>
Subject: Special handling of display/VGA devices in hotplug drivers
To: Dely Sy <dely.l.sy@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>,
	Guenter Roeck <groeck@juniper.net>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

It looks like you added the initial pciehp driver [1], which includes
the following code in pciehp_disable_slot():

+ if (class_code == PCI_BASE_CLASS_DISPLAY) {
+ /* Display/Video adapter (not supported) */
+ rc = REMOVE_NOT_SUPPORTED;

+ /* If it's a bridge, check the VGA Enable bit */
+ if ((header_type & 0x7F) == PCI_HEADER_TYPE_BRIDGE) {
+ rc = pci_bus_read_config_byte (pci_bus, devfn, PCI_BRIDGE_CONTROL, &BCR);
+ if (rc)
+ return rc;
+
+ /* If the VGA Enable bit is set, remove isn't supported */
+ if (BCR & PCI_BRIDGE_CTL_VGA) {
+ rc = REMOVE_NOT_SUPPORTED;

I'm trying to figure out why VGA devices are handled specially.  I
can't find anything in the PCI specs that mentions this.  Most of the
other PCI hotplug drivers have similar code.  Do you remember anything
about this?

Bjorn


[1] https://git.kernel.org/cgit/linux/kernel/git/tglx/history.git/commit/drivers/pci/hotplug/pciehp_ctrl.c?id=c16b4b14d9806e639f4afefa2d651a857a212afe
