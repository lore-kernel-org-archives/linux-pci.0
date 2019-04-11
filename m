Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9971FC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 04:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 629FA217D4
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 04:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdsT6kda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfDKE2N (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 00:28:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38331 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfDKE2L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Apr 2019 00:28:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so5376553wro.5;
        Wed, 10 Apr 2019 21:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=txS5K0t/babaX0UQdaUfV/KGVtvAv9X5zQGn/++TGrg=;
        b=LdsT6kdaBTy2aZHxulrRPGENURohhTDEn5wKVqlS8HIqq00zyT9lC4vx5tfVWIKDbq
         WbhYZcyVIkxcFicA7F8+WJonkXACTnVHAkrwu4jj2pZzfqu6c+Ani6w30XGCevJLxRku
         XjZfuyZiRVuK3tDEzphD+Cmx78LOBu/id7XSKggI+exjXi3aYBmhbw/gP/8kjKLYYyzN
         71dH1v8qol/xb/FLU22ZAnsdZ/BjcjYzJXl9iFB/dDxQG2EY3AFrhnmGz1Gcs4TTjZ2a
         QWGpHcHJzDBrXO+wRR5m3FXqxLBMWMJ4Vhw2M922tr2B3Nh0oJllTquvxXxrZEViCO/W
         B8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=txS5K0t/babaX0UQdaUfV/KGVtvAv9X5zQGn/++TGrg=;
        b=KE6f1uwGoM8qfPgrWX3hThC1NhkAnWrpVAiOsyeRyyRreIPWoeV7hNz16WjnhB7jL7
         BAfuaZTqTnju0ODPv2dZJ4TjGD91FJXtB59SIWMAuaS8HBSgCaAh5HnyxLz/QJK8LCR4
         u3vxEXoCRkRBZJsYjkJ9gKdOfjhh9FXMi1CNd7d6VzOAl3PRvDaWkZMux/5bYB5qNEmq
         Sf9j59IT+GWkWKizDscOy/OtlmpCg3mMXO+EsYg6f49+6afAJqks/z0fbUUK2bqYRvsU
         +uLDRDLg/J231UVVuc3Qg8Tbzol4KwR/G8fsg9L4blsePbGvyZIuwdGOcuzoNLYTlQBD
         u4Tw==
X-Gm-Message-State: APjAAAXMp/7aN00xYKjOwr9fxtpi1kjPjrRQl0O/PowEGaU30qb5zRCQ
        FZ0XOOo8iAAu1xWs0kFoE10=
X-Google-Smtp-Source: APXvYqx3xvbhrM2S93Nr5TbEahE4hspgM2cJxcCwnO1V1Q0oLSVQVl8o9wriOtqqeqr23tjvO6L7VQ==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr30217032wrm.225.1554956889461;
        Wed, 10 Apr 2019 21:28:09 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2da5:5700:805e:d3ab:f95:5de])
        by smtp.gmail.com with ESMTPSA id 204sm6376153wmc.1.2019.04.10.21.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 21:28:08 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: Update remaining @linux.vnet.ibm.com addresses
Date:   Thu, 11 Apr 2019 06:27:52 +0200
Message-Id: <20190411042752.22039-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Paul McKenney attempted to update all email addresses @linux.vnet.ibm.com
to @linux.ibm.com in commit 1dfddcdb95c4
("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com"), but
some still remained.

We update the remaining email addresses in MAINTAINERS, hopefully finally
catching all cases for good.

Fixes: 1dfddcdb95c4 ("MAINTAINERS: Update from @linux.vnet.ibm.com to @linux.ibm.com")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---

Tyrel, please take this patch. Thanks.

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2359e12e4c41..454b3cf36aa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7439,14 +7439,14 @@ F:	drivers/crypto/vmx/ghash*
 F:	drivers/crypto/vmx/ppc-xlate.pl
 
 IBM Power PCI Hotplug Driver for RPA-compliant PPC64 platform
-M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
+M:	Tyrel Datwyler <tyreld@linux.ibm.com>
 L:	linux-pci@vger.kernel.org
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	drivers/pci/hotplug/rpaphp*
 
 IBM Power IO DLPAR Driver for RPA-compliant PPC64 platform
-M:	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
+M:	Tyrel Datwyler <tyreld@linux.ibm.com>
 L:	linux-pci@vger.kernel.org
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
@@ -10388,7 +10388,7 @@ F:	arch/arm/mach-mmp/
 
 MMU GATHER AND TLB INVALIDATION
 M:	Will Deacon <will.deacon@arm.com>
-M:	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
+M:	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
 M:	Andrew Morton <akpm@linux-foundation.org>
 M:	Nick Piggin <npiggin@gmail.com>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.17.1

