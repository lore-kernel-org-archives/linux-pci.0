Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C70C43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 01:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E28F21871
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 01:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546392493;
	bh=hjrUtNXCE4m20teCOVhOxvQ3bn9KxyuOFTRLDwbwEDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L3wpns1ZYLyw745OsoI5QEgrYaDhlE5f4vT+W7vj1EPkMb3+ARbdl6Wvcl2//glJb
	 3jmZ3uK6PIpBfeMiHTZGeYAZ9dohY7vj+9Fpguh9t+7LwN+fMAoA7hPmQc4u4LdM4e
	 UxuBFB2SXDiwkZ6/hkOd0xB2gCMgO5AbmADFhbQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbfABB2M (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 1 Jan 2019 20:28:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbfABB2M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Jan 2019 20:28:12 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D03C42171F;
        Wed,  2 Jan 2019 01:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546392491;
        bh=hjrUtNXCE4m20teCOVhOxvQ3bn9KxyuOFTRLDwbwEDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1RGs6CXj2CIrNcJ6qzohel+sWH3k61Xg7ierw69ZZz+aheurP4lorSh0tiHH64j/g
         7kuLE+LAKW/sn57ay7ve3yWBitHDI9geR2yesE2TfNYjkD1dKn+R/MLBjtoK/zD3eW
         TbheBijN1yVfanTY4QdTtgsTIX6vQZDDku4oE/5M=
Date:   Tue, 1 Jan 2019 19:28:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "TheSven73@googlemail.com" <TheSven73@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v6] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
Message-ID: <20190102012809.GB126384@google.com>
References: <1545365708-13086-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545365708-13086-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 21, 2018 at 04:33:38AM +0000, Richard Zhu wrote:
> The MSI Enable bit in the MSI Capability (PCIe r4.0, sec 7.7.1.2)
> controls whether a Function can request service using MSI.
> 
> i.MX6 Root Ports implement the MSI Capability and may use MSI to
> request service for events like PME, hotplug, AER, etc.  In
> addition, on i.MX6, the MSI Enable bit controls delivery of MSI
> interrupts from components below the Root Port.
> 
> Prior to commit f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection
> of CONFIG_PCIEPORTBUS"), enabling CONFIG_PCI_IMX6 automatically also
> enabled CONFIG_PCIEPORTBUS, and when portdrv claimed the Root Ports,
> it set the MSI Enable bit so it could use PME, hotplug, AER, etc.
> As a side effect, that also enabled delivery of MSI interrupts from
> downstream components.
> 
> After f3fdfc4ac3a2, the imx6q-pcie driver can operate without
> portdrv, but that means imx6q-pcie must set the MSI Enable bit
> itself if downstream components use MSI.
> 
> Fixes: f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection of CONFIG_PCIEPORTBUS")
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Applied with Trent's tested-by to pci/imx6 for v4.21.

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
> Changes v5 -> v6:
> * Update with Bjorn's commit.
> * One "commit" added in "Prior to f3fdfc4ac3a2" refer to the complain of
> checkpatch.pl.
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
>  
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
