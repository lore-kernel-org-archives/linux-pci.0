Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40E8C10F0E
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 18:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961AB2064A
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 18:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij0epLFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389782AbfDRSlN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:41:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37183 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389770AbfDRSlN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Apr 2019 14:41:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id v13so2769068ljk.4;
        Thu, 18 Apr 2019 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ACYLco5x8b2knjBLFQsolq1c+0YktfCN70azvxOs8N8=;
        b=Ij0epLFeC3mk7OcJHpkVxCW8u7UUutBa1NMGO146u93cvho0I7ZvcKWMg//KhucXn/
         QnjBwBFvsPTlgdat550z3cit9n2OO1sL0J6GvngBDdbtpUfuzHnytoqN6yauuzvd5Kl4
         aEr/RhusRag+f+aQfc5z4RWXbzx6oXORWzuLfLfqykt8Xo7Je2UknrHYiaOFBmHu3SDq
         zi189Qms/Cb2crqbumoKKaeIvgUlTqoIp+H7ZFo8+icm4Ooa8YrGIc3CGOoH43GSyPz1
         NBStcwwjq+NJK6fOOZpdrMtl+4sXTzTUWjEskFN7BIdwmEZqMN3LlAw1J9suBilVcdGD
         duTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ACYLco5x8b2knjBLFQsolq1c+0YktfCN70azvxOs8N8=;
        b=VwgYX3vHmBshhli3h0/tsX1QTzH9+4JqJ1/yhkUUeMx7m09zioN45+RrEzTMRdVr6y
         0kT5AsDOtw6ZytYm1by+K4BE2XSD1DXPp/EA4Sjr0FQboVqI44NPfhjZaKSS2XRZI6Em
         HvC8HIIL76FfzYHqRxDKXJbUUV3uMMttsCyF0bdCNj29+3Qx3HAHtqBJqEe7ijRqYlFL
         fHTPpC8Ta3gPm32qQqrhY3+AwPbtnWMNZQKM3iiPGH5bUdCbbCdYpffPXUVfbNvWlnlC
         qF735RBkvmTHdBs7IoeBxpyX3NIqE0yOLbu3zqgwunu/Vl3l5ekt71GOxGshkD1+ge4b
         26dA==
X-Gm-Message-State: APjAAAW9zzKdHwKp8aGH+v5t66xBtxuSB4oKZkP4RuHRrTSPyTtEecJg
        9QVzXkF9YRWocD90O2usiaHE9Qt1gKE6Sg==
X-Google-Smtp-Source: APXvYqzMbzJ2P4xr3LaDOWlNIWnLRvzVhKr7DdL2rKH17uDcON5iaThCXwE0Ou+SlyCkHtFv5DPbEw==
X-Received: by 2002:a2e:6a05:: with SMTP id f5mr29093981ljc.149.1555612871479;
        Thu, 18 Apr 2019 11:41:11 -0700 (PDT)
Received: from localhost.localdomain (31-91-24.netrun.cytanet.com.cy. [31.153.91.24])
        by smtp.gmail.com with ESMTPSA id b12sm600325lfa.74.2019.04.18.11.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Apr 2019 11:41:10 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: pci: Define pr_fmt() and use pr_*() instead of printk()
Date:   Thu, 18 Apr 2019 21:41:04 +0300
Message-Id: <1555612864-4059-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define a pr_fmt() macro that convert all of the explicit printk() calls
into corresponding pr_*().

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/pci/pci-stub.c | 11 +++++------
 drivers/pci/quirks.c   | 10 +++++-----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index 66f8a59..f946bf9 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -16,6 +16,8 @@
  * .../0000:00:19.0/driver -> ../../../bus/pci/drivers/pci-stub
  */
 
+#define pr_fmt(fmt) "pci-stub: " fmt
+
 #include <linux/module.h>
 #include <linux/pci.h>
 
@@ -66,20 +68,17 @@ static int __init pci_stub_init(void)
 				&class, &class_mask);
 
 		if (fields < 2) {
-			printk(KERN_WARNING
-			       "pci-stub: invalid id string \"%s\"\n", id);
+			pr_warn("invalid id string \"%s\"\n", id);
 			continue;
 		}
 
-		printk(KERN_INFO
-		       "pci-stub: add %04X:%04X sub=%04X:%04X cls=%08X/%08X\n",
+		pr_info("add %04X:%04X sub=%04X:%04X cls=%08X/%08X\n",
 		       vendor, device, subvendor, subdevice, class, class_mask);
 
 		rc = pci_add_dynid(&stub_driver, vendor, device,
 				   subvendor, subdevice, class, class_mask, 0);
 		if (rc)
-			printk(KERN_WARNING
-			       "pci-stub: failed to add dynamic id (%d)\n", rc);
+			pr_warn("failed to add dynamic id (%d)\n", rc);
 	}
 
 	return 0;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index f9cd4d4..3b367b7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -11,6 +11,7 @@
  * Init/reset quirks for USB host controllers should be in the USB quirks
  * file, where their drivers can use them.
  */
+#define pr_fmt(fmt) "PCI: " fmt
 
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -159,8 +160,7 @@ static int __init pci_apply_final_quirks(void)
 	u8 tmp;
 
 	if (pci_cache_line_size)
-		printk(KERN_DEBUG "PCI: CLS %u bytes\n",
-		       pci_cache_line_size << 2);
+		pr_debug("CLS %u bytes\n", pci_cache_line_size << 2);
 
 	pci_apply_fixup_final_quirks = true;
 	for_each_pci_dev(dev) {
@@ -177,7 +177,7 @@ static int __init pci_apply_final_quirks(void)
 			if (!tmp || cls == tmp)
 				continue;
 
-			printk(KERN_DEBUG "PCI: CLS mismatch (%u != %u), using %u bytes\n",
+			pr_debug("CLS mismatch (%u != %u), using %u bytes\n",
 			       cls << 2, tmp << 2,
 			       pci_dfl_cache_line_size << 2);
 			pci_cache_line_size = pci_dfl_cache_line_size;
@@ -185,7 +185,7 @@ static int __init pci_apply_final_quirks(void)
 	}
 
 	if (!pci_cache_line_size) {
-		printk(KERN_DEBUG "PCI: CLS %u bytes, default %u\n",
+		pr_debug("CLS %u bytes, default %u\n",
 		       cls << 2, pci_dfl_cache_line_size << 2);
 		pci_cache_line_size = cls ? cls : pci_dfl_cache_line_size;
 	}
@@ -2613,7 +2613,7 @@ static void nvbridge_check_legacy_irq_routing(struct pci_dev *dev)
 	pci_read_config_dword(dev, 0x74, &cfg);
 
 	if (cfg & ((1 << 2) | (1 << 15))) {
-		printk(KERN_INFO "Rewriting IRQ routing register on MCP55\n");
+		pr_info("Rewriting IRQ routing register on MCP55\n");
 		cfg &= ~((1 << 2) | (1 << 15));
 		pci_write_config_dword(dev, 0x74, cfg);
 	}
-- 
2.7.4

