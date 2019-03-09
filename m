Return-Path: <SRS0=rJvA=RM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138DEC10F0C
	for <linux-pci@archiver.kernel.org>; Sat,  9 Mar 2019 00:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D671820866
	for <linux-pci@archiver.kernel.org>; Sat,  9 Mar 2019 00:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKZh571e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfCIA4U (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:56:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55768 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCIA4U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Mar 2019 19:56:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id q187so14194538wme.5;
        Fri, 08 Mar 2019 16:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tG1/W45bclxbHIJ/XTTD3wUwj/6fNCMlABDLg542AJ8=;
        b=WKZh571eKS0sL4qi7PgsDLwTnVcxsMDpnDSASGZk+kdulgPMcPYcc3KHXMzI5dQLvc
         uiG5B3jK9B12mTO5FZUKxmKo6H/G7WJ3T7gL9oS9fjGUpkrFN4YbW2G34QYZesLpt/se
         EMZ6C3m0vMaJSu7TBcwFYDzwoZUfvjNCGdGxmvpEvI9tGtQ16bofdVbwu8WW85dvN6EM
         kW2tn+f+w6HgRz20I2ES9CNdXOYYCMISr1+xPSry9IUJcqjgc4updzzwZgiqY72o5007
         kdhvkdap9wvW3IyVe7gFhwVe9Vk0GQZvpRamooUdHpGOoFUruyTzO6GiRhVUxhbCxxzz
         /+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tG1/W45bclxbHIJ/XTTD3wUwj/6fNCMlABDLg542AJ8=;
        b=QJdQDex+8dYT6fnqk/NYJoR7jWfDV6M2KuufahmgJCK+WiN9B0AkXJp5Gd/cQjKGX8
         hpGdKoyV2KhIDFA0s7Q1W8ZRY/K3w36OLr8PVNTBif2mC4VxhsCsc6Q8w8m6StjKhdb9
         afZRXrb/hqIJV1uMwaqMhhP7CHAn2WoIECJoEzTSMGj7ANFPrUIP9UCl3gcc82CMlFAL
         dMYZS5CvFHlKt59UT9EHkhaAh2R/F31Nx4Qq3oq5W2gPnL5e/Dr9gYNJ7Wf52ZCBLFfO
         +jft4XWOsf2d2w7tiEeVz+mQ5by/isQr6i2BPMTQl6K31V583qX21gY0U6duLOc78VfM
         rvqQ==
X-Gm-Message-State: APjAAAViC7yIFjgpsIhqYWkp2O1MYKv3kX/vv4FNWPwtgycZLp7+UVWE
        OfpHeIbGdmji/w6uZf3JjK+Vlp+s
X-Google-Smtp-Source: APXvYqzmxK8Ho2eIso30bNohfI9EKH1LsnSOaTe3rzdXwUy1WQRVaJQUdmumsEQHqNYEXmwLlRWy/A==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr10568868wma.114.1552092977678;
        Fri, 08 Mar 2019 16:56:17 -0800 (PST)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id e23sm8340623wme.15.2019.03.08.16.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 16:56:16 -0800 (PST)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/2] PCI: rcar: Clean up remaining macros defining bits
Date:   Sat,  9 Mar 2019 01:56:12 +0100
Message-Id: <20190309005613.1493-1-marek.vasut@gmail.com>
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

