Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:56502 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258Ab2F2GsA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jun 2012 02:48:00 -0400
Received: from /spool/local
	by e5.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Fri, 29 Jun 2012 02:47:59 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5T6lvsc400230
	for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2012 02:47:57 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5T6lu2H001102
	for <linux-pci@vger.kernel.org>; Fri, 29 Jun 2012 03:47:57 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: bhelgaas@google.com, yinghai@kernel.org, benh@kernel.crashing.org,
	linuxram@us.ibm.com, Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: [PATCH 3/7] pci: make find_pci_host_bridge global
Date: Fri, 29 Jun 2012 14:47:46 +0800
Message-Id: <5cc19d49348943cd7986fa74558e3b82cc60de73.1340949637.git.shangw@linux.vnet.ibm.com>
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch makes function find_pci_host_bridge() global so that the
platforms (e.g. PPC) can access pci_host_bridge.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/host-bridge.c |    2 +-
 include/linux/pci.h       |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index fc16357..a43d393 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -17,7 +17,7 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 	return bus;
 }
 
-static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
+struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
 {
 	struct pci_bus *root_bus = find_pci_root_bus(bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fefb4e1..615ac90 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -385,6 +385,7 @@ struct pci_host_bridge {
 };
 
 #define	to_pci_host_bridge(n) container_of(n, struct pci_host_bridge, dev)
+struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus);
 void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 		     void (*release_fn)(struct pci_host_bridge *),
 		     void *release_data);
-- 
1.7.9.5

