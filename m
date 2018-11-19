Return-Path: <SRS0=q0B1=N6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E2CC43441
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 11:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 892152086A
	for <linux-pci@archiver.kernel.org>; Mon, 19 Nov 2018 11:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AypJ+omw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892152086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeKSWCG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:02:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbeKSWCG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Nov 2018 17:02:06 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1F4E20851;
        Mon, 19 Nov 2018 11:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542627523;
        bh=sxQHa6RGtExdE0ID2w0S+++Uo9asUk+vEz8MYLtfOoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AypJ+omwU2GziG66oPbxLOKMuEebb6BwWliKlpQsy/uGBxw2Yr9RjRTW9AEYY7/Nu
         7ewwK4C+u5lnLG/YQcgjmCepU3/x+MLYea4DSvYbC9cBZJy+7sO8r18l0f5ZPvZz3P
         eF0SQhjSYx7Tj4bNQYTdButt4gN/g3+7cEi61eUM=
Date:   Mon, 19 Nov 2018 19:38:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] PCI: imx: Add multi-pd support
Message-ID: <20181119113816.GP5829@dragon>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
 <ee0c4ecb4b6bd26f548096e7be90a07d181d50ee.1539020938.git.leonard.crestez@nxp.com>
 <20181116122541.GD3228@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116122541.GD3228@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 16, 2018 at 12:25:41PM +0000, Lorenzo Pieralisi wrote:
> On Mon, Oct 08, 2018 at 06:06:21PM +0000, Leonard Crestez wrote:
> > On some chips the PCIE and PCIE_PHY blocks are in separate power domains
> > which can be power-gated independently. The pci driver needs to handle
> > this by keeping both domain active.
> > 
> > This is intended for imx6sx where PCIE is in DISPLAY and PCIE_PHY in
> > it's own domain. Defining the DISPLAY domain requires a way for pcie to
> > keep it active or it will break when displays are off.
> > 
> > The power-domains on imx6sx are meant to look like this:
> > 	power-domains = <&pd_disp>, <&pd_pci>;
> > 	power-domain-names = "pcie", "pcie_phy";
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 48 +++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> 
> I expect Shawn to pick the whole series up and therefore I am dropping
> this series from the PCI tree.

Lorenzo,

I think the best approach is that you send patch #2 and #3 for 4.21
through PCI tree, and we will be able to apply patch #4 in 4.22
development cycle.

Queuing patch #3 on IMX tree will stands a good chance for conflicts
with other pci-imx6.c changes on PCI tree.

Shawn
