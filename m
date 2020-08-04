Return-Path: <SRS0=QtGK=BO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2E7C433E3
	for <linux-pci@archiver.kernel.org>; Tue,  4 Aug 2020 11:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C94342086A
	for <linux-pci@archiver.kernel.org>; Tue,  4 Aug 2020 11:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596542357;
	bh=u2oXaoc7c+xMcnLIk0vwD7jCP4vTDO56YfP1bb9hufI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qWKnDuWP4hC+bkfPfjqM3OUhJs0LRI9+0Ximyh5Rx+EBDY8UobOJvx32pLykaOKrU
	 1Gg0Zt96l1g/IL/KCe/yt+AbOqfcPPVbcEn9b3JGPUvIAXD0ui9s1l3JZojkxNQY+M
	 TEN0WxvCyMqQH4gMhDTNjc0SLH1yOuueZugX8Tjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgHDL7Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730413AbgHDL6E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 07:58:04 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A90FF208A9;
        Tue,  4 Aug 2020 11:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596542283;
        bh=u2oXaoc7c+xMcnLIk0vwD7jCP4vTDO56YfP1bb9hufI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfG7DuDLq+xepRSrnpwffkwaB9c+AuW3vEtLJ7a1ASMIvzJXS6EjaqlcRdeszZ9ay
         CQiX0cnV3NKlzVsw6qGj7NjH7L8uT0iLiMA6lm5vbi43h8Kzw6/aHLJ/faIS86MWOy
         w+FEUg7Pw3f2VAw8fP/eVXPXYomKpzmmEywdfO/k=
Received: by pali.im (Postfix)
        id F08587FD; Tue,  4 Aug 2020 13:58:01 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: [PATCH v2 1/5] PCI: aardvark: Fix compilation on s390
Date:   Tue,  4 Aug 2020 13:57:43 +0200
Message-Id: <20200804115747.7078-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200804115747.7078-1-pali@kernel.org>
References: <20200804115747.7078-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Include linux/gpio/consumer.h instead of linux/gpio.h, as is said in the
latter file.

This was reported by kernel test bot when compiling for s390.

  drivers/pci/controller/pci-aardvark.c:350:2: error: implicit declaration of function 'gpiod_set_value_cansleep' [-Werror,-Wimplicit-function-declaration]
  drivers/pci/controller/pci-aardvark.c:1074:21: error: implicit declaration of function 'devm_gpiod_get_from_of_node' [-Werror,-Wimplicit-function-declaration]
  drivers/pci/controller/pci-aardvark.c:1076:14: error: use of undeclared identifier 'GPIOD_OUT_LOW'

Link: https://lore.kernel.org/r/202006211118.LxtENQfl%25lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 5169a9851da ("PCI: aardvark: Issue PERST via GPIO")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 90ff291c24f0..8caa80b19cf8 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
-- 
2.20.1

