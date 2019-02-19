Return-Path: <SRS0=sVnv=Q2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4E3C10F00
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 06:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DBBE21905
	for <linux-pci@archiver.kernel.org>; Tue, 19 Feb 2019 06:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SyiEXisE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbfBSGDv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:03:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40943 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfBSGDu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2019 01:03:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so9691195pfo.7
        for <linux-pci@vger.kernel.org>; Mon, 18 Feb 2019 22:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WAJkt5pKYVfaSlTbiQyzNhjMJz/17VQ97ZsS8VrSTns=;
        b=SyiEXisEw8m2f8P4XliUEL1x1ifBMrLtI9hZ2DIjOSvalBWB9Ie/TsZTWmuNIDQzuf
         3/rbzu2GUhPHJbPI1KeD572UQAGQHYWyqkgVhK+3+kfbGbaUoe4Yzs4CrUEE7az9sR6H
         8gKTfnc1gCl0qpTu8UYKvpC0H+j/ulyfBtWYmyvwz9dyeH7xm6zPemqskg9aXfSxEoWo
         O8P04nVn6lbncvtAzPfosFNLYvO8l9VlKa4y7SLX1SpFU3+8pDVpDvGLB6DCTFz9ysEN
         KQ5GaicA9iRhgGLrjJQ4uuU/TKwppJOfTRniuVzuP8d09HPYAXMvCnPgly6NsIa5lu63
         sj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WAJkt5pKYVfaSlTbiQyzNhjMJz/17VQ97ZsS8VrSTns=;
        b=b3n6fqRRCKO13ZN6OBCz162xU9FwmA8lLCTE1K6iUmHO+AnwBuYa/0btof8dyP4vW1
         IdnpeP4Vl2n91gTI5Aw2ni10+eT1CKySxeTRiYYKrshDlEGuwv/gTuPkwElx9F1e9AmI
         RRB2xpb2PepNVZNDCA2ZuAsAiWst3cA2TAEKRf2A/bT47/DByhdFYYldz/fsgyoyc5aS
         +5FaxJAO1tH8wvagf7vIMzGB71/Ul/ZQSai+l7iZ2Quk+jzvatBFF8ORUZ8SFJrI82YU
         DqEItLDin/8JMUxMpdW0pEk8WlJieeba86JU3OleqiZ1XFtppAzI1vBSUYK2dNjlcMWD
         TPHg==
X-Gm-Message-State: AHQUAubmEX0LntWAvBlNjbaOHyNJtAMKiyfQCc007oLzk6mairPQXBzb
        CJOsDa/0JY2Mbk9hHrgogBEljA==
X-Google-Smtp-Source: AHgI3IZZA2BipuFrb5VuJRSHdSRZgQaYi2Gg6KmPRfE1ezlffV9/u5JJw8fOqUkkemGbOao6TvGitQ==
X-Received: by 2002:a63:c04b:: with SMTP id z11mr22001661pgi.135.1550556229700;
        Mon, 18 Feb 2019 22:03:49 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 86sm31914838pfk.157.2019.02.18.22.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 22:03:48 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 0/7] QCS404 PCIe PHY and controller
Date:   Mon, 18 Feb 2019 22:04:00 -0800
Message-Id: <20190219060407.15263-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for the PCIe controller and PHY found in the Qualcomm
platform QCS404.

Bjorn Andersson (7):
  clk: gcc-qcs404: Add PCIe resets
  dt-bindings: phy: Add binding for Qualcomm PCIe2 PHY
  phy: qcom: Add Qualcomm PCIe2 PHY driver
  PCI: qcom: Use clk_bulk API for 2.4.0 controllers
  dt-bindings: PCI: qcom: Add QCS404 to the binding
  PCI: qcom: Add QCS404 PCIe controller support
  arm64: dts: qcom: qcs404: Add PCIe related nodes

 .../devicetree/bindings/pci/qcom,pcie.txt     |  25 +-
 .../bindings/phy/qcom-pcie2-phy.txt           |  40 +++
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi      |  25 ++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  67 ++++
 drivers/clk/qcom/gcc-qcs404.c                 |   7 +
 drivers/pci/controller/dwc/pcie-qcom.c        | 108 +++---
 drivers/phy/qualcomm/Kconfig                  |   8 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 drivers/phy/qualcomm/phy-qcom-pcie2.c         | 331 ++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-qcs404.h   |   7 +
 10 files changed, 558 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie2-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-pcie2.c

-- 
2.18.0

