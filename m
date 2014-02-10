Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:18218 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbaBJPXx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2014 10:23:53 -0500
Date: Mon, 10 Feb 2014 18:23:50 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Marta Rybczynska <rybczynska@gmail.com>,
	linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] PCI hotplug: cpqphp: hex vs decimal typo in cpqhpc_probe()
Message-ID: <20140210152350.GA24189@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a static checker fix and I can't test it, but from the context
it definitely looks like hexidecimal 0x20 was intended here instead of
decimal 20.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index 31273e155e6c..037e2612c5bd 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -920,12 +920,12 @@ static int cpqhpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				bus->max_bus_speed = PCI_SPEED_100MHz_PCIX;
 				break;
 			}
-			if (bus_cap & 20) {
+			if (bus_cap & 0x20) {
 				dbg("bus max supports 66MHz PCI-X\n");
 				bus->max_bus_speed = PCI_SPEED_66MHz_PCIX;
 				break;
 			}
-			if (bus_cap & 10) {
+			if (bus_cap & 0x10) {
 				dbg("bus max supports 66MHz PCI\n");
 				bus->max_bus_speed = PCI_SPEED_66MHz;
 				break;
