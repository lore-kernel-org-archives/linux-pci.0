Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C4CC43334
	for <linux-pci@archiver.kernel.org>; Mon, 13 Jun 2022 14:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347884AbiFMOzb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 13 Jun 2022 10:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387171AbiFMOy4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 10:54:56 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA5ACD19F9;
        Mon, 13 Jun 2022 04:57:45 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,297,1647270000"; 
   d="scan'208";a="124235793"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Jun 2022 20:57:21 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C9CE54220BF2;
        Mon, 13 Jun 2022 20:57:21 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/7] treewide: PCI: renesas: Add R-Car Gen4 PCIe support
Date:   Mon, 13 Jun 2022 20:57:05 +0900
Message-Id: <20220613115712.2831386-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.

Yoshihiro Shimoda (7):
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
  PCI: renesas: Add R-Car Gen4 PCIe Host support
  PCI: renesas: Add R-Car Gen4 PCIe Endpoint support
  MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
  arm64: dts: renesas: r8a779f0: Add PCIe Host and Endpoint nodes
  arm64: dts: renesas: r8a779f0: spider: Enable PCIe Host ch0

 .../bindings/pci/rcar-gen4-pci-ep.yaml        | 111 ++++++++
 .../bindings/pci/rcar-gen4-pci-host.yaml      | 104 +++++++
 MAINTAINERS                                   |   1 +
 .../boot/dts/renesas/r8a779f0-spider-cpu.dtsi |  43 +++
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi     | 133 +++++++++
 drivers/pci/controller/dwc/Kconfig            |  18 ++
 drivers/pci/controller/dwc/Makefile           |   2 +
 .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 253 ++++++++++++++++++
 .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 235 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 198 ++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  60 +++++
 11 files changed, 1158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

-- 
2.25.1

