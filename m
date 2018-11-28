Return-Path: <SRS0=2mbU=OH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8857DC43441
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 04:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51446205C9
	for <linux-pci@archiver.kernel.org>; Wed, 28 Nov 2018 04:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51446205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeK1PEj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 28 Nov 2018 10:04:39 -0500
Received: from mx.socionext.com ([202.248.49.38]:37675 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeK1PEj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Nov 2018 10:04:39 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 28 Nov 2018 13:04:28 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id A216360062;
        Wed, 28 Nov 2018 13:04:28 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 28 Nov 2018 13:04:28 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 0E4281A1235;
        Wed, 28 Nov 2018 13:04:28 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v4 0/2] Add new UniPhier PCIe host driver
Date:   Wed, 28 Nov 2018 13:04:24 +0900
Message-Id: <1543377866-16634-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds PCIe host controller driver for Socionext UniPhier SoCs.
This controller is based on the DesignWare PCIe core. This driver
supports LD20 and PXs3 SoCs.

v3: https://www.spinics.net/lists/linux-pci/msg77224.html

About legacy IRQ, it might be necessary to share common view from
keystone driver that have been cleaned up[1].

[1] https://lore.kernel.org/patchwork/patch/989541/

Changes since v3:
- dt-bindings: fix INTX numbering of legacy interrupt map
- change interrupts to level ones
- remove .xlate function
- merge uniphier_pcie_ltssm_disable() into uniphier_pcie_ltssm_enable()
- remove an error message on uniphier_pcie_establish_link()
- change the order between irq_domain_add_liniear() and
  irq_set_chained_handler_and_data()
- replace dummy_irq_chip with uniphier_pcie_irq_chip and its functions
- add dependency on CONFIG_HAS_IOMEM
- MAINTAINERS: add pcie-uniphier entry

Changes since v2:
- dt-bindings: remove a comment that the node name isn't important
- dt-bindings: remove "intx" interrupt
- dt-bindings: define 'legacy-interrupt-controller' node and its properties
- return an error value when link up fails
- remove devm_request_irq() and a handler for MSI IRQ
- use chained interrupt instead of devm_request_irq() for legacy IRQ
- add unipher_pcie_config_legacy_irq() to get legacy IRQ from
  'legacy-interrupt controller' node
- replace 4 statments to handle INTX with for_each_set_bit()
- remove initialization of pp->root_bus_nr
- remove indivisual interrupt enable bit definitions
- rename 'irq_domain' member to 'legacy_irq_domain' in private structure
- use pci_irqd_intx_xlate() for irq_domain_ops.xlate function

Changes since v1:
- follow capitalization conventions in the descriptions
- use C style comments except for the SPDX line

Kunihiko Hayashi (2):
  dt-bindings: PCI: Add UniPhier PCIe host controller description
  PCI: uniphier: Add UniPhier PCIe host controller support

 .../devicetree/bindings/pci/uniphier-pcie.txt      |  81 ++++
 MAINTAINERS                                        |   7 +
 drivers/pci/controller/dwc/Kconfig                 |  10 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pcie-uniphier.c         | 471 +++++++++++++++++++++
 5 files changed, 570 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
 create mode 100644 drivers/pci/controller/dwc/pcie-uniphier.c

-- 
2.7.4

