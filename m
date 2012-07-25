Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:54732 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753326Ab2GYBuK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Jul 2012 21:50:10 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Tue, 24 Jul 2012 21:50:09 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 265A1C9001C
	for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 21:50:07 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q6P1o64x388674
	for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 21:50:06 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q6P1o38A015853
	for <linux-pci@vger.kernel.org>; Tue, 24 Jul 2012 21:50:06 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, linuxram@us.ibm.com,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 1/8] pci: change variable name for find_pci_host_bridge
Date: Wed, 25 Jul 2012 09:49:50 +0800
Message-Id: <1343180997-9483-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1343180997-9483-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patch changes the variable name for function find_pci_host_bridge()
so that it looks more meaningful. More specificly, the "bus" has been
replaced with "root_bus".

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/host-bridge.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

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
1.7.5.4

