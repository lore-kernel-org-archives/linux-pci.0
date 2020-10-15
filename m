Return-Path: <SRS0=n3kO=DW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FE9C433E7
	for <linux-pci@archiver.kernel.org>; Thu, 15 Oct 2020 19:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9274E2072D
	for <linux-pci@archiver.kernel.org>; Thu, 15 Oct 2020 19:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602790251;
	bh=AAl1svi5X5RLBT8xujD80/Js1bxdtUHZvExslzti8zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X/HVd0i2x4e9kf8KzGfBLvxSDrkMFSp4veN8yZgOdBknx4oQ1p5YICx+f70bnl9UJ
	 GtX8Fb4fxx0jlQk7jNd/ry9WV7vjINsbnBtPRbIITnqBRr41F+VSEyru0hr7YUBiNJ
	 b22JXWC+GLR3FAnhhRMx6sU9bfIch0MYYiLD0u1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391577AbgJOTau (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391610AbgJOTau (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:30:50 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EE93206DD;
        Thu, 15 Oct 2020 19:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602790249;
        bh=AAl1svi5X5RLBT8xujD80/Js1bxdtUHZvExslzti8zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ajk+KNbdq6idjSsqV1OgLcwI38QG3sm1KD0LwRBmF4zWy88CiM4ar65FafxUsRhH/
         Y4P9NWHnwIwhK7OYjGzk4gvM2c0m5cqYb/xEynh0RaoQ/2kCp9huhdpCRsu0p/bULs
         N3n9zOMY8lNrSEhW88TEWj51KbFjpzbmtFRzkQnY=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 01/12] PCI/ASPM: Move pci_clear_and_set_dword() earlier
Date:   Thu, 15 Oct 2020 14:30:28 -0500
Message-Id: <20201015193039.12585-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015193039.12585-1-helgaas@kernel.org>
References: <20201015193039.12585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Move pci_clear_and_set_dword() earlier in file to prepare for future patch.
No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aspm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 253c30cc1967..237a423e53ae 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -493,6 +493,17 @@ static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
 	return NULL;
 }
 
+static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
+				    u32 clear, u32 set)
+{
+	u32 val;
+
+	pci_read_config_dword(pdev, pos, &val);
+	val &= ~clear;
+	val |= set;
+	pci_write_config_dword(pdev, pos, val);
+}
+
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				struct aspm_register_info *upreg,
@@ -651,17 +662,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 	}
 }
 
-static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
-				    u32 clear, u32 set)
-{
-	u32 val;
-
-	pci_read_config_dword(pdev, pos, &val);
-	val &= ~clear;
-	val |= set;
-	pci_write_config_dword(pdev, pos, val);
-}
-
 /* Configure the ASPM L1 substates */
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
-- 
2.25.1

