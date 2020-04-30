Return-Path: <SRS0=q/mj=6O=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC44C4724C
	for <linux-pci@archiver.kernel.org>; Thu, 30 Apr 2020 20:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8F420870
	for <linux-pci@archiver.kernel.org>; Thu, 30 Apr 2020 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588279221;
	bh=5Snw5Ucaj8rYXrTv7rmk42pJX+ytZh64Y19B+5t8ZUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=qpHCbq1f1NwjlRov61CXo4BZag6/KtT/z2lArF6/TXBIG1Z3ty5r/H+DFA5DNvb1e
	 4Ysix8X4PiWUkI5B5c4kmk+S8ZA4ZzmO0R2e47Ogfxux9mcHMKKKuaQFk+IyOy9NhR
	 AGj1O9jmH7ahTwAfORAfptHm5nDnRNA8kNw+snoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgD3UkV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgD3UkU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 16:40:20 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BFEF206C0;
        Thu, 30 Apr 2020 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588279219;
        bh=5Snw5Ucaj8rYXrTv7rmk42pJX+ytZh64Y19B+5t8ZUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QQEcW57aBZptdf4jpOft/n3IKmo0zDugFzHwKTWq/Y2GcQ7r1C23c5kd2fISfvG+M
         HkGzyX5fzulrTCYiTUXYSwvpM/24r4Sq7SBY9lt0Atc1ZQSDUtNVdk1hQnUJbwkYPK
         ND3uH56xSkxeZT0Bch/NYTzZtMkCULqOh0dOlS4I=
Date:   Thu, 30 Apr 2020 15:40:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] PCI: brcmstb: disable L0s component of ASPM by
 default
Message-ID: <20200430204017.GA62947@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430185522.4116-5-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 02:55:22PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Some informal internal experiments has shown that the BrcmSTB ASPM L0s
> savings may introduce an undesirable noise signal on some customers'
> boards.  In addition, L0s was found lacking in realized power savings,
> especially relative to the L1 ASPM component.  This is BrcmSTB's
> experience and may not hold for others.  At any rate, we disable L0s
> savings by default unless the DT node has the 'brcm,aspm-en-l0s'
> property.

I assume this works by writing the PCIe Link Capabilities register,
which is read-only via the config space path used by the generic ASPM
code, so that code thinks the device doesn't support L0s at all.

Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt includes
an "aspm-no-l0s" property.  It'd be nice if this could use the same
property.

> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 2bc913c0262c..bc1d514b19e4 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -44,6 +44,9 @@
>  #define PCIE_RC_CFG_PRIV1_ID_VAL3			0x043c
>  #define  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK	0xffffff
>  
> +#define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
> +#define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
> +
>  #define PCIE_RC_DL_MDIO_ADDR				0x1100
>  #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
>  #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
> @@ -696,7 +699,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	int num_out_wins = 0;
>  	u16 nlw, cls, lnksta;
>  	int i, ret;
> -	u32 tmp;
> +	u32 tmp, aspm_support;
>  
>  	/* Reset the bridge */
>  	brcm_pcie_bridge_sw_init_set(pcie, 1);
> @@ -806,6 +809,15 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  		num_out_wins++;
>  	}
>  
> +	/* Only support ASPM L1 unless L0s is explicitly desired */
> +	aspm_support = PCIE_LINK_STATE_L1;
> +	if (of_property_read_bool(pcie->np, "brcm,aspm-en-l0s"))
> +		aspm_support |= PCIE_LINK_STATE_L0S;
> +	tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> +	u32p_replace_bits(&tmp, aspm_support,
> +		PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK);
> +	writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
> +
>  	/*
>  	 * For config space accesses on the RC, show the right class for
>  	 * a PCIe-PCIe bridge (the default setting is to be EP mode).
> -- 
> 2.17.1
> 
