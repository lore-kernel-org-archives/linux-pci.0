Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E53DC4161D
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E621520685
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 11:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E621520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbeKTWGI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:06:08 -0500
Received: from foss.arm.com ([217.140.101.70]:47482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbeKTWGI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 17:06:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 773CC80D;
        Tue, 20 Nov 2018 03:37:25 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 216F53F575;
        Tue, 20 Nov 2018 03:37:23 -0800 (PST)
Date:   Tue, 20 Nov 2018 11:37:18 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     Jianguo Sun <sunjianguo1@huawei.com>,
        kernel-janitors@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: histb: constify dw_pcie_host_ops structure
Message-ID: <20181120113718.GA20893@e107981-ln.cambridge.arm.com>
References: <1540665079-27788-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540665079-27788-1-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 27, 2018 at 08:31:19PM +0200, Julia Lawall wrote:
> The dw_pcie_host_ops structure is only stored in the ops field
> of a pcie_port structure, and this field is const, so make the
> dw_pcie_host_ops structure const as well.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  drivers/pci/controller/dwc/pcie-histb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/dwc for v4.21, thanks.

Lorenzo

> diff -u -p a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -202,7 +202,7 @@ static int histb_pcie_host_init(struct p
>  	return 0;
>  }
>  
> -static struct dw_pcie_host_ops histb_pcie_host_ops = {
> +static const struct dw_pcie_host_ops histb_pcie_host_ops = {
>  	.rd_own_conf = histb_pcie_rd_own_conf,
>  	.wr_own_conf = histb_pcie_wr_own_conf,
>  	.host_init = histb_pcie_host_init,
> 
