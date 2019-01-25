Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A44C282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 23:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CF6218D0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 23:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOF2idGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfAYXpg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:45:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38203 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfAYXpg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jan 2019 18:45:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so5439271pfi.5
        for <linux-pci@vger.kernel.org>; Fri, 25 Jan 2019 15:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WAJkt5pKYVfaSlTbiQyzNhjMJz/17VQ97ZsS8VrSTns=;
        b=cOF2idGsukSeFWXjra3D1geIqOCF4Z/rilqfKCLm/ozpaS8mpxBf1j0z/VErPBW1zq
         iDshwHN8rUvoughAq7E2/e7jzkFSha0QoBqW98o9oIvqNFHSY3V/0IO8IYwBMiiddWm3
         LRPnBL8/93/jYbPvoUytLWMcrNl+GxK2+IVIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WAJkt5pKYVfaSlTbiQyzNhjMJz/17VQ97ZsS8VrSTns=;
        b=UEhaEqXbWqvsoHrGxOPTc5n1bBt1lSg7f73wixLr3Ec4j0cGhidYSvqJ84sc7Lcrxb
         6JI+S4CtIZV4dOjKtb0VjqSJonD0tHX5fMH6b5lYt+67CNncfujh+Ea9X7oUlAuRH05x
         A+Q/NWX3MLd17xY+5J1ktqn9aJCw2TyTc3kk4UzaBYw1LDoo0YadeYmLoOK9HS3ws8Cg
         wzlcvRQeMW25hgfG1Q9QABVhPz3VQeqE3mbVDDsY9fhFgcw5wRrwKJUtPUmKMXQ7dMHG
         n45JNcYdmGtHNrRhxWoZuXiAmAr9qXEAdt9ZbTre/93IPq1+n/63V1Xg4t5l6YYJxgmG
         Y7xw==
X-Gm-Message-State: AJcUukf/XC28U7dauYUocuKEAZ9rG0ziGNsR2f4WnLhH5nOyCUcMEt6n
        O9A8zo/MrrqC5AlPs7nmmFEcnA==
X-Google-Smtp-Source: ALg8bN5/VcgAWdH3Xyee+PPzZnto39/r1r0QODgXbemuZpkEkvlp8cP3uAgmpFx+hpgHBqpGo5ZyjA==
X-Received: by 2002:a62:4d81:: with SMTP id a123mr13327468pfb.122.1548459935416;
        Fri, 25 Jan 2019 15:45:35 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y9sm32950302pfi.74.2019.01.25.15.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:45:34 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Brown <david.brown@linaro.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/7] QCS404 PCIe PHY and controller
Date:   Fri, 25 Jan 2019 15:45:02 -0800
Message-Id: <20190125234509.26419-1-bjorn.andersson@linaro.org>
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

