Return-Path: <SRS0=IRPw=OW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63BFC65BAE
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 14:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACCD20879
	for <linux-pci@archiver.kernel.org>; Thu, 13 Dec 2018 14:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544712082;
	bh=2Y9dcSxEbm7++2W57FJQNCnpbdFgMI2E2n6HsLTa0SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H0BRO1W6a5XufsZE30u63/uW86d64gB1silA794dQnWAXcf1OCP3lmabxayvphVR2
	 v5DV/9VlDC70s9F0yPedmkYAM7DqDrh8jO3Mt4D2iKajd4OZHUNHv2ktaKB8yr2GRo
	 as1+BTlxA7vAUDBsHFqeKwpJG9PFsDnShYWtk7eM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACCD20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbeLMOlR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:41:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbeLMOlR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 09:41:17 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CEC20849;
        Thu, 13 Dec 2018 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544712077;
        bh=2Y9dcSxEbm7++2W57FJQNCnpbdFgMI2E2n6HsLTa0SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NaFSsTx73EVZhzLJ/ne6WrSUMZcjxwczulAfKDaeZmYYjxArXML9M+aH2Ue2QDFLG
         RMI4KMUCgeCB1TmHC79pAecJ66fTRX0Y8YsWuNlv9lViSLnWGr1OcHO23HsptPJ5Ms
         7YxdgoPScJvi4EV6RYfnU6PxMMlifnGr6pihU0fU=
Date:   Thu, 13 Dec 2018 08:41:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v2] PCI: imx: make msi work without pcieportbus
Message-ID: <20181213144115.GA4701@google.com>
References: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544687042-16595-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 13, 2018 at 08:02:11AM +0000, Richard Zhu wrote:
> MSI_EN of iMX PCIe RC would be asserted when
> PCIEPORTBUS driver is selected.
> Thus, the MSI works fine on iMX PCIe before.
> Assert it unconditionally when MSI is supported.
> Otherwise, the MSI wouldn't be triggered although
> the EP is present and the MSIs are assigned.

This subject line and changelog need some rework.  I can't understand
what's going on at all.  Lorenzo or I can help craft something, but I
don't understand enough to propose anything yet.

"MSI_EN" doesn't appear in the driver; I assume it's some
device-specific signal.

"iMX" does not look like the typical spelling.  You could use "imx6"
to refer to the driver, but in this case you're talking about the
hardware itself, not the driver.  So you should use "i.MX6" or
whatever the appropriate brand is.

If "PCIEPORTBUS driver is selected" means "CONFIG_PCIEPORTBUS=y", say
that.  The connection of portdrv (which is generic PCIe support) to
MSI_EN (which is apparently device-specific) is unclear.  It would be
helpful if you could connect those dots a little more.

"MSI works fine on iMX PCIe before."  Before what?  Is this a
regression, where MSI worked before some commit and this patch fixes
it?

Please rewrap the changelog so it uses the entire 80-column width.
Wrap to 75 so it still fits when "git log" adds the 4 char indent.

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 26087b3..d3e4296 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -74,6 +74,7 @@ struct imx6_pcie {
>  #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
>  
>  /* PCIe Root Complex registers (memory-mapped) */
> +#define PCI_MSI_CAP				0x50

I wish this didn't look quite so much like a PCI core name, because
this is really an i.MX-specific offset.  It looks like the PCIE_RC_*
names are all similar i.MX-specific things.  Shouldn't this match
those?

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
> @@ -1070,6 +1072,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>  	ret = imx6_add_pcie_port(imx6_pcie, pdev);
>  	if (ret < 0)
>  		return ret;
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		val = dw_pcie_readw_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS);
> +		val |= PCI_MSI_FLAGS_ENABLE;
> +		dw_pcie_writew_dbi(pci, PCI_MSI_CAP + PCI_MSI_FLAGS, val);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
