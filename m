Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E64C433E6
	for <linux-pci@archiver.kernel.org>; Thu, 25 Feb 2021 17:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC6364F1A
	for <linux-pci@archiver.kernel.org>; Thu, 25 Feb 2021 17:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhBYRls (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Feb 2021 12:41:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45792 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhBYRlq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Feb 2021 12:41:46 -0500
Received: from 1-171-225-221.dynamic-ip.hinet.net ([1.171.225.221] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lFKdM-0007iZ-VY; Thu, 25 Feb 2021 17:41:05 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Aaron Ma <aaron.ma@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] PCI: Set AMD Renoir USB controller to D3 when shutdown
Date:   Fri, 26 Feb 2021 01:40:39 +0800
Message-Id: <20210225174041.405739-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225174041.405739-1-kai.heng.feng@canonical.com>
References: <20210225174041.405739-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Aaron Ma <aaron.ma@canonical.com>

On AMD Renoir/Cezanne platforms, when set "Always on USB" to "On" in BIOS,
USB controller will consume more power than 0.03w.

Set it to D3cold when shutdown, S5 power consumption will be 0.03w lower.
The USB can charge other devices as before.
USB controller works fine after power on and reboot.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1f94fafc6920..0a848ef0b7db 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -28,6 +28,7 @@
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
 #include <linux/switchtec.h>
+#include <linux/kexec.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -5619,3 +5620,10 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+static void pci_fixup_shutdown_d3(struct pci_dev *pdev)
+{
+	if (!kexec_in_progress)
+		pci_set_power_state(pdev, PCI_D3cold);
+}
+DECLARE_PCI_FIXUP_SHUTDOWN(PCI_VENDOR_ID_AMD, 0x1639, pci_fixup_shutdown_d3);
-- 
2.30.0

