Return-Path: <SRS0=j1yu=SW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBF4C282DD
	for <linux-pci@archiver.kernel.org>; Sat, 20 Apr 2019 04:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1260121479
	for <linux-pci@archiver.kernel.org>; Sat, 20 Apr 2019 04:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO+PORDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfDTEFh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 20 Apr 2019 00:05:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42726 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfDTEFh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Apr 2019 00:05:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id v22so6018509lje.9;
        Fri, 19 Apr 2019 21:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5iuKKqF8/Xmym00zfxsVjKrr4Qwc+UuAXjuAx19SovU=;
        b=OO+PORDxKph5D799MXNS/odzNa241Q8sfwLH1SDXrLuYhi1mup7F5eaeMEfNzm6CHt
         y0h0anndrFw28NRd2GOSv8a7FU75j4GU7IwL2zXMLNpjwwSHIi95/qTZUMzoJ851Jo5L
         0txtg4AkyAWxuKelv79AKIQInsQmZvZsw9iF5qPIA9i0CBlx/VdhOUDviWd52SHZSXXa
         nJKdymYskUEg/N4GDOBm4AZEL7FFUsSEux0u1yHzZukxI40GgPyOlaabVxzZ+WktMnnB
         aNC5Aycd192SnVW6d0a/e3kqYZRgh/kUcKegw+wnqEHEX2x2h0Or/fwdWvkU7PyDPi8X
         riOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5iuKKqF8/Xmym00zfxsVjKrr4Qwc+UuAXjuAx19SovU=;
        b=iu9sbzEkZh85eml5moYovjCqFmA1iF4ilSyHpwI0XFuzV/end3A+hhvk9C5ci5vUCk
         oQZfR2a6Ljc2aNkZawT7hhS+KC/cjOG+j/R7sl/mH2eL3LUHeg+vBJcF62n0VP/SMGv2
         Bn6T5YVO9KjZ5Abpb6Cy+tHW7/qDG9qzPdS+7GN8S/jpwQBmTu5jwdJY5Ka2vK6Fc8XK
         uo9reYGAlJqPGa5uuJiXfCfGYzb+GucrLu4dhOKW3/BjzazI6OuZfqB2SRMzELJK25rk
         tlLuKTRGg5Iax7tNWc2DP6HENNn1fLOS+vCmNobEIPYnFtj6Ev6X6lRec0JbDGflzvx5
         /+Mw==
X-Gm-Message-State: APjAAAUL3sCgvg97vUmrbK7RgLXFO4ACgaVnGsCiY0bieGhXDtrz8s7g
        Y7RxXFUuuDlVZOtjmFC03f8=
X-Google-Smtp-Source: APXvYqwcLsmtu1SjU+FgFR1sLAJJg0FFk3TC/I+6nxTBoFl6Ru4t/vLkpjiodlATk2mT3v5qSPQewA==
X-Received: by 2002:a2e:3c0a:: with SMTP id j10mr4008017lja.164.1555733134287;
        Fri, 19 Apr 2019 21:05:34 -0700 (PDT)
Received: from localhost.localdomain (93-96-157.netrun.cytanet.com.cy. [93.109.96.157])
        by smtp.gmail.com with ESMTPSA id h12sm1685613lfj.45.2019.04.19.21.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 21:05:33 -0700 (PDT)
From:   Mohan Kumar <mohankumar718@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: Define pr_fmt() and use pr_*() instead of printk()
Date:   Sat, 20 Apr 2019 07:05:30 +0300
Message-Id: <1555733130-19804-1-git-send-email-mohankumar718@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define a pr_fmt() macro that convert all of the explicit printk() calls
into corresponding pr_*().

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/pci/bus.c       |  5 ++++-
 drivers/pci/pci-stub.c  | 11 +++++------
 drivers/pci/pci-sysfs.c |  3 ++-
 drivers/pci/pci.c       |  5 +++--
 drivers/pci/quirks.c    |  9 +++++----
 drivers/pci/setup-bus.c |  5 +++--
 drivers/pci/slot.c      |  4 +++-
 7 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 5cb40b2..a742ef5 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -6,6 +6,9 @@
  *	David Miller (davem@redhat.com)
  *	Ivan Kokshaysky (ink@jurassic.park.msu.ru)
  */
