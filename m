Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59618C43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAFA20879
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J++HdVaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbfDAE0P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:26:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37060 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731733AbfDAE0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 00:26:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id 8so3885773pfr.4
        for <linux-pci@vger.kernel.org>; Sun, 31 Mar 2019 21:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mazOhM/Ixdx4XrIQEzfQUJQ6M0vk6dsGZPlsezBBEYs=;
        b=J++HdVaFD5MxBTo9R9V3p0ngV9ndVJjPlu1SM+uHPfvjz1Q6vzQtOFVU2+iHI54wvL
         9TlZ1BnXCyRE7Mr0mA1J9lqEbxzFaCUJVJEHJIMiVivjiV+vutyaDXuiW2TtQpWVXr/g
         2S69fh2Z9qNzjL42qC0xSz6g+PZXqq8peUsjxZn1P8miABNHoHJbYc6/agl/8b3xbsPf
         EWBydgsNvR51kZS2Ec+bAPu78Lg8w6gATKHnGuONftzKqW3R1vPpJv9pvkmBOD/Wk+i8
         Xpy5PjSqXnadiHptiZ9poFoWId9jdLF3TJC4CkEvV3M0m9o0DBTABsdk8HtcHlUqigV+
         rqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mazOhM/Ixdx4XrIQEzfQUJQ6M0vk6dsGZPlsezBBEYs=;
        b=QO0gyBTrlTj+czVqtGD+CeLLKNIHSDMxtnjV3PlvFRt6Eo0Wg98mpDFGfpw90HvD9m
         kz4Gc34XhmvNdBAownwfQRQY3hEdu9jeGZ9pujuk2iWcNAPU4ZODCDMQHiMtBs3WIO18
         8LLgtKicSvmNAj2mt7BXh/J8eLC8jbq52JwmY1Ioa+GJrRcJpEbvbLp5Xq7kbJdGlYsj
         +OiIfwHTZm7J1pzpO7Oz+mWzS9VGrevurYMhuyBwfgIn0AAI+Zbc6YoxIlpEY/dJxyXl
         j9q2lBkKZZ4d9c0Vp25w5P7pWIW1f7rh7Md6ZFyMsj9KW58k6cO4KXsR1cpptPmMurrl
         ZQPw==
X-Gm-Message-State: APjAAAUqrRLZY90OqKG3vUiqGioiHBROstoy5iL66+wFw8szymKhxNYr
        /8vCXyFMagrvDbqjfZr9tEEAKfMW
X-Google-Smtp-Source: APXvYqxuZh0KscYmqFTKXUnjJ0fdaQwV0wM//Zt1xhJnz+EgMAElu50FQ/fmsfVZ/n9DS+dINwAR/Q==
X-Received: by 2002:a63:e051:: with SMTP id n17mr58367463pgj.19.1554092774562;
        Sun, 31 Mar 2019 21:26:14 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t22sm10996829pgu.45.2019.03.31.21.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:26:13 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH v3 11/11] PCI: imx6: Replace calls to udelay() with usleep_range()
Date:   Sun, 31 Mar 2019 21:25:47 -0700
Message-Id: <20190401042547.14067-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401042547.14067-1-andrew.smirnov@gmail.com>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In both cases udelay() is called in non-atomic context, so there's
really no need to use it there. Change the code to use usleep_range()
instead.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c9431a8a7ca1..3f13022991ec 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -167,7 +167,7 @@ static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 		if (val == exp_val)
 			return 0;
 
-		udelay(1);
+		usleep_range(10, 100);
 	} while (wait_counter < max_iterations);
 
 	return -ETIMEDOUT;
@@ -449,7 +449,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		 * reset time is too short, cannot meet the requirement.
 		 * add one ~10us delay here.
 		 */
-		udelay(10);
+		usleep_range(10, 100);
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
-- 
2.20.1

