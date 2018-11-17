Return-Path: <SRS0=yfZz=N4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3B4C43441
	for <linux-pci@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FC520815
	for <linux-pci@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD9PSmMP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FC520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbeKREaA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:30:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45034 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKREaA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Nov 2018 23:30:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so444386pfh.11;
        Sat, 17 Nov 2018 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQXpmGqoNlvoa3L5e4/ydma6HiYdDt50w+WJrMmHO0A=;
        b=gD9PSmMPlgjbow6JgCDb/rdwLZ3Ml263yjCJsGd1vNou5H8xLfuxc8QCWqZvanMCsj
         QcYzmIxDlFS2Qdy8AuxK2KkpfMghDG7/BU+GxBy4Dz75j+4b2EQ4VA/NwyOEKpnqf0ol
         FawxMqEFfagFI4iUzlSEuCTfpx8aFPoeUdOm727qcvfBgidWEXBV1yTP9Bx26oTMqamM
         HJ3+yANIxw0FEHESXzRXXOn47slqROmWdGToALes1X4WTZWVuNiNaqL9if2V6aNv5OCW
         m2NzyJuaz+chxVfZtCk80OkyYp+hH+9/f3OZ5r1fdmD/h2Bevl2t6S4xU34vzE28T1vh
         FvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VQXpmGqoNlvoa3L5e4/ydma6HiYdDt50w+WJrMmHO0A=;
        b=AFwO5HPjQ9lKshLHUjLjF0ftJig6EZaTqEwit45rnJ8QEiIiXeu6TPB75Dwhz1HqFA
         fR5DaDt5+n3GCx+snKYvVbGMkV4lgs7aH/peWU2hc3bvBIaBqs9YGl1gVUgXGLzFXb56
         9EVbgBufMiTN+Vzlpd7vRG4RrcFoPu2aon1kGlsuX0meerrNk+clKMB8jMtTP+cvxrLN
         PNKZ8bYjkYYhxk57IlMVeMXmGqlZTUn1lZu07UrCDbPKe2C6teDcJCT1AKqB2/Stz43r
         Me7cGw9dvxkd1sCVBfRmEVwrKZZlqFqBaw7SsY2wTsL00eDW6MehSlJyjZiJiCmNKu5/
         smFg==
X-Gm-Message-State: AA+aEWYhUVRkEIoJGa08Jvr6lctOwc0fCWCA+Sd0wys8XsdOQuklEq3u
        MDG6gVOHXBfrrUoflip1dq/2XZ2kb9w=
X-Google-Smtp-Source: AFSGD/UcEcwpgFUTVpzE8zpjodknTX4wCnW0gqu4oy32ytqLhsMd4Pb49/EuuwrJdviWPFWZoFTUzA==
X-Received: by 2002:a65:534b:: with SMTP id w11mr4973299pgr.125.1542478351376;
        Sat, 17 Nov 2018 10:12:31 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t2sm13868196pfm.32.2018.11.17.10.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 10:12:30 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, bhelgaas@google.com,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/3] PCIE support for i.MX8MQ
Date:   Sat, 17 Nov 2018 10:12:22 -0800
Message-Id: <20181117181225.10737-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Everyone:

This series contains changes I made in order to enable support of PCIE
IP block on i.MX8MQ SoCs (full tree can be found at [github-v0]). This series
is _very_ preliminary and by no means is ready for inclusion (it also
has some unmet dependencies).  However is should be in OK enough shape
to get some early feedback on, which is the intent of this submission.

Specifically, I'd like to get some feedback on whether newly
introduced "fsl,iomux-gpr1x" and "fsl,gpr12-device-type" DT
properties, added to handle differences between PCIE0 and PCIE1, is a
good (acceptable) solution for the problem.

All other feedback is appreciated as well!

Thank you,
Andrey Smirnov

[github-v0] https://github.com/ndreys/linux/commits/imx8mq-pcie-v0

Andrey Smirnov (3):
  PCI: imx: No-op imx6_setup_phy_mpll() on i.MX7D
  PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
  PCI: imx: Add support for i.MX8MQ

 drivers/pci/controller/dwc/Kconfig    |   2 +-
 drivers/pci/controller/dwc/pci-imx6.c | 119 +++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 4 deletions(-)

-- 
2.19.1

