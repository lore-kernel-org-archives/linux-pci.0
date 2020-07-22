Return-Path: <SRS0=NVP0=BB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FB2C433E6
	for <linux-pci@archiver.kernel.org>; Wed, 22 Jul 2020 02:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975A9207BB
	for <linux-pci@archiver.kernel.org>; Wed, 22 Jul 2020 02:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595384776;
	bh=VRGvVTdJbSM4F9eRaTS/6225dLTcot9uGVshRUzLAGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gy60yIBDJLlxUHv8oA7GLIcyZmtz097bpkoAva6j4YV3P4ffBi9wABzRfvlqI4rGt
	 FsbUd8BtRJzR99GJGR/rOTu2jFdjHY3KvzKtLgIoc4ebIop98YcXLdoujTrLKZBkQ5
	 Hvca1nX18ta/NDv6XcPwe3tIa775bbu40CqMRdek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbgGVC0P (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 21 Jul 2020 22:26:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33139 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731782AbgGVC0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:26:15 -0400
Received: by mail-io1-f66.google.com with SMTP id d18so897376ion.0;
        Tue, 21 Jul 2020 19:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mTNQAve5povS8TrvE+0nUolFQg+WN5UXhl/Hn39DM0=;
        b=mhJIUs564W/k6Zl1h91JI0v6kol2+PqnGaeqsFQvb7JQlsfMlKgTbWrvDUZxkQi58z
         heMhdVPc1JB2WhLdmgAGOR4D0QiZtJJ8D7tYXd4lK+CqZiaa5QKaPq8EOj3RFCLjPUlR
         aXpmo6nXPvBzz2W0QJ+wXqhjURiEASIEWBbk0O4ex+vyAg2uinAoznN6Sh/f8ZbkCNjY
         QRsom6FEz48a0ZD7b9zYxRixJ3R5m5eRxbpelB8DZU8zJSKXsC1UeQiLWko5RAvMaC2u
         szOojDxgCGBRTAOcu5gTkqrE2/uVp1sKBxPrJC3x6jJnOJlQmUxPYv09XBNiQ1vXTGlG
         ur8Q==
X-Gm-Message-State: AOAM531/kRKuA6DiS5dR2Iu5YJtzfDdb0wQ81f9LsiDrpjBauGMavjvq
        rx9c7DFM3O6ULxEeLPjFOg==
X-Google-Smtp-Source: ABdhPJwBWgPlDrivNv7yM8QtASYvLdMFektK4ZjC00WS80MxFWmYcuAiL14q2J7bkLOOQkMyVsL6vQ==
X-Received: by 2002:a05:6602:2008:: with SMTP id y8mr24036196iod.69.1595384774572;
        Tue, 21 Jul 2020 19:26:14 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:26:13 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Will Deacon <will@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH 16/19] PCI: of: Reduce missing non-prefetchable memory region to a warning
Date:   Tue, 21 Jul 2020 20:25:11 -0600
Message-Id: <20200722022514.1283916-17-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722022514.1283916-1-robh@kernel.org>
References: <20200722022514.1283916-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pci-rcar-gen2 controller requires only a prefetchable memory region,
and the error prevents using pci_parse_request_of_pci_ranges() for it.
Let's reduce this to just a warning message so this function can be used
for pci-rcar-gen2.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/of.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 27839cd2459f..cfb940c8b399 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -564,11 +564,10 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 		}
 	}
 
-	if (res_valid)
-		return 0;
+	if (!res_valid)
+		dev_warn(dev, "non-prefetchable memory resource required\n");
 
-	dev_err(dev, "non-prefetchable memory resource required\n");
-	err = -EINVAL;
+	return 0;
 
  out_release_res:
 	pci_free_resource_list(resources);
-- 
2.25.1

