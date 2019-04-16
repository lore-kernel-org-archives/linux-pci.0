Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E6FC10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 10:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774FB206BA
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 10:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfDPKFI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:05:08 -0400
Received: from foss.arm.com ([217.140.101.70]:51254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfDPKFI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Apr 2019 06:05:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EC7180D;
        Tue, 16 Apr 2019 03:05:08 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 073723F68F;
        Tue, 16 Apr 2019 03:05:06 -0700 (PDT)
Date:   Tue, 16 Apr 2019 11:05:04 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     wangzhou1@hisilicon.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: fix warning for struct hisi_pcie_platform_ops
Message-ID: <20190416100504.GA14503@red-moon>
References: <20190415085349.161915-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415085349.161915-1-maowenan@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 15, 2019 at 04:53:49PM +0800, Mao Wenan wrote:
> There is one warning exist while compiling drivers/pci/controller/dwc/pcie-hisi.c.
> make allmodconfig ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> make C=2 drivers/pci/controller/dwc/pcie-hisi.o ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
> drivers/pci/controller/dwc/pcie-hisi.c:365:21: warning: symbol 'hisi_pcie_platform_ops' was not declared. Should it be static?
> 
> Fixes: a2ec1996098("PCI: hisi: Add DT almost-ECAM support for Hip06/Hip07 host controllers")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/pci/controller/dwc/pcie-hisi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/misc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-hisi.c b/drivers/pci/controller/dwc/pcie-hisi.c
> index 6d9e1b2..11f5ff7 100644
> --- a/drivers/pci/controller/dwc/pcie-hisi.c
> +++ b/drivers/pci/controller/dwc/pcie-hisi.c
> @@ -362,7 +362,7 @@ static int hisi_pcie_platform_init(struct pci_config_window *cfg)
>  	return 0;
>  }
>  
> -struct pci_ecam_ops hisi_pcie_platform_ops = {
> +static struct pci_ecam_ops hisi_pcie_platform_ops = {
>  	.bus_shift    = 20,
>  	.init         =  hisi_pcie_platform_init,
>  	.pci_ops      = {
> -- 
> 2.7.4
> 