+
+#define pr_fmt(fmt) "PCI: " fmt
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
@@ -23,7 +26,7 @@ void pci_add_resource_offset(struct list_head *resources, struct resource *res,
 
 	entry = resource_list_create_entry(res, 0);
 	if (!entry) {
-		printk(KERN_ERR "PCI: can't add host bridge window %pR\n", res);
+		pr_err("can't add host bridge window %pR\n", res);
 		return;
 	}
 
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
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 25794c2..455bf29 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -12,6 +12,7 @@
  * Modeled after usb's driverfs.c
  */
 
+#define pr_fmt(fmt) "pci: warning: " fmt
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -1111,7 +1112,7 @@ void pci_create_legacy_files(struct pci_bus *b)
 	kfree(b->legacy_io);
 	b->legacy_io = NULL;
 kzalloc_err:
-	printk(KERN_WARNING "pci: warning: could not create legacy I/O port and ISA memory resources to sysfs\n");
+	pr_warn("could not create legacy I/O port and ISA memory resources to sysfs\n");
 	return;
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f5ff01d..a24a8bc 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -8,6 +8,8 @@
  * Copyright 1997 -- 2000 Martin Mares <mj@ucw.cz>
  */
 
+#define pr_fmt(fmt) "PCI: " fmt
+
 #include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -6276,8 +6278,7 @@ static int __init pci_setup(char *str)
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
 			} else {
-				printk(KERN_ERR "PCI: Unknown option `%s'\n",
-						str);
+				pr_err("Unknown option `%s'\n", str);
 			}
 		}
 		str = k;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 06af0c3..fb802d1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -12,6 +12,8 @@
  * file, where their drivers can use them.
  */
 
+#define pr_fmt(fmt) "PCI: " fmt
+
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
@@ -159,8 +161,7 @@ static int __init pci_apply_final_quirks(void)
 	u8 tmp;
 
 	if (pci_cache_line_size)
-		printk(KERN_DEBUG "PCI: CLS %u bytes\n",
-		       pci_cache_line_size << 2);
+		pr_info("CLS %u bytes\n", pci_cache_line_size << 2);
 
 	pci_apply_fixup_final_quirks = true;
 	for_each_pci_dev(dev) {
@@ -177,7 +178,7 @@ static int __init pci_apply_final_quirks(void)
 			if (!tmp || cls == tmp)
 				continue;
 
-			printk(KERN_DEBUG "PCI: CLS mismatch (%u != %u), using %u bytes\n",
+			pr_info("CLS mismatch (%u != %u), using %u bytes\n",
 			       cls << 2, tmp << 2,
 			       pci_dfl_cache_line_size << 2);
 			pci_cache_line_size = pci_dfl_cache_line_size;
@@ -185,7 +186,7 @@ static int __init pci_apply_final_quirks(void)
 	}
 
 	if (!pci_cache_line_size) {
-		printk(KERN_DEBUG "PCI: CLS %u bytes, default %u\n",
+		pr_info("CLS %u bytes, default %u\n",
 		       cls << 2, pci_dfl_cache_line_size << 2);
 		pci_cache_line_size = cls ? cls : pci_dfl_cache_line_size;
 	}
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ec44a0f..418023a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -14,6 +14,8 @@
  *	     tighter packing. Prefetchable range support.
  */
 
+#define pr_fmt(fmt) "PCI: " fmt
+
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -2016,8 +2018,7 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 		goto enable_all;
 	}
 
-	printk(KERN_DEBUG "PCI: No. %d try to assign unassigned res\n",
-			 tried_times + 1);
+	pr_info("No. %d try to assign unassigned res\n", tried_times + 1);
 
 	/*
 	 * Try to release leaf bridge's resources that doesn't fit resource of
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index c46d5e1..9f0463e 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -5,6 +5,8 @@
  *	Alex Chiang <achiang@hp.com>
  */
 
+#define pr_fmt(fmt) "PCI: " fmt
+
 #include <linux/kobject.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -403,7 +405,7 @@ static int pci_slot_init(void)
 	pci_slots_kset = kset_create_and_add("slots", NULL,
 						&pci_bus_kset->kobj);
 	if (!pci_slots_kset) {
-		printk(KERN_ERR "PCI: Slot initialization failure\n");
+		pr_err("Slot initialization failure\n");
 		return -ENOMEM;
 	}
 	return 0;
-- 
2.7.4

