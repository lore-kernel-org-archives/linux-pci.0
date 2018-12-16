Return-Path: <SRS0=ngrz=OZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C9BC43387
	for <linux-pci@archiver.kernel.org>; Sun, 16 Dec 2018 23:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600692084A
	for <linux-pci@archiver.kernel.org>; Sun, 16 Dec 2018 23:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBs4ssjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbeLPXJj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:09:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42517 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbeLPXJj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Dec 2018 18:09:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so5168939pga.9;
        Sun, 16 Dec 2018 15:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OFUjPN/jOVveBQnYLdpNxVZQI1qdFi0ky0CAVcNgUaU=;
        b=cBs4ssjyrKZh/pfBcHc7tszNNTI5KPBtKvjTvBabda0HwZAW5CZ5BJ66dZ0UPhy9ax
         PcGshBPnEbxuz7l0wTbwyyXZcUFrFYn7VwB2maTAOwzPlpZvY2mT9c9/FZglFyUdNi/w
         Um4Y3l+4Df4m1XfjixauL/bI9onIN/gVbEj70HAG5GgUNdFa3ZLMt4yQW/UMYrYXlT7+
         h1M8qAqo6hUAzbhdYeWAgPuThH/0XQYFbrM/f6soBETkhqG03NElpwrA76tkWT5CF5/y
         nTCtYQZ2dkLDfClfNcfIeWj7EaQeGyPumu0j4Q5tZPbmJTmHlXtIyZn79/sc91GMTbeV
         LFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OFUjPN/jOVveBQnYLdpNxVZQI1qdFi0ky0CAVcNgUaU=;
        b=oH8nQRfQ98+Cl50T6jhkyYtFeqD/2SbJ0NziNR4GjznY3C0fXkH2D8n9aZlUKybjiu
         15Lgvu0Vqd4gtu6z5BtvvdCFqdKGTlAR4vNT22Q9/n3Cl6mAaHKa0ehPONVxfBOB+p7t
         V8Xt//wuGSixkUx4S82PpJzMcaPL63wQxxtX7iHEjQJz3ry9ImYVGEy492ihqy9M/w/Y
         vzVCUdK1oTPZPkuGS56RUEIrJhEuV7VpySPwDzRb0VhbThYLmns76CTeJksxG2ZIDi7A
         hulc1R3iqqQJrd1o0e2QUUG604LB6feV2fdHukOJEKiqHQdOxorbs5FqJqkNiGx+Cyve
         phLQ==
X-Gm-Message-State: AA+aEWYguGSAKtNXwD2EX+x53O5po7iJZkBwgZEA2BZ1J32rwoi1kI8R
        O3C1SP65Oov49DzvIo/EZhE=
X-Google-Smtp-Source: AFSGD/Xw/f1wvmdqOuwCVFqUk0yRoQPPRFGqUlAy+zXV3KDbMCKTOndo5zG2SVqP/+c4sv7+gnyplg==
X-Received: by 2002:a63:c00b:: with SMTP id h11mr10345302pgg.429.1545001778050;
        Sun, 16 Dec 2018 15:09:38 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id d18sm13837878pfj.47.2018.12.16.15.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 15:09:37 -0800 (PST)
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
Subject: [PATCH 0/3] Fixes for "PCIE support for i.MX8MQ"
Date:   Sun, 16 Dec 2018 15:09:13 -0800
Message-Id: <20181216230916.22982-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lorenzo:

These are patches fixing things pointed out by Bjorn in [1] and [2] as
well as something I noticed while giving pci/next branch a try (#endif
placement). Hopefully this is at least somewhat helpful.

Thanks,
Andrey Smirnov

[1] lkml.kernel.org/r/20181214203828.GD20725@google.com
[2] lkml.kernel.org/r/20181214203042.GC20725@google.com

Andrey Smirnov (3):
  PCI: imx6: Fixup Kconfig and #endif placement
  PCI: imx6: Invert checks in imx6_pcie_reset_phy() and
    imx6_setup_phy_mpll()
  PCI: imx6: Make fallthrough comments more consistent

 drivers/pci/controller/dwc/Kconfig    |  4 ++--
 drivers/pci/controller/dwc/pci-imx6.c | 29 ++++++++++++++++++---------
 2 files changed, 21 insertions(+), 12 deletions(-)

-- 
2.19.1

