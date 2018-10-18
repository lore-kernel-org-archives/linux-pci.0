Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67CFECDE43
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 18:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87886205C9
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 18:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87886205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeJSCmM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:42:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34677 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSCmM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Oct 2018 22:42:12 -0400
Received: from mail-qt1-f199.google.com ([209.85.160.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1gDDAk-0006cB-3O
        for linux-pci@vger.kernel.org; Thu, 18 Oct 2018 18:37:26 +0000
Received: by mail-qt1-f199.google.com with SMTP id i64-v6so33025642qtb.21
        for <linux-pci@vger.kernel.org>; Thu, 18 Oct 2018 11:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NclvvB40TxQbdPL4DDvlauQ+xtT8J1d4L7Y1pNey3NI=;
        b=fQvp4gtjxHqSH+cCz6MRULG6O2EuWfMk6d82T9gYiZOzYBMKyRQaPy5l7+BdJHj373
         +P8bkBkpfZ0IS1KYUVLuo10CoKdjV3KpLUAtfgnpQxxE5vOXJ5U0IZU8UAlzILDp263G
         JtLb8IhWU1jRyZQJD6HhiqyfqO0h4Tp3l5BFxlnj6RspUkLd1a/1ucImidULC4W09D2V
         FsIlee+LiOj38JQiI7mpWTA8A+7Gh6YVM7RSEQ3ZKO92olmLpycMpK8FENcvuXvbyNRB
         lsmP7VORgtmZzk429kEdIrPvXAYLgJFdc6r2XtCUjK0Lwi43FBWbGHIFkKaln3RiQsB+
         6mqA==
X-Gm-Message-State: ABuFfoj1FiOJsoYLZAofNNgD9cwfSQqMZzES7q0vOuQLU2HHn0E0cVld
        Zj2VFltRpdX/nGrPPo7LMA5L9CV97peP2all8UoejCd4ytL/tG+F4VMvNCgBkAjeCx4vQsI2WXy
        DJAiP2Tz7HbwbQkBDI3cbh1bIlaQIRCESKb0k3w==
X-Received: by 2002:aed:3165:: with SMTP id 92-v6mr29266234qtg.72.1539887844662;
        Thu, 18 Oct 2018 11:37:24 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62jUux+ZzkbGulQBAgA0QXCMD1M1BFmT24W2IX3mYeZpUhgCVCRGUc4zQfYgA7zneZwHr6rzA==
X-Received: by 2002:aed:3165:: with SMTP id 92-v6mr29266205qtg.72.1539887844485;
        Thu, 18 Oct 2018 11:37:24 -0700 (PDT)
Received: from localhost ([179.225.132.84])
        by smtp.gmail.com with ESMTPSA id o41-v6sm16209527qto.38.2018.10.18.11.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 11:37:23 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        andi@firstfloor.org, lukas@wunner.de, billy.olsen@canonical.com,
        cascardo@canonical.com, ddstreet@canonical.com,
        fabiomirmar@canonical.com, gavin.guo@canonical.com,
        gpiccoli@canonical.com, jay.vosburgh@canonical.com,
        kernel@gpiccoli.net, mfo@canonical.com,
        shan.gavin@linux.alibaba.com
Subject: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Date:   Thu, 18 Oct 2018 15:37:19 -0300
Message-Id: <20181018183721.27467-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recently was noticed in an HP GEN9 system that kdump couldn't succeed
due to an irq storm coming from an Intel NIC, narrowed down to be lack
of clearing the MSI/MSI-X enable bits during the kdump kernel boot.
For that, we need an early quirk to manually turn off MSI/MSI-X for
PCI devices - this was worked as an optional boot parameter in a
subsequent patch.

Problem is that in our test system, the Intel NICs were not present in
any secondary bus under the first PCIe root complex, so they couldn't
be reached by the recursion in check_dev_quirk(). Modern systems,
specially with multi-processors and multiple NUMA nodes expose multiple
root complexes, describing more than one PCI hierarchy domain. Currently
the simple recursion present in the early-quirks code from x86 starts a
descending recursion from bus 0000:00, and reach many other busses by
navigating this hierarchy walking through the bridges. This is not
enough in systems with more than one root complex/host bridge, since
the recursion won't "traverse" to other root complexes by starting
statically in 0000:00 (for more details, see [0]).

This patch hence implements the full bus/device/function scan in
early_quirks(), by checking all possible busses instead of using a
recursion based on the first root bus or limiting the search scope to
the first 32 busses (like it was done in the beginning [1]).

[0] https://bugs.launchpad.net/bugs/1797990

[1] From historical perspective, early PCI scan dates back
to BitKeeper, added by Andi Kleen's "[PATCH] APIC fixes for x86-64",
on October/2003. It initially restricted the search to the first
32 busses and slots.

Due to a potential bug found in Nvidia chipsets, the scan
was changed to run only in the first root bus: see
commit 8659c406ade3 ("x86: only scan the root bus in early PCI quirks")

Finally, secondary busses reachable from the 1st bus were re-added back by:
commit 850c321027c2 ("x86/quirks: Reintroduce scanning of secondary buses")

Reported-by: Dan Streetman <ddstreet@canonical.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 arch/x86/kernel/early-quirks.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 50d5848bf22e..fd50f9e21623 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -731,7 +731,6 @@ static int __init check_dev_quirk(int num, int slot, int func)
 	u16 vendor;
 	u16 device;
 	u8 type;
-	u8 sec;
 	int i;
 
 	class = read_pci_config_16(num, slot, func, PCI_CLASS_DEVICE);
@@ -760,11 +759,8 @@ static int __init check_dev_quirk(int num, int slot, int func)
 	type = read_pci_config_byte(num, slot, func,
 				    PCI_HEADER_TYPE);
 
-	if ((type & 0x7f) == PCI_HEADER_TYPE_BRIDGE) {
-		sec = read_pci_config_byte(num, slot, func, PCI_SECONDARY_BUS);
-		if (sec > num)
-			early_pci_scan_bus(sec);
-	}
+	if ((type & 0x7f) == PCI_HEADER_TYPE_BRIDGE)
+		return -1;
 
 	if (!(type & 0x80))
 		return -1;
@@ -787,8 +783,11 @@ static void __init early_pci_scan_bus(int bus)
 
 void __init early_quirks(void)
 {
+	int bus;
+
 	if (!early_pci_allowed())
 		return;
 
-	early_pci_scan_bus(0);
+	for (bus = 0; bus < 256; bus++)
+		early_pci_scan_bus(bus);
 }
-- 
2.19.0

