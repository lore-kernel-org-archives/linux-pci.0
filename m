Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4478C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AADE20820
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbfDJVFf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:05:35 -0400
Received: from ale.deltatee.com ([207.54.116.67]:49422 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbfDJVFf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 17:05:35 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hEKPV-0000k0-TT; Wed, 10 Apr 2019 15:05:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hEKPV-0001By-D9; Wed, 10 Apr 2019 15:05:33 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 10 Apr 2019 15:05:31 -0600
Message-Id: <20190410210532.4538-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410210532.4538-1-logang@deltatee.com>
References: <20190410210532.4538-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 1/2] PCI: Fix issue with "pci=disable_acs_redir" parameter being ignored
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In most cases, kmalloc will not be available early in boot when
pci_setup() is called. Thus, the kstrdup call that was added to fix the
__initdata bug with the disable_acs_redir parameter usually returns
NULL. Thus the parameter is discarded and it does not take into effect.

To fix this, we store the string that's in initdata until a initcall
function can allocate the memory appropriately. This way we
don't need any additional static memory.

Fixes: d2fd6e81912a ("PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c1b362f599a..766f5779db92 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6262,8 +6262,7 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
-				disable_acs_redir_param =
-					kstrdup(str + 18, GFP_KERNEL);
+				disable_acs_redir_param = str + 18;
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
@@ -6274,3 +6273,19 @@ static int __init pci_setup(char *str)
 	return 0;
 }
 early_param("pci", pci_setup);
+
+/*
+ * 'disable_acs_redir_param' is initialized in pci_setup(), above, to point
+ * to data in the __initdata section which will be freed after the init
+ * sequence is complete. We can't allocate memory in pci_setup() because some
+ * architectures do not have any memory allocation service available during
+ * an early_param() call. So we allocate memory and copy the variable here
+ * before the init section is freed.
+ */
+static int __init pci_realloc_setup_params(void)
+{
+	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
+
+	return 0;
+}
+pure_initcall(pci_realloc_setup_params);
-- 
2.20.1

