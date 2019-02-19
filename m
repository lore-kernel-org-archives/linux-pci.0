Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D99C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2C221738
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 20:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5V2n/p5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbfBSUEO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:04:14 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32974 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfBSUEO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 15:04:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id h11so8273117pgl.0;
        Tue, 19 Feb 2019 12:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEG5J67YzK79II1Bqsot5pa/6iNTJCjnXXIT96/SY68=;
        b=p5V2n/p5qJOwrUZIQB7TqaZrmr1eq5el2zgmjJwzcej1/lHAzhwGWKx5tY2/z6B4pD
         rTW2qiSucXx/K4VHy6HEPQc5Xt/eb66ceYiRJVgLWKUTf7Sn1iijkLQDQFa7RoOg0G61
         mtGqvJ52t4Fsnd4AmZ6cKKRX66y0G3RYLybTZx3nennldGk0BpJDVp/izxVm1pE4oCg5
         QLQZCZwUZ0uOEVJYFPxIZurMi5A/wpTzAL2xpnDms+xUcr3gpH/GktUE2NMw7/HSDrOj
         9Pp9VOwCesaHCe8jZCZAkgCoLcnqFVPztHbT/aMdTWx1qKjRo9QvtrPgOiWc00HB+lOX
         i4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bEG5J67YzK79II1Bqsot5pa/6iNTJCjnXXIT96/SY68=;
        b=QZA3v+bU7WFXbByWBRKyuhul47J/riqXsVgjeaFneY08Gw18FRTO2G5p7qvF99wcP+
         I5A7lek7mmdHHVVlSqCPxOYu9dCV2/PHTRrJN0NpMOzBrCgBIQFblCDnfRG7jOvMVzGL
         Vkz4ZzqrxzCEiD1M4ZDlHnzsGeZ/fY7ZaV36u+z4UB3G1CGNU0+nmlMQZMG7L3xllTrH
         xtpvhXjlVqM2HnaW7xYEPEkOK/Ac16bl7kFTvj10hTh/5fnohCj5hHXKw64XPVUrR/a9
         7PVBFN98eMQi0Nu3DDM00czJYAFinDcpkWEBqKozB0zrKHnfrHLmQndGsxFeHEYg3ooS
         37xA==
X-Gm-Message-State: AHQUAuaIBxNLNsKNB8LgbiGQGQnyUNIaHJ11wv7YRV/J3+q4DHd4M9vh
        l7cLeo3LZDemDfIzDdstRL0=
X-Google-Smtp-Source: AHgI3Ia9U6/EBEGiHLHYxnaLmRUrTdUz9pHjZ0uYR81cVEcdrvv4tmJisNYrjWqXxN8Nh6Xshi8q6A==
X-Received: by 2002:a63:6e02:: with SMTP id j2mr21081313pgc.229.1550606653489;
        Tue, 19 Feb 2019 12:04:13 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e63sm31519622pfc.47.2019.02.19.12.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 12:04:12 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/5] DesignWare PCI improvements
Date:   Tue, 19 Feb 2019 12:02:37 -0800
Message-Id: <20190219200242.17243-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Everyone:

This is the series is a spin-off from [imx6-dwc] containing only small
improvements that I made while reading the code and researching commit
history of pcie-designware*.c. All changes are optional, so
commits that don't seem like an improvement can be easily
dropped. Hopefully each patch is self-explanatory.

I tested this series on i.MX6Q, i.MX7D and i.MX8MQ.

Feedback is welcome!

Thanks,
Andrey Smirnov

[imx6-dwc] https://lore.kernel.org/lkml/20190104174925.17153-1-andrew.smirnov@gmail.com

Andrey Smirnov (5):
  PCI: dwc: Make use of IS_ALIGNED()
  PCI: dwc: Share code for dw_pcie_rd/wr_other_conf()
  PCI: dwc: Make use of BIT() in constant definitions
  PCI: dwc: Make use of GENMASK/FIELD_PREP
  PCI: dwc: Remove superfluous shifting in definitions

 .../pci/controller/dwc/pcie-designware-host.c | 61 +++++++------------
 drivers/pci/controller/dwc/pcie-designware.c  |  6 +-
 drivers/pci/controller/dwc/pcie-designware.h  | 57 +++++++++--------
 3 files changed, 56 insertions(+), 68 deletions(-)

-- 
2.20.1

