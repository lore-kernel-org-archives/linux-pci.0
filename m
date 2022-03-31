Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD412C433EF
	for <linux-pci@archiver.kernel.org>; Thu, 31 Mar 2022 06:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiCaGXB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Mar 2022 02:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiCaGXA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 02:23:00 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 557DF1EC9AA;
        Wed, 30 Mar 2022 23:21:13 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id A37EF1E80CC5;
        Thu, 31 Mar 2022 14:20:41 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q6OyTEZGp0wu; Thu, 31 Mar 2022 14:20:39 +0800 (CST)
Received: from localhost.localdomain (unknown [61.152.154.52])
        (Authenticated sender: renyu@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id 97FE41E80C85;
        Thu, 31 Mar 2022 14:20:38 +0800 (CST)
From:   Ren Yu <renyu@nfschina.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, yuzhe@nfschina.com,
        Ren Yu <renyu@nfschina.com>
Subject: [PATCH] pci: check the function request_region return value
Date:   Thu, 31 Mar 2022 14:21:05 +0800
Message-Id: <20220331062105.2586-1-renyu@nfschina.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329065602.262316-1-renyu@nfschina.com>
References: <20220329065602.262316-1-renyu@nfschina.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the function return NULL,add a warning message

Signed-off-by: Ren Yu <renyu@nfschina.com>
---
 drivers/pci/quirks.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index da829274fc66..fdf3d7394c79 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -584,8 +584,12 @@ static void quirk_ati_exploding_mce(struct pci_dev *dev)
 {
 	pci_info(dev, "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb\n");
 	/* Mae rhaid i ni beidio ag edrych ar y lleoliadiau I/O hyn */
-	request_region(0x3b0, 0x0C, "RadeonIGP");
-	request_region(0x3d3, 0x01, "RadeonIGP");
+	if (!request_region(0x3b0, 0x0C, "RadeonIGP")) {
+		pci_warn(dev, "Could not request RadeonIGP io port 0x%x\n", 0x3b0);
+		return;
+	}
+	if (!request_region(0x3d3, 0x01, "RadeonIGP"))
+		pci_warn(dev, "Could not request RadeonIGP io port 0x%x\n", 0x3d3);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce);
 
-- 
2.25.1

