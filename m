Return-Path: <SRS0=PTHP=RO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A641C43381
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 11:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C9220857
	for <linux-pci@archiver.kernel.org>; Mon, 11 Mar 2019 11:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="geLIyNtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfCKLwr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:52:47 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:46882 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfCKLwq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Mar 2019 07:52:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C9F9B41980;
        Mon, 11 Mar 2019 11:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1552305163; x=1554119564; bh=ZrIst2xnQ7ULBorrlRMljb8s29GRLVn+0Wx
        Dv3ZOO3Y=; b=geLIyNtgbuskm0bE0YS2AZhKBrsA5I5SjaVaDNUCTSYTF3RkZFm
        EwA7xUqUgC8LUquUUmUocFdnLPtzg5V6gq/rTOOtl6QT+9HNI9JTSI9bPPmOh7JG
        StEniTbwaquOuRIHqQAYShBwQsgcsL9Li/Q9p24ZWMDrQpLpyDPsnK4E=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JafX-PpWKQJt; Mon, 11 Mar 2019 14:52:43 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id AA39A41988;
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
Subject: [PATCH v5 4/8] powerpc/pci: Reduce code duplication in pci_add_device_node_info
Date:   Mon, 11 Mar 2019 14:52:29 +0300
Message-ID: <20190311115233.6514-5-s.miroshnichenko@yadro.com>
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

It is possible now to allocate and fill a new pdn with add_one_dev_pci_data

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/kernel/pci_dn.c | 38 +++++++++++++++---------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index b594b055b2cf..7f12882d8882 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -159,22 +159,20 @@ static struct pci_dn *pci_alloc_pdn(struct pci_dn *parent,
 {
 	struct pci_dn *pdn;
 
-	/* Except PHB, we always have the parent */
-	if (!parent)
-		return NULL;
-
 	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
 	if (!pdn)
 		return NULL;
 
-	pdn->phb = parent->phb;
 	pdn->parent = parent;
 	pdn->busno = busno;
 	pdn->devfn = devfn;
 	pdn->pe_number = IODA_INVALID_PE;
 	INIT_LIST_HEAD(&pdn->child_list);
 	INIT_LIST_HEAD(&pdn->list);
-	list_add_tail(&pdn->list, &parent->child_list);
+	if (parent) {
+		pdn->phb = parent->phb;
+		list_add_tail(&pdn->list, &parent->child_list);
+	}
 
 	return pdn;
 }
@@ -341,25 +339,29 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 	const __be32 *regs;
 	struct device_node *parent;
 	struct pci_dn *pdn;
+	int busno = 0, devfn = 0;
 #ifdef CONFIG_EEH
 	struct eeh_dev *edev;
 #endif
 
-	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
-	if (pdn == NULL)
-		return NULL;
-	dn->data = pdn;
-	pdn->phb = hose;
-	pdn->pe_number = IODA_INVALID_PE;
 	regs = of_get_property(dn, "reg", NULL);
 	if (regs) {
 		u32 addr = of_read_number(regs, 1);
 
 		/* First register entry is addr (00BBSS00)  */
-		pdn->busno = (addr >> 16) & 0xff;
-		pdn->devfn = (addr >> 8) & 0xff;
+		busno = (addr >> 16) & 0xff;
+		devfn = (addr >> 8) & 0xff;
 	}
 
+	parent = of_get_parent(dn);
+	pdn = pci_alloc_pdn(parent ? PCI_DN(parent) : NULL,
+			    busno, devfn);
+	if (!pdn)
+		return NULL;
+
+	dn->data = pdn;
+	pdn->phb = hose;
+
 	/* vendor/device IDs and class code */
 	regs = of_get_property(dn, "vendor-id", NULL);
 	pdn->vendor_id = regs ? of_read_number(regs, 1) : 0;
@@ -380,14 +382,6 @@ struct pci_dn *pci_add_device_node_info(struct pci_controller *hose,
 	}
 #endif
 
-	/* Attach to parent node */
-	INIT_LIST_HEAD(&pdn->child_list);
-	INIT_LIST_HEAD(&pdn->list);
-	parent = of_get_parent(dn);
-	pdn->parent = parent ? PCI_DN(parent) : NULL;
-	if (pdn->parent)
-		list_add_tail(&pdn->list, &pdn->parent->child_list);
-
 	return pdn;
 }
 EXPORT_SYMBOL_GPL(pci_add_device_node_info);
-- 
2.20.1

