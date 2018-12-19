Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F20C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 14:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD08218AE
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 14:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545228765;
	bh=mYSv6C/anEPEOntT611vVWNftpPDSMGVwZM4K2vIyl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fd0YafXvzthuxgledV0D2ectDluXpMPOtpCIC4tC3fXQSbltWsHHMCL2MTnNz9NKz
	 Cp3jO9yWsoZiwAhL9GJcvlitVsh3d1KP17r/Si6bbMx+/BTCaJJmQCo1daPyp1fTrm
	 NvIe5qUqjLFp4rlFhQxgIdVtBwiYvFiPn204OXEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeLSOMo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:12:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727635AbeLSOMo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Dec 2018 09:12:44 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 669512084A;
        Wed, 19 Dec 2018 14:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545228763;
        bh=mYSv6C/anEPEOntT611vVWNftpPDSMGVwZM4K2vIyl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ByvLzt4YfomMJA54EMmSb1yQTm5xnxXrsuygozJeZ5oY5zmyIugwowSxbSaIjs0k7
         WEWq/5bv8YbYMp8rBhUNcvtBtvW0kRl/4hzorhM+j6FYGYvR25WM0MqOZa6cAwOiuD
         LibnrvKayjkp4raXjyz97OA3rX0H3qoqwfRNMFJo=
Date:   Wed, 19 Dec 2018 08:12:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrew Smirnov <andrew.smirnov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Trent Piepho <tpiepho@impinj.com>
Subject: Re: [v4] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Message-ID: <20181219141241.GB12763@google.com>
References: <1544768762-18124-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544768762-18124-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Sven, Trent, et al from related report:
https://lore.kernel.org/linux-pci/20181218210444.5950-1-TheSven73@googlemail.com]

On Fri, Dec 14, 2018 at 06:44:15AM +0000, Richard Zhu wrote:
> Assertion of the MSI Enable bit of RC's MSI CAP is mandatory required to
> trigger MSI on i.MX6 PCIe.
> This bit would be asserted when CONFIG_PCIEPORTBUS=y.
> Thus, the MSI works fine on i.MX6 PCIe before the commit "f3fdfc4".
> 
> Assert it unconditionally when MSI is enabled.
> Otherwise, the MSI wouldn't be triggered although the EP is present and
> the MSIs are assigned.

OK, I think I finally understand most of what's going on.  Please
check the following possible changelog text:

  The MSI Enable bit in the MSI Capability (PCIe r4.0, sec 7.7.1.2)
  controls whether a Function can request service using MSI.

  i.MX6 Root Ports implement the MSI Capability and may use MSI to
  request service for events like PME, hotplug, AER, etc.  In
  addition, on i.MX6, the MSI Enable bit controls delivery of MSI
  interrupts from components below the Root Port.

  Prior to f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection of
  CONFIG_PCIEPORTBUS"), enabling CONFIG_PCI_IMX6 automatically also
  enabled CONFIG_PCIEPORTBUS, and when portdrv claimed the Root Ports,
  it set the MSI Enable bit so it could use PME, hotplug, AER, etc.
  As a side effect, that also enabled delivery of MSI interrupts from
  downstream components.

  After f3fdfc4ac3a2, the imx6q-pcie driver can operate without
  portdrv, but that means imx6q-pcie must set the MSI Enable bit
  itself if downstream components use MSI.

  Fixes: f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection of CONFIG_PCIEPORTBUS")

I still don't understand exactly *how* MSI Enable affects MSI from
downstream components, since the downstream component just does a DMA
write, and the Root Port can't tell whether the write is to memory or
interrupt controller unless the Root Port knows where the MSI targets
are, e.g., if the interrupt controller is actually part of the RC.

Bjorn

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> Changes v1 -> v2:
> * Assert the MSI_EN unconditionally when MSI is supported.
> Changes v2 -> v3:
> * Remove the IS_ENABLED(CONFIG_PCI_MSI) since the driver depends on
> PCI_MSI_IRQ_DOMAIN
> * Extended with a check for pci_msi_enabled() to see if the user
> explicitly want legacy IRQs
> Changes v3 -> v4:
> * Refer to Bjorn's comments, refine the subject and commit log and change
> the PCI_MSI_CAP to PCIE_RC_IMX6_MSI_CAP.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 26087b3..639bb27 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -74,6 +74,7 @@ struct imx6_pcie {
>  #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
>  
>  /* PCIe Root Complex registers (memory-mapped) */
> +#define PCIE_RC_IMX6_MSI_CAP			0x50
>  #define PCIE_RC_LCR				0x7c
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
> @@ -926,6 +927,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	struct resource *dbi_base;
>  	struct device_node *node = dev->of_node;
>  	int ret;
> +	u16 val;
>  
>  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
>  	if (!imx6_pcie)
> @@ -1071,6 +1073,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (pci_msi_enabled()) {
> +		val = dw_pcie_readw_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
> +				PCI_MSI_FLAGS);
> +		val |= PCI_MSI_FLAGS_ENABLE;
> +		dw_pcie_writew_dbi(pci, PCIE_RC_MSI_IMX6_CAP +
> +				PCI_MSI_FLAGS, val);
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
