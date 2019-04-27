Return-Path: <SRS0=VK9V=S5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158C4C43219
	for <linux-pci@archiver.kernel.org>; Sat, 27 Apr 2019 19:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE2D20881
	for <linux-pci@archiver.kernel.org>; Sat, 27 Apr 2019 19:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="fm+vjMnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfD0TNX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:13:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39385 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfD0TNW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Apr 2019 15:13:22 -0400
Received: by mail-oi1-f195.google.com with SMTP id n187so5495051oih.6
        for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2019 12:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yB3ceRNeie3ekFC/SUDDCaxF9O67AqC+ZxAxz2oma3A=;
        b=fm+vjMnpYE5GOyxCJ9WFPRgoGhzGcvPKxyAcwvdjhgnLIKQ8q8iOimX5wvezJXglRJ
         jiJ+iNyeCfJyZ/JSxELxGhjSbV9L+oVmXHkW+SmgVBuRzUl261mxDCQiTkfzWR4oo7U0
         3O//BUKDFXnwh9BhO/B75L1eieWoV/8Hjue9QEnBJhiMAUnsQtmtEhDWpm/lGtHG1WOZ
         1B5DkAD/VNwdfie93CymaL27kJaWY2oHy5uHZXVzjTSZ9w3nYbyh1E7qIKAtrknPdlmY
         3KcCMwbYFli0bMygKoKzJ25cuWYHbI9T2exVy8Wv2nE3AtMMvUYOtDUgJM2v5KCbG1BD
         CocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yB3ceRNeie3ekFC/SUDDCaxF9O67AqC+ZxAxz2oma3A=;
        b=kX9rUoeuyWFhzArBLafUo40zHWRdBWxbvnfwcd3qIS2i1MLp8wOybeSWMIcQMzKVYX
         EQbQ4vOQjL53Yokg/X3dQY2e4gturtDUcsGCgmR51MEwJQoYcLsZGEYQUEvzfA465MJ7
         ddEOZp+OppZY+AI4KhtB0wlz3gXjf7l2KqF0rwxFMzm+QSeg5cpfBLiE3Y2u5u72nKp5
         hnhRHR85M5AdWQVKBO9ZU6yOzb9tgSEsxUCNV6CcAKF34WSf8Ca+xVuj9TJPdBZzfQso
         cvq4pBYYRFe7BHQtsnMlzk2x78nKphuy9deBUFe7s8arhjHwR81i6HPhCx+nZK9srKkq
         DliA==
X-Gm-Message-State: APjAAAVJWw2zR0yhp5EkL87KIz8hvRTaS3Oz13o4EtUMIDxScm9uQEoX
        EXj5qKgusDKdE7EL7wSejJa/2Q==
X-Google-Smtp-Source: APXvYqwXgTY+aJVdZninNhoXzMl5VJJNcGI6GKWPFcuOrPW3qwwDXU8j1HRDTiOgxzppjG8GUdDmkw==
X-Received: by 2002:aca:97:: with SMTP id 145mr417673oia.36.1556392400983;
        Sat, 27 Apr 2019 12:13:20 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:3d43:9acc:6ecc:a72c])
        by smtp.gmail.com with ESMTPSA id d11sm342069otl.33.2019.04.27.12.13.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 12:13:20 -0700 (PDT)
From:   fred@fredlawl.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH 4/4] PCI/portdrv: Add dev_fmt() to port drivers
Date:   Sat, 27 Apr 2019 14:13:04 -0500
Message-Id: <20190427191304.32502-5-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190427191304.32502-1-fred@fredlawl.com>
References: <20190427191304.32502-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Frederick Lawler <fred@fredlawl.com>

Add dev_fmt() to port drivers.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/hotplug/pciehp_core.c  | 3 +++
 drivers/pci/hotplug/pciehp_ctrl.c  | 2 ++
 drivers/pci/hotplug/pciehp_hpc.c   | 3 +++
 drivers/pci/hotplug/pciehp_pci.c   | 2 ++
 drivers/pci/pcie/aer.c             | 3 +++
 drivers/pci/pcie/aer_inject.c      | 2 ++
 drivers/pci/pcie/bw_notification.c | 2 ++
 drivers/pci/pcie/dpc.c             | 2 ++
 drivers/pci/pcie/pme.c             | 2 ++
 9 files changed, 21 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 430a47556813..b07d713fd4bd 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -17,6 +17,9 @@
  *   Dely Sy <dely.l.sy@intel.com>"
  */
 
+#define pr_fmt(fmt) "pciehp: " fmt
+#define dev_fmt(fmt) pr_fmt(fmt)
+
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 345c02b1e8d7..969a9c72f65d 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -13,6 +13,8 @@
  *
  */
 
+#define dev_fmt(fmt) "pciehp: " fmt
+
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 28a132a0d9db..f2a3da105f5b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -12,6 +12,9 @@
  * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
  */
 
+#define pr_fmt(fmt) "pciehp: " fmt
+#define dev_fmt(fmt) pr_fmt(fmt)
+
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/jiffies.h>
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index 55967ce567f6..04ccd535aca7 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -13,6 +13,8 @@
  *
  */
 
+#define dev_fmt(fmt) "pciehp: " fmt
+
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pci.h>
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 224d878a28b4..6fd67285423d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -12,6 +12,9 @@
  *    Andrew Patterson <andrew.patterson@hp.com>
  */
 
+#define pr_fmt(fmt) "AER: " fmt
+#define dev_fmt(fmt) pr_fmt(fmt)
+
 #include <linux/cper.h>
 #include <linux/pci.h>
 #include <linux/pci-acpi.h>
diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 610b617ae600..d4f6d49acd0c 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -12,6 +12,8 @@
  *     Huang Ying <ying.huang@intel.com>
  */
 
+#define dev_fmt(fmt) "AER: " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
index d2eae3b7cc0f..a4bb90562cd5 100644
--- a/drivers/pci/pcie/bw_notification.c
+++ b/drivers/pci/pcie/bw_notification.c
@@ -14,6 +14,8 @@
  * and warns when links become degraded in operation.
  */
 
+#define dev_fmt(fmt) "BWN: " fmt
+
 #include "../pci.h"
 #include "portdrv.h"
 
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 72659286191b..b3c10cdc508a 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -6,6 +6,8 @@
  * Copyright (C) 2016 Intel Corp.
  */
 
+#define dev_fmt(fmt) "DPC: " fmt
+
 #include <linux/aer.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index 54d593d10396..d6698423a6d6 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -7,6 +7,8 @@
  * Copyright (C) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  */
 
+#define dev_fmt(fmt) "PME: " fmt
+
 #include <linux/pci.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
-- 
2.17.1

