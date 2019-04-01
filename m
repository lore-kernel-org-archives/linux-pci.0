Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019D2C43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 19:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CE420896
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 19:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfDATdT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 15:33:19 -0400
Received: from ale.deltatee.com ([207.54.116.67]:45386 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfDATdT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Apr 2019 15:33:19 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hB2gH-00005u-Iu; Mon, 01 Apr 2019 13:33:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hB2gG-0003LN-Qq; Mon, 01 Apr 2019 13:33:16 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andrew Maier <andrew.maier@eideticom.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon,  1 Apr 2019 13:33:02 -0600
Message-Id: <20190401193302.12813-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com, andrew.maier@eideticom.com, bhelgaas@google.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] PCI: Fix issue with "pci=disable_acs_redir" parameter being ignored
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

To fix this we have to do what we originally did with the
resource_alignment parameter: allocate a static buffer and copy the
string from the command line to it.

Fixes: d2fd6e81912a ("PCI: Fix __initdata issue with "pci=disable_acs_redir" parameter")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Andrew Maier <andrew.maier@eideticom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---

Sorry, it seems I didn't test the previous patch in this area properly
and I actually made disable_acs_redir ineffective in most cases.

This change should fix it and I got a colleague to test it fully
on his system as well.

drivers/pci/pci.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c1b362f599a..537395dfd0df 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3125,7 +3125,17 @@ void pci_request_acs(void)
 	pci_acs_enable = 1;
 }

-static const char *disable_acs_redir_param;
+static char disable_acs_redir_param[COMMAND_LINE_SIZE];
+
+static void pci_set_disable_acs_redir_param(const char *param)
+{
+	if (strlen(param) >= sizeof(disable_acs_redir_param)) {
+		pr_err("PCI: disable_acs_redir parameter is too long and has been ignored!\n");
+		return;
+	}
+
+	strcpy(disable_acs_redir_param, param);
+}

 /**
  * pci_disable_acs_redir - disable ACS redirect capabilities
@@ -3140,7 +3150,7 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
 	int pos;
 	u16 ctrl;

-	if (!disable_acs_redir_param)
+	if (!disable_acs_redir_param[0])
 		return;

 	p = disable_acs_redir_param;
@@ -6262,8 +6272,7 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
-				disable_acs_redir_param =
-					kstrdup(str + 18, GFP_KERNEL);
+				pci_set_disable_acs_redir_param(str + 18);
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
--
2.20.1
