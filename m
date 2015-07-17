Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:36124 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756712AbbGQGDI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jul 2015 02:03:08 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Fri, 17 Jul 2015 11:33:05 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id A20E6E006A
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 11:36:58 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t6H62wYq37355748
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 11:32:59 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t6H4m3XX002825
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2015 10:18:04 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V9 02/11] PCI: Add pcibios_bus_add_device() weak function
Date: Fri, 17 Jul 2015 14:02:32 +0800
Message-Id: <1437112961-17275-3-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds a weak function pcibios_bus_add_device() for arch dependent
code could do proper setup. For example, powerpc could setup EEH related
resources.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/bus.c |    3 +++
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
1.7.9.5

