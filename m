Return-Path: <SRS0=AkHN=R2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB1AC4360F
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC612087F
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIPHsiKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfCWByT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:54:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35843 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfCWByT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 21:54:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id y13so4234365wrd.3;
        Fri, 22 Mar 2019 18:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5eS/gN/VqRZFxg/obSwIzyXeP5b5RAZ+JaNHCPQk6Q=;
        b=OIPHsiKUBJv2FhSwdQi8TMtau0cwPy0E1sTnLbBTlDFoVHoQJL+V8mIXBi9Jb3rvdp
         is7YScF7p9s0LMuORta2Dk50vmScv86uaFWKxHyD1ADtVNN39/9tp0g5eQDQYKwYoyJf
         BRaGbYOHTC78mKnJQiQ7TfA8/C75O7YRXwOzcPDb/4VG/cEnD0fgWeOgBCWxmtGvvkNv
         2H1A+CQnd23GOm2HmlfFMz2kt7sH14Pw8EQmFOoVpBjKA3tnntoPItAXyfKssb0oHX01
         4Mq4jIbc+3C+7KdRp6EgZJcn9SzHEL1p6eCmDQahWm0vSPwYZc0hc8q43bqofgiJJKXx
         01Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5eS/gN/VqRZFxg/obSwIzyXeP5b5RAZ+JaNHCPQk6Q=;
        b=SZG2E8iGRXg12meT4/v+eVmwtc64vj/Jyeyyuk4Oz1r0gG42dxyVjmuPhaFnpsPyuf
         YXkzxhyO1AeA9TF2aqJXIcAAQPvCqqINIdnOdq33MGZ2lQ/7ySN7m1bIcgx/7UQMk20t
         AbtzhHFNw5aEoVlTMXgypI4lb8Z4HAQwUQJ9bBdw2xkAzlpZu3SsSYkM5SZfrR32YGhv
         1s5qKu6PeYWYMEq96xIiBC+f+XVC+CRD0xv4DzyRiv7SoJi9KOgtZc1JiGCDx+HM+FWW
         4Adz8dEV22pwC47Kqk2orRwlWKV5KsMuwoufXD+u6ITD1hHxdiQ0+LO9cmcFHRpDlAxf
         nf0Q==
X-Gm-Message-State: APjAAAVeR4Wy6iwfPuB+x9oLSpuCr7EyAqsDFH9lkUxsusxsSmVeMjIT
        OXJxjF+s9+J72fdGjNBjv2ykNw1/
X-Google-Smtp-Source: APXvYqzxzeSsuBWD6dwRZ7B1jy0m4GRoXfkjfx70l0MGfSao0k5Pms1ksYh3+VGhJgvRELIhnd2lJg==
X-Received: by 2002:adf:fb04:: with SMTP id c4mr7933023wrr.299.1553306056980;
        Fri, 22 Mar 2019 18:54:16 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id y192sm25433050wmc.6.2019.03.22.18.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:54:16 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V3 5/6] PCI: rcar: Clean up debug messages
Date:   Sat, 23 Mar 2019 02:53:58 +0100
Message-Id: <20190323015359.7231-5-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323015359.7231-1-marek.vasut@gmail.com>
References: <20190323015359.7231-1-marek.vasut@gmail.com>
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
---
 drivers/pci/controller/pcie-rcar.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index f835e4341590..4d9e68ddcdd9 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -284,8 +284,8 @@ static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
 	else if (size == 2)
 		*val = (*val >> ((where & 2) << 3)) & 0xffff;
 
-	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
-		bus->number, devfn, where, size, (unsigned long)*val);
+	dev_dbg(&bus->dev, "pcie-config-read: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
+		bus->number, devfn, where, size, *val);
 
 	return ret;
 }
@@ -304,8 +304,8 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
 
-	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08lx\n",
-		bus->number, devfn, where, size, (unsigned long)val);
+	dev_dbg(&bus->dev, "pcie-config-write: bus=%3d devfn=0x%04x where=0x%04x size=%d val=0x%08x\n",
+		bus->number, devfn, where, size, val);
 
 	if (size == 1) {
 		shift = (where & 3) << 3;
-- 
2.20.1

