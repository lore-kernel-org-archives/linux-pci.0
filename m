Return-Path: <SRS0=aMvC=SS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FFBC10F13
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 10:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9322D206B6
	for <linux-pci@archiver.kernel.org>; Tue, 16 Apr 2019 10:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfDPKIm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:08:42 -0400
Received: from foss.arm.com ([217.140.101.70]:51322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfDPKIm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Apr 2019 06:08:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3911880D;
        Tue, 16 Apr 2019 03:08:42 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B28E63F68F;
        Tue, 16 Apr 2019 03:08:40 -0700 (PDT)
Date:   Tue, 16 Apr 2019 11:08:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     thomas.petazzoni@bootlin.com, jason@lakedaemon.net,
        bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: mvebu: Make mvebu_pci_bridge_emul_ops static
Message-ID: <20190416100841.GB14503@red-moon>
References: <20190410140949.26716-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410140949.26716-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 10, 2019 at 10:09:49PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/pci/controller/pci-mvebu.c:557:28: warning:
>  symbol 'mvebu_pci_bridge_emul_ops' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pci/controller/pci-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/misc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index d3a0419..ed032e9 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -554,7 +554,7 @@ mvebu_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
>  	}
>  }
>  
> -struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
> +static struct pci_bridge_emul_ops mvebu_pci_bridge_emul_ops = {
>  	.write_base = mvebu_pci_bridge_emul_base_conf_write,
>  	.read_pcie = mvebu_pci_bridge_emul_pcie_conf_read,
>  	.write_pcie = mvebu_pci_bridge_emul_pcie_conf_write,
> -- 
> 2.7.4
> 
> 
