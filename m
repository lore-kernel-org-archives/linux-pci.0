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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FDBC10F0E
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D302087F
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 01:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyiYCSFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfCWByN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 21:54:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38225 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfCWByN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Mar 2019 21:54:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id g12so4205748wrm.5;
        Fri, 22 Mar 2019 18:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYbg+Rd5CZUA/IeYEIt0PqnPXP6HNU4KEIYd+8v11jI=;
        b=FyiYCSFX7kLkchey/QjFGPVq1OREFV+LNqeI6v8XClCwWuf6dlKo2NCoMsoan3CT0N
         WwbGI0bG3MsbWEyfOHUze/TZplki+ShyAsDn/I+C1yBDOHgho30tfg29lZfo8L5lHiBK
         WOHcOtTOdI7abrp7VFSBza1VE9NCnU3U5+yI8b3arqV6hxz9/DHzWJ7v9wsN/HUKk3EU
         bSGOBI4PBboFlr+l1sUWsU3CnD7yVcrMmIEFhm/HTRlaaK/zF2fY5/NDWE2Dry/jWQrR
         YB6QzLyLUcapgny7ouEBWxP1nY3D+wyjlpxny2dEsgN1jEpsmEP/2bLoSBfFPkJQN0sa
         DK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DYbg+Rd5CZUA/IeYEIt0PqnPXP6HNU4KEIYd+8v11jI=;
        b=l0Ivh6k1hHOWp27aN1FC1UGr9z5D9KkyZHjq5kDFJIDBy8UxGFlJMPxguBh7y/w5FK
         0aPX2G83EEheOKQzXWcpBIxsn2rnYtlEzruXfY+wnAy1HXFqVOaZKW02KDUt8gYVbgAY
         ph3nhx5avGCK6EDK5GvHh5Wv+9kHFsc1iRi8dNPzVBimWsiTp/OfRJYAD4B9vqFeN/zU
         bSReNbwxoBxrxanaBhK7TzyhrEciA+QU3DmPTplgz+12S40R+96Yad6QwprfxdRZb3gH
         jkUkk2o6v89BUB1RycNGEL7hmY1jRDiCgaeP4jFnkf9/zSoCXQsejaTShfZ3wCAEdFR+
         5XkA==
X-Gm-Message-State: APjAAAUlL+nrpzPsWDPNBLdegYbEZuOjr/ocgpswBPGgBJ1/yDh2X0Ur
        QpQlFeLQfZveaJO3A5nssKDmtdDI
X-Google-Smtp-Source: APXvYqz51rlmwWJ0haKM8EX4bws4mViTVxRG7/fzfSoObbA2bz0/oLIUHo4DTCwy6d6vJw7He5s0ow==
X-Received: by 2002:adf:cd90:: with SMTP id q16mr8080155wrj.75.1553306050911;
        Fri, 22 Mar 2019 18:54:10 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id y192sm25433050wmc.6.2019.03.22.18.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 18:54:09 -0700 (PDT)
From:   marek.vasut@gmail.com
To:     linux-pci@vger.kernel.org
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH V3 1/6] PCI: rcar: Clean up remaining macros defining bits
Date:   Sat, 23 Mar 2019 02:53:54 +0100
Message-Id: <20190323015359.7231-1-marek.vasut@gmail.com>
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
---
V2: Bundle this patch with other cleanups before resending
V3: Add Wolfram's R-B
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

