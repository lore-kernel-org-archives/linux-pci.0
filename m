Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E6C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 12:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96F6218AC
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 12:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfBAMmj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:42:39 -0500
Received: from foss.arm.com ([217.140.101.70]:59380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfBAMmj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 07:42:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C59280D;
        Fri,  1 Feb 2019 04:42:38 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A2233F59C;
        Fri,  1 Feb 2019 04:42:37 -0800 (PST)
Date:   Fri, 1 Feb 2019 12:42:30 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, Joao Pinto <joao.pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v2 0/8] Improve Synopsys DesignWare Root Complex driver
 code
Message-ID: <20190201124230.GA17991@e107981-ln.cambridge.arm.com>
References: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548958059.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 07:16:59PM +0100, Gustavo Pimentel wrote:
> This patch series aims to improve Synopsys DesignWare Root Complex driver
> code by:
>  - removing unnecessary header files
>  - enforcing variable naming coherency among similar functions
>  - simplifing code readability of mask/unmask function operations
>  - replacing bit rotation operation (1 << bit) by BIT(bit)
> 
> No functional changes are intended.
> 
> All patches are independent so they can be easily analyzed and accepted or
> discarded.
> 
> This patches organization also allows to easily merge (squash) some patches,
> if desired.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> 
> Gustavo Pimentel (8):
>   PCI: dwc: Remove unnecessary header include (of_gpio.h)
>   PCI: dwc: Remove unnecessary header include (signal.h)
>   PCI: dwc: Rename variable name from data to d on
>     dw_pci_bottom_mask/unmask()
>   PCI: dwc: Rename variable name from data to d on
>     dw_pci_setup_msi_msg()
>   PCI: dwc: Rename variable name from data to d on
>     dw_pci_msi_set_affinity()
>   PCI: dwc: Rename variable name from data to d on
>     dw_pcie_irq_domain_free()
>   PCI: dwc: Improve code readability and simplifies mask/unmask
>     operations
>   PCI: dwc: Replace bit rotation operation (1 << bit) by BIT(bit)
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c | 52 +++++++++++------------
>  drivers/pci/controller/dwc/pcie-designware-plat.c |  2 -
>  drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>  3 files changed, 27 insertions(+), 29 deletions(-)
> 

Applied to pci/dwc for v5.1, thanks.

Lorenzo
