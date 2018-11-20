Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1EDC04EBC
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 13:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3714120672
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 13:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3714120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeKTXdc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:33:32 -0500
Received: from foss.arm.com ([217.140.101.70]:48572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbeKTXdb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 18:33:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FEB580D;
        Tue, 20 Nov 2018 05:04:29 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9EB63F5B7;
        Tue, 20 Nov 2018 05:04:27 -0800 (PST)
Date:   Tue, 20 Nov 2018 13:04:25 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: layerscape: constify driver data
Message-ID: <20181120130425.GB23472@e107981-ln.cambridge.arm.com>
References: <20181119100022.27501-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119100022.27501-1-stefan@agner.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 19, 2018 at 11:00:22AM +0100, Stefan Agner wrote:
> Constify driver data since they don't get changed at runtime.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied to pci/dwc for v4.21.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 3724d3ef7008..905a0ab0e6fa 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -222,12 +222,12 @@ static const struct dw_pcie_ops dw_ls_pcie_ops = {
>  	.link_up = ls_pcie_link_up,
>  };
>  
> -static struct ls_pcie_drvdata ls1021_drvdata = {
> +static const struct ls_pcie_drvdata ls1021_drvdata = {
>  	.ops = &ls1021_pcie_host_ops,
>  	.dw_pcie_ops = &dw_ls1021_pcie_ops,
>  };
>  
> -static struct ls_pcie_drvdata ls1043_drvdata = {
> +static const struct ls_pcie_drvdata ls1043_drvdata = {
>  	.lut_offset = 0x10000,
>  	.ltssm_shift = 24,
>  	.lut_dbg = 0x7fc,
> @@ -235,7 +235,7 @@ static struct ls_pcie_drvdata ls1043_drvdata = {
>  	.dw_pcie_ops = &dw_ls_pcie_ops,
>  };
>  
> -static struct ls_pcie_drvdata ls1046_drvdata = {
> +static const struct ls_pcie_drvdata ls1046_drvdata = {
>  	.lut_offset = 0x80000,
>  	.ltssm_shift = 24,
>  	.lut_dbg = 0x407fc,
> @@ -243,7 +243,7 @@ static struct ls_pcie_drvdata ls1046_drvdata = {
>  	.dw_pcie_ops = &dw_ls_pcie_ops,
>  };
>  
> -static struct ls_pcie_drvdata ls2080_drvdata = {
> +static const struct ls_pcie_drvdata ls2080_drvdata = {
>  	.lut_offset = 0x80000,
>  	.ltssm_shift = 0,
>  	.lut_dbg = 0x7fc,
> @@ -251,7 +251,7 @@ static struct ls_pcie_drvdata ls2080_drvdata = {
>  	.dw_pcie_ops = &dw_ls_pcie_ops,
>  };
>  
> -static struct ls_pcie_drvdata ls2088_drvdata = {
> +static const struct ls_pcie_drvdata ls2088_drvdata = {
>  	.lut_offset = 0x80000,
>  	.ltssm_shift = 0,
>  	.lut_dbg = 0x407fc,
> -- 
> 2.19.1
> 
