Return-Path: <SRS0=NVP0=BB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABE2C433E3
	for <linux-pci@archiver.kernel.org>; Wed, 22 Jul 2020 02:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0DE207BB
	for <linux-pci@archiver.kernel.org>; Wed, 22 Jul 2020 02:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595384724;
	bh=eVOprm8ofDWM/fAVq42WQQt2FAu7qxrF+5fVjVXoZ/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=myvanKeEGW2HcOfIixDwQMUy+4TUBUh9RfjS6kv5tjtr5hMhZ6aRGJyLKu1kuLyTw
	 lBZYAO4gHs5LGvVcSe7bFOH/6lEGtHBIBys3HcCdp2XhD7NpW307XrrTp3Kxke0Xf8
	 twrMqhBdHE1XPdkw/E+GyCoylQZRRz3fzA/JsVuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbgGVCZX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 21 Jul 2020 22:25:23 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45876 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbgGVCZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:25:22 -0400
Received: by mail-io1-f68.google.com with SMTP id e64so834833iof.12;
        Tue, 21 Jul 2020 19:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MyXhb4el16fajsxGsXz/wV6IH5NaMinhka6PcK2IANE=;
        b=qrr+FpfT7oLgY3e7or7JTQnxKT9pSx7ytwFZX3pMH4/Wxdk8JZt0CuiOOQHVP1GTp0
         6ukKsWnjKWEEekt+/vlPhdIqJOmi8Nju/Q96+6IpZCohPOBkn5QUYxkAFrQXpaBL/p+8
         vGZhe1eVvOpRgpkqowMgc08b4DB2zYPrBO5R+y/8/L64cZn7/2O9zzDLG305hq16mcd5
         PqAKGHrkxGmyawQH+jC75IUowqfp/8pHZpj1XtoPjOLurdRauiHVJI33NJaZz9d481n3
         rGhCl3uIQych39yKjx/zCMiCSj8FZBHUPV+UGHZruUzAUJ2zTYoL/Gr+eren6GMCGs02
         VHYA==
X-Gm-Message-State: AOAM531t6Ylvoa4M5M2xekJF5PCVpc/xMhr8jJ8UXSfqxu3rd5r9zmRX
        +NzavfKlbeN89wM4vTsQKg==
X-Google-Smtp-Source: ABdhPJw9sjN4i3hv+EUnrvTU0N7EMYRicG7AaP+J+lzghrPkKVyl1hYVs6jl+PQuS8VRc9FqhQnCxg==
X-Received: by 2002:a5d:9c44:: with SMTP id 4mr30944438iof.15.1595384721474;
        Tue, 21 Jul 2020 19:25:21 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:25:20 -0700 (PDT)
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
Subject: [PATCH 01/19] PCI: versatile: Drop flag PCI_ENABLE_PROC_DOMAINS
Date:   Tue, 21 Jul 2020 20:24:56 -0600
Message-Id: <20200722022514.1283916-2-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722022514.1283916-1-robh@kernel.org>
References: <20200722022514.1283916-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI_ENABLE_PROC_DOMAINS is only used on powerpc and doesn't do anything
for the Versatile host driver, so let's drop it. I'm not sure how or why
I had this to begin with. PCI_ENABLE_PROC_DOMAINS was never used on ARM.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-versatile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index e90f0cc65c73..6e55cc59999b 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -153,7 +153,6 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	 */
 	writel(0, versatile_cfg_base[0] + PCI_INTERRUPT_LINE);

-	pci_add_flags(PCI_ENABLE_PROC_DOMAINS);
 	pci_add_flags(PCI_REASSIGN_ALL_BUS);

 	bridge->dev.parent = dev;
--
2.25.1
