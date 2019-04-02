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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932FEC4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 01:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645C020880
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 01:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY9S2akV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfDBBdV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:33:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36617 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfDBBdV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 21:33:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so4181662plb.3;
        Mon, 01 Apr 2019 18:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x+YBEyd8q21TVn0yuRHS8HNRncJHYiBpNY2O31LawgM=;
        b=MY9S2akVFFxNVlenpTgcD/Y7QmDTalwQmT9VzBGVylWKN4s6MiZuG7S1OFd2VjhbB1
         /d28H5AfBXqzbVrYD8SguhAI71iU1Nw7LYHdtgPoKU6bzscxN7n+keJpv9UCYTMvg/SD
         HC3MZt+8Yh1TP041ZvqVY4uXfQgQywJzn9Mu8B2Qqykq3TNOc4B+0HOWwa+mRHxfSk+6
         KBCSsuv6PUI8szmBJSU/B4so/C+Nhqijtjg8Edv3wtpjueonQf5LK2jCONxFx2JQaF6/
         qUbdLbsDAgM7INLvvhQvmK/sJ97wAqS3hBazHUXjQ0Dq6fbhP2WBpC4cKgmeeXS3qvPQ
         MD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x+YBEyd8q21TVn0yuRHS8HNRncJHYiBpNY2O31LawgM=;
        b=tpJ6m4tKCTY3rc3FLQWeXYhq4TzUJwsSrfJruapmMUfe/uUAYvz5TWHGbc0toX6W3t
         QtYCVAXC7z1zodKHWDPKbCRG2NNpZt8YDzDFq+xKoLtp2gVkZh6d6yZhhjlOYn+4Kagf
         rwVqISY/p3lYGMzSOueD6DnL8IJ5hqYfWOHXoWBSvMSj3XZxUtllCgENUDuCrJB0Q7pt
         EMhJM4UNu4SQGTFM0H4iyJhw0FYaEpZ1XKsORGL95LIauY2yEMu8V4+L/xSn5/uJ6iTE
         d5/zxl9hF620goyLUaji8pXyiI1Vz+uduSHovYOr5HVGXUHZ7b7UN4oSnkO6Aw7Gl1qF
         Uycg==
X-Gm-Message-State: APjAAAXKAjIgUfckAdOibupHCXveXXDXDaZ9NL34RJVBZ1f+3+R3zkPo
        4awaOs2pryXj9ahOrMmkJnGnzMRB
X-Google-Smtp-Source: APXvYqzFtzgB1F0claRigwPcIYogwcOGNP4LX2ZbGuh/EKg940d72RLUTD023tVYezbsMi0P2u/3yQ==
X-Received: by 2002:a17:902:820e:: with SMTP id x14mr4132652pln.207.1554168800315;
        Mon, 01 Apr 2019 18:33:20 -0700 (PDT)
Received: from localhost.localdomain ([1.1.125.76])
        by smtp.gmail.com with ESMTPSA id q86sm27912247pfi.171.2019.04.01.18.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 18:33:19 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V5 1/6] PCI: rcar: Clean up remaining macros defining bits
Date:   Tue,  2 Apr 2019 03:33:02 +0200
Message-Id: <20190402013307.20912-1-marek.vasut@gmail.com>
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
V5: Rebase on next/master 20190401
---
 drivers/pci/controller/pcie-rcar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 6a4e435bd35f..542b5bbf4bf1 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -47,14 +47,14 @@
 /* Transfer control */
 #define PCIETCTLR		0x02000
 #define  DL_DOWN		BIT(3)
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

