Return-Path: <SRS0=ryE9=CX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB599C43461
	for <linux-pci@archiver.kernel.org>; Mon, 14 Sep 2020 05:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C00F221E5
	for <linux-pci@archiver.kernel.org>; Mon, 14 Sep 2020 05:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJj3ssAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgINFbY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Sep 2020 01:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgINFbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 01:31:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6202C06174A;
        Sun, 13 Sep 2020 22:31:22 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id j11so21401217ejk.0;
        Sun, 13 Sep 2020 22:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4iEj3Ymg+Q2X4T+WUK3swUuww1ugyEhT/pd099TK5xA=;
        b=CJj3ssAF6khrs5ozTVp4L6Ss415aCOCMrFDlbHoNMHO9U4gnw5Am9by6vCskebJTb+
         +QcswmmXDx4qBkEvf1jxsqUfUcWZkjARK48x+miuRxG4WzKbLR+mGjCAO9vpFTY+FeRO
         A/lacMJlzLbANwGPal/RvlYKzjl2LDFw9rTHEpDsjoMsefNkvHCvH+nL7dyywCnxa27E
         B21knwKco680MbeO3P9ZYpfzp0NKQTSAw9Yhlf/p/hDm9pirzLNeEcG9PiswVTuSObX/
         mQOAyzMNTW6ZOVvlKYqeV9s7bqPz+X0JV3n1eWCwjBRg9kZ5hCkbaCKEF0+5uhIN2vdN
         89XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4iEj3Ymg+Q2X4T+WUK3swUuww1ugyEhT/pd099TK5xA=;
        b=c3ywlhlGLNLZw3xEFb5MZb4U+vL745PXSpRTNx2JvM0NG1xYn9ibuCDI8VFNnKncM/
         YSYibXwSTrn9Y7mL4TBPNEeNx/zmM5meWgBFr5m9iOBSLgtIYL8Ysx9Hs5c751Dk2qr/
         elYut8tI2oJC67nrpsYXfwXj8PUVAulcC7FkfUNL2l8/fbdt1YyWpYp5nSYw/AVGuTM6
         +8CB7unKuZqxxvRlS5Xt4jJ1cukMgYgY5kB7JKceMytNfn75KZYyh8bNKcZP59iXumcG
         O9kf6+J9bBaQftBX843mvOEccbkI7b9Mauub9zp1sQhAGlkoy7avo+fCXxPiHs7fXrd/
         /gLg==
X-Gm-Message-State: AOAM533f3u2zSWLDPJkeHmRDhi/j+d6qXD26Wdp/a9FTwYuM1/GoQp6i
        eZQKw/sZ+BYD94iOatKMKSs=
X-Google-Smtp-Source: ABdhPJxQxGiCt0yzJvDaLuwuSh0m3eOndl420ZgNpGK1OQK3o7FwX3Yve4lC3a+U+Sq5/Wo82bXZlg==
X-Received: by 2002:a17:906:4c89:: with SMTP id q9mr13534240eju.290.1600061481445;
        Sun, 13 Sep 2020 22:31:21 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2ddc:3000:7936:d9d0:986e:cca5])
        by smtp.gmail.com with ESMTPSA id k1sm6687958eji.20.2020.09.13.22.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 22:31:21 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: make linux-mediatek list remarks consistent
Date:   Mon, 14 Sep 2020 07:31:10 +0200
Message-Id: <20200914053110.23286-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 637cfacae96f ("PCI: mediatek: Add MediaTek PCIe host controller
support") does not mention that linux-mediatek@lists.infradead.org is
moderated for non-subscribers, but the other eight entries for
linux-mediatek@lists.infradead.org do.

Adjust this entry to be consistent with all others.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on v5.9-rc5 and next-20200911

Ryder, please ack.

Bjorn, Matthias, please pick this minor non-urgent clean-up patch.

This patch submission will also show me if linux-mediatek is moderated or
not. I have not subscribed to linux-mediatek and if it shows up quickly in
the archive, the list is probably not moderated; and if it takes longer, it
is moderated, and hence, validating the patch.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5e6e36542c62..83c83d7ef2a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13485,7 +13485,7 @@ F:	drivers/pci/controller/dwc/pcie-histb.c
 PCIE DRIVER FOR MEDIATEK
 M:	Ryder Lee <ryder.lee@mediatek.com>
 L:	linux-pci@vger.kernel.org
-L:	linux-mediatek@lists.infradead.org
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/mediatek*
 F:	drivers/pci/controller/*mediatek*
-- 
2.17.1

