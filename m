Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28121C10F05
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 09:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A8E21738
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 09:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfCQJe4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Mar 2019 05:34:56 -0400
Received: from sauhun.de ([88.99.104.3]:52538 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfCQJe4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 17 Mar 2019 05:34:56 -0400
Received: from localhost (ip-109-41-130-14.web.vodafone.de [109.41.130.14])
        by pokefinder.org (Postfix) with ESMTPSA id 62E752C27DA;
        Sun, 17 Mar 2019 10:34:53 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] PCI: rcar: don't shadow the 'irq' variable
Date:   Sun, 17 Mar 2019 10:34:45 +0100
Message-Id: <20190317093445.7746-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

sparse rightfully says:
drivers/pci/controller/pcie-rcar.c:741:30: warning: symbol 'irq' shadows an earlier one

It doesn't affect the current code. But fix it now to avoid future
surprises and for good coding style.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested.

 drivers/pci/controller/pcie-rcar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 7002e9ad0b81..f513058e3a70 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -738,15 +738,15 @@ static irqreturn_t rcar_pcie_msi_irq(int irq, void *data)
 
 	while (reg) {
 		unsigned int index = find_first_bit(&reg, 32);
-		unsigned int irq;
+		unsigned int msi_irq;
 
 		/* clear the interrupt */
 		rcar_pci_write_reg(pcie, 1 << index, PCIEMSIFR);
 
-		irq = irq_find_mapping(msi->domain, index);
-		if (irq) {
+		msi_irq = irq_find_mapping(msi->domain, index);
+		if (msi_irq) {
 			if (test_bit(index, msi->used))
-				generic_handle_irq(irq);
+				generic_handle_irq(msi_irq);
 			else
 				dev_info(dev, "unhandled MSI\n");
 		} else {
-- 
2.19.1

