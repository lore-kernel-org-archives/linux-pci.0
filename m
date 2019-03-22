Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A499CC10F00
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A9E218FC
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXOeu20K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfCVCi5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:38:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34598 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfCVCi4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 22:38:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so701781wrq.1;
        Thu, 21 Mar 2019 19:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yl2AJ0VIhJwymMfATd9RMvkhKTRbOBqw4HZrQffV7rw=;
        b=dXOeu20KovqkGpTC1mhGRPopUs5j3sAr7Z5X/dzYMT+8hnD+yCiqG8c5HHmdXiPhs2
         EmLVzXdOryfBTO1sEgzFapS++y1u7gik5MCHwu0TO0L282xcA3MBVTGNDUJ0wCMZpCaU
         zJF0wxC3/t180NikJc++uS5+VeLlkGZkhCdWbc2H2ys0jP+HUT+9nkMJeuDyNfQOtJi+
         26LFh785aHTN+heI+g9raSRG2OKb4zEdIuWGgXkbPbSWap5VmcDTFxW5JjXWeqf1zNl4
         j57hZH3TEeEMaCGTjmCcY18+GTYcBbEDe0Z43k2Q+XQXTszlT3/o85CK/CLQPAHURxzJ
         UPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yl2AJ0VIhJwymMfATd9RMvkhKTRbOBqw4HZrQffV7rw=;
        b=ZHhv2wJpyGRq4FGPuq4k6nYIBtqpUNpKZY3WF3XPaDqkPWunRxdLfDJfhaYW4cjqHd
         HULmyXOj1E9yipmgffG9WBEMEmEnBtoXuEW+VffynKweOWN7q0Y5E1fooWzui4AlLb7I
         m7WdGW4+BcXJt6gV52hoyIXd/zDwFEV9f0gkM34YisMAw3ybc3bWskYm3K7S6k/h4IPE
         E2TtJqGJcJeQxKIveX/Sjm2JuMIZDqSzd269qavdKINgCbwHWqnbPIME9Z9rGm6PwF+A
         rkdTOrfqMjRhN/VfLLrurmnYo83T2gceCMR06XSWy07hbFnLSiQIMgE3+MW6PpxR5lbV
         4M2Q==
X-Gm-Message-State: APjAAAVhLvqch11HlguaxzhqUyvlt5XY5yRoq4yz21TpG3YNWOSGgNKz
        4suCnb2hjU3Ge/kD+wuZIuO4Q7o4
X-Google-Smtp-Source: APXvYqzCgE8yKxWOWngH8Lf+XPUzBYSxuCWD8abx/cG5SBizQu8KA5ZBA5KCWzzxFXlMikfIyXl+bA==
X-Received: by 2002:a5d:6b4c:: with SMTP id x12mr4634860wrw.14.1553222334610;
        Thu, 21 Mar 2019 19:38:54 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id w18sm10432692wru.24.2019.03.21.19.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 19:38:53 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2 4/6] PCI: rcar: Replace (8 * n) with (n << 3)
Date:   Fri, 22 Mar 2019 03:38:42 +0100
Message-Id: <20190322023844.18574-4-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322023844.18574-1-marek.vasut@gmail.com>
References: <20190322023844.18574-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Replace (8 * n) with (n << 3) to make bit shift operations consistent.
No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
---
V2: Bundle this patch with other cleanups before resending
---
 drivers/pci/controller/pcie-rcar.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 66599e0c4bb4..0ab05803bb70 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -169,7 +169,7 @@ enum {
 
 static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 {
-	unsigned int shift = 8 * (where & 3);
+	unsigned int shift = (where & 3) << 3;
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	val &= ~(mask << shift);
@@ -179,7 +179,7 @@ static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
 
 static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
 {
-	unsigned int shift = 8 * (where & 3);
+	unsigned int shift = (where & 3) << 3;
 	u32 val = rcar_pci_read_reg(pcie, where & ~3);
 
 	return val >> shift;
@@ -280,9 +280,9 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 	}
 
 	if (size == 1)
-		*val = (*val >> (8 * (where & 3))) & 0xff;
+		*val = (*val >> ((where & 3) << 3)) & 0xff;
 	else if (size == 2)
-		*val = (*val >> (8 * (where & 2))) & 0xffff;
+		*val = (*val >> ((where & 2) << 3)) & 0xffff;
 
 	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
 		bus->number, devfn, where, size, (unsigned long)*val);
@@ -307,11 +307,11 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 		bus->number, devfn, where, size, (unsigned long)val);
 
 	if (size == 1) {
-		shift = 8 * (where & 3);
+		shift = (where & 3) << 3;
 		data &= ~(0xff << shift);
 		data |= ((val & 0xff) << shift);
 	} else if (size == 2) {
-		shift = 8 * (where & 2);
+		shift = (where & 2) << 3;
 		data &= ~(0xffff << shift);
 		data |= ((val & 0xffff) << shift);
 	} else
-- 
2.20.1

