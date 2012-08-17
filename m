Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f74.google.com ([74.125.83.74]:52986 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab2HQXgD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2012 19:36:03 -0400
Received: by eekd4 with SMTP id d4so192260eek.1
        for <linux-pci@vger.kernel.org>; Fri, 17 Aug 2012 16:36:01 -0700 (PDT)
Subject: [PATCH v2 03/16] pcmcia: Use common pci_stop_and_remove_bus_device()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pcmcia@lists.infradead.org, Yinghai Lu <yinghai@kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Date: Fri, 17 Aug 2012 17:36:00 -0600
Message-ID: <20120817233600.10973.11841.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
References: <20120817233100.10973.59521.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Use pci_stop_and_remove_bus_device() like most other hotplug drivers
rather than the special-purpose "behind_bridge" variant.  This just
means we have to iterate through all the devices downstream of the
bridge ourselves, which is the same thing pci_stop_behind_bridge()
did.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pcmcia/cardbus.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
index 24caeaf..94f87b5 100644
--- a/drivers/pcmcia/cardbus.c
+++ b/drivers/pcmcia/cardbus.c
@@ -106,7 +106,10 @@ int __ref cb_alloc(struct pcmcia_socket *s)
 void cb_free(struct pcmcia_socket *s)
 {
 	struct pci_dev *bridge = s->cb_dev;
+	struct pci_bus *bus = bridge->subordinate;
+	struct pci_dev *dev, *tmp;
 
-	if (bridge)
-		pci_stop_and_remove_behind_bridge(bridge);
+	if (bus)
+		list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list)
+			pci_stop_and_remove_bus_device(dev);
 }

