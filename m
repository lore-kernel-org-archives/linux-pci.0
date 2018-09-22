Return-Path: <SRS0=8Jd2=ME=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C3DECE560
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 15:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E0221569
	for <linux-pci@archiver.kernel.org>; Sat, 22 Sep 2018 15:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLvE2nLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E0221569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeIVU4u (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Sep 2018 16:56:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45657 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbeIVU4u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Sep 2018 16:56:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id a17-v6so979592wrs.12;
        Sat, 22 Sep 2018 08:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DZiw9OxUqgjwjzsohLWN5Zt9l6Ymn77fLpCnW3VY9O4=;
        b=FLvE2nLpnjVDvSsL4A1+b5HoTlkVeZp6HJwM20ruXCqn7ULeJvB6QwBO5j+pEuW6Zw
         4rxs2Plzirqs1ECr61d5X+9bdLCLl0Yb2TFJVqcHhZpPUAXIMg5zafKOdAB6g2nY6I9C
         Gj4oQa7JxO3KvSMBxw5lj/7YiD6LMMMhzOaf7UxNSM8r0cv5TwBKXuKzcnoG/UgrI7SR
         QVNF50bap4CmNpRLD+xxJievSvv5ncWknwOb4TIJmlYltr5lhdt1VgwNwUpnT8RxxEyW
         TleSdwC1GbeJ/56lrozvof5IcULO34k75fOgxuyTaTAJAa3ySr5X+m3U/UhLs6Ot0vio
         IITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DZiw9OxUqgjwjzsohLWN5Zt9l6Ymn77fLpCnW3VY9O4=;
        b=sAkuxJeGGwlxQ7DtiLHdcBKKHuYhivj/4qqhKoz3Qg7H1YFtNwR7MAavHb7+4nW2Vh
         V1nMocYAxTPRlqWFC10voknHPwS/LipqPY9VAfaqUtmKjqd00j1VBePG5YUf2v741UrO
         //lB7JQv9PlohU39vdUvI99eRXfHKaLNcZjh0H0x6kREO/QCwd+PnS1O8xxJlObj4TBe
         y1qHFYcse03qWGm/x+OQMaPpNaTQls6QJpbTggqYAXMI/wexrQAD1aSbckb6Io2jah0S
         vMr8KNyEAjfEfgLVDpEVwNSBLUAilH8ysZz1FAumCwP88nih141mSNhbGHa3QR7n5q4A
         W89w==
X-Gm-Message-State: ABuFfoj9lZOVZMIEBGcNHPo0QHxWwUyt5NsU0yvcOxFnGdh5AKHLpcFy
        FgOSMCGiJmMPLGCj5/VJGIMco7qu
X-Google-Smtp-Source: ACcGV60JRVffOXd48F4aGk3SxuKxqnkW8QWtWVvZ1xLmW7traJPyh7uoDOq15HalYFnvvc0a3TgECA==
X-Received: by 2002:adf:f842:: with SMTP id d2-v6mr2162950wrq.172.1537628575192;
        Sat, 22 Sep 2018 08:02:55 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6419425wmf.12.2018.09.22.08.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 08:02:54 -0700 (PDT)
From:   Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, Tho Vu <tho.vu.wh@rvc.renesas.com>,
        Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] DT: pci: rcar-pci: document R8A77990 bindings
Date:   Sat, 22 Sep 2018 17:02:52 +0200
Message-Id: <20180922150252.18754-1-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Tho Vu <tho.vu.wh@rvc.renesas.com>

Document the R-Car E3 (R8A77990) SoC in the R-Car PCIe bindings.

Signed-off-by: Tho Vu <tho.vu.wh@rvc.renesas.com>
Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index a5f7fc62d10e..5f2f9e380efb 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -9,6 +9,7 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
 	    "renesas,pcie-r8a7795" for the R8A7795 SoC;
 	    "renesas,pcie-r8a7796" for the R8A7796 SoC;
 	    "renesas,pcie-r8a77980" for the R8A77980 SoC;
+	    "renesas,pcie-r8a77990" for the R8A77990 SoC;
 	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
 				     RZ/G1 compatible device.
 	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
-- 
2.18.0

