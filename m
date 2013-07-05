Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:38435 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143Ab3GEC5p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jul 2013 22:57:45 -0400
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <shangw@linux.vnet.ibm.com>;
	Thu, 4 Jul 2013 20:57:45 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C661319D8041
	for <linux-pci@vger.kernel.org>; Thu,  4 Jul 2013 20:57:31 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r652vfnR134962
	for <linux-pci@vger.kernel.org>; Thu, 4 Jul 2013 20:57:41 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r652verh016197
	for <linux-pci@vger.kernel.org>; Thu, 4 Jul 2013 20:57:41 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, Gavin Shan <shangw@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH 4/8] PCI/hotplug: Needn't remove EEH cache again
Date: Fri,  5 Jul 2013 10:57:30 +0800
Message-Id: <1372993054-25730-5-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372993054-25730-1-git-send-email-shangw@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Since pci_stop_and_remove_bus_device() has removed the EEH cache,
we needn't do that again.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/rpadlpar_core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index b29e20b..bb7af78 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -388,7 +388,6 @@ int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
 	/* Remove the EADS bridge device itself */
 	BUG_ON(!bus->self);
 	pr_debug("PCI: Now removing bridge device %s\n", pci_name(bus->self));
-	eeh_remove_bus_device(bus->self, true);
 	pci_stop_and_remove_bus_device(bus->self);
 
 	return 0;
-- 
1.7.5.4

