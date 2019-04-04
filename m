Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF597C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 09:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA791206B6
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 09:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbfDDJ2l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:28:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55936 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733193AbfDDJ2l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Apr 2019 05:28:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D8BB169E;
        Thu,  4 Apr 2019 02:28:40 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00D423F557;
        Thu,  4 Apr 2019 02:28:38 -0700 (PDT)
Date:   Thu, 4 Apr 2019 10:28:33 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V5 6/6] PCI: rcar: Fix 64bit MSI message address handling
Message-ID: <20190404092833.GA13236@red-moon>
References: <20190402013307.20912-1-marek.vasut@gmail.com>
 <20190402013307.20912-6-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402013307.20912-6-marek.vasut@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 02, 2019 at 03:33:07AM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> The MSI message address in the RC address space can be 64 bit. The
> R-Car PCIe RC supports such a 64bit MSI message address as well.
> The code currently uses virt_to_phys(__get_free_pages()) to obtain
> a reserved page for the MSI message address, and the return value
> of which can be a 64 bit physical address on 64 bit system.
> 
> However, the driver only programs PCIEMSIALR register with the bottom
> 32 bits of the virt_to_phys(__get_free_pages()) return value and does
> not program the top 32 bits into PCIEMSIAUR, but rather programs the
> PCIEMSIAUR register with 0x0. This worked fine on older 32 bit R-Car
> SoCs, however may fail on new 64 bit R-Car SoCs.
> 
> Since from a PCIe controller perspective, an inbound MSI is a memory
> write to a special address (in case of this controller, defined by
> the value in PCIEMSIAUR:PCIEMSIALR), which triggers an interrupt, but
> never hits the DRAM _and_ because allocation of an MSI by a PCIe card
> driver obtains the MSI message address by reading PCIEMSIAUR:PCIEMSIALR
> in rcar_msi_setup_irqs(), incorrectly programmed PCIEMSIAUR cannot
> cause memory corruption or other issues.
> 
> There is however the possibility that if virt_to_phys(__get_free_pages())
> returned address above the 32bit boundary _and_ PCIEMSIAUR was programmed
> to 0x0 _and_ if the system had physical RAM at the address matching the
> value of PCIEMSIALR, a PCIe card driver could allocate a buffer with a
> physical address matching the value of PCIEMSIALR and a remote write to
> such a buffer by a PCIe card would trigger a spurious MSI.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> V2: - s/it's/its/ in commit message
>     - Add R-B from Geert
> V3: - Reworded commit message and thus dropped Geerts R-B
> V4: - Add Geert's R-B again
> V5: - Rebase on next/master 20190401
>     - Use {lower,upper}_32_bits() instead of >> 32

If that's the only reason you resent this series I will add the
lower_32_bits() code myself.

Please do not rebase on top of next, apply code on top of a fixed -rc1
(we are currently using v5.1-rc1) and if there are dependencies on code
already queued do let us know, we will handle conflicts in next
ourselves.

Lorenzo

> ---
>  drivers/pci/controller/pcie-rcar.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 168bc6b9bb93..5e0102796345 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -892,7 +892,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
>  	struct rcar_msi *msi = &pcie->msi;
> -	unsigned long base;
> +	phys_addr_t base;
>  	int err, i;
>  
>  	mutex_init(&msi->lock);
> @@ -933,8 +933,8 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
>  	msi->pages = __get_free_pages(GFP_KERNEL, 0);
>  	base = virt_to_phys((void *)msi->pages);
>  
> -	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
> -	rcar_pci_write_reg(pcie, 0, PCIEMSIAUR);
> +	rcar_pci_write_reg(pcie, lower_32_bits(base) | MSIFE, PCIEMSIALR);
> +	rcar_pci_write_reg(pcie, upper_32_bits(base), PCIEMSIAUR);
>  
>  	/* enable all MSI interrupts */
>  	rcar_pci_write_reg(pcie, 0xffffffff, PCIEMSIIER);
> -- 
> 2.20.1
> 
