Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1404C4360F
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CFC2175B
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 15:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDEPWS (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:22:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDEPWR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 11:22:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C94F16A3;
        Fri,  5 Apr 2019 08:22:17 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.44])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EEAC3F68F;
        Fri,  5 Apr 2019 08:22:16 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller
Date:   Fri,  5 Apr 2019 16:20:47 +0100
Message-Id: <20190405152047.153417-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is a Marvell 88SE9170 PCIe SATA controller I found on a board
here. Some quick testing with the ARM SMMU enabled reveals that it
suffers from the same requester ID mixup problems as the other Marvell
chips listed already.

Add the PCI vendor/device ID to the list of chips which need the
workaround.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a59ad09ce911..a077f67fe1da 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3877,6 +3877,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9128,
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9130,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9170,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c47 + c57 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9172,
 			 quirk_dma_func1_alias);
-- 
2.17.1

