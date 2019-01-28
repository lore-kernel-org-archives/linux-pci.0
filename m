Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7F9C282CF
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 18:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F1521741
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 18:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O/VHaSad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfA1SXW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:23:22 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:60124 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfA1SXV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2019 13:23:21 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 74D4624E25B3;
        Mon, 28 Jan 2019 10:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548699801; bh=OTungu4bSMQBio9y+YBLvMOL5B1r6dKIaYFPE/XM9RE=;
        h=From:To:Cc:Subject:Date:From;
        b=O/VHaSad+BpnXGF3ZZi8A7ijP/IIe/SZTxu8q0uH4ux+FzJOfWATALMj6syhfbFMc
         c12L+oeezoCM3J72VAgN2zmMtc0SSvuWVYK4E3daJaB4WB67xtKqESLhnOqGQ0fW/2
         f+aeshnYmyOdS0SObmBvEvls6Fadk2NDw86hHeok/iWCyeOiKtgl5iv1bKNAq/acbR
         Vmw6MZnLBQqOYFWkdHb1hfXeBzojwSTmh4wieM8FKcxoHjyxgUyk07H8/tHN60gMMw
         e2HWGEUgdOnsed+i7HWBQx57fjiIUxTtOqqJPvhMyqBZ0SbplvLKZrNHlpmDsU4+3b
         KqLXRsRoJBKXQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id C2A6AA006A;
        Mon, 28 Jan 2019 18:23:20 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 04F933D8E5;
        Mon, 28 Jan 2019 19:23:20 +0100 (CET)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        stable@vger.kernel.org
Subject: [PATCH] PCI: dwc: Fix stop condition on __dw_pcie_ep_find_next_cap()
Date:   Mon, 28 Jan 2019 19:22:59 +0100
Message-Id: <9780b57125c83d6742bae3405d95e6b52686c450.1548699779.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The combination of __dw_pcie_ep_find_next_cap() and
dw_pcie_ep_find_capability() allows to search on the Endpoint
configuration space for a specific capability ID.

This search is done recursively by __dw_pcie_ep_find_next_cap() jumping
from capability to capability (using the next offset register to calculate
next jump address), stopping until the next offset register is null or
the current capability meets the desired ID.

However, if the desired capability is at the end of that list, the
recursive search will be returning because the next offset will
be null (thus filling the first stop condition) and not because it
has reached the desired ID and therefore reporting capability "not
found".

This fix will swap the stop conditions order of
__dw_pcie_ep_find_next_cap(), allowing to find the desired capability ID,
if it encounters at the end of the list.

Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
Reported-by: Jian Wang <jianwang@ra.rockwell.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index a543c45..0258894 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -50,12 +50,12 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
 	next_cap_ptr = (reg & 0xff00) >> 8;
 	cap_id = (reg & 0x00ff);
 
-	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
-		return 0;
-
 	if (cap_id == cap)
 		return cap_ptr;
 
+	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
+		return 0;
+
 	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
 }
 
-- 
2.7.4

