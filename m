Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F6DC43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 14:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEA22186A
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 14:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeLTOuH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:50:07 -0500
Received: from foss.arm.com ([217.140.101.70]:57248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbeLTOuH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 09:50:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 932BFA78;
        Thu, 20 Dec 2018 06:50:06 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39AA43F575;
        Thu, 20 Dec 2018 06:50:05 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:49:56 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [v5] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Message-ID: <20181220144956.GA7041@e107981-ln.cambridge.arm.com>
References: <1545193599-11604-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545193599-11604-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 19, 2018 at 04:45:04AM +0000, Richard Zhu wrote:
> Assertion of the MSI Enable bit of RC's MSI CAP is mandatory required to
> trigger MSI on i.MX6 PCIe.
> This bit would be asserted when CONFIG_PCIEPORTBUS=y.
> Thus, the MSI works fine on i.MX6 PCIe before the commit "f3fdfc4".
> 
> Assert it unconditionally when MSI is enabled.
> Otherwise, the MSI wouldn't be triggered although the EP is present and
> the MSIs are assigned.
> 
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
> Changes v4 -> v5:
> * Correct one spell mistake from PCIE_RC_MSI_IMX6_CAP to
> PCIE_RC_IMX6_MSI_CAP.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index e563ca9..73542dd 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -82,6 +82,7 @@ struct imx6_pcie {
>  #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
>  
>  /* PCIe Root Complex registers (memory-mapped) */
> +#define PCIE_RC_IMX6_MSI_CAP			0x50
>  #define PCIE_RC_LCR				0x7c
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
>  #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
> @@ -999,6 +1000,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	struct resource *dbi_base;
>  	struct device_node *node = dev->of_node;
>  	int ret;
> +	u16 val;
>  
>  	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
>  	if (!imx6_pcie)
> @@ -1149,6 +1151,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> +	if (pci_msi_enabled()) {
> +		val = dw_pcie_readw_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
> +				PCI_MSI_FLAGS);
> +		val |= PCI_MSI_FLAGS_ENABLE;
> +		dw_pcie_writew_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
> +				PCI_MSI_FLAGS, val);
> +	}
> +
>  	return 0;
>  }

Hi Richard,

the patch is OK with me (even though I have to take for granted how the
IMX MSI logic works), the commit log isn't. So please update it with
Bjorn's version:

https://lore.kernel.org/linux-pci/20181219141241.GB12763@google.com/

*inclusive* of the Fixes: tag.

With the commit log updated as per the link above:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
