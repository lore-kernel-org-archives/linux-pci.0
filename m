Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C94ECAAD3
	for <linux-pci@archiver.kernel.org>; Thu,  1 Sep 2022 15:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiIAPXg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiIAPXf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 11:23:35 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06E686077;
        Thu,  1 Sep 2022 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662045814;
  x=1693581814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9ju/6wQLIcO2NCD3fn3ymvU+mw5s1Mi3lE03VQmfwKo=;
  b=QqHUgo0H11c/Y4dn8KA++EkQCEJQl3rA1fSdtzpci1FQgm8KhjH5+4Ox
   ulDRpULA0p19pxtyx+5cIy0F9flpcUCgDsy1ayyWHPu+AH7ZSn3ApwNIn
   Lr6ggqReB+FW9of7tBZ28uF5DAOmGpAk0B2u2isAlf856VEDG6O5Fp3v1
   F/DjRAUZ+crcbtaPF3QqK00tZVSAZuyQfLCre86D8/qKIPrdNR8H/PTHx
   0aEk4mRRhprNyy4aDAO9LMdYyNriJvQ/yFcMWXtt80BR/letrBKtRbmdk
   TdxJMCxhvOE3cLZIl+gFsJwtGt2OZoFgoRgDOEfshK++lJoA+tK5WxinC
   A==;
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Jesper Nilsson <jesper.nilsson@axis.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: Map PCI bios specific error to generic errno
Date:   Thu, 1 Sep 2022 17:23:24 +0200
Message-ID: <20220901152324.29654-1-jesper.nilsson@axis.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_read_config_byte() may return a PCI bios specific error value
(in my case PCIBIOS_DEVICE_NOT_FOUND 0x86) which is nonsensical
to return to the caller of of_irq_parse_pci() which expects
a negative errno if something goes wrong.

Use the appropriate mapping function before passing the error on.

Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/pci/of.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 196834ed44fe..130bcfe61e04 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -440,8 +440,10 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
 	 * for PCI. If you do different, then don't use that routine.
 	 */
 	rc = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
-	if (rc != 0)
+	if (rc != 0) {
+		rc = pcibios_err_to_errno(rc);
 		goto err;
+	}
 	/* No pin, exit with no error message. */
 	if (pin == 0)
 		return -ENODEV;
-- 
2.36.0

