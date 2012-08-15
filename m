Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:65302 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab2HOOLR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 10:11:17 -0400
Received: by yenl14 with SMTP id l14so1800433yen.19
        for <linux-pci@vger.kernel.org>; Wed, 15 Aug 2012 07:11:15 -0700 (PDT)
Message-ID: <502BAEA5.5080505@gmail.com>
Date: Wed, 15 Aug 2012 22:13:57 +0800
From: Yijing Wang <wangyijing0307@gmail.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Do we need acpiphp_sanitize_bus() in acpiphp?
Content-Type: text/plain; charset=GB2312
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,
   I have some confusion on acpiphp_sanitize_bus() functions.If I understand wrong about this, correct me,thanks your help.
   I think there are three problems in this function:
   1¡¢Use list_for_each_entry here is not safe, because pci_stop_and_remove_bus_device() will remove the device from bus.
   2¡¢If assign resources fail after hot-add a device, the resource will reset to zero, in reset_resource(), res->start = 0,
      res->end =0, res->end = 0.
   3¡¢I think leave the fail pci devices in the system is better rather than remove them, so we can see all pci devices
      by lspci after hot-add, what about your opinion?

thanks!
Yijing.

/*
 * Remove devices for which we could not assign resources, call
 * arch specific code to fix-up the bus
 */
static void acpiphp_sanitize_bus(struct pci_bus *bus)
{
	struct pci_dev *dev;
	int i;
	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM;

	list_for_each_entry(dev, &bus->devices, bus_list) {
		for (i=0; i<PCI_BRIDGE_RESOURCES; i++) {
			struct resource *res = &dev->resource[i];
			if ((res->flags & type_mask) && !res->start &&
					res->end) {
				/* Could not assign a required resources
				 * for this device, remove it */
				pci_stop_and_remove_bus_device(dev);
				break;
			}
		}
	}
}
