Return-Path: <SRS0=cvZd=QJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA24C282D8
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 00:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7840E20863
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 00:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkCpzawB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfBBAPg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:15:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44076 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfBBAPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Feb 2019 19:15:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so3672215pgr.11;
        Fri, 01 Feb 2019 16:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEfHVg5adgM29Wvz/BKP6/4kELk5ivTcvMeeOgWs9Bo=;
        b=RkCpzawBmG/DUG20vkHE8nM+/HZVsIgcbpJyA134UvLrxUKAeotdXxP/iHwhWMRqf4
         AYkRiZkuGV/+zU2tcznCbc59WslEiNG6EiZmbGibznA8UipVmyJ3xpQFQ6E/wtfTh2wQ
         ywyxQ9t2CNl2X7nQMG+Hf+Msb70CD0mgzN3QnC7eCxktCYk0S8yRvYLAdAiv/yPfgj7T
         IlLKgFQZx5Typ45zO+71rCWwLA89wNy1MsycW/+dWac3Bf1iq3nqoZAz/72MdCC0Ycia
         k9pAXJ1cUgfjQWaVUlMlzi9nQX/3mpJ3mvnRYWGOnKGL9rx4WkDl6pTDXFflgefs1l0W
         LAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEfHVg5adgM29Wvz/BKP6/4kELk5ivTcvMeeOgWs9Bo=;
        b=Bd7dhwoUUNhZElt1hsI/7VrpVNpLkRu2u1vytz5Gf3bcqktIcp1ZsmRTHW6N1xZfL+
         ibD/B/3uAZgpEwuX8amYli9aBndFRxcKdSFVUTv1KSqKEuo9O9MdcPD1c73JxxgEfQDc
         JVkozHoD7iUefNI8ZPC+ZyWPc9f8lRTbOq6cvqrPnGLEDNu/ZlhWK39WPODzjL36gOiK
         ISMaLvYB51lVUFT6kz96/PijNCQUhTQjx0NpMXR+hvIm5vIAWHvIDkvgq8TsloW7PSfA
         ZPZcwjrqv0O8P0TueG3Kcdh8KjMYU3cH//UczWJu1CIsM262dTYYp/bf/b35FY2DhukF
         PkSg==
X-Gm-Message-State: AJcUukcHC1bvBVn0yGAE6Z/Apiy6mWiP+9LM+vk5ZXD/OhgzS1Dwwd9f
        tGf1aVVK+v5zM+osTmBJgTo=
X-Google-Smtp-Source: ALg8bN7CwYfzPenhtI9KfgSMrD9gYvxUtOH9Knxhz3A5up69TRXJk2mfCuNzwvmmXgNtOi20Cj16jQ==
X-Received: by 2002:a62:32c4:: with SMTP id y187mr43076304pfy.195.1549066534634;
        Fri, 01 Feb 2019 16:15:34 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id w6sm28374545pga.72.2019.02.01.16.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 16:15:33 -0800 (PST)
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
Subject: [PATCH v7 0/4] PCIE support for i.MX8MQ
Date:   Fri,  1 Feb 2019 16:15:19 -0800
Message-Id: <20190202001523.12517-1-andrew.smirnov@gmail.com>
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

Changes since [v6]:

 - Patches rebased on Lorenzo's pci/dwc branch

 - Reworded commit message of "PCI: imx6: Mark PHY functions as i.MX6
   specific"

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

[v6] https://lore.kernel.org/linux-arm-kernel/https://lore.kernel.org/linux-arm-kernel/20190124201522.8973-1-andrew.smirnov@gmail.com
[v5] https://lore.kernel.org/linux-arm-kernel/20190112215601.9535-1-andrew.smirnov@gmail.com
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

