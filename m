Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97566C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 11:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF3D20657
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 11:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="bzASLhdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfCKLwt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:52:49 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:46894 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfCKLwt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 07:52:49 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 50F9C41988;
        Mon, 11 Mar 2019 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1552305164; x=1554119565; bh=zwC+H++gkJhGxHtGDcAzM9ecIX+L1dL1E7U
        7AMtXV5Y=; b=bzASLhdll09rn0xuttoK20J8D2LQdqQqOX3gw5YyhQdizGR6qQH
        IRjNVxe04YF34PnugzGqJRLubtFrW3OaIAGKCDR+sC5tKYuNWpNylruh0+AXLXNz
        woi9opYePwE93bbW89WsoR9c1DI4VpRYCk+JvDCIfSbI8fka7H2yIdD8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NY1ERhbw9WkG; Mon, 11 Mar 2019 14:52:44 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id B0CAC419AF;
        Mon, 11 Mar 2019 14:52:41 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 11
 Mar 2019 14:52:41 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
CC:     Oliver O'Halloran <oohall@gmail.com>,
        Stewart Smith <stewart@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell Currey <ruscur@russell.cc>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v5 5/8] powerpc/pci/IOV: Add support for runtime enabling the VFs
Date:   Mon, 11 Mar 2019 14:52:30 +0300
Message-ID: <20190311115233.6514-6-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311115233.6514-1-s.miroshnichenko@yadro.com>
References: <20190311115233.6514-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When called within pcibios_sriov_enable(), the pci_sriov_get_totalvfs(pdev)
returns zero, because the device is yet preparing to enable the VFs.

With this patch it becomes possible to enable VFs via sysfs "sriov_numvfs"
on PowerNV.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |  4 +--
 arch/powerpc/kernel/pci_dn.c              | 32 ++++++++++++++---------
 arch/powerpc/platforms/powernv/pci-ioda.c |  4 +--
 arch/powerpc/platforms/pseries/pci.c      |  4 +--
 4 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index fc188e0e9179..6479bc96e0b6 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -225,8 +225,8 @@ struct pci_dn {
 extern struct pci_dn *pci_get_pdn_by_devfn(struct pci_bus *bus,
 					   int devfn);
 extern struct pci_dn *pci_get_pdn(struct pci_dev *pdev);
-extern struct pci_dn *add_dev_pci_data(struct pci_dev *pdev);
-extern void remove_dev_pci_data(struct pci_dev *pdev);
+extern struct pci_dn *pci_create_vf_pdns(struct pci_dev *pdev, int num_vfs);
+extern void pci_destroy_vf_pdns(struct pci_dev *pdev);
 extern struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 					       struct device_node *dn);
 extern void pci_remove_device_node_info(struct device_node *dn);
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 7f12882d8882..7fa362f8038d 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -222,18 +222,19 @@ static struct pci_dn *pci_create_pdn_from_dev(struct pci_dev *pdev,
 	return pdn;
 }
 
-struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
+struct pci_dn *pci_create_vf_pdns(struct pci_dev *pdev, int num_vfs)
 {
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+
 #ifdef CONFIG_PCI_IOV
-	struct pci_dn *parent, *pdn;
+	struct pci_dn *parent;
 	int i;
 
 	/* Only support IOV for now */
 	if (!pdev->is_physfn)
-		return pci_get_pdn(pdev);
+		return pdn;
 
 	/* Check if VFs have been populated */
-	pdn = pci_get_pdn(pdev);
 	if (!pdn || (pdn->flags & PCI_DN_FLAG_IOV_VF))
 		return NULL;
 
@@ -242,33 +243,38 @@ struct pci_dn *add_dev_pci_data(struct pci_dev *pdev)
 	if (!parent)
 		return NULL;
 
-	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
+	for (i = 0; i < num_vfs; i++) {
 		struct eeh_dev *edev __maybe_unused;
+		struct pci_dn *vpdn;
 
-		pdn = pci_alloc_pdn(parent,
-				    pci_iov_virtfn_bus(pdev, i),
-				    pci_iov_virtfn_devfn(pdev, i));
-		if (!pdn) {
+		vpdn = pci_alloc_pdn(parent,
+				     pci_iov_virtfn_bus(pdev, i),
+				     pci_iov_virtfn_devfn(pdev, i));
+		if (!vpdn) {
 			dev_warn(&pdev->dev, "%s: Cannot create firmware data for VF#%d\n",
 				 __func__, i);
 			return NULL;
 		}
 
-		pdn->vf_index = i;
+		vpdn->vf_index = i;
+		vpdn->vendor_id = pdn->vendor_id;
+		vpdn->device_id = pdn->device_id;
+		vpdn->class_code = pdn->class_code;
+		vpdn->pci_ext_config_space = 0;
 
 #ifdef CONFIG_EEH
 		/* Create the EEH device for the VF */
-		edev = eeh_dev_init(pdn);
+		edev = eeh_dev_init(vpdn);
 		BUG_ON(!edev);
 		edev->physfn = pdev;
 #endif /* CONFIG_EEH */
 	}
 #endif /* CONFIG_PCI_IOV */
 
-	return pci_get_pdn(pdev);
+	return pdn;
 }
 
-void remove_dev_pci_data(struct pci_dev *pdev)
+void pci_destroy_vf_pdns(struct pci_dev *pdev)
 {
 #ifdef CONFIG_PCI_IOV
 	struct pci_dn *parent;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ed500f51d449..979c901535f2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1720,14 +1720,14 @@ int pnv_pcibios_sriov_disable(struct pci_dev *pdev)
 	pnv_pci_sriov_disable(pdev);
 
 	/* Release PCI data */
-	remove_dev_pci_data(pdev);
+	pci_destroy_vf_pdns(pdev);
 	return 0;
 }
 
 int pnv_pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 {
 	/* Allocate PCI data */
-	add_dev_pci_data(pdev);
+	pci_create_vf_pdns(pdev, num_vfs);
 
 	return pnv_pci_sriov_enable(pdev, num_vfs);
 }
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 37a77e57893e..5e87596903a6 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -205,7 +205,7 @@ int pseries_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 int pseries_pcibios_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 {
 	/* Allocate PCI data */
-	add_dev_pci_data(pdev);
+	pci_create_vf_pdns(pdev, num_vfs);
 	return pseries_pci_sriov_enable(pdev, num_vfs);
 }
 
@@ -217,7 +217,7 @@ int pseries_pcibios_sriov_disable(struct pci_dev *pdev)
 	/* Releasing pe_num_map */
 	kfree(pdn->pe_num_map);
 	/* Release PCI data */
-	remove_dev_pci_data(pdev);
+	pci_destroy_vf_pdns(pdev);
 	pci_vf_drivers_autoprobe(pdev, true);
 	return 0;
 }
-- 
2.20.1

