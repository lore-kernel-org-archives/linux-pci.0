Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:32842 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbJZDRv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 25 Oct 2015 23:17:51 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 26 Oct 2015 08:47:49 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7CD6B3940019
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2015 08:47:46 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t9Q3Hjqo49873012
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2015 08:47:45 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t9Q3Higc010762
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2015 08:47:45 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au,
	aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V10 02/12] PCI: Add pcibios_bus_add_device() weak function
Date: Mon, 26 Oct 2015 11:15:52 +0800
Message-Id: <1445829362-2738-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a weak function pcibios_bus_add_device() for arch dependent
code could do proper setup. For example, powerpc could setup EEH related
resources.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 6fbd3f2..b7e30a7 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -267,6 +267,7 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
 
 void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
 
+void __weak pcibios_bus_add_device(struct pci_dev *dev) { }
 /**
  * pci_bus_add_device - start driver for a single device
  * @dev: device to add
@@ -277,6 +278,8 @@ void pci_bus_add_device(struct pci_dev *dev)
 {
 	int retval;
 
+	pcibios_bus_add_device(dev);
+
 	/*
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
-- 
2.5.0

