Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D52C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 04:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625892086C
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 04:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb357ngO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeLREHV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:07:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36764 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeLREHV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Dec 2018 23:07:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so7165430pgm.3;
        Mon, 17 Dec 2018 20:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3+OCgKPBIWFfLC4rx2+DZloTP4JnnVc5aNIGz681To=;
        b=gb357ngOzxNoFri/o7AF4EJpdSAeaYcCfa9DurKZvA1OumCMThDqf5Z5LeYiUkAGP/
         Onui3I2USzFMiGzvbMHjCTY4ziceWzKOcSzOWYaHUgSLxHI+HA2N/RL0ppDpyy7kPhLT
         UzOY5G/DwcFkjFH1enqhlBLQDJCYNZS5hFpBWaqNYmy3keh53AIwOLvecu+8cWLKHBCe
         qujZYhpknUD8PF2ZSTA5rvAuWAeylV6DAgeAZoOuie8PLIg3x5qPS6pzdCIh0UAQMc2r
         UivI6V/TZvVjbjSAd3XFGjL+mxJLsHW59muttveYtOEtna5uDAaIHEParqq6hLm1lxW0
         7ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3+OCgKPBIWFfLC4rx2+DZloTP4JnnVc5aNIGz681To=;
        b=h+xzkDsxOL74qipI4Z2W0fOkud7sP+qZs7BjRTlkm+WsLEcvkUHrlimruAMhCZA4P3
         zXV1Wm4TNmPKcD95+5kMcwe5C5FNv4JKApMquMl4ySpzK5t29wKoZngSmPnC6lYZdzw5
         KL1CeBe9/ZSMoIGIPwD9HIPBnO3lHuXXeTj9hiOpOKUsu4uEGAiavfC8vSLDibR3tRU5
         ocRt/hAerYr6MgiTroN0hyqxqUzF9rgBOiUvVT/XZVb1mJO8qbwg6gcfA1PrqByAJ3l6
         HNhxdsHiGj6Yx3rsRt0hZ/RfNlLSnYZDMkFwciS9cH8Tpxyqd5ylBty92SchDQU5oPM7
         nRiQ==
X-Gm-Message-State: AA+aEWbHr9XDdIo6++gcDFT0eW9pWBilRkP9WV/RtwGuMF6kMoDaNAIT
        ItGnCmflleDBwXG2cjTv2QE=
X-Google-Smtp-Source: AFSGD/VwUDV/b7a2YyxHMr5g+cDFK6C3R+R4LhOP6fp+RV2donKCg6OSjbhgJIdr30CaIbFy0BFuPg==
X-Received: by 2002:a63:cd11:: with SMTP id i17mr14570991pgg.345.1545106040001;
        Mon, 17 Dec 2018 20:07:20 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id m67sm18538837pfm.73.2018.12.17.20.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 20:07:18 -0800 (PST)
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
Subject: [PATCH v3 0/3] PCIE support for i.MX8MQ
Date:   Mon, 17 Dec 2018 20:06:59 -0800
Message-Id: <20181218040702.29231-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Everyone:

This series contains changes I made in order to enable support of PCIE
IP block on i.MX8MQ SoCs.

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

[patch] https://patchwork.kernel.org/patch/10712261/
[fixes] https://lore.kernel.org/linux-arm-kernel/20181216230916.22982-1-andrew.smirnov@gmail.com
[v2] https://lore.kernel.org/linux-arm-kernel/20181206073545.10967-1-andrew.smirnov@gmail.com
[v1] https://lore.kernel.org/linux-arm-kernel/20181117181225.10737-1-andrew.smirnov@gmail.com/

Andrey Smirnov (3):
  PCI: imx6: introduce drvdata
  PCI: imx6: Mark PHY functions as i.MX6 specific
  PCI: imx6: Add support for i.MX8MQ

 .../bindings/pci/fsl,imx6q-pcie.txt           |   6 +-
 drivers/pci/controller/dwc/Kconfig            |   4 +-
 drivers/pci/controller/dwc/pci-imx6.c         | 150 +++++++++++++++---
 3 files changed, 136 insertions(+), 24 deletions(-)

-- 
2.19.1

