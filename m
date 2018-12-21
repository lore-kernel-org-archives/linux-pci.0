Return-Path: <SRS0=Xdj1=O6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C69C43387
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4285921903
	for <linux-pci@archiver.kernel.org>; Fri, 21 Dec 2018 07:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPCt8xVC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbeLUH1k (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:27:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44930 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbeLUH1k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Dec 2018 02:27:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so2096345plt.11;
        Thu, 20 Dec 2018 23:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOc0ZMWuA+wm6aVDJRuGECq2GcrB/9tzKOsAAmB0XOw=;
        b=TPCt8xVCVDNxQebkP1nin8NzBDcA1ymLh+qmgaDZK2/R84wnC0MGL83O2AbRWUOMIl
         aBz+6aVlXOFXp87rfma2dUDM7+FQhc/0kNuzxmMs0aojYjVMlulbqZH972LaSDHUaR3t
         QWdxj4ms/Hqvayzoyuy4YlyJ4OLZP5BixfI6GlXQtL+7RegjwPqIVOJPYTouv1H0T5b+
         5jiJBS+SI1eP2mSf4dbyd3Bv7MpN3YIP51YYOP5PuxYWALLGPM8fNEg0CdVWAw/SrKGw
         LUSgAkc78RNyeNHrAExKXm8zzBtGaxLPB8ZQ/NmI+saNZAif8Rm5Zxfqbys0PDMuhohf
         c4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOc0ZMWuA+wm6aVDJRuGECq2GcrB/9tzKOsAAmB0XOw=;
        b=Tug9pO7nwi6O7T4vnX9ZQDN7RFmvW85Q9cZrWLYsVIrx3EkiNKVLYJEqHtP8Qvk9cF
         hztYrVTGdcz9u6meCmT8qBy1Qs+0+2a9btOhAum4cT5UgJFToexGJU6wlctdibZQb4bL
         pymRKBjJ7cQRGlixL/ML0ph3EALjt9WSqR185b2M/VCBOxFXsntECD9MtLJ/EoIe8ktk
         4Ucy9fPyRu/epPKzePUJBCi5TwMOqVDaWKyj6X+9VhCIYLoYKztl7QWuJ+wwLeGP8R0q
         3PbVduR6fa1IgmAHG7tS/v9vsJdmjJ09/hLJHWekDEAw67sxuKRmbsglYlhf7MMGhtla
         ySLA==
X-Gm-Message-State: AJcUukdq6017qwfLeSe/YqhPfGrbywCHlqxmYFHaND7I+UPDpBndNvFY
        YJm1tZM9VYAH7Pnu+9iq35+y0rU3
X-Google-Smtp-Source: ALg8bN7yfpjuiwJOykG2+SWyVOxDLnQslYnPFMp5CGu0sCI/4m5T4u96cgAQER5ge0VU9qEafNlb7w==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr1405913plb.169.1545377259137;
        Thu, 20 Dec 2018 23:27:39 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t90sm44971921pfj.23.2018.12.20.23.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 23:27:38 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/21] i.MX6, DesignWare PCI improvements
Date:   Thu, 20 Dec 2018 23:26:55 -0800
Message-Id: <20181221072716.29017-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Everyone:

This is the series containing various small improvements that I made
while reading the code and researching commit history of pci-imx6.c
and pcie-designware*.c files. All changes are optional, so commits
that don't seem like an improvement can be easily dropped. Hopefully
each patch is self-explanatory.

I tested this series on i.MX6Q, i.MX7D and i.MX8MQ.

Feedback is welcome!

Thanks,
Andrey Smirnov

Andrey Smirnov (21):
  PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
  PCI: imx6: Remove redundant debug tracing
  PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
  PCI: imx6: Remove duplicate macro definitions
  PCI: imx6: Remove PCIE_PL_PFLR_* constants
  PCI: imx6: Remove PCIE_PHY_RX_ASIC_OUT* constants
  PCI: designware: Make use of IS_ALIGNED()
  PCI: designware: Share code for dw_pcie_rd/wr_other_conf()
  PCI: imx6: Drop imx6_pcie_link_up()
  PCI: designware: imx6: Share PHY debug register definitions
  PCI: designware: Make use of BIT() in constant definitions
  PCI: imx6: Make use of BIT() in constant definitions
  PCI: imx6: Simplify bit operations in PHY functions
  PCI: imx6: Simplify pcie_phy_poll_ack()
  PCI: imx6: Restrict PHY register data to 16-bit
  PCI: imx6: Pass data to dw_pcie_writel_dbi() directly
  PCI: imx6: Use common mask in imx6_pcie_reset_phy()
  PCI: imx6: Simplify bit operations in imx6_setup_phy_mpll()
  PCI: imx6: Remove magic numbers from imx6_pcie_establish_link()
  PCI: designware: Make use of GENMASK/FIELD_PREP
  PCI: designware: Remove superfluous shifting in definitions

 drivers/pci/controller/dwc/pci-imx6.c         | 151 +++++++-----------
 .../pci/controller/dwc/pcie-designware-host.c |  61 +++----
 drivers/pci/controller/dwc/pcie-designware.c  |  18 +--
 drivers/pci/controller/dwc/pcie-designware.h  |  60 +++----
 4 files changed, 116 insertions(+), 174 deletions(-)

-- 
2.19.1

