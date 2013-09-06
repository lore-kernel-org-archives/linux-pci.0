Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:42647 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065Ab3IFBqK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2013 21:46:10 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 6 Sep 2013 11:32:04 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 04C942BB0055
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2013 11:46:02 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r861joeX59703430
	for <linux-pci@vger.kernel.org>; Fri, 6 Sep 2013 11:45:50 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r861k08M013935
	for <linux-pci@vger.kernel.org>; Fri, 6 Sep 2013 11:46:00 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH 1/3] PCI: use pci_is_root_bus() to check whether it is a root bus
Date: Fri,  6 Sep 2013 09:45:56 +0800
Message-Id: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In __pci_bus_size_bridges() we check whether a pci bus is a root
bus by testing bus->self. As indicated by commit 79af72d7
("PCI: pci_is_root_bus helper"), bus->self == NULL is not a proper
way to check the pci root bus.

This patch changes it to pci_is_root_bus() to check whether it is
a root bus.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/setup-bus.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 520210f..989de3c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1134,7 +1134,7 @@ void __ref __pci_bus_size_bridges(struct pci_bus *bus,
 	}
 
 	/* The root bus? */
-	if (!bus->self)
+	if (pci_is_root_bus(bus))
 		return;
 
 	switch (bus->self->class >> 8) {
-- 
1.7.1

