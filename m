Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e8.ny.us.ibm.com ([32.97.182.138]:42650 "EHLO e8.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257Ab2F2GsA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jun 2012 02:48:00 -0400
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Fri, 29 Jun 2012 02:47:59 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5T6luTh370306
	for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2012 02:47:56 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5T6lsUf001241
	for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2012 03:47:56 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: bhelgaas@google.com, yinghai@kernel.org, benh@kernel.crashing.org,
	linuxram@us.ibm.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 1/7] pci: change variable name for find_pci_host_bridge
Date: Fri, 29 Jun 2012 14:47:44 +0800
Message-Id: <4d83a00eb93941658d685c9f117b28e26687396e.1340949637.git.shangw@linux.vnet.ibm.com>
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch changes the variable name for function find_pci_host_bridge()
so that it looks more meaningful. More specificly, the "bus" has been
replaced with "root_bus".

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/host-bridge.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index a68dc61..c19776a 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -22,9 +22,9 @@ static struct pci_bus *find_pci_root_bus(struct pci_dev *dev)
 
 static struct pci_host_bridge *find_pci_host_bridge(struct pci_dev *dev)
 {
-	struct pci_bus *bus = find_pci_root_bus(dev);
+	struct pci_bus *root_bus = find_pci_root_bus(dev);
 
-	return to_pci_host_bridge(bus->bridge);
+	return to_pci_host_bridge(root_bus->bridge);
 }
 
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
-- 
1.7.9.5

