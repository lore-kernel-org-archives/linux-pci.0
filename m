Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDF3C4360F
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8267920700
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 17:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDCRMD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:12:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45344 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfDCRMC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Apr 2019 13:12:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6934780D;
        Wed,  3 Apr 2019 10:12:02 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFB693F68F;
        Wed,  3 Apr 2019 10:12:00 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:11:55 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/8] PCI: DWC/Keystone: MSI configuration cleanup
Message-ID: <20190403171154.GA3783@red-moon>
References: <20190321095927.7058-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321095927.7058-1-kishon@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 21, 2019 at 03:29:19PM +0530, Kishon Vijay Abraham I wrote:
> This series tries to address the comments discussed in [1] w.r.t
> removing Keystone specific callbacks defined in dw_pcie_host_ops.
> 
> This series also tries to cleanup the Keystone interrupt handling
> part.
> 
> Changes from v4:
> *) Removed legacy interrupt cleanup patch which uses hierarchy IRQ
>    domain since TI platform uses edge interrupt for legacy interrupt.
>    This will be deferred till I get more details from HW team.
> 
> Changes from v3:
> *) Uses hierarchy IRQ domain for legacy interrupts since there is 1:1
>    mapping between legacy interrupt and GIC IRQ.
>    (MSI still depends on the order of IRQs populated in dt).
> 
> Changes from v2:
> *) Removed patch that modifies ks_pcie_legacy_irq_handler() to check the
>    IRQ_STATUS of INTA/B/C/D. Lorenzo's comment to create a matrix
>    LinuxIRQ x INTx will be added in AM654x PCIe support series
> *) ks_pcie_legacy_irq_handler() is made to use hwirq to get IRQ offset
>    instead of virq.
> *) default msi_irq_chip is assigned in dw_pcie_host_init() once keystone
>    assigns its msi_irq_chip
> *) Fixed other minor comments from Lorenzo and Bjorn
> 
> Changes from v1:
> *) Removed "PCI: keystone: Use "dummy_irq_chip" instead of new irqchip
> for legacy interrupt handling" from the patch series. It should be
> handled differently.
> 
> *) Added Gustavo's ACKed by and fixed a commit message.
> 
> [1] -> https://patchwork.kernel.org/patch/10681587/
> 
> Kishon Vijay Abraham I (8):
>   PCI: keystone: Cleanup interrupt related macros
>   PCI: keystone: Add separate functions for configuring MSI and legacy
>     interrupt
>   PCI: keystone: Use hwirq to get the MSI IRQ number offset
>   PCI: keystone: Cleanup ks_pcie_msi_irq_handler
>   PCI: dwc: Add support to use non default msi_irq_chip
>   PCI: keystone: Use Keystone specific msi_irq_chip
>   PCI: dwc: Remove Keystone specific dw_pcie_host_ops
>   PCI: dwc: Do not write to MSI control registers if the platform
>     doesn't use it
> 
>  drivers/pci/controller/dwc/pci-keystone.c     | 365 ++++++++++--------
>  .../pci/controller/dwc/pcie-designware-host.c |  78 ++--
>  drivers/pci/controller/dwc/pcie-designware.h  |   6 +-
>  3 files changed, 233 insertions(+), 216 deletions(-)

I would need Gustavo's ACKs on dwc patches, I will queue the
series then.

Lorenzo
