Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:47920 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab3DVGOZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 02:14:25 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <qiudayu@linux.vnet.ibm.com>;
	Mon, 22 Apr 2013 11:40:50 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 570F81258023
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 11:45:51 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r3M6E94w2556250
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 11:44:10 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id r3M6EEjq032394
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 16:14:15 +1000
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Cc: benh@kernel.crashing.org, tglx@linutronix.de,
	Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: [PATCH] PowerNV/PCI: Fix NULL PCI controller
Date: Mon, 22 Apr 2013 02:13:56 -0400
Message-Id: <1366611236-1811-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

In pnv_pci_read_config() or pnv_pci_write_config(), we never check if
the PCI controller is valid before converting that into platform
dependent one, this is very dangerous. 

To avoid this potential risks, the patch check PCI controller first
before use it.

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b8b8e0b..e7b7f1a 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -286,11 +286,11 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 			       int where, int size, u32 *val)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
-	struct pnv_phb *phb = hose->private_data;
+	struct pnv_phb *phb = hose ? hose->private_data : NULL;
 	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
 	s64 rc;
 
-	if (hose == NULL)
+	if (!phb)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	switch (size) {
@@ -330,10 +330,10 @@ static int pnv_pci_write_config(struct pci_bus *bus,
 				int where, int size, u32 val)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
-	struct pnv_phb *phb = hose->private_data;
+	struct pnv_phb *phb = hose ? hose->private_data : NULL;
 	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
 
-	if (hose == NULL)
+	if (!phb)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	cfg_dbg("pnv_pci_write_config bus: %x devfn: %x +%x/%x -> %08x\n",
-- 
1.7.10.1

