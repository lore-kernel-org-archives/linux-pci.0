Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C29C282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 16:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490D6218AC
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 16:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfBAQ1h (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:27:37 -0500
Received: from foss.arm.com ([217.140.101.70]:34868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfBAQ1h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 11:27:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B706815BE;
        Fri,  1 Feb 2019 08:27:36 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80A203F71E;
        Fri,  1 Feb 2019 08:27:34 -0800 (PST)
Date:   Fri, 1 Feb 2019 16:27:29 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/20] i.MX6, DesignWare PCI improvements
Message-ID: <20190201162729.GA22030@e107981-ln.cambridge.arm.com>
References: <20190104174925.17153-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104174925.17153-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 04, 2019 at 09:49:05AM -0800, Andrey Smirnov wrote:
> Everyone:
> 
> This is the series containing various small improvements that I made
> while reading the code and researching commit history of pci-imx6.c
> and pcie-designware*.c files. All changes are optional, so commits
> that don't seem like an improvement can be easily dropped. Hopefully
> each patch is self-explanatory.

Side note: You should trim the CC list, eg I do not think CC LKML is
needed at all for this series.

@Lucas: May I ask you to consider please which patches you deem
worth for inclusion ? I will have a look too but I would be grateful
if the driver maintainers can chime in to help.

Thanks,
Lorenzo

> I tested this series on i.MX6Q, i.MX7D and i.MX8MQ.
> 
> Feedback is welcome!
> 
> Thanks,
> Andrey Smirnov
> 
> Changes since [v1]:
> 
>   - Dropped "PCI: imx6: Drop imx6_pcie_link_up()" due to the matter
>     already having been addressed by "PCI: imx6: Fix link training
>     status detection in link up check" from Trent Piepho
> 
>   - Changed "designware" -> "dwc" for all subject lines
> 
>   - Collected Acked-by's from Gustavo Pimentel
> 
> [v1] lkml.kernel.org/r/20181221072716.29017-1-andrew.smirnov@gmail.com
> 
> Andrey Smirnov (20):
>   PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
>   PCI: imx6: Remove redundant debug tracing
>   PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
>   PCI: imx6: Remove duplicate macro definitions
>   PCI: imx6: Remove PCIE_PL_PFLR_* constants
>   PCI: imx6: Remove PCIE_PHY_RX_ASIC_OUT* constants
>   PCI: dwc: Make use of IS_ALIGNED()
>   PCI: dwc: Share code for dw_pcie_rd/wr_other_conf()
>   PCI: dwc: imx6: Share PHY debug register definitions
>   PCI: dwc: Make use of BIT() in constant definitions
>   PCI: imx6: Make use of BIT() in constant definitions
>   PCI: imx6: Simplify bit operations in PHY functions
>   PCI: imx6: Simplify pcie_phy_poll_ack()
>   PCI: imx6: Restrict PHY register data to 16-bit
>   PCI: imx6: Pass data to dw_pcie_writel_dbi() directly
>   PCI: imx6: Use common mask in imx6_pcie_reset_phy()
>   PCI: imx6: Simplify bit operations in imx6_setup_phy_mpll()
>   PCI: imx6: Remove magic numbers from imx6_pcie_establish_link()
>   PCI: dwc: Make use of GENMASK/FIELD_PREP
>   PCI: dwc: Remove superfluous shifting in definitions
> 
>  drivers/pci/controller/dwc/pci-imx6.c         | 139 +++++++-----------
>  .../pci/controller/dwc/pcie-designware-host.c |  61 +++-----
>  drivers/pci/controller/dwc/pcie-designware.c  |  18 +--
>  drivers/pci/controller/dwc/pcie-designware.h  |  60 ++++----
>  4 files changed, 115 insertions(+), 163 deletions(-)
> 
> -- 
> 2.20.1
> 
