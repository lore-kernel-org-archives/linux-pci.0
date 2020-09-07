Return-Path: <SRS0=zisR=CQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35523C433E2
	for <linux-pci@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFA3208C7
	for <linux-pci@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599501384;
	bh=1cpl4cueW3TfrufysjqTxDM1ImHIUS1uP6sSuXLgEtQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lWkoEwM/UX/6tM6sD7ULDjgJVK6Gnn/9frplY+4PQRw5OdqH9ARgXQPEvJvuGgjDJ
	 gehjWEPAP4y2rNrb9WHOFgLfwDjcA6xS1YcEpztESvIC4/WEtyh2qaYLVNkmM/+fQg
	 7j1AN6NCN7pXjChyxg9Dc7DDLa1A+k3I8dRW+uuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgIGR4V (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbgIGLUg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 07:20:36 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F060A21741;
        Mon,  7 Sep 2020 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599477062;
        bh=1cpl4cueW3TfrufysjqTxDM1ImHIUS1uP6sSuXLgEtQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Z1BnaEC8lydeTQM5858uaopUa6IIjL3A2TTUO6T5UiR/4F4KLcqh/8LztOrxNZhzv
         fh5myovJJ3f+kj5SqJfF6Ug4gILTW9I5tjxMZKHjZ3Jlo/xrK9A6YSubxx+yiAr6hM
         r7fyd6Bci/f2KSOqA0EmMf6d8oHw2J6p+YG+bBpM=
Received: by pali.im (Postfix)
        id 458E11248; Mon,  7 Sep 2020 13:11:00 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: [PATCH v3 3/5] PCI: pci-bridge-emul: Export API functions
Date:   Mon,  7 Sep 2020 13:10:36 +0200
Message-Id: <20200907111038.5811-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200907111038.5811-1-pali@kernel.org>
References: <20200907111038.5811-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It allows kernel modules which are not compiled into kernel image to use
pci-bridge-emul API functions.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/pci/pci-bridge-emul.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index ccf26d12ec61..139869d50eb2 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -294,6 +294,7 @@ int pci_bridge_emul_init(struct pci_bridge_emul *bridge,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(pci_bridge_emul_init);
 
 /*
  * Cleanup a pci_bridge_emul structure that was previously initialized
@@ -305,6 +306,7 @@ void pci_bridge_emul_cleanup(struct pci_bridge_emul *bridge)
 		kfree(bridge->pcie_cap_regs_behavior);
 	kfree(bridge->pci_regs_behavior);
 }
+EXPORT_SYMBOL_GPL(pci_bridge_emul_cleanup);
 
 /*
  * Should be called by the PCI controller driver when reading the PCI
@@ -366,6 +368,7 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL_GPL(pci_bridge_emul_conf_read);
 
 /*
  * Should be called by the PCI controller driver when writing the PCI
@@ -430,3 +433,4 @@ int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
 
 	return PCIBIOS_SUCCESSFUL;
 }
+EXPORT_SYMBOL_GPL(pci_bridge_emul_conf_write);
-- 
2.20.1

