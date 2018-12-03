Return-Path: <SRS0=SeHV=OM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9F9C04EB9
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 10:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B34F214DA
	for <linux-pci@archiver.kernel.org>; Mon,  3 Dec 2018 10:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B34F214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeLCK1n (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:27:43 -0500
Received: from foss.arm.com ([217.140.101.70]:33788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbeLCK1n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Dec 2018 05:27:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB4ED80D;
        Mon,  3 Dec 2018 02:27:16 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7CD23F59C;
        Mon,  3 Dec 2018 02:27:13 -0800 (PST)
Date:   Mon, 3 Dec 2018 10:27:08 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, sudeep.holla@arm.com
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Message-ID: <20181203102708.GA6090@e107981-ln.cambridge.arm.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181123141831.8214-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123141831.8214-6-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Rafael, Sudeep]

On Fri, Nov 23, 2018 at 03:18:24PM +0100, Miquel Raynal wrote:
> Add suspend and resume callbacks. The priority of these are
> "_noirq()", to workaround early access to the registers done by the
> PCI core through the ->read()/->write() callbacks at resume time.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/pci/controller/pci-aardvark.c | 52 +++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 108b3f15c410..7ecf1ac4036b 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -1108,6 +1108,55 @@ static int advk_pcie_setup_clk(struct advk_pcie *pcie)
>  	return ret;
>  }
>  
> +static int __maybe_unused advk_pcie_suspend(struct device *dev)
> +{
> +	struct advk_pcie *pcie = dev_get_drvdata(dev);
> +
> +	advk_pcie_disable_phy(pcie);
> +
> +	clk_disable_unprepare(pcie->clk);

I have noticed it is common practice, still, I would like to check whether
it is allowed to call functions that may sleep in a NOIRQ suspend/resume
callback ?

Thanks,
Lorenzo

> +
> +	return 0;
> +}
> +
> +static int __maybe_unused advk_pcie_resume(struct device *dev)
> +{
> +	struct advk_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(pcie->clk);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Empirical delay needed after enabling the clock and before
> +	 * accessing any register.
> +	 */
> +	msleep(10);
> +
> +	ret = advk_pcie_enable_phy(pcie);
> +	if (ret)
> +		return ret;
> +
> +	advk_pcie_hard_reset(pcie);
> +
> +	advk_pcie_setup_hw(pcie);
> +
> +	advk_sw_pci_bridge_init(pcie);
> +
> +	return 0;
> +}
> +
> +/*
> + * The PCI core will try to reconfigure the bus quite early in the resume path.
> + * We must use the _noirq() alternatives to ensure the controller is ready when
> + * the core uses the ->read()/->write() callbacks.
> + */
> +static const struct dev_pm_ops advk_pcie_dev_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(advk_pcie_suspend,
> +				      advk_pcie_resume)
> +};
> +
>  static int advk_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1188,6 +1237,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	dev_set_drvdata(dev, pcie);
> +
>  	return 0;
>  }
>  
> @@ -1200,6 +1251,7 @@ static struct platform_driver advk_pcie_driver = {
>  	.driver = {
>  		.name = "advk-pcie",
>  		.of_match_table = advk_pcie_of_match_table,
> +		.pm = &advk_pcie_dev_pm_ops,
>  		/* Driver unloading/unbinding currently not supported */
>  		.suppress_bind_attrs = true,
>  	},
> -- 
> 2.19.1
> 
