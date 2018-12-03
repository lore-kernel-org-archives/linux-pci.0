Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39B2C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 21:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5582087F
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 21:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhCG5//W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5582087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeLCVGG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:06:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLCVGF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 16:06:05 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C18E2082F;
        Mon,  3 Dec 2018 21:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543871164;
        bh=PvoMyo+/n4YeOvpFXSplnX/WqoiaryB2LW1RF3g/evw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhCG5//W7gbOuGItph8C16C7mNwe+oNwxdn95fKeeT9bydxks1FEkV3qL7myzVl5Z
         WAVs/erdvCaFRh+8OTJLoNVz0fc3uV7cM+yQaVZfGlr+HkQqlYfEKDBL1d0pqoZz1S
         V/JsWo1KtKIOQ5cebkyV61MqN8RBolbvHsFGwLR4=
Date:   Mon, 3 Dec 2018 15:06:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH 1/2] PCI: mobiveil: ls_pcie_g4: add Workaround for
 A-011577
Message-ID: <20181203210602.GB207198@google.com>
References: <20181202133303.33988-1-Zhiqiang.Hou@nxp.com>
 <20181202133303.33988-2-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202133303.33988-2-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 02, 2018 at 01:32:42PM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Can we pick one driver name (either "mobiveil" or "ls_pcie_g4" (this
seems excessively long and excessively specific), or something else)?
I don't want to waste the space of "PCI: mobiveil: ls_pcie_g4:" in
every future subject line.

Then "Add workaround for ...".  I assume the "A-011577" part is
meaningful inside NXP, but it's not useful to anybody else.  Move that
to the changelog proper and say something about the actual issue in
the subject.

> PCIe configuration access to non-existent function triggered
> SERROR interrupt exception.
> 
> Workaround:
> Disable error reporting on AXI bus during the Vendor ID read
> transactions in enumeration.
> 
> This ERRATA is only for LX2160A Rev1.0, and it will be fixed
> in Rev2.0.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  .../controller/mobiveil/pci-layerscape-gen4.c | 24 +++++++++++++++++++
>  .../controller/mobiveil/pcie-mobiveil-host.c  | 13 +++++++++-
>  .../pci/controller/mobiveil/pcie-mobiveil.h   |  2 ++
>  3 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> index 174cbcac4059..1fe56532b288 100644
> --- a/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> +++ b/drivers/pci/controller/mobiveil/pci-layerscape-gen4.c
> @@ -24,6 +24,9 @@
>  
>  /* LUT and PF control registers */
>  #define PCIE_LUT_OFF			(0x80000)
> +#define PCIE_LUT_GCR			(0x28)
> +#define PCIE_LUT_GCR_RRE		(0)
> +
>  #define PCIE_PF_OFF			(0xc0000)
>  #define PCIE_PF_INT_STAT		(0x18)
>  #define PF_INT_STAT_PABRST		(31)
> @@ -188,8 +191,29 @@ static void ls_pcie_g4_reset(struct work_struct *work)
>  	ls_pcie_g4_reinit_hw(pcie);
>  }
>  
> +static int ls_pcie_g4_read_other_conf(struct pci_bus *bus, unsigned int devfn,
> +				   int where, int size, u32 *val)
> +{
> +	struct mobiveil_pcie *pci = bus->sysdata;
> +	struct ls_pcie_g4 *pcie = to_ls_pcie_g4(pci);
> +	int ret;
> +
> +	if (where == PCI_VENDOR_ID)
> +		ls_pcie_g4_lut_writel(pcie, PCIE_LUT_GCR,
> +				      0 << PCIE_LUT_GCR_RRE);
> +
> +	ret = pci_generic_config_read(bus, devfn, where, size, val);
> +
> +	if (where == PCI_VENDOR_ID)
> +		ls_pcie_g4_lut_writel(pcie, PCIE_LUT_GCR,
> +				      1 << PCIE_LUT_GCR_RRE);

1) As a general style rule, it's better to "clear, then restore" than
to "clear, then set" the bit.  That way if somebody elsewhere decides
that PCIE_LUT_GCR_RRE should be cleared by default, this code won't
stomp on that decision.  E.g.,

  gcr = ls_pcie_g4_lut_readl(...);
  ls_pcie_g4_lut_writel(..., 0 << PCIE_LUT_GCR_RRE);
  ret = pci_generic_config_read(...);
  ls_pcie_g4_lut_writel(..., gcr);

2) I don't *think* the PCIe spec requires that the first access to a
device be a read of the Vendor ID, so this is a 99% solution, not a
100% solution.  A 100% solution would be to handle the SERROR so it's
not fatal.  But I'm pretty sure Linux always does read the Vendor ID
first (except after a reset, and when we do config reads after a
reset, we already know the device *exists*), so this is probably
pretty safe.

> +	return ret;
> +}
> +
>  static struct mobiveil_rp_ops ls_pcie_g4_rp_ops = {
>  	.interrupt_init = ls_pcie_g4_interrupt_init,
> +	.read_other_conf = ls_pcie_g4_read_other_conf,
>  };
>  
>  static const struct mobiveil_pab_ops ls_pcie_g4_pab_ops = {
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index c85f00d3cfcf..8b6db38320d7 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -79,9 +79,20 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bus *bus,
>  	return pcie->rp.config_axi_slave_base + where;
>  }
>  
> +static int mobiveil_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> +				     int where, int size, u32 *val)
> +{
> +	struct mobiveil_pcie *pcie = bus->sysdata;
> +	struct root_port *rp = &pcie->rp;
> +
> +	if (bus->number > rp->root_bus_nr && rp->ops->read_other_conf)
> +		return rp->ops->read_other_conf(bus, devfn, where, size, val);
> +
> +	return pci_generic_config_read(bus, devfn, where, size, val);
> +}
>  static struct pci_ops mobiveil_pcie_ops = {
>  	.map_bus = mobiveil_pcie_map_bus,
> -	.read = pci_generic_config_read,
> +	.read = mobiveil_pcie_config_read,
>  	.write = pci_generic_config_write,
>  };
>  
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 0ccd6cee5f8f..ef93b41f4419 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -145,6 +145,8 @@ struct mobiveil_msi {			/* MSI information */
>  
>  struct mobiveil_rp_ops {
>  	int (*interrupt_init)(struct mobiveil_pcie *pcie);
> +	int (*read_other_conf)(struct pci_bus *bus, unsigned int devfn,
> +			       int where, int size, u32 *val);
>  };
>  
>  struct root_port {
> -- 
> 2.17.1
> 
