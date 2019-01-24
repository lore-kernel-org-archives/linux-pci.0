Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A567C282C5
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 20:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C56217D7
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 20:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpwsPUpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfAXUPm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:15:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42169 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbfAXUPm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 15:15:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so3538493pfr.9;
        Thu, 24 Jan 2019 12:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOW0LX2PweR/cHPMdWN96QKcxoiR7cIq0Nnzo7uwIxQ=;
        b=OpwsPUpW8/I2DQ5qaiHRZ2tsIrURfyiUuNgI+6so7LJsu9yCoseuYvkzW9G5LpiF2o
         lSHIV8RTnSMjJ8YNXsIXiMKzYVe1rcm5+fypfvZ+h4PegBGyIuELJ7cPhM5Etq/wux0v
         uvjjDLlDO74EGwtAAViqAUodrWOisCLkmjle6tedXEaMXwKcuhOpDKGEKz75NOdfmt1w
         Ve1BJSMRmm0zNnu8ztpTFCaVmtJoNtH7YqJhYcUPaB7pMg25VLmu6kuaubU0+xWjRaBd
         9+ZHIFe+hGXuNl3Id0oZusMSHcqhOL6lHSvGO+SJReKxg/4GASInXvKsQg8YH15o3U6Q
         GVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOW0LX2PweR/cHPMdWN96QKcxoiR7cIq0Nnzo7uwIxQ=;
        b=L9a5MxuLx33noDQ+f7/P04eK4l5+cSbFB8ExQ32TSV17rEyVUW9IsRWlurm2mkeJI9
         OR8E+rESxN3jVE280TGfT57JZqLkTxSHUbYZ5L2b8iM5pktvJ4hk1/Lb1GaxYDgzt99R
         0cjFZnxtwM18u0mHGcyzCP5Djq+/gnYQ1vrNSoK598tkmkFyQ4AWsG/KoI6C0pkRs+7D
         bJidWWTVlgAy77J0xm2XcnnBgOYu26kSg3X0J/fWlRwCx1IA641d9qNop71sEQQXzIii
         jdr3WlGCyQa4Br0MSuynuHhgBkxLOcF1vUQoCDieIdGrUxPLe9OuR6M3E9zWvZEUxRJL
         MJeA==
X-Gm-Message-State: AJcUukdSbn5yRRLgUWr/iM2z59aqzztVAUZnQjqbgSDopK2fNJeTaEzg
        2WJHvzADRilQFY8xXvG3Us4=
X-Google-Smtp-Source: ALg8bN59RNULZU+WG6d1l7jJkppHQOKsMddfjKVuOCk2i9NONH2dLJtZnjD5Yp8qHwxIrI263ZVswg==
X-Received: by 2002:a63:5f89:: with SMTP id t131mr7400377pgb.26.1548360940688;
        Thu, 24 Jan 2019 12:15:40 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id m65sm53062646pfg.180.2019.01.24.12.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 12:15:39 -0800 (PST)
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
Subject: [PATCH v6 0/4] PCIE support for i.MX8MQ
Date:   Thu, 24 Jan 2019 12:15:18 -0800
Message-Id: <20190124201522.8973-1-andrew.smirnov@gmail.com>
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

Changes since [v5]:

 - Reformatted commit messages to adhere to
   https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

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
  PCI: imx6: Introduce drvdata
  PCI: imx6: Mark PHY functions as i.MX6 specific
  PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to use a flag
  PCI: imx6: Add support for i.MX8MQ

 .../bindings/pci/fsl,imx6q-pcie.txt           |   3 +-
 drivers/pci/controller/dwc/Kconfig            |   4 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 150 +++++++++++++++---
 3 files changed, 133 insertions(+), 24 deletions(-)

-- 
2.20.1

