Return-Path: <SRS0=tn0J=7S=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72A7C433DF
	for <linux-pci@archiver.kernel.org>; Fri,  5 Jun 2020 09:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19FF206A2
	for <linux-pci@archiver.kernel.org>; Fri,  5 Jun 2020 09:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgFEJom (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:44:42 -0400
Received: from mx.socionext.com ([202.248.49.38]:45667 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgFEJol (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jun 2020 05:44:41 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 05 Jun 2020 18:44:39 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 8EA4A18010B;
        Fri,  5 Jun 2020 18:44:39 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 5 Jun 2020 18:44:39 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id EF85B1A12AD;
        Fri,  5 Jun 2020 18:44:38 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 0/6] PCI: uniphier: Add features for UniPhier PCIe host controller
Date:   Fri,  5 Jun 2020 18:44:30 +0900
Message-Id: <1591350276-15816-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds some features for UniPhier PCIe host controller.

- Add support for PME and AER invoked by MSI interrupt
- Add iATU register view support for PCIe version >= 4.80
- Add an error message when failing to get phy driver

This adds a new function called by MSI handler in DesignWare PCIe framework,
that invokes PME and AER funcions to detect the factor from SoC-dependent
registers.

Changes since v3:
- Move msi_host_isr() call into dw_handle_msi_irq()
- Move uniphier_pcie_misc_isr() call into the guard of chained_irq
- Use a bool argument is_msi instead of pci_msi_enabled()
- Consolidate handler calls for the same interrupt
- Fix typos in commit messages

Changes since v2:
- Avoid printing phy error message in case of EPROBE_DEFER
- Fix iATU register mapping method
- dt-bindings: Add Acked-by: line
- Fix typos in commit messages
- Use devm_platform_ioremap_resource_byname()

Changes since v1:
- Add check if struct resource is NULL
- Fix warning in the type of dev_err() argument

Kunihiko Hayashi (6):
  PCI: dwc: Add msi_host_isr() callback
  PCI: uniphier: Add misc interrupt handler to invoke PME and AER
  dt-bindings: PCI: uniphier: Add iATU register description
  PCI: uniphier: Add iATU register support
  PCI: uniphier: Add error message when failed to get phy
  PCI: uniphier: Use devm_platform_ioremap_resource_byname()

 .../devicetree/bindings/pci/uniphier-pcie.txt      |  1 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |  3 +
 drivers/pci/controller/dwc/pcie-designware.h       |  1 +
 drivers/pci/controller/dwc/pcie-uniphier.c         | 73 +++++++++++++++++-----
 4 files changed, 63 insertions(+), 15 deletions(-)

-- 
2.7.4

