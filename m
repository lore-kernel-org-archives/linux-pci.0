Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064ABC10F05
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 01:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B811C20857
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 01:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCeLtbO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfDBBdj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:33:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37844 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfDBBdj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 21:33:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so1314331pgc.4;
        Mon, 01 Apr 2019 18:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTCFqfUft32w+PCS7xScjBZEtbn1BupBZrXKsXl5ZlU=;
        b=qCeLtbO+dGuDRHbVWLDedkqhg7MfN5fzLAln+1kPnx/y3QTe1UO5zdvyIwBf2Fh/6o
         yei/A09aSu+J62WNzTzpuoH1sOiZzHlDTSoHi+j/dXWWFWZpV8gVmUc8aEJGyCDfQzkf
         gcUtmZ0Q4IbaS1eDPb7PzCHm+9UAQyuSnjFdrfaqXIItve1t2zVvKHtHaTw82nPcPzNe
         TG79432w9dljVR5NbIjvANORQKA8jDtLlr1Kni7JhluCbXkAlVhAKDocR6S9e5p2SDvO
         l2GX0D0q5iqheoa+msaZEJPUv3zsJCL13gQ56sJIgcomgDG3fSA95wpL5MvBSj7dhORr
         joUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTCFqfUft32w+PCS7xScjBZEtbn1BupBZrXKsXl5ZlU=;
        b=RuWJyxfSO/WUIl6s/CzgH8QS62PYczrVQR9dj3dDPYUoQr5eOLpojfLOa4qelPp1Xx
         TwM90ZbQrRe65jo49zpA4/XNqSYRHmUjCHmCCyL4SZif3OQm3WWoeTRHCT+OG6mg7vHT
         eyK5H10wCf+LGOgYtwp41/5LfMoLrINJKllh6fWeUIb3GaGMLMXQG+erPfjiSUkBvbof
         d73q6KY5sgoQ6FOCKYr/EwdjqOZNpcUskhB09H3ym5tNRlfanmJ1NTZYyxWzFOP/mFoC
         jno+HKKGUujpTyOY3aoOYfhnj4eM9gxiEbbcZGXSedLv+gWi9a2KJhl7vEY/X69Zcwff
         S82w==
X-Gm-Message-State: APjAAAXzdlZAb2NKPs8+4SxDKibywfFS7wcBf3VKoZozS1CXi+aDPrUU
        NzoySUDMCbc22VJHHM8+NWqRmGB7
X-Google-Smtp-Source: APXvYqwUjudmLV5EwzstSmqs8DO9EE1Ft3REAyoH6VD4nNzKQKWXUolMqAe4ANj9nKq9NG3P6uXMhw==
X-Received: by 2002:a62:1881:: with SMTP id 123mr65287871pfy.25.1554168818167;
        Mon, 01 Apr 2019 18:33:38 -0700 (PDT)
Received: from localhost.localdomain ([1.1.125.76])
        by smtp.gmail.com with ESMTPSA id q86sm27912247pfi.171.2019.04.01.18.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 18:33:37 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V5 5/6] PCI: rcar: Clean up debug messages
Date:   Tue,  2 Apr 2019 03:33:06 +0200
Message-Id: <20190402013307.20912-5-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402013307.20912-1-marek.vasut@gmail.com>
References: <20190402013307.20912-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Drop useless casts from debug messages, they are no longer needed
due to the data type cleanup.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
V2: - Bundle this patch with other cleanups before resending
    - Add R-B from Geert
V3: Add Wolfram's R-B
V4: No change
V5: Rebase on next/master 20190401
---
 drivers/pci/controller/pcie-rcar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index d9b8c7cd9fba..168bc6b9bb93 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -286,8 +286,8 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 	else if (size == 2)
 		*val = (*val >> (BITS_PER_BYTE * (where & 2))) & 0xffff;
 
-	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
-		bus->number, devfn, where, size, (unsigned long)*val);
+	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
+		bus->number, devfn, where, size, *val);
 
 	return ret;
 }
@@ -306,8 +306,8 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
 
-	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
-		bus->number, devfn, where, size, (unsigned long)val);
+	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
+		bus->number, devfn, where, size, val);
 
 	if (size == 1) {
 		shift = BITS_PER_BYTE * (where & 3);
-- 
2.20.1

