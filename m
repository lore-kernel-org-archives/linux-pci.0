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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AACC10F00
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0595421900
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 02:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3wbQXEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfCVCiw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:38:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42495 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfCVCiw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 22:38:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so661601wrx.9;
        Thu, 21 Mar 2019 19:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oyufogf+KDRw5kf68/JGm5ce3/ZrEBM4vcxMGmMiU5Q=;
        b=l3wbQXEQf38Uxj8B2+OYcfwT+r6UOlJvIyUlqr1K5FPbpInuiLpcHHkY1THXDWfPJ4
         J5KuUYs89dPhXeF+OiDJCqOZhG9ZFsSRXrxejVD9wwU3206+7o7Ft3Bzfkbq2CFBItT7
         hBXRYjkHu8ovWMDZLcTIr1fjwnnXusOAsoW1DIAxlXtyX1ifDOsJU1YEr6+RVR466+yH
         ovwf7ls/P/oQ9aSDNmZrUTYfksBrtMdntqwxouH941oAwZNem+AM3RX/EZNvdS2i00tM
         YsamduA1MK4odBShKqoE6jtTvHhjKMntvaW+v1ECrRKK0VaPow4HXJBIvOx27uy49JTl
         ua7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oyufogf+KDRw5kf68/JGm5ce3/ZrEBM4vcxMGmMiU5Q=;
        b=XLr5dhr63RzN4mdLGln10ff42BmhpsFkAoKBdb/rvpRPybVCMwaQ1pewMD8YOyzIkO
         bXFC7shU3rI2Edk/VQutxqhCmq7eH6B+qISfX9V9dk3U8mULTLu81M2sq7y4BCbBX2z8
         ciI+jH4UucRjx7A/fvtL3tUpDqVIn2F5MLLBfWndNoxcruxNpHZPbFl2nPv0ksg3Mp4E
         dNWBqXAszTVOp1Wh9HWvwEE/zsqJovrjrtsCzrx2JU98QjB6s5UnA5nrjZOREcTvPgQh
         fvjZKqlCrKy5aQyQpsaPRhG62/8KluAEeYloa023Gt+VQit0npjREj7ZbzUWm6SamHEV
         aVJQ==
X-Gm-Message-State: APjAAAVGwxrUNQkOQE3VxZ89b8b30e+NCtvScTd0aIIatgXCFVkdpF1o
        zmU8duozykvcWVDD0d0RmRG8GYyU
X-Google-Smtp-Source: APXvYqxHfLFUrz4uoApdUfCVgEgRwT9oP5IQbVM6stj3Nn94Akra9MZhMMK+mRDhSQN9JH5Jtk97Mg==
X-Received: by 2002:a5d:5188:: with SMTP id k8mr4564550wrv.183.1553222329703;
        Thu, 21 Mar 2019 19:38:49 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id w18sm10432692wru.24.2019.03.21.19.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 19:38:48 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH V2 1/6] PCI: rcar: Clean up remaining macros defining bits
Date:   Fri, 22 Mar 2019 03:38:39 +0100
Message-Id: <20190322023844.18574-1-marek.vasut@gmail.com>
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
V2: Bundle this patch with other cleanups before resending
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

