Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F1C636C8
	for <linux-pci@archiver.kernel.org>; Mon, 19 Jul 2021 02:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1EA761019
	for <linux-pci@archiver.kernel.org>; Mon, 19 Jul 2021 02:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbhGSCrb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 18 Jul 2021 22:47:31 -0400
Received: from mx.socionext.com ([202.248.49.38]:17409 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233720AbhGSCrb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Jul 2021 22:47:31 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 19 Jul 2021 11:44:31 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id B6ED1205902A;
        Mon, 19 Jul 2021 11:44:31 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 19 Jul 2021 11:44:31 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 7A9E9B631E;
        Mon, 19 Jul 2021 11:44:31 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] PCI: endpoint: Use sysfs_emit() in "show" functions
Date:   Mon, 19 Jul 2021 11:44:26 +0900
Message-Id: <1626662666-15798-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert sprintf() in sysfs "show" functions to sysfs_emit() in order to
check for buffer overruns in sysfs outputs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c |  4 ++--
 drivers/pci/endpoint/pci-ep-cfs.c            | 13 ++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index bce274d..f5dfc63 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -1918,7 +1918,7 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
 									\
-	return sprintf(page, "%d\n", ntb->_name);			\
+	return sysfs_emit(page, "%d\n", ntb->_name);			\
 }
 
 #define EPF_NTB_W(_name)						\
@@ -1949,7 +1949,7 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 									\
 	sscanf(#_name, "mw%d", &win_no);				\
 									\
-	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
+	return sysfs_emit(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
 }
 
 #define EPF_NTB_MW_W(_name)						\
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index f3a8b83..b40a42f 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -198,8 +198,7 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
 
 static ssize_t pci_epc_start_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%d\n",
-		       to_pci_epc_group(item)->start);
+	return sysfs_emit(page, "%d\n", to_pci_epc_group(item)->start);
 }
 
 CONFIGFS_ATTR(pci_epc_, start);
@@ -321,7 +320,7 @@ static ssize_t pci_epf_##_name##_show(struct config_item *item,	char *page)    \
 	struct pci_epf *epf = to_pci_epf_group(item)->epf;		       \
 	if (WARN_ON_ONCE(!epf->header))					       \
 		return -EINVAL;						       \
-	return sprintf(page, "0x%04x\n", epf->header->_name);		       \
+	return sysfs_emit(page, "0x%04x\n", epf->header->_name);	       \
 }
 
 #define PCI_EPF_HEADER_W_u32(_name)					       \
@@ -390,8 +389,8 @@ static ssize_t pci_epf_msi_interrupts_store(struct config_item *item,
 static ssize_t pci_epf_msi_interrupts_show(struct config_item *item,
 					   char *page)
 {
-	return sprintf(page, "%d\n",
-		       to_pci_epf_group(item)->epf->msi_interrupts);
+	return sysfs_emit(page, "%d\n",
+			  to_pci_epf_group(item)->epf->msi_interrupts);
 }
 
 static ssize_t pci_epf_msix_interrupts_store(struct config_item *item,
@@ -412,8 +411,8 @@ static ssize_t pci_epf_msix_interrupts_store(struct config_item *item,
 static ssize_t pci_epf_msix_interrupts_show(struct config_item *item,
 					    char *page)
 {
-	return sprintf(page, "%d\n",
-		       to_pci_epf_group(item)->epf->msix_interrupts);
+	return sysfs_emit(page, "%d\n",
+			  to_pci_epf_group(item)->epf->msix_interrupts);
 }
 
 PCI_EPF_HEADER_R(vendorid)
-- 
2.7.4

