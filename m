Return-Path: <SRS0=cJ9t=SD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796A0C43381
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 13:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4749720830
	for <linux-pci@archiver.kernel.org>; Mon,  1 Apr 2019 13:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfDANue (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:50:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbfDANue (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Apr 2019 09:50:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3E1280D;
        Mon,  1 Apr 2019 06:50:33 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 392733F59C;
        Mon,  1 Apr 2019 06:50:32 -0700 (PDT)
Date:   Mon, 1 Apr 2019 14:50:18 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 0/5] PCI: dwc: Support remove
Message-ID: <20190401134946.GA4722@e107981-ln.cambridge.arm.com>
References: <20190329194750.265f6df6@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329194750.265f6df6@xhacker.debian>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 29, 2019 at 11:55:36AM +0000, Jisheng Zhang wrote:
> Currently, the PCI dwc host users don't support the remove, but nothing
> prevent us from supporting it. To achieve this goal, we need to ensure
> we can do necessary clean up work.
> 
> Changes since v3:
>   - add Gustavo's ACK to patch2, patch5
>   - remove IS_ENABLED(CONFIG_PCI_MSI) check
> 
> Changes since v2:
>   - address all Gustavo's comments
>   - add Gustavo's ACK to patch1, patch3, patch4
> 
> Changes since v1:
>   - address Bjorn's comments, I.E Capitalize, s/irq/IRQ/, s/msi/MSI/
> 
> 
> Jisheng Zhang (5):
>   PCI: dwc: Fix dw_pcie_free_msi() if msi_irq is invalid
>   PCI: dwc: Free the page for MSI IRQ in dw_pcie_free_msi()
>   PCI: dwc: Free MSI in the error code path of dw_pcie_host_init()
>   PCI: dwc: Use devm_pci_alloc_host_bridge() to simplify the code
>   PCI: dwc: Save root bus for driver remove
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 60 ++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 +
>  2 files changed, 34 insertions(+), 28 deletions(-)
 
Applied to pci/dwc for v5.2, thanks.

Lorenzo
