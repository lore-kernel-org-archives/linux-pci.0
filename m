Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E186C10F13
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4064C20850
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 00:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+2169/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfDOAr1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 14 Apr 2019 20:47:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39906 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfDOAr1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Apr 2019 20:47:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so7719582pga.6;
        Sun, 14 Apr 2019 17:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ZPyWSQHPinUgWmwQRPfs9W8YBEIvp9FgszeG1juFHE=;
        b=V+2169/1jR/HaXhDuVoQLVhzYg7l+7RaU+E/nUKpESLYBrs6bs/qTKw7pr5xIwlmMt
         qODOrHcNsS5IdWajLNpMenrq+ZIh1gVeDDPgDdPIYw7MwhWt3ph8ZopDrTPjHjv3vEPv
         u15PsvDaCQon4kwkB6IPtsc2JYxAaNLm4wR8w+Tt5ZSWJFF+eOOrTpPqHON8/MrtgmsQ
         BE/BfH4FyqJnXb3FNSwAfB6KigpVXIctj6RKQvt4kpKPYkuUeeNQim6/7sDrlHKIB1cc
         xjjHiPrmKbx+3msrl2D+iSvDICZmepgkUg1Afej+VkEI8lb9hwekqu80pCp3wY73gh34
         /NQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6ZPyWSQHPinUgWmwQRPfs9W8YBEIvp9FgszeG1juFHE=;
        b=ffrfFptp17RwXESS3caYNS/eseIwKUJt2Du1S/VanygL6Ymzm0dn7x5PvQZutxhLPi
         wYh/8DLGI1wlcK+gEWdYkL5/LiRLmQ5Wln4/WSqprvPRKfRHsQcK7jI+vi5n1LIopvY6
         mqr9xwDx+tYlDRkLwyLH1ffK2gJDHbBGatdADXUDkuPZK30hZwfGaX6dg6wSuuXcpzrS
         yJjeHjWvobzIjK+WJg274DCvxXIyFNOO2AqNDDEnAHweHNqZvcYngPmS10y4jLZZa/1u
         RKB1AtYHmyB/MrQcwO8x5v4STCB+Bvb4XI6e95cvIxNueMgYLinnx3/0gXVhHxbxG4l8
         nroA==
X-Gm-Message-State: APjAAAU3jdMPHAT49f+CjNouPm8lM6J10ndY7wJrBekx/j3s1umuGG2f
        2/BOaGAHPAk1M7crtvsWPaxrYnKf
X-Google-Smtp-Source: APXvYqw7hf3lFVNbVikfY9YkZ2TVMYXTAKQgR6zFOYzPBkUrROfk638Y34ZH5sanq3hrGkeTVnnZvQ==
X-Received: by 2002:a65:6150:: with SMTP id o16mr6819893pgv.285.1555289246368;
        Sun, 14 Apr 2019 17:47:26 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id u17sm66111981pfn.19.2019.04.14.17.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 17:47:25 -0700 (PDT)
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
Subject: [PATCH v4 00/11] i.MX6, DesignWare PCI improvements
Date:   Sun, 14 Apr 2019 17:46:21 -0700
Message-Id: <20190415004632.5907-1-andrew.smirnov@gmail.com>
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

Chagnes since [v3]:

    - Collected Reviewed-by from Lucas for most of the patches

    - Converted "PCI: imx6: Replace calls to udelay() with
      usleep_range()" to "PCI: imx6: Use usleep_range() in
      imx6_pcie_enable_ref_clk()"
      
    - Converted "PCI: imx6: Remove redundant debug tracing" to "PCI:
      imx6: Drop imx6_pcie_wait_for_link()"
      
    - Converted all of the callers of pcie_phy_poll_ack() to use
      true/false in "PCI: imx6: Simplify pcie_phy_poll_ack()"

Changes since [v2]:

    - All non i.MX6 patches dropped, since they were accepted as a
      seprarte series
      
    - Series rebased on latest 'dwc-pci' branch of PCI tree
    
    - Patches "PCI: imx6: Use flags to indicate support for suspend"
      and "PCI: imx6: Replace calls to udelay() with usleep_range()"
      added to the series

Changes since [v1]:

  - Dropped "PCI: imx6: Drop imx6_pcie_link_up()" due to the matter
    already having been addressed by "PCI: imx6: Fix link training
    status detection in link up check" from Trent Piepho

  - Changed "designware" -> "dwc" for all subject lines

  - Collected Acked-by's from Gustavo Pimentel

[v3] lkml.kernel.org/r/20190401042547.14067-1-andrew.smirnov@gmail.com
[v2] lkml.kernel.org/r/20190104174925.17153-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20181221072716.29017-1-andrew.smirnov@gmail.com

Andrey Smirnov (11):
  PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
  PCI: imx6: Drop imx6_pcie_wait_for_link()
  PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
  PCI: imx6: Remove PCIE_PL_PFLR_* constants
  PCI: dwc: imx6: Share PHY debug register definitions
  PCI: imx6: Make use of BIT() in constant definitions
  PCI: imx6: Simplify bit operations in PHY functions
  PCI: imx6: Simplify pcie_phy_poll_ack()
  PCI: imx6: Restrict PHY register data to 16-bit
  PCI: imx6: Use flags to indicate support for suspend
  PCI: imx6: Use usleep_range() in imx6_pcie_enable_ref_clk()

 drivers/pci/controller/dwc/pci-imx6.c        | 143 ++++++++-----------
 drivers/pci/controller/dwc/pcie-designware.c |  12 +-
 drivers/pci/controller/dwc/pcie-designware.h |   3 +
 3 files changed, 62 insertions(+), 96 deletions(-)

-- 
2.20.1

