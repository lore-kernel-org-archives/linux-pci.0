Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01200C10F14
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C182920870
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZWcBo51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbfDOAr6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:47:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44232 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfDOArm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 20:47:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so7677660pll.11;
        Sun, 14 Apr 2019 17:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VaYvWVwzOkdBmgVwNCUSm0J2jSP5fZYz6kavihb0vk=;
        b=KZWcBo51AOew8nyqaGo3kd7C++QD9lIb/qtq2eBsUf2OxzI/HIRTAxSd5PuLV/2T4g
         KvqA7KLH9VpIWqLe4L+zQpYzReb4UUTXvGatEzbDJwTHeHB7jcjppZpT5Be8uO1KfLCo
         UprxIIZf//kePk7Zz7oHDmNZxJhqfeebTTi5AV32XhKSbosue9+csmaDTmU4IErNhhMs
         kchMvx3aa+z+6dFeWYXDcJNrhcK2xCogY1W3+UMzBNmQM2/yaAwUsEODpvpJqB3JIjNr
         zdsHsd9RRJE8I7znrw5HannwTPEls8gqxfwjxGperLfJ+cuHs4/xwgoMkuzZmkGVbhRW
         dFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3VaYvWVwzOkdBmgVwNCUSm0J2jSP5fZYz6kavihb0vk=;
        b=So3IB1UADYpZuky1osRB0HyifJa8Rnth1oWvO2Sth2i8j2oyIyNoda/mhfwTqbiGKQ
         7aQW5BCVq4bV508WZbfOFd/sJuo8ilPaNJpel3B6Nlxy9EqfCTfArI/IueUEiIhxhtSD
         fZItC7FUiGfa2TuQb+woW31FtzPmGss8+GBJMQqU9Lbq2e+R8CGKm1ZlPwri+RL0pbF1
         87MQJo1skGJQOK0d1s+s24Vf/q6VMsKwMx3RYHmgqcwIDhbvXNO+TaJUrpztzGSZatCB
         mQfjvrdsFhzWMPYyuJMeGTheLIym1QwhbDajUavNCUcFsM52yYmUAqvIbgYhFCugMy9a
         /89g==
X-Gm-Message-State: APjAAAWimSIaylUQ97MRFOohFJZucf2N4TCxNennIQX64BMXiVc9w0EZ
        xmb5O0clZ0mSEdyZbidxjQyE6w9J
X-Google-Smtp-Source: APXvYqz2zECm3zq6MDJMmsxC6n9r+1USMjhRz7oMfT9xqxy4W8H/wJJwDZgoFSCbeDn0YQsblUmoGw==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr72889689plr.251.1555289261729;
        Sun, 14 Apr 2019 17:47:41 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u17sm66111981pfn.19.2019.04.14.17.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 17:47:40 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/11] PCI: imx6: Use usleep_range() in imx6_pcie_enable_ref_clk()
Date:   Sun, 14 Apr 2019 17:46:32 -0700
Message-Id: <20190415004632.5907-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415004632.5907-1-andrew.smirnov@gmail.com>
References: <20190415004632.5907-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

imx6_pcie_enable_ref_clk() is never called in atomic context, so
there's no need to use udelay(). Replace it with usleep_range().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3e45f49b8a4f..c6d6bde4d860 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
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

