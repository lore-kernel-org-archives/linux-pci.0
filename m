Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF22C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 01:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDEA2186A
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 01:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcOD4IzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBLBvX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Feb 2019 20:51:23 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:43620 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfBLBvX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Feb 2019 20:51:23 -0500
Received: by mail-pf1-f177.google.com with SMTP id q17so458554pfh.10;
        Mon, 11 Feb 2019 17:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WWvbZPKYjHa1Sh3c2VYx3h0zBcjICrXwMR9K6Y7BuCg=;
        b=OcOD4IzSN7fQOL74FtDnchffPAylfBojpleBh1FtI6fCNLdZT/d2lGi/nIUKlDUbeb
         REeYd5c3UBgMchq56zPAXRDkOxKqRLcQqzk0l/KwCVnrMPPH6GytqEiKeOLzpgLvVMsP
         cnxLpJsaLDOdErY5AAQOPbipBQmrpEtzF7T5YcMoel8/FZaSfUM2YpfNAnZxtegwdJvx
         p8JQPFxqdRnmeWuXcnSGe1xNPLU65i1WHvLF/ZV9qrzY9B3tfdkJ/Exn8EpD4GCLiL3/
         +VmhxA2pfrC0ydc9KuLr65/5nocmQHPtBHq9tRk1j5eWr+VtVU0COwYm0QHt2an/5TMM
         X+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WWvbZPKYjHa1Sh3c2VYx3h0zBcjICrXwMR9K6Y7BuCg=;
        b=mheQCowT4sdW7wQiWwB0XN8Md2BpDcq2/Pgb4E0VzXI0MPZjpo/M5v03h0SkPsZClD
         EBMnW0Kzy0RCb4m4Ifetj/YkiRScZ6jpxl8LlikWSQHOu0d7MrsVhO65GLvoa4yYWaFj
         acwlsUzVlSH90g90od1tX6gaKTHAEdxPMfUNB1XbOafW+jNy/V2GNXPs2TR4UfwKjBzh
         mERCkUBrNPFYyFAAazEcEsFAE4wSRKyYpgba9MAfL/hTuFsA83fPk0lfiQUXGCbLIphg
         zotUH0q9A2rIbu7ZYQ18yrdTloGMgrQ224tanIu2kfEgwTDzk56tNc7+JY3GH2r2UVRD
         ir6A==
X-Gm-Message-State: AHQUAuYok2q6zfUa+IPs0e3ExAqQkV9yL3OteK6p8A0TsKnk638YLVRu
        t4+3Y9C3Tr9wjQAO/lV0lVA=
X-Google-Smtp-Source: AHgI3Ia0F4vKw82kH44GS69Oo1c5662wVJeYMvY64EqwxW4xhO7r/ceJIpElfwYVZ3mNPQaFvP/Qyg==
X-Received: by 2002:a65:5cc4:: with SMTP id b4mr1199169pgt.365.1549936282354;
        Mon, 11 Feb 2019 17:51:22 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h64sm17146941pfc.142.2019.02.11.17.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 17:51:21 -0800 (PST)
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
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] "pcie_aux" clock for i.MX8MQ
Date:   Mon, 11 Feb 2019 17:51:06 -0800
Message-Id: <20190212015108.16952-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lorenzo:

This small series adds code to control "pcie_aux" clock. This is an
oversight from original submission [pcie-imx8mq-v7], which was only
discovered once I submitted an RFC for corresponding DT changes going
via i.MX tree [imx-dt-rfc].

Thanks,
Andrey Smirnov

[imx-dt-rfc] https://lore.kernel.org/lkml/20190131204333.31846-1-andrew.smirnov@gmail.com
[pcie-imx8mq-v7] https://lore.kernel.org/lkml/20190202001523.12517-1-andrew.smirnov@gmail.com

Andrey Smirnov (2):
  dt-bindings: imx6q-pcie: Add "pcie_aux" clock for imx8mq
  PCI: imx6: Add code to request/control "pcie_aux" clock for i.MX8MQ

 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt   |  4 ++++
 drivers/pci/controller/dwc/pci-imx6.c            | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.20.1

