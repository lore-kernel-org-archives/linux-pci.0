Return-Path: <SRS0=29+c=PU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313BAC43387
	for <linux-pci@archiver.kernel.org>; Sat, 12 Jan 2019 21:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B5C206B7
	for <linux-pci@archiver.kernel.org>; Sat, 12 Jan 2019 21:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB8bX8Jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfALV4O (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 12 Jan 2019 16:56:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45653 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfALV4O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Jan 2019 16:56:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so7801805pgc.12;
        Sat, 12 Jan 2019 13:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3vJfMdgiVEA4VDR/kEGDKihZfUkd5cH3sJDDh5BGKs=;
        b=DB8bX8Jf14k4jVPG0SnjWlW31F5N6xU1qCEGMXdOUcKLovBS1jQil4NADkMxFvBFou
         MyD7A/7oHOrJ1wyvD36ypodEWXs37fdPUQykyJXyHljNbA9PlbuwBC64HrimxalNCt2k
         5WiaCs/1bXMHg3HbBWmUpC//2go8u1dmAfTIUqCodyY3OPr34YypYzqQ86ZxoOSxf+TX
         bPRz3mdLaCk+W0RAV6BUyz0xPeniLssGq7swDLqgzeWfTt+CywfP1IWwvobLoUkcfy25
         DQoy7NOPTaYp8h7DzY3tddoFAgfmCb08nEIlowPe4Ww3KGY0Z3IgnbMctfGsnx/nQ2aX
         qv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3vJfMdgiVEA4VDR/kEGDKihZfUkd5cH3sJDDh5BGKs=;
        b=g/rV3Q/wBaFmBvaDl0oA03JQoYD2PV859uxaTLCf3ILYsfbuaQrYkY+nUROGQp9MG3
         LVdKXQz+yVsfKxOdfzLeBL93LEBGKNJM7xWa4rnHXC1Z77STJtqIMIuPi8Ev7A8d4/yI
         BS3tytTwaC8BM0PUXCkU4hHVWOqksWdwRrmcRjfaBHSNuRTctbzWxXKr/54reoO/5Pmr
         H4rjJAZHati3/pe/AIiOdpeE9oh2AoKiOc7czUpeSGSHU+tPOWUN5HRR2swaCy2UHruf
         NPGWZi6eXLZyXrJ18SXEQMGb51pTNWQf05wUN+pNuJRAu9/esYw7loKHOsSJVILIA9jc
         4pGg==
X-Gm-Message-State: AJcUukfCR/yxjcvkU6f7Eac21yLTJKd5dXmWsAT/GGSQXNWUUvdqL9zS
        cID3y0UHnswKnnlRMA4gl66MjyDA+Q4=
X-Google-Smtp-Source: ALg8bN4IWoCJaYJiTdNEcbMksNHQH5T8M1EUVpoJ3aiTcRfRp9p9oqi05CJGPFRo7sUxRXgDvW36IA==
X-Received: by 2002:a62:870e:: with SMTP id i14mr20284592pfe.41.1547330172464;
        Sat, 12 Jan 2019 13:56:12 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i72sm122284327pfe.181.2019.01.12.13.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 13:56:11 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v5 0/4] PCIE support for i.MX8MQ
Date:   Sat, 12 Jan 2019 13:55:57 -0800
Message-Id: <20190112215601.9535-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Everyone:

This series contains changes I made in order to enable support of PCIE
IP block on i.MX8MQ SoCs.

Changes since [v4]:

 - Collected Reviewed-by from Lucas

 - Replaced ((ARM || ARM64) && COMPILE_TEST) with COMPILE_TEST as per
   suggestion from Rob

Changes since [v3]:

 - Based on feedback from NXP, DIRECT_SPEED_CHANGE quirk was expanded
   to cover both i.MX7 and i.MX8MQ

 - Code setting device type in GPR12 moved to a standalone function

 - Explicit "fsl,controller-id" binding was dropped, replaced by using
   controller physical address to determine logical ID

 - Dropped Reviewed-by from Lucas for patch 4/4 due to the change
   above (haven't heard explicit "yea" for it from him)

Changes since [v2], [fixes]:

 - Incorporated [patch] introducing drvdata

 - i.MX6 PHY operation gating converted to a single patch and to use a
   dedicated flag instead of doing explicit variant check

 - Kconfig entry changed to use ARM64 && ARCH_MXC

 - Dropped FALLTHROUGH annotations

Changes since [v1]:

 - Driver changed to use single "fsl,controller-id" property to
   distinguish between two intances of PCIE IP block

 - All code pertaining to L1SS was dropped to simplify the patch

 - Documented additions to DT bindings

Feedback is welcome!

Thanks,
Andrey Smirnov

[v4] https://lore.kernel.org/linux-arm-kernel/20190104165335.13205-1-andrew.smirnov@gmail.com
[v3] https://lore.kernel.org/linux-arm-kernel/20181218040702.29231-1-andrew.smirnov@gmail.com
[patch] https://patchwork.kernel.org/patch/10712261/
[fixes] https://lore.kernel.org/linux-arm-kernel/20181216230916.22982-1-andrew.smirnov@gmail.com
[v2] https://lore.kernel.org/linux-arm-kernel/20181206073545.10967-1-andrew.smirnov@gmail.com
[v1] https://lore.kernel.org/linux-arm-kernel/20181117181225.10737-1-andrew.smirnov@gmail.com/

Andrey Smirnov (4):
  PCI: imx6: introduce drvdata
  PCI: imx6: Mark PHY functions as i.MX6 specific
  PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to use a flag
  PCI: imx6: Add support for i.MX8MQ

 .../bindings/pci/fsl,imx6q-pcie.txt           |   3 +-
 drivers/pci/controller/dwc/Kconfig            |   4 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 150 +++++++++++++++---
 3 files changed, 133 insertions(+), 24 deletions(-)

-- 
2.20.1

