Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD615C282CE
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 10:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A783021872
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 10:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfDLKC4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:02:56 -0400
Received: from foss.arm.com ([217.140.101.70]:56904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfDLKC4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 06:02:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88C6615AB;
        Fri, 12 Apr 2019 03:02:55 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7143D3F68F;
        Fri, 12 Apr 2019 03:02:53 -0700 (PDT)
Date:   Fri, 12 Apr 2019 11:02:51 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     honghui.zhang@mediatek.com
Cc:     matthias.bgg@gmail.com, robh@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        ryder.lee@mediatek.com, robh+dt@kernel.org,
        youlin.pei@mediatek.com, jianjun.wang@mediatek.com
Subject: Re: [PATCH] arm64: dts: mt2712: Remove un-used property for PCIe
Message-ID: <20190412100251.GC8113@red-moon>
References: <1552897675-8051-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552897675-8051-1-git-send-email-honghui.zhang@mediatek.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 18, 2019 at 04:27:55PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The "num-lanes" property for PCIe is not used, remove it.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 2 --
>  1 file changed, 2 deletions(-)

Applied to pci/mediatek for v5.2, thanks.

Lorenzo

> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> index 976d92a..43307ba 100644
> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -819,7 +819,6 @@
>  			#size-cells = <2>;
>  			#interrupt-cells = <1>;
>  			ranges;
> -			num-lanes = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
>  					<0 0 0 2 &pcie_intc0 1>,
> @@ -840,7 +839,6 @@
>  			#size-cells = <2>;
>  			#interrupt-cells = <1>;
>  			ranges;
> -			num-lanes = <1>;
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
>  					<0 0 0 2 &pcie_intc1 1>,
> -- 
> 2.6.4
> 
