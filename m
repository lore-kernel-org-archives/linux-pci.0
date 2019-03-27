Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DE4C10F00
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 11:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EC42087C
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 11:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="H87w/Mv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfC0L0D (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:26:03 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:55570 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfC0L0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 07:26:03 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 580C125BF18;
        Wed, 27 Mar 2019 22:26:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1553685961; bh=PfochXcsx5MZvh9dpTm8dP6sOBGVF3CjmFurATitOxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H87w/Mv3qMoQOlA2Q1K98BYAB1BV9QzJmhiOt6R4APh118ukx/cZBD3+9qjP/48ip
         8wEnD9YYDjky1oCo5UejcVBxDWFu72KaKTNTDuvPzGdzezQBBTg3ZrmDsovhCDZaea
         IDV4Sj8ZFbWKgJpT+oiaTxmmkfVd0xxa8qW740Jk=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 70C9D940376; Wed, 27 Mar 2019 12:25:58 +0100 (CET)
Date:   Wed, 27 Mar 2019 12:25:58 +0100
From:   Simon Horman <horms@verge.net.au>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V4 3/6] PCI: rcar: Replace various variable types with
 unsigned ones for register values
Message-ID: <20190327112558.q5ho4wehulqf42yp@verge.net.au>
References: <20190325114101.10198-1-marek.vasut@gmail.com>
 <20190325114101.10198-3-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325114101.10198-3-marek.vasut@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 12:40:58PM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> Replace various variable types with u32 or unsigned int type for
> variables holding register values, since the registers are 32bit.
> Note that rcar_pcie_msi_irq() still uses various variable types
> because both find_first_bit() and __fls() require various variable
> types as an argument.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> V2: - s@unsigned long@various variable types@ in the commit message
>     - Replace int with unsigned int for the $shift variable
>     - Replace int with unsigned int / u32 in rcar_pcie_config_access()
> V3: - Change shift from u32 to unsigned int
>     - Change addr and data in phy_write_reg() from unsigned int to u32
> V4: - Change reg to unsigned int in rcar_pcie_config_access()
> ---
>  drivers/pci/controller/pcie-rcar.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 3db693b4410e..6699211fdc9a 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -170,7 +170,7 @@ enum {
>  
>  static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
>  {
> -	int shift = 8 * (where & 3);
> +	unsigned int shift = 8 * (where & 3);
>  	u32 val = rcar_pci_read_reg(pcie, where & ~3);
>  
>  	val &= ~(mask << shift);
> @@ -180,7 +180,7 @@ static void rcar_rmw32(struct rcar_pcie *pcie, int where, u32 mask, u32 data)
>  
>  static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
>  {
> -	int shift = 8 * (where & 3);
> +	unsigned int shift = 8 * (where & 3);
>  	u32 val = rcar_pci_read_reg(pcie, where & ~3);
>  
>  	return val >> shift;
> @@ -191,7 +191,7 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
>  		unsigned char access_type, struct pci_bus *bus,
>  		unsigned int devfn, int where, u32 *data)
>  {
> -	int dev, func, reg, index;
> +	unsigned int dev, func, reg, index;
>  
>  	dev = PCI_SLOT(devfn);
>  	func = PCI_FUNC(devfn);
> @@ -295,8 +295,9 @@ static int rcar_pcie_write_conf(struct pci_bus *bus, unsigned int devfn,
>  				int where, int size, u32 val)
>  {
>  	struct rcar_pcie *pcie = bus->sysdata;
> -	int shift, ret;
> +	unsigned int shift;
>  	u32 data;
> +	int ret;
>  
>  	ret = rcar_pcie_config_access(pcie, RCAR_PCI_ACCESS_READ,
>  				      bus, devfn, where, &data);
> @@ -506,10 +507,10 @@ static int phy_wait_for_ack(struct rcar_pcie *pcie)
>  }
>  
>  static void phy_write_reg(struct rcar_pcie *pcie,
> -				 unsigned int rate, unsigned int addr,
> -				 unsigned int lane, unsigned int data)
> +			  unsigned int rate, u32 addr,
> +			  unsigned int lane, u32 data)
>  {
> -	unsigned long phyaddr;
> +	u32 phyaddr;
>  
>  	phyaddr = WRITE_CMD |
>  		((rate & 1) << RATE_POS) |
> @@ -1117,7 +1118,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct rcar_pcie *pcie;
> -	unsigned int data;
> +	u32 data;
>  	int err;
>  	int (*phy_init_fn)(struct rcar_pcie *);
>  	struct pci_host_bridge *bridge;
> -- 
> 2.20.1
> 
