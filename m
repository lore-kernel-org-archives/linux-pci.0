Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3379ECE562
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 10:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A831214D5
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 10:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A831214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725757AbeIQPkn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:40:43 -0400
Received: from foss.arm.com ([217.140.101.70]:56004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbeIQPkn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 11:40:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8520B18A;
        Mon, 17 Sep 2018 03:13:59 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CA1E3F5BD;
        Mon, 17 Sep 2018 03:13:57 -0700 (PDT)
Date:   Mon, 17 Sep 2018 11:13:53 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 0/2] Workaround for IMX7d PCI-e PLL lock failure
Message-ID: <20180917101353.GA7239@e107981-ln.cambridge.arm.com>
References: <20180718194424.8844-1-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718194424.8844-1-tpiepho@impinj.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917101353.0eMJG792D2wV4-uuqp9_pGGzfO3s6Cd7DSZgu5pMiCo@z>

On Wed, Jul 18, 2018 at 12:44:22PM -0700, Trent Piepho wrote:
> This is the workaround for the IMX7d Erratum e10728, failure of
> initialize PCIe PLL VCO oscillation resulting in PLL lock failure and
> failure of the PCI-e link to come up.
> 
> The registers used in the workaround are based on the latest patch in
> the NXP kernel, but many things around that have been changed.
> 
> This uses a new node of type fsl,imx-pcie-phy to get the PHY's
> registers.  The node is found via a phandle added to the PCI-e
> controller's node, rather than the incorrect way done in the NXP kernel.
> 
> There is no error if the phandle is not preset (since it's needed except
> for the imx7d workaround and no existing dtses have it), but if preset
> it is an error if something relating to it does not work.
> 
> ** Should the node be fsl,imx7d-pcie-phy?  snps,dw-pcie-phy?  
> 
> There is little to no documenation from NXP and Synopsis about this, so I'm
> unsure of the PHY's lineage.
> 
> The imx6 PCI-e driver does not use the generic phy layer to interact
> with the PHY.  It appears PHY related hardware, like clocks, regulators,
> and resets, are part of the fsl,imx6q-pcie node.  But again, the
> topology of this hardware is not documented very well.
> 
> Another approach would be to add the PHY registers as another bank in
> the PCI-e node.  This would match how the PHY reset, clock, etc.  are
> done.  However, the PHY is attached to a different AXI master than the
> PCI-e controller, so the register range really does not belong there.
> 
> Trent Piepho (2):
>   ARM: dts: imx7d: Add node for PCIe PHY
>   PCI: imx: Add workaround for e10728, IMX7d PCIe PLL failure

Marked as "changes requested", following Lucas' review, please
respin as appropriate.

Lorenzo

>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     | 11 ++++
>  arch/arm/boot/dts/imx7d.dtsi                       |  9 ++++
>  drivers/pci/dwc/pci-imx6.c                         | 59 ++++++++++++++++++++++
>  3 files changed, 79 insertions(+)
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> 
> -- 
> 2.14.4
> 
> 
