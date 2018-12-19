Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EC6C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 15:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03B820449
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 15:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeLSPsz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:48:55 -0500
Received: from foss.arm.com ([217.140.101.70]:37788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbeLSPsy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Dec 2018 10:48:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68F0580D;
        Wed, 19 Dec 2018 07:48:54 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51CAC3F675;
        Wed, 19 Dec 2018 07:48:52 -0800 (PST)
Date:   Wed, 19 Dec 2018 15:48:49 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v5 0/2] Add new UniPhier PCIe host driver
Message-ID: <20181219154849.GB25410@e107981-ln.cambridge.arm.com>
References: <1544143992-16385-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544143992-16385-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 07, 2018 at 09:53:10AM +0900, Kunihiko Hayashi wrote:
> This series adds PCIe host controller driver for Socionext UniPhier SoCs.
> This controller is based on the DesignWare PCIe core. This driver
> supports LD20 and PXs3 SoCs.
> 
> v4: https://www.spinics.net/lists/linux-pci/msg78278.html
> 
> About legacy IRQ, it might be necessary to share common view from
> keystone driver that have been cleaned up[1].
> 
> [1] https://lore.kernel.org/patchwork/patch/989541/
> 
> Changes since v4:
> - fix an issue of using the wrong value to mask IRQ mask register
> 
> Changes since v3:
> - dt-bindings: fix INTX numbering of legacy interrupt map
> - change interrupts to level ones
> - remove .xlate function
> - merge uniphier_pcie_ltssm_disable() into uniphier_pcie_ltssm_enable()
> - remove an error message on uniphier_pcie_establish_link()
> - change the order between irq_domain_add_liniear() and
>   irq_set_chained_handler_and_data()
> - replace dummy_irq_chip with uniphier_pcie_irq_chip and its functions
> - add dependency on CONFIG_HAS_IOMEM
> - MAINTAINERS: add pcie-uniphier entry
> 
> Changes since v2:
> - dt-bindings: remove a comment that the node name isn't important
> - dt-bindings: remove "intx" interrupt
> - dt-bindings: define 'legacy-interrupt-controller' node and its properties
> - return an error value when link up fails
> - remove devm_request_irq() and a handler for MSI IRQ
> - use chained interrupt instead of devm_request_irq() for legacy IRQ
> - add unipher_pcie_config_legacy_irq() to get legacy IRQ from
>   'legacy-interrupt controller' node
> - replace 4 statments to handle INTX with for_each_set_bit()
> - remove initialization of pp->root_bus_nr
> - remove indivisual interrupt enable bit definitions
> - rename 'irq_domain' member to 'legacy_irq_domain' in private structure
> - use pci_irqd_intx_xlate() for irq_domain_ops.xlate function
> 
> Changes since v1:
> - follow capitalization conventions in the descriptions
> - use C style comments except for the SPDX line
> 
> Kunihiko Hayashi (2):
>   dt-bindings: PCI: Add UniPhier PCIe host controller description
>   PCI: uniphier: Add UniPhier PCIe host controller support
> 
>  .../devicetree/bindings/pci/uniphier-pcie.txt      |  81 ++++
>  MAINTAINERS                                        |   7 +
>  drivers/pci/controller/dwc/Kconfig                 |  10 +
>  drivers/pci/controller/dwc/Makefile                |   1 +
>  drivers/pci/controller/dwc/pcie-uniphier.c         | 471 +++++++++++++++++++++
>  5 files changed, 570 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/uniphier-pcie.txt
>  create mode 100644 drivers/pci/controller/dwc/pcie-uniphier.c

Applied to pci/uniphier, aiming for v4.21, thanks.

Lorenzo
