Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EB5C2BB9A
	for <linux-pci@archiver.kernel.org>; Thu, 17 Dec 2020 17:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C97223998
	for <linux-pci@archiver.kernel.org>; Thu, 17 Dec 2020 17:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgLQRPO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Dec 2020 12:15:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbgLQRPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Dec 2020 12:15:13 -0500
From:   Keith Busch <kbusch@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/3] PCI/AER: Actually get the root port
Date:   Thu, 17 Dec 2020 09:14:30 -0800
Message-Id: <20201217171431.502030-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201217171431.502030-1-kbusch@kernel.org>
References: <20201217171431.502030-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci_dev parameter given to aer_root_reset() may be a downstream port
rather than the root port. Get the root port from the provided device in
order to clear the root's aer status, and update the message to indicate
which type of port was actually reset.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pcie/aer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 77b0f2c45bc0..b2b0e9eb5cfb 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1388,7 +1388,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	if (type == PCI_EXP_TYPE_RC_END)
 		root = dev->rcec;
 	else
-		root = dev;
+		root = pcie_find_root_port(dev);
 
 	/*
 	 * If the platform retained control of AER, an RCiEP may not have
@@ -1414,7 +1414,8 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 		}
 	} else {
 		rc = pci_bus_error_reset(dev);
-		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
+		pci_info(dev, "%s Port link has been reset (%d)\n", rc,
+			pci_is_root_bus(dev->bus) ? "Root" : "Downstream");
 	}
 
 	if ((host->native_aer || pcie_ports_native) && aer) {
-- 
2.24.1

