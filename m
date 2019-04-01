Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D02C43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFAA20870
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 04:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDc76Jl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfDAE0A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:26:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37000 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfDAE0A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Apr 2019 00:26:00 -0400
Received: by mail-pl1-f196.google.com with SMTP id w23so870387ply.4;
        Sun, 31 Mar 2019 21:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Ji7Xwi4CX455TTm7FFnww+qNo0h+6JrE6lrT1VdynY=;
        b=BDc76Jl3PoyoLKFPdcJaMp7O95LaPSgoitZ1Rmeecx4zQsHxdqctBQzO4Kun4mJeoV
         osxHv6tprfvEJMbR+84TdcyeLS46KcVvwbKORPVfee0kHABd4cTGRyYj3wciajmhyP95
         IgCAXs9XWG48rg427IluZgbkB1QWbSgXP0n7jReWSwX04P2kM1dwDxGnCiSB91ho4VzI
         h8kh1g4TV03E5zcQWZgXrJxY5tAyNaqZXV56t5pH61CIGjYVQWMp8xuuejV+cBYmIhQt
         mtdbOvtDTzMeBNLp38W28xr/38ugoyZe2uLU4OTRASQV/+nsfV6EOHJKftsNtIukTeoY
         rW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Ji7Xwi4CX455TTm7FFnww+qNo0h+6JrE6lrT1VdynY=;
        b=G4LvUpL05sOEpkbYa9/x2kYw1ec5/bLUsmBpB9mwe7fjlBWJm2R+gELA01kbXeXR+Q
         QJeKRwxoeqG5TkFqQ8Y1i4EUps0ZLUkIPZjD8+KZQl2bnKXFTBTg1Uj/QEA+GHOcs4hd
         pRU19MZX95SoAsToIOahAIgzkeFXqjte26Jt7xcwRlsVf8InT+MR3IYgC5KlbF6aWNeU
         MYjfAhAO3FmK4CizkjcWSVt/pLDcx9M5RcmsvAP2jUewTAJVTBjv00f+pH7aPAHGmeG7
         TkQTYZrreiIA7G/RiPxMgOMwfS/ENWFzIY43Wc15d0cG/qYuCCkxaKRm5XkKGAL3XePb
         J80g==
X-Gm-Message-State: APjAAAUPFI38EnOx8sLoP9UuHILhDiFD2ZJ2BsmVbkEt7QRA2SDlgpuq
        y+E3ylhoHb/+/PhqietpfYQyyzrw
X-Google-Smtp-Source: APXvYqwpc6sqR9aUkSdqMU7paYBxspuj5lmmtiLkXT4iSMvkm+VzHsZ6aw287aYBfIVx+SEGKgUBZw==
X-Received: by 2002:a17:902:2927:: with SMTP id g36mr34153435plb.57.1554092759109;
        Sun, 31 Mar 2019 21:25:59 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t22sm10996829pgu.45.2019.03.31.21.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:25:57 -0700 (PDT)
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
Subject: [PATCH v3 00/11] i.MX6, DesignWare PCI improvements
Date:   Sun, 31 Mar 2019 21:25:36 -0700
Message-Id: <20190401042547.14067-1-andrew.smirnov@gmail.com>
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

Changes since [v2]:

    - All non i.MX6 patches dropped, since they were accepted as a
      seprarte series
      
    - Series rebased on lates 'dwc-pci' branch of PCI tree
    
    - Patches "PCI: imx6: Use flags to indicate support for suspend"
      and "PCI: imx6: Replace calls to udelay() with usleep_range()"
      added to the series

Changes since [v1]:

  - Dropped "PCI: imx6: Drop imx6_pcie_link_up()" due to the matter
    already having been addressed by "PCI: imx6: Fix link training
    status detection in link up check" from Trent Piepho

  - Changed "designware" -> "dwc" for all subject lines

  - Collected Acked-by's from Gustavo Pimentel

[v2] lkml.kernel.org/r/20190104174925.17153-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20181221072716.29017-1-andrew.smirnov@gmail.com

Andrey Smirnov (11):
  PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
  PCI: imx6: Remove redundant debug tracing
  PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
  PCI: imx6: Remove PCIE_PL_PFLR_* constants
  PCI: dwc: imx6: Share PHY debug register definitions
  PCI: imx6: Make use of BIT() in constant definitions
  PCI: imx6: Simplify bit operations in PHY functions
  PCI: imx6: Simplify pcie_phy_poll_ack()
  PCI: imx6: Restrict PHY register data to 16-bit
  PCI: imx6: Use flags to indicate support for suspend
  PCI: imx6: Replace calls to udelay() with usleep_range()

 drivers/pci/controller/dwc/pci-imx6.c        | 119 ++++++++-----------
 drivers/pci/controller/dwc/pcie-designware.c |  12 +-
 drivers/pci/controller/dwc/pcie-designware.h |   3 +
 3 files changed, 54 insertions(+), 80 deletions(-)

-- 
2.20.1

