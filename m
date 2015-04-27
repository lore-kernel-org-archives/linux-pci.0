Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:54661 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbbD0GjW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2015 02:39:22 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Mon, 27 Apr 2015 16:39:20 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp03.au.ibm.com (Postfix) with ESMTP id 56F0E3578056
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:39:18 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t3R6dAoa11403364
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:39:18 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t3R6ch8O009479
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2015 16:38:44 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org,
	bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v3 09/21] powerpc/eeh: Delay probing EEH device during hotplug
Date: Mon, 27 Apr 2015 16:37:41 +1000
Message-Id: <1430116673-22500-10-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1430116673-22500-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 1c509148b ("powerpc/eeh: Do probe on pci_dn") probes EEH
devices in early stage, which is reasonable to pSeries platform.
However, it's wrong for PowerNV platform because the PE# isn't
determined until the resources (IO and MMIO) are assigned to
PE. So we have to delay probing EEH devices for PowerNV platform
until that point.

Fixes: 1c509148b ("powerpc/eeh: Do probe on pci_dn")
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index c63d1eb..b5847dc 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1056,6 +1056,9 @@ void eeh_add_device_early(struct pci_dn *pdn)
 	if (!edev || !eeh_enabled())
 		return;
 
+	if (!eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
+		return;
+
 	/* USB Bus children of PCI devices will not have BUID's */
 	phb = edev->phb;
 	if (NULL == phb ||
@@ -1105,6 +1108,10 @@ void eeh_add_device_late(struct pci_dev *dev)
 
 	pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
 	edev = pdn_to_eeh_dev(pdn);
+	if (eeh_has_flag(EEH_PROBE_MODE_DEV))
+		eeh_ops->probe(pdn, NULL);
+
+	/* Check if PCI device and EEH device has been bound */
 	if (edev->pdev == dev) {
 		pr_debug("EEH: Already referenced !\n");
 		return;
-- 
2.1.0

