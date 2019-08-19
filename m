Return-Path: <SRS0=MDMf=WP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C638C3A59B
	for <linux-pci@archiver.kernel.org>; Mon, 19 Aug 2019 06:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D01D2086C
	for <linux-pci@archiver.kernel.org>; Mon, 19 Aug 2019 06:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCnQuB/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfHSGFh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:05:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39248 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSGFh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 02:05:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id i63so479186wmg.4;
        Sun, 18 Aug 2019 23:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mN/6XEGXs1kDZ4ZZjwlZYjkzDXusecI2C8l+7vO+fpo=;
        b=rCnQuB/Hv2Iu/iQaR2QfbZg/dmc+0Ie1bTnG1qIJ6xGg4EMNkcAuY+uJ6E0LZ6fuxL
         Fth5VOWzdTnVr88F56jmTO66pP5rEzaCofrCffDm/ncTS021lpYAXs1bLsrhI4Ux5KFW
         4RXr9aOxTnjA0Uw3jtVGXLKxx+15voHhW6n018cRS2eDKAubVE+HPPez4O3Mqz5ZCHZ5
         W2UKZgFZIxP0Tc4552APoD/BB1oROrFtV80IafSfOko5I6INp4kBXMDvrtOubTy2UE7f
         2O3TbDv0ayl1FEJDXOSBk0+ciMw5jufv/u4rFmGDL8OsidUX9FW8dVY4ntReGCFo8bIu
         YLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=mN/6XEGXs1kDZ4ZZjwlZYjkzDXusecI2C8l+7vO+fpo=;
        b=W+8GtkycxVrQ392Q9tjLJWtG64ZOjnXVUW82T5J04lRQ/wspt2ToqKPgRgEYuGw0kV
         3/3Tzk6YHt7FlQn0OQIE3GR3OIEWO6jQh41HC1z03QSey4jiFjiu400RLfjGZbCf/dWO
         TV5JukHLq2N6DVpBcrk32zZkj+f6nKDMK/pGmCkFPomuQcu0IKYIAfTpt5yKtf+ABuq+
         q4Eqsi0EyDPWNMxaScMDCMFAUCyeJOIKXJS9BFrx7aMX/J/NG/Rw8pIigF5uzVHWegtY
         001gDZlDzJ3tTHVX9DPdIaUf4jdLetOP4cLzJ03GHHytLcCMFjUeHV+OnLRhBygiRHqF
         Ovhg==
X-Gm-Message-State: APjAAAUNwyi++jaAplr4ZOWFevsiBRxkjsgLpHRHuKBkzHt637p6WY++
        JZPFkLaFopbI8LgrF0vdJA4=
X-Google-Smtp-Source: APXvYqymEXzkOa+YoBfDufeIGWG8/FhZz0bW9SAFAOGUhem1uA7FgJXnnfTf2dAityZ+m7zQSDiMVA==
X-Received: by 2002:a7b:ce02:: with SMTP id m2mr5780294wmc.7.1566194734848;
        Sun, 18 Aug 2019 23:05:34 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aef41.dynamic.kabel-deutschland.de. [95.90.239.65])
        by smtp.gmail.com with ESMTPSA id m23sm22282503wml.41.2019.08.18.23.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 23:05:33 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/PCI: Replace deprecated EXTRA_CFLAGS with ccflags-y.
Date:   Mon, 19 Aug 2019 08:05:32 +0200
Message-Id: <20190819060532.17093-1-kw@linux.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update arch/x86/pci/Makefile replacing the deprecated EXTRA_CFLAGS
with the ccflags-y matching recommendation as per the section 3.7
"Compilation flags" of the "Linux Kernel Makefiles" (see:
Documentation/kbuild/makefiles.txt).

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 arch/x86/pci/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
index c806b57d3f22..48bcada5cabe 100644
--- a/arch/x86/pci/Makefile
+++ b/arch/x86/pci/Makefile
@@ -24,6 +24,4 @@ obj-y				+= bus_numa.o
 obj-$(CONFIG_AMD_NB)		+= amd_bus.o
 obj-$(CONFIG_PCI_CNB20LE_QUIRK)	+= broadcom_bus.o
 
-ifeq ($(CONFIG_PCI_DEBUG),y)
-EXTRA_CFLAGS += -DDEBUG
-endif
+ccflags-$(CONFIG_PCI_DEBUG)	+= -DDEBUG
-- 
2.22.0

