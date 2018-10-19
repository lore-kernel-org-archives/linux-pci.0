Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E032AECDE44
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 03:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C9221476
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 03:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHjlFR1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C9221476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeJSL14 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 07:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbeJSL14 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 07:27:56 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.90.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17C0E21477;
        Fri, 19 Oct 2018 03:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539919429;
        bh=iFvklhw9+TTG2ySm/Lmg/biUNaMOqsc4wFsnM+KJvL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHjlFR1xx3r1BKUgLuNaxcD0sYGL2qH7Jkg5oVSQbxEC716g+WXY8X7DmQ2GhWtUZ
         QsstNRZ1MzRirebENP/GkKL9EUtq7+sQG47dnOmIi28mBF/NZ3JIs+zNvVsS7urPl2
         coZ/9A1gB3yFL4dgagjL/garsPkFxiMDb+qm1vVc=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH v1 2/3] PCI: Add options to pci_reset_function
Date:   Fri, 19 Oct 2018 03:23:42 +0000
Message-Id: <20181019032345.5791-2-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181019032345.5791-1-okaya@kernel.org>
References: <20181019032345.5791-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Getting ready to deprecate pci_reset_function_locked(). Add
saverestore and locked parameters to pci_reset_function() function
and add saverestore = true and locked = false to all existing
callers.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/pci/pci.c   | 14 ++++++++++----
 include/linux/pci.h |  4 ++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ccd69f5d01f3..17b10c33cb53 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4819,13 +4819,19 @@ int pci_reset_function(struct pci_dev *dev, u32 reset_type)
 	if (!dev->reset_fn)
 		return -ENOTTY;
 
-	pci_dev_lock(dev);
-	pci_dev_save_and_disable(dev);
+	if (!(reset_type & PCI_RESET_ALREADYLOCKED))
+		pci_dev_lock(dev);
+
+	if (!(reset_type & PCI_RESET_NOSAVERESTORE))
+		pci_dev_save_and_disable(dev);
 
 	rc = __pci_reset_function_locked(dev, reset_type);
 
-	pci_dev_restore(dev);
-	pci_dev_unlock(dev);
+	if (!(reset_type & PCI_RESET_NOSAVERESTORE))
+		pci_dev_restore(dev);
+
+	if (!(reset_type & PCI_RESET_ALREADYLOCKED))
+		pci_dev_unlock(dev);
 
 	return rc;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fedd34a5af77..ad5996d521eb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -896,6 +896,9 @@ enum {
  *
  * PCI_RESET_NOSAVERESTORE tells the PCI core to not save the card context
  * before performing a reset and restore the values after reset.
+ *
+ * PCI_RESET_ALREADYLOCKED indicates that caller is holding the device lock and
+ * PCI core should not try to lock again.
  */
 #define PCI_RESET_DEV_SPECIFIC	(1 << 0)
 #define PCI_RESET_FLR		(1 << 1)
@@ -903,6 +906,7 @@ enum {
 #define PCI_RESET_SLOT		(1 << 3)
 #define PCI_RESET_BUS		(1 << 4)
 #define PCI_RESET_NOSAVERESTORE (1 << 5)
+#define PCI_RESET_ALREADYLOCKED (1 << 6)
 
 #define PCI_RESET_FUNC		(PCI_RESET_DEV_SPECIFIC | \
 				 PCI_RESET_FLR | PCI_RESET_PM)
-- 
2.19.0

