Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0E9C43387
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 16:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071032070D
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 16:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544805221;
	bh=Bs2xI0cuLFCzGAKEs9CWjrvwd+ItlwUs4IvLfjseGHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jZ6q1G+syVmslQ4baLuczVC8MXMY0QMigqX8OwAbXCHFxA0ly/X4ggVZibi+suU7E
	 smCwY0Vw1e9aFUO1JMqCPGgJoB6wbo9fenqI5UgcUumfUa6uMoEzjGFxTw3Eg6N5tB
	 FXLEI/1uoC3vzRbqgw8z5Y1R6B6Ir9VxDV5thJlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbeLNQde (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:33:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730145AbeLNQdc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Dec 2018 11:33:32 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.30.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFF702075B;
        Fri, 14 Dec 2018 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544805212;
        bh=Bs2xI0cuLFCzGAKEs9CWjrvwd+ItlwUs4IvLfjseGHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXKPs1OJvnjBRCubA+PDaiFRJMeGL5vNJSgUQZNL3Pyy2xtnILby9JuggUX+aROA6
         QsFF4jYYBhn4zCG7/blAL1OOdYRXCk+ePoZQpIa/Y7t06GlZflWT3mB572cJXZPzkn
         dyj94DdLha9JrUbBvsu+KT0My2cLaWP5Ft2g2sTU=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 6/6] PCI: Stub out pci_request_acs() when CONFIG_PCI is not set
Date:   Fri, 14 Dec 2018 16:33:19 +0000
Message-Id: <20181214163319.27479-7-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181214163319.27479-1-okaya@kernel.org>
References: <20181214163319.27479-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ACPI IORT table code relies on pci_request_acs() to be present. Define
a stub function when CONFI_PCI is not set.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 include/linux/pci.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 51a5a5217667..f0f2f55ea93c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2101,7 +2101,11 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 	return NULL;
 }
 
+#ifdef CONFIG_PCI
 void pci_request_acs(void);
+#else
+static inline void pci_request_acs(void) {}
+#endif
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
 			  struct pci_dev *end, u16 acs_flags);
-- 
2.19.0

