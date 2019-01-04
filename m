Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06743C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA87521872
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 17:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXlHtoMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfADRtm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:49:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38356 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfADRtl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 12:49:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so17783274pgc.5;
        Fri, 04 Jan 2019 09:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3a4KVHdFpZohLc9Lz0HnZk5LDcrQaSTNBzc6TtIUt+E=;
        b=KXlHtoMTt9xiPy9mkkBCnREitHoOvmNi3nEYJnY1KF6Wtvu2QXFoMlw3o/jb1G+cBP
         81VHnVuQ4i1zpwy6zO3TQpnDEB+Jadp9ad89dUBhOk5oq0pfhpsnP7ks24u29pwoNjXg
         ks/Ucrp1Al/jdqjQy/zys1umYamaiHZ+uZwKWXVK6uk8cmzKL6ign7mOpLpI1Oo3Uzt6
         d55FgDfUoYru7h3YYmsWRyPemcxvkPLfTRk+u7znuGnvX9gdoZqC1Q4chX482Guu2wD7
         0i2U8Il3u8HFbzaFqe1oDumVsqbCJ4wHbRCtj1ssUDQJyMOo2WFa3ClZYDmjBryhWJIh
         H4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3a4KVHdFpZohLc9Lz0HnZk5LDcrQaSTNBzc6TtIUt+E=;
        b=Z/BDpoFgs/ri8Xi95tTyHtr6OgpqZDmsHtNTzW9Ou40UPxtJYU+gC1hxFK6+jRiMM4
         pVy6gOmsfSYe9jd7c8Rp+2N/8AjwxyKhyNi6Fe7JFuxJJ5YMhswJ91LnqCp3Oixp/lZc
         zxWrPp1VlmkZ1pytXmOzfaYlny43kuL/cQAtk/UDGD1VF0W8v9ZBV+WMRs3wafUU5J9s
         9fERxeB6lA51hK5uDyvGf27nlEM2kBtzcdasdbzq1eR/pnjy6aVMOoy999+j6sAlSiEo
         M44ZPXXuCPSOUwrYnLptPNSbrv4I3PZRV2/8gkspug4Rya3oB4M85c1DaDfkiWm0TBfG
         jkQw==
X-Gm-Message-State: AJcUukcz5lV9MSsfvYdXVHzzUph29TiQo6z2mJ9jB/arnvjb4NRaQWE4
        Tw4azEv5Lj9ds3uLEaNgt7g13UwbX4s=
X-Google-Smtp-Source: ALg8bN6fYxRl67ezSLhygiOFXSew3F11dDLDHq2W1Wx8Hx85rr/zhQcpZAtYweuULUfI0dlqYCn7NQ==
X-Received: by 2002:a63:6782:: with SMTP id b124mr50197134pgc.151.1546624179336;
        Fri, 04 Jan 2019 09:49:39 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i193sm100699632pgc.22.2019.01.04.09.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 09:49:38 -0800 (PST)
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
Subject: [PATCH v2 00/20] i.MX6, DesignWare PCI improvements
Date:   Fri,  4 Jan 2019 09:49:05 -0800
Message-Id: <20190104174925.17153-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
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

Changes since [v1]:

  - Dropped "PCI: imx6: Drop imx6_pcie_link_up()" due to the matter
    already having been addressed by "PCI: imx6: Fix link training
    status detection in link up check" from Trent Piepho

  - Changed "designware" -> "dwc" for all subject lines

  - Collected Acked-by's from Gustavo Pimentel

[v1] lkml.kernel.org/r/20181221072716.29017-1-andrew.smirnov@gmail.com

Andrey Smirnov (20):
  PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
  PCI: imx6: Remove redundant debug tracing
  PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
  PCI: imx6: Remove duplicate macro definitions
  PCI: imx6: Remove PCIE_PL_PFLR_* constants
  PCI: imx6: Remove PCIE_PHY_RX_ASIC_OUT* constants
  PCI: dwc: Make use of IS_ALIGNED()
  PCI: dwc: Share code for dw_pcie_rd/wr_other_conf()
  PCI: dwc: imx6: Share PHY debug register definitions
  PCI: dwc: Make use of BIT() in constant definitions
  PCI: imx6: Make use of BIT() in constant definitions
  PCI: imx6: Simplify bit operations in PHY functions
  PCI: imx6: Simplify pcie_phy_poll_ack()
  PCI: imx6: Restrict PHY register data to 16-bit
  PCI: imx6: Pass data to dw_pcie_writel_dbi() directly
  PCI: imx6: Use common mask in imx6_pcie_reset_phy()
  PCI: imx6: Simplify bit operations in imx6_setup_phy_mpll()
  PCI: imx6: Remove magic numbers from imx6_pcie_establish_link()
  PCI: dwc: Make use of GENMASK/FIELD_PREP
  PCI: dwc: Remove superfluous shifting in definitions

 drivers/pci/controller/dwc/pci-imx6.c         | 139 +++++++-----------
 .../pci/controller/dwc/pcie-designware-host.c |  61 +++-----
 drivers/pci/controller/dwc/pcie-designware.c  |  18 +--
 drivers/pci/controller/dwc/pcie-designware.h  |  60 ++++----
 4 files changed, 115 insertions(+), 163 deletions(-)

-- 
2.20.1

