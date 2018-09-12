Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45384 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbeILRij (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Sep 2018 13:38:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CCU0Ox141822
        for <linux-pci@vger.kernel.org>; Wed, 12 Sep 2018 08:34:20 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mf1jmm23k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 12 Sep 2018 08:34:19 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <sebott@linux.ibm.com>;
        Wed, 12 Sep 2018 13:34:17 +0100
From: Sebastian Ott <sebott@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 2/2] s390/pci: handle function enumeration after sriov enablement
Date: Wed, 12 Sep 2018 14:34:11 +0200
In-Reply-To: <20180912123411.23229-1-sebott@linux.ibm.com>
References: <20180912123411.23229-1-sebott@linux.ibm.com>
Message-Id: <20180912123411.23229-3-sebott@linux.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Implement pcibios_sriov_{add|del}_vfs as empty functions. VF
creation will be triggered by the hotplug code.

Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
---
 arch/s390/pci/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 9f6f392a4461..b5f8db652bf5 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -731,6 +731,17 @@ struct dev_pm_ops pcibios_pm_ops = {
 };
 #endif /* CONFIG_HIBERNATE_CALLBACKS */
 
+#ifdef CONFIG_PCI_IOV
+int pcibios_sriov_add_vfs(struct pci_dev *pdev, u16 num_vfs)
+{
+	return 0;
+}
+
+void pcibios_sriov_del_vfs(struct pci_dev *pdev)
+{
+}
+#endif
+
 static int zpci_alloc_domain(struct zpci_dev *zdev)
 {
 	if (zpci_unique_uid) {
-- 
2.13.4
