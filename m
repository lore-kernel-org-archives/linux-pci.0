Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58A7C43333
	for <linux-pci@archiver.kernel.org>; Mon,  4 Jan 2021 23:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0C52253D
	for <linux-pci@archiver.kernel.org>; Mon,  4 Jan 2021 23:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbhADXDv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:03:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbhADXDt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 18:03:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4432B2256F;
        Mon,  4 Jan 2021 23:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609801388;
        bh=9moplLCuNdRgj7FDWgkL0dHt82jL3U/8g1Dx74XzJxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9A3bkfjGS7zTx6wvTgq343bVxrJvSE3QwgkloVoG0j1GAxHzLLTCnij3KR7AtNMw
         q1vHgaPbDuYpr0HYjxpZtj5fufb3LqxaGiAsPI9KmQJoWLmiZ33+IwWSTHFVnmJ3AC
         rQsC46kji8bakUWUAQ11xvOt+CroKYDlgIe4sU4bEk42lYBtgx0cjggrp6SBDsa1SK
         OG3+d51BQCVqkMGaLrkt+GLIsPibOwqanRdJoJdxtc/DtE3CISbzgaS6rDs0Ayo2Sl
         Ce/o7FsFKuMrx2UI0f02hYESUpUe7z3gfWaJUfLOYPbuRvo53mFALI9Ppxo2pk4EyK
         BObHi61xXldQQ==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/5] PCI/AER: Specify the type of port that was reset
Date:   Mon,  4 Jan 2021 15:02:59 -0800
Message-Id: <20210104230300.1277180-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210104230300.1277180-1-kbusch@kernel.org>
References: <20210104230300.1277180-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The AER driver may be called upon to reset either a downstream or a root
port. Check which type it is to properly identify it when logging that
the reset occured.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3fd4aaaa627e..ba22388342d1 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1414,7 +1414,8 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 		}
 	} else {
 		rc = pci_bus_error_reset(dev);
-		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
+		pci_info(dev, "%s Port link has been reset (%d)\n",
+			pci_is_root_bus(dev->bus) ? "Root" : "Downstream", rc);
 	}
 
 	if ((host->native_aer || pcie_ports_native) && aer) {
-- 
2.24.1

