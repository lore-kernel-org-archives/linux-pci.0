Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752519AbeCNQfh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 12:35:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2EGYwlJ079214
        for <linux-pci@vger.kernel.org>; Wed, 14 Mar 2018 12:35:37 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gq515ff61-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 14 Mar 2018 12:35:37 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <desnesn@linux.vnet.ibm.com>;
        Wed, 14 Mar 2018 10:35:36 -0600
From: "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, ruscur@russell.cc, aik@ozlabs.ru,
        david@gibson.dropbear.id.au, fbarrat@linux.vnet.ibm.com,
        brking@linux.vnet.ibm.com
Subject: [PATCH 2/2, powerpc/powernv] powerpc/powernv: Tweak PCI_DEV_FLAGS_QUIET_PCI_REALIGN on/off during boot
Date: Wed, 14 Mar 2018 13:34:55 -0300
In-Reply-To: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
References: <20180314163455.15854-1-desnesn@linux.vnet.ibm.com>
Message-Id: <20180314163455.15854-3-desnesn@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Turn on PCI_DEV_FLAGS_QUIET_PCI_REALIGN flag on powernv's pci driver
to silent PCI realignment messages through a early stage hook, and turn
it off right before the pci device is enabled with a final stage hook.

Fixes: 38274637699 ("powerpc/powernv: Override pcibios_default_alignment() to force PCI devices to be page aligned")
Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 69d102cbf48f..d28ce0899487 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -1108,6 +1108,20 @@ static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
 
+/* Fixup that disables PCI realignment menssages for all PCI devices */
+static void disable_realign_menssages(struct pci_dev *dev)
+{
+	dev->dev_flags |= PCI_DEV_FLAGS_QUIET_PCI_REALIGN;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, disable_realign_menssages);
+
+/* Fixup that enables PCI realignment messages for all PCI devices */
+static void enable_realign_menssages(struct pci_dev *dev)
+{
+	dev->dev_flags ^= PCI_DEV_FLAGS_QUIET_PCI_REALIGN;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, enable_realign_menssages);
+
 void __init pnv_pci_init(void)
 {
 	struct device_node *np;
-- 
2.14.3
