Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE48C10F0E
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58E92064A
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 13:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfDONAN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:00:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34392 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfDONAN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Apr 2019 09:00:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53E10374;
        Mon, 15 Apr 2019 06:00:13 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE1003F706;
        Mon, 15 Apr 2019 06:00:11 -0700 (PDT)
Date:   Mon, 15 Apr 2019 14:00:09 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     thomas.petazzoni@bootlin.com, jason@lakedaemon.net,
        bhelgaas@google.com, gustavo.pimentel@synopsys.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: mvebu: Make mvebu_pci_bridge_emul_ops static
Message-ID: <20190415130009.GA12388@red-moon>
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

Is Mr.Robot reachable by email ?

If it is a CI bot I doubt it is useful to leave this tag there unless
you want it for accounting purposes, just let me know.

Thanks,
Lorenzo

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pci/controller/pci-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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
