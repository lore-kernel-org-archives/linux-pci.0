Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:39181 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbbKDDa5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2015 22:30:57 -0500
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 4 Nov 2015 13:30:55 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 414A72BB0054
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2015 14:30:53 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id tA43Ud6o33554438
	for <linux-pci@vger.kernel.org>; Wed, 4 Nov 2015 14:30:47 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id tA43UKgq015815
	for <linux-pci@vger.kernel.org>; Wed, 4 Nov 2015 14:30:20 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
	aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V12 2/9] PCI: Add pcibios_bus_add_device() weak function
Date: Wed,  4 Nov 2015 11:28:45 +0800
Message-Id: <1446607732-4166-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1446607732-4166-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1446607732-4166-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a weak function pcibios_bus_add_device() for arch dependent code could
do proper setup. For example, powerpc could setup EEH related resources.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index d3346d2..2b8b756 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -269,6 +269,7 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 
 void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
 
+void __weak pcibios_bus_add_device(struct pci_dev *dev) { }
 /**
  * pci_bus_add_device - start driver for a single device
  * @dev: device to add
@@ -279,6 +280,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 {
 	int retval;
 
+	pcibios_bus_add_device(dev);
+
 	/*
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
-- 
2.5.0

