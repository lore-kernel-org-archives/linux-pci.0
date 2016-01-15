Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:59515 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbcAOHJN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2016 02:09:13 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <xyjxie@linux.vnet.ibm.com>;
	Fri, 15 Jan 2016 17:09:11 +1000
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
	alex.williamson@redhat.com, benh@kernel.crashing.org,
	paulus@samba.org, mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
	zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
	Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 4/5] powerpc/powernv/pci-ioda: Enable msi_filtered bit for any IODA host bridge
Date: Fri, 15 Jan 2016 15:06:13 +0800
Message-Id: <1452841574-2781-5-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch enables msi_filtered bit for any IODA host bridge.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 414fd1a..689f0dc 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2934,6 +2934,11 @@ static void pnv_pci_ioda_fixup(void)
 #endif
 }
 
+static void pnv_pci_ioda_fixup_phb(struct pci_controller *hose)
+{
+	to_pci_host_bridge(hose->bus->bridge)->msi_filtered = 1;
+}
+
 /*
  * Returns the alignment for I/O or memory windows for P2P
  * bridges. That actually depends on how PEs are segmented.
@@ -3201,6 +3206,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 * the child P2P bridges) can form individual PE.
 	 */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
+	ppc_md.pcibios_fixup_phb = pnv_pci_ioda_fixup_phb;
 	hose->controller_ops = pnv_pci_ioda_controller_ops;
 
 #ifdef CONFIG_PCI_IOV
-- 
1.7.9.5

