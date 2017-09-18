Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750868AbdIRT1a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2017 15:27:30 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8IJOT1u074173
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2017 15:27:30 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d2hacjph9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2017 15:27:29 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <bryantly@linux.vnet.ibm.com>;
        Mon, 18 Sep 2017 15:27:28 -0400
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        "Juan J . Alvarez" <jjalvare@us.ibm.com>
Subject: [PATCH v1 2/3] pseries: Override pci_bus_match_virtfn_driver
Date: Mon, 18 Sep 2017 14:26:50 -0500
In-Reply-To: <20170918192651.78404-1-bryantly@linux.vnet.ibm.com>
References: <20170918192651.78404-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20170918192651.78404-3-bryantly@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For Powervm SR-IOV (Pseries) enablement we dont want to match
the virtual function's device drivers since firmware
plans to load the device node in the device tree
dynamically when Novalink assigns the VF to a partition.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@us.ibm.com>
---
 arch/powerpc/platforms/pseries/pci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 09eba5a9929a..15d5145a622d 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -58,6 +58,23 @@ void pcibios_name_device(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_name_device);
 #endif
 
+#ifdef CONFIG_PCI_IOV
+void pci_bus_match_virtfn_driver(struct pci_dev *dev)
+{
+	/*
+	 * Per PSeries SR-IOV requirement there is no need to
+	 * match virtual function device driver as firmware
+	 * will load the device node in the device tree dynamically.
+	 * Since there is no matching of device driver there is
+	 * no failure when attaching driver, therefore there is no
+	 * need to remove sysfs file. Furthermore, the VF platform
+	 * management still needs to exist in sysfs files to be used
+	 * by management.
+	 */
+	dev->is_added = 1;
+}
+#endif
+
 static void __init pSeries_request_regions(void)
 {
 	if (!isa_io_base)
-- 
2.11.0 (Apple Git-81)
