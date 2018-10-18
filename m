Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A205ECDE43
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 18:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108722098A
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 18:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108722098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeJSCmF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:42:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34674 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSCmF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Oct 2018 22:42:05 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1gDDAn-0006dD-3Y
        for linux-pci@vger.kernel.org; Thu, 18 Oct 2018 18:37:29 +0000
Received: by mail-qt1-f198.google.com with SMTP id j60-v6so32736741qtb.8
        for <linux-pci@vger.kernel.org>; Thu, 18 Oct 2018 11:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQU+mYYQH1bIxZoOsHkFT7NpJP8OEJadZXFdQ8UOtBM=;
        b=GE/jN+vwQJ3QrQntENzmiXwsgwcjX137b6TSWg4hkgz3qmB8TWflCHC2VLSzs+FvRG
         21wJjzM4PWtlTnRJcfFFa1DEvgnA8kqajtTgAVH52N+Cr8XF6XaJmVvILz2j472OA4ig
         s7zliE5H5R2e1h0aU5hMnl4+wf4/kPGEAnBzvf3hYWs/LbuclpJW/YJh4t3hGTWphish
         PhDkSkpLvXsFmi24/n12fFP2xhrV+9vvE2NR6GVpneGsndRNdBtH2cCuWgyPSxutMYsT
         9DoSfu+FUK65aNIHqDXe8pZS2LJDgpyL+nv995fRgne02J6n+r+LA/SMDqEtjOi4QnQT
         hpkQ==
X-Gm-Message-State: ABuFfoiemraXYAyS0ibEXQ6XeHu2BKozfFX6EY4Rbr7L0jL5BG8J9HeL
        IFMZ3JxpC0d3AMwDD7HO9L5lo/HhwNDNnnYPzAZID/5NGNA61zSOnftDRxPvAWFqzRUtCtg+1hW
        Jp41OuzlvGBrWoPWLmWQS9Wg7PhX6ty5GynOpCw==
X-Received: by 2002:ac8:234c:: with SMTP id b12-v6mr29988047qtb.187.1539887847811;
        Thu, 18 Oct 2018 11:37:27 -0700 (PDT)
X-Google-Smtp-Source: ACcGV605+AL8HwCcNCPU/nkKhzUeq4+GVpWfBRG8MeKfX+QOaeYcp+5qYIEohM7LCwdLL1RUvCZ6+A==
X-Received: by 2002:ac8:234c:: with SMTP id b12-v6mr29988017qtb.187.1539887847599;
        Thu, 18 Oct 2018 11:37:27 -0700 (PDT)
Received: from localhost ([179.225.132.84])
        by smtp.gmail.com with ESMTPSA id j66-v6sm12484237qkf.1.2018.10.18.11.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 11:37:26 -0700 (PDT)
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
Subject: [PATCH 2/3] x86/PCI: Export find_cap() to be used in early PCI code
Date:   Thu, 18 Oct 2018 15:37:20 -0300
Message-Id: <20181018183721.27467-2-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181018183721.27467-1-gpiccoli@canonical.com>
References: <20181018183721.27467-1-gpiccoli@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch exports (and renames) the function find_cap() to be used
in the early PCI quirk code, by the next patch.

This is being moved out from AGP code to generic early-PCI code
since it's not AGP-specific and can be used for any PCI device.
No functional changes intended.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---
 arch/x86/include/asm/pci-direct.h |  1 +
 arch/x86/kernel/aperture_64.c     | 30 ++----------------------------
 arch/x86/pci/early.c              | 25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/pci-direct.h b/arch/x86/include/asm/pci-direct.h
index 94597a3cf3d0..813996305bf5 100644
--- a/arch/x86/include/asm/pci-direct.h
+++ b/arch/x86/include/asm/pci-direct.h
@@ -10,6 +10,7 @@
 extern u32 read_pci_config(u8 bus, u8 slot, u8 func, u8 offset);
 extern u8 read_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset);
 extern u16 read_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset);
+extern u32 pci_early_find_cap(int bus, int slot, int func, int cap);
 extern void write_pci_config(u8 bus, u8 slot, u8 func, u8 offset, u32 val);
 extern void write_pci_config_byte(u8 bus, u8 slot, u8 func, u8 offset, u8 val);
 extern void write_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset, u16 val);
diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
index 2c4d5ece7456..365fcc37b2a2 100644
--- a/arch/x86/kernel/aperture_64.c
+++ b/arch/x86/kernel/aperture_64.c
@@ -120,32 +120,6 @@ static u32 __init allocate_aperture(void)
 }
 
 
-/* Find a PCI capability */
-static u32 __init find_cap(int bus, int slot, int func, int cap)
-{
-	int bytes;
-	u8 pos;
-
-	if (!(read_pci_config_16(bus, slot, func, PCI_STATUS) &
-						PCI_STATUS_CAP_LIST))
-		return 0;
-
-	pos = read_pci_config_byte(bus, slot, func, PCI_CAPABILITY_LIST);
-	for (bytes = 0; bytes < 48 && pos >= 0x40; bytes++) {
-		u8 id;
-
-		pos &= ~3;
-		id = read_pci_config_byte(bus, slot, func, pos+PCI_CAP_LIST_ID);
-		if (id == 0xff)
-			break;
-		if (id == cap)
-			return pos;
-		pos = read_pci_config_byte(bus, slot, func,
-						pos+PCI_CAP_LIST_NEXT);
-	}
-	return 0;
-}
-
 /* Read a standard AGPv3 bridge header */
 static u32 __init read_agp(int bus, int slot, int func, int cap, u32 *order)
 {
@@ -234,8 +208,8 @@ static u32 __init search_agp_bridge(u32 *order, int *valid_agp)
 				case PCI_CLASS_BRIDGE_HOST:
 				case PCI_CLASS_BRIDGE_OTHER: /* needed? */
 					/* AGP bridge? */
-					cap = find_cap(bus, slot, func,
-							PCI_CAP_ID_AGP);
+					cap = pci_early_find_cap(bus, slot,
+						 func, PCI_CAP_ID_AGP);
 					if (!cap)
 						break;
 					*valid_agp = 1;
diff --git a/arch/x86/pci/early.c b/arch/x86/pci/early.c
index f5fc953e5848..f1ba9d781b52 100644
--- a/arch/x86/pci/early.c
+++ b/arch/x86/pci/early.c
@@ -51,6 +51,31 @@ void write_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset, u16 val)
 	outw(val, 0xcfc + (offset&2));
 }
 
+u32 pci_early_find_cap(int bus, int slot, int func, int cap)
+{
+	int bytes;
+	u8 pos;
+
+	if (!(read_pci_config_16(bus, slot, func, PCI_STATUS) &
+						PCI_STATUS_CAP_LIST))
+		return 0;
+
+	pos = read_pci_config_byte(bus, slot, func, PCI_CAPABILITY_LIST);
+	for (bytes = 0; bytes < 48 && pos >= 0x40; bytes++) {
+		u8 id;
+
+		pos &= ~3;
+		id = read_pci_config_byte(bus, slot, func, pos+PCI_CAP_LIST_ID);
+		if (id == 0xff)
+			break;
+		if (id == cap)
+			return pos;
+		pos = read_pci_config_byte(bus, slot, func,
+						pos+PCI_CAP_LIST_NEXT);
+	}
+	return 0;
+}
+
 int early_pci_allowed(void)
 {
 	return (pci_probe & (PCI_PROBE_CONF1|PCI_PROBE_NOEARLY)) ==
-- 
2.19.0

