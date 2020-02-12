Return-Path: <SRS0=ut+1=4A=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C84CC3B186
	for <linux-pci@archiver.kernel.org>; Wed, 12 Feb 2020 14:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DECD20873
	for <linux-pci@archiver.kernel.org>; Wed, 12 Feb 2020 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581516277;
	bh=o9BHn+9tET4BD0g8kAYLMhwyFEa94It7nBIG65XyVow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=q2oMSwY9PY/+yeRTjQdqGfWlrSNGXz6F+TcAWRMKsQem5AgUgFXzKHTUiSOmoZNaa
	 Nv/aot4h2rg9njVkJKuLXLImWeKUJw8FDKr37lAHOSX/KXjeZ//LRLEcLtSafFgO+Y
	 MTELGBrEzEn9d+5uLkB9gN568cSf9vn87ese8n9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgBLOEg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgBLOEg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 09:04:36 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7839A20724;
        Wed, 12 Feb 2020 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581516275;
        bh=o9BHn+9tET4BD0g8kAYLMhwyFEa94It7nBIG65XyVow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ybhA5sw1XC0h+W6Zeya0JSyVEIzLi+xMgWYE+Dwss2uAZuddrdzio//rz6eimr3jf
         5fLzed0lzlgiW1e3gJzM4JGdbsZRLPLhAOBWjt9aGVTFpyj7hLZk6qW6Tax2jy+LJS
         zVOS8XI3s1D5+v5kCab07CmDWyahtMIe3CLy9eEY=
Date:   Wed, 12 Feb 2020 08:04:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 2/6] PCI: rcar: Fix calculating mask for PCIEPAMR
 register
Message-ID: <20200212140434.GA129189@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208183641.6674-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 08, 2020 at 06:36:37PM +0000, Lad Prabhakar wrote:
> The mask value was calculated incorrectly for PCIEPAMR register if the
> size was less the 128bytes, this patch fixes the above by adding a check
> on size.

s/less the/less than/
s/128bytes,/128 bytes./
s/this patch fixes the above/Fix this issue/

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pci/controller/pcie-rcar.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index d5568db..c76a92a 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -71,7 +71,7 @@ void rcar_pcie_set_outbound(int win, void __iomem *base,
>  	/* Setup PCIe address space mappings for each resource */
>  	resource_size_t res_start;
>  	resource_size_t size;
> -	u32 mask;
> +	u32 mask = 0x0;
>  
>  	rcar_pci_write_reg(base, 0x00000000, PCIEPTCTLR(win));
>  
> @@ -80,7 +80,8 @@ void rcar_pcie_set_outbound(int win, void __iomem *base,
>  	 * keeps things pretty simple.
>  	 */
>  	size = resource_size(res);
> -	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
> +	if (size > 128)
> +		mask = (roundup_pow_of_two(size) / SZ_128) - 1;

I would put the "mask = 0x0" right here so it's all in one place,
i.e.,

  if (size > 128)
    mask = (roundup_pow_of_two(size) / SZ_128) - 1;
  else
    mask = 0x0;

>  	rcar_pci_write_reg(base, mask << 7, PCIEPAMR(win));
>  
>  	if (!host) {
> -- 
> 2.7.4
> 
