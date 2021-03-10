Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960E1C433DB
	for <linux-pci@archiver.kernel.org>; Wed, 10 Mar 2021 19:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B40E64FD9
	for <linux-pci@archiver.kernel.org>; Wed, 10 Mar 2021 19:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhCJTct (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:32:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233992AbhCJTcs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Mar 2021 14:32:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33EEF64FB2;
        Wed, 10 Mar 2021 19:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615404768;
        bh=f5/lUJllLGXsUxKTawCkR3n1Ver3P//PbBnMTRmYk/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fUbYZ64I87gmzgnsW41cv2cHvR1Ba5VaKcad5Du7xG5eVNOyr715DL+39NQuGyE02
         QcI3yJOBiah1yKhatbZOpU4WUOjQv85YQXB726vwjqgB+/EB0fSpVZx96oHkkSsM9I
         m8rv2HkKtGUhf1wrvkPvfrTWQxbLqlXJakLmPUx0L5zRd6fkp7s7mss8K7rAin3chl
         XgKlvGRwIpf7cXK5aLu+ddEEGinavXXwLmnBGK0RIKBeilic6qfpjhbyqN9I5527b5
         gk89tI+MGJ9iX8ote//aWqqqD0Eewn3Gro8vC4LZG4+Ky4eJm+FFaqOUJqVQ0cGpkV
         3nT7vmIcMmEVg==
Date:   Wed, 10 Mar 2021 13:32:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: controller: al: select CONFIG_PCI_ECAM
Message-ID: <20210310193246.GA2033984@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308152501.2135937-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 08, 2021 at 04:24:46PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Compile-testing this driver without ECAM support results in a link
> failure:
> 
> ld.lld: error: undefined symbol: pci_ecam_map_bus
> >>> referenced by pcie-al.c
> >>>               pci/controller/dwc/pcie-al.o:(al_pcie_map_bus) in archive drivers/built-in.a
> 
> Select CONFIG_ECAM like the other drivers do.

Did we add these compile issues in the v5.12-rc1?  I.e., are the fixes
candidates for v5.12?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 5a3032d9b844..d981a0eba99f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -311,6 +311,7 @@ config PCIE_AL
>  	depends on OF && (ARM64 || COMPILE_TEST)
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
> +	select PCI_ECAM
>  	help
>  	  Say Y here to enable support of the Amazon's Annapurna Labs PCIe
>  	  controller IP on Amazon SoCs. The PCIe controller uses the DesignWare
> -- 
> 2.29.2
> 
