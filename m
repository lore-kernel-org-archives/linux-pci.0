Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87175C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 16:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F121218CD
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uF2/qmwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfADQx5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:53:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35967 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfADQx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2019 11:53:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so17675165plo.3;
        Fri, 04 Jan 2019 08:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHC/zMtIBsgOaORZM1PGs7BI8KoWKlR6MHjCuPkH680=;
        b=uF2/qmwUquF5L+bNLOVzyUlm3r6wjN9Uv+W37NpsWru0ExE/Lk7SNsuucBVo2wAf4+
         C5w7D8dkBZcoDOD2VZpxjKxBrV4aA+KqFHr97HrJXc2mVXpRWxUC3gnJ4ALm8oOC4QCN
         +GPGO+GeskloIq3NtNnedtrJCviBH6uWwasjBuVaUpYsHY2v1a321o6cJtoLD0NMihkP
         Teh3P0sVuGG9tZZpJ6g0zMya3C3fu4xxYB9TPVLC5P8FtlQujNyXFgpbCALZyLEUVwbY
         gZ7EoVHkJQbyZ3hTO2sMdSgarMUqKam6i9ns5n+qM5P8Cv55usZjR3HjZSPo/ZpQocP/
         IDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KHC/zMtIBsgOaORZM1PGs7BI8KoWKlR6MHjCuPkH680=;
        b=ZX74V8VFiCnYqij8qauGxRjMsz7tFWxTIsp6ZF2UxlQa5h2LhGQfhMfcfg01S9hzDz
         0AiTYjfzsMVS+o1RdRKvyTOquBEtoiSoIOhWi6l2YMLNLx7aolKC6tMn+FMDAjSt/V06
         tIoyDGIM0rS0Dx/sC49+R9x5lhcjqsKBUG0sMDNkcgzc+U+KGiJHM4epv+Iquad5QF1A
         +sxplHyP87b3sKvapXrwsOvUzHcmNyRBzJ/Tjsh2vJ3WxAZWmDG+31yuP7i/L06hMKbt
         jz8KyRJM4N3OiCe8UUoO1//IcxOZ0cG6MLVS5/U2ze9TCU8mfiew9F4og48Wx+PaF38p
         5URg==
X-Gm-Message-State: AJcUukczXKXrn1enfjTRdDh+FLVqKaMzLAW04u/GCH7Q/noFRDPA3NO0
        OY3WkS0hXmeY4NrztHQMYGM=
X-Google-Smtp-Source: ALg8bN5VITyWQzPo2idOKEn1GD9kVo+ZZ+YuJPiFgVMh5C6p12jU3RIH5eJtV0LS4Yzh1O6kw+kqlg==
X-Received: by 2002:a17:902:4d46:: with SMTP id o6mr49524570plh.302.1546620836177;
        Fri, 04 Jan 2019 08:53:56 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p67sm101900564pfg.44.2019.01.04.08.53.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 08:53:55 -0800 (PST)
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
Subject: [PATCH v4 0/4] PCIE support for i.MX8MQ
Date:   Fri,  4 Jan 2019 08:53:31 -0800
Message-Id: <20190104165335.13205-1-andrew.smirnov@gmail.com>
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

