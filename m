Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98428C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B88920855
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 19:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mdtRCxTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfDDTzK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:55:10 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16742 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfDDTzK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Apr 2019 15:55:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca6611b0000>; Thu, 04 Apr 2019 12:55:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 12:55:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 12:55:09 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Apr
 2019 19:55:09 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 4 Apr 2019 19:55:09 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca661170004>; Thu, 04 Apr 2019 12:55:08 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <lorenzo.pieralisi@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <mperttunen@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 02/16] PCI/PME: Export pcie_pme_disable_msi() API
Date:   Fri, 5 Apr 2019 01:24:29 +0530
Message-ID: <1554407683-31580-3-git-send-email-vidyas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554407707; bh=fOKk8kJSCrRDxiOD359Z/xQgEQbTlTPNQvE7TeJz3Ms=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=mdtRCxTzSatNR3AAda7RvxK62GaJ+cHZeS41svjZyPYA8z+csmFI7oid4romu4aj3
         FMWukSOHVwXXMQlpzNmXBv3B9DupaDRRktO+J8vfnZyVdJrrdh9xXK3JlKC2JNDxyO
         v8Z52hG+dGYg2kQHJQfE4zCwvOoIMQm8tTlOPbvuLkq1EHChEmqUBrIUhBtXB52V+m
         NCm5YIDDVliL8OR8hBhhM5OVZt5OVzmgPC8w9XaBgHqESeU/tJRHu3xTXt+KXkcwDV
         ggFlt/wX9oT1oTgTvCc1NSoYXnjK7wy/CJtIzRVe1j9yZTiRXGMWrFaP7xZC34w1xI
         VoBsQfC6X+aGQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Export pcie_pme_disable_msi() API to enable drivers using this API be able to
build as loadable modules

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes from [v1]:
* This is a new patch in v2 series

 drivers/pci/pcie/pme.c     | 6 ++++++
 drivers/pci/pcie/portdrv.h | 5 +----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 54d593d10396..18e815c1e3c9 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -27,6 +27,12 @@
  */
 bool pcie_pme_msi_disabled;
 
+void pcie_pme_disable_msi(void)
+{
+	pcie_pme_msi_disabled = true;
+}
+EXPORT_SYMBOL_GPL(pcie_pme_disable_msi);
+
 static int __init pcie_pme_setup(char *str)
 {
 	if (!strncmp(str, "nomsi", 5))
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 1d50dc58ac40..2be7b7e9a784 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -127,10 +127,7 @@ struct pci_dev;
 #ifdef CONFIG_PCIE_PME
 extern bool pcie_pme_msi_disabled;
 
-static inline void pcie_pme_disable_msi(void)
-{
-	pcie_pme_msi_disabled = true;
-}
+void pcie_pme_disable_msi(void);
 
 static inline bool pcie_pme_no_msi(void)
 {
-- 
2.7.4

