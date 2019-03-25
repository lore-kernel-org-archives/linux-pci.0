Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E6BC10F03
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514CC2087C
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 11:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVUGePq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfCYLlQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:41:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40554 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfCYLlQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 07:41:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id t5so9683486wri.7;
        Mon, 25 Mar 2019 04:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQLU4ZrakoZ8yhfMSqT9OlU72pPX+Agq08ND+UiglRA=;
        b=IVUGePq8MYuabAwceDIXSF51YymcHq0dFKMBEy+KU39cmA1EPRi8/uIOLaUwbl7gD/
         LVhpUe3pP+5ZsE5qVIoWB/8cJ5bLgL6stFjrwgXVwGS0f0ULUBEEgRgDC4gnNW8sV91V
         By2fQZarnDLWBZ9LdiBHnEUTDqtDu1h9XLZ16J1zj+US4RxMQuWTWoPqiVwzEc/9ACFC
         BzocgFWVTcNyqG0EGS6+zL+y77Sd/DxTPMBtbgWrvwF4K+dFXaWAwBa+y9a2hNzzy2NQ
         0J3L1w4BeQaiR8f50YvmstJh1kd5aJNYkEhXDqZqtbGoxhxuYeJi34wGsf1hbq3XXzfZ
         7+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iQLU4ZrakoZ8yhfMSqT9OlU72pPX+Agq08ND+UiglRA=;
        b=t5M5dRPiWZVmbuWxbMYLrwOX+efCr4RUv2vadduF9e0DJcfLD4nqfRY0c5JQzZq4Tr
         Q5in9hXBx2YSoHLoM9JNmvUFr/bUI7xYAcHaNayhENiRHlhbHgpRr1pHVdPUh6euS24P
         rwOGXw+aN8YjMdx3qj29GLY9Oe/GX15fhB8/MJMr6nVBspR3S91t0lUyrNYfpwgDMCeA
         LYQ+Lq5G9X6NY4RnYO65AEinOBRg+GBCsufixXOk7RChe9wCqP0xlnZtApVI13BB6FQG
         /YKZ4guD6OLzEI4Ej7n6Axmykoelt6fRWGNrIE9nySA3x6WmSXl6vIgKxNBU7ru9mfi3
         m7fA==
X-Gm-Message-State: APjAAAXgrfO9sHfx2553H/MmWrKj+xxLg3kxMp0Ncjt0Wb8TaxVG1hj4
        zVk+jAvBRJrmZAWUOV4s1w82oHbK
X-Google-Smtp-Source: APXvYqz59O/DShwXS8EB/pAF6qWaNfzXAhGilyB/TrG4lXmIS4VSbhdVGu9dziM3XBKLUzIoaI3bfg==
X-Received: by 2002:a5d:458f:: with SMTP id p15mr16189006wrq.188.1553514074425;
        Mon, 25 Mar 2019 04:41:14 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id f1sm3905730wrt.87.2019.03.25.04.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:41:13 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V4 1/6] PCI: rcar: Clean up remaining macros defining bits
Date:   Mon, 25 Mar 2019 12:40:56 +0100
Message-Id: <20190325114101.10198-1-marek.vasut@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Replace macros using constants with BIT()s instead, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
To: linux-pci@vger.kernel.org
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
V2: Bundle this patch with other cleanups before resending
V3: Add Wolfram's R-B
V4: Add Geert's R-B
---
 drivers/pci/controller/pcie-rcar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index c8febb009454..5b8736f0cd6b 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -46,14 +46,14 @@
 
 /* Transfer control */
 #define PCIETCTLR		0x02000
-#define  CFINIT			1
+#define  CFINIT			BIT(0)
 #define PCIETSTR		0x02004
-#define  DATA_LINK_ACTIVE	1
+#define  DATA_LINK_ACTIVE	BIT(0)
 #define PCIEERRFR		0x02020
 #define  UNSUPPORTED_REQUEST	BIT(4)
 #define PCIEMSIFR		0x02044
 #define PCIEMSIALR		0x02048
-#define  MSIFE			1
+#define  MSIFE			BIT(0)
 #define PCIEMSIAUR		0x0204c
 #define PCIEMSIIER		0x02050
 
-- 
2.20.1

