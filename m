Return-Path: <SRS0=x4dU=NP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AB7C32789
	for <linux-pci@archiver.kernel.org>; Sun,  4 Nov 2018 03:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA892085A
	for <linux-pci@archiver.kernel.org>; Sun,  4 Nov 2018 03:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dztsrU8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA892085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbeKDNIj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 4 Nov 2018 08:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbeKDNIi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 4 Nov 2018 08:08:38 -0500
Received: from tiger (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4746B2081C;
        Sun,  4 Nov 2018 03:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541303711;
        bh=wk9OvtqKmjX1XCwyugRwiIPWKqQkkx7bxIOMqx8r+zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dztsrU8wmjPru8RGfssOhis9+K17bv0G5AbiBbZEYeMeiQ1qB5J2i98E6tR12+9Y5
         8e/zpFO+hiJ5hh9FnhA3gXozAUwBqzCLlFT456JYDV9ltdZo/e/2v74SDrlBub1U5J
         lhi7I8XjjxsuKlXSPOITs+czzxyeURYD94nEw6/U=
Date:   Sun, 4 Nov 2018 11:54:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stefan Agner <stefan@agner.ch>, Marek Vasut <marex@denx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] ARM: dts: imx6sx: Add DISPLAY power domain support
Message-ID: <20181104035453.GA6093@tiger>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
 <a3265a84052a7c11ae96e61e39adc988ca980d66.1539020938.git.leonard.crestez@nxp.com>
 <20181031061134.GB10386@tiger>
 <AM0PR04MB4290F31234D75AC7029F066FEECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4290F31234D75AC7029F066FEECD0@AM0PR04MB4290.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 31, 2018 at 12:17:50PM +0000, Leonard Crestez wrote:
> On 10/31/2018 8:12 AM, Shawn Guo wrote:
> > On Mon, Oct 08, 2018 at 06:06:23PM +0000, Leonard Crestez wrote:
> >> This was implemented in the driver but not actually defined and
> >> referenced in dts. This makes it always on.
> >>
> >>  From reference manual in section "10.4.1.4.1 Power Distribution":
> >>
> >> "Display domain - The DISPLAY domain contains GIS, CSI, PXP, LCDIF,
> >> PCIe, DCIC, and LDB. It is supplied by internal regulator."
> >>
> >> The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
> >> actually inside the DISPLAY domain. Handle this by adding the pcie node
> >> in both power domains.
> >>
> >> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > 
> > Applied, thanks.
> 
> As mentioned in the cover letter this requires multi-PD support in 
> imx-pci to be implemented, specifically PATCH 3/4 of this series:
> 
> 	https://lore.kernel.org/patchwork/patch/996810/
> 
> Unless that also gets merged soon via pci I expect issues in linux-next. 
> The patch already has reviewed-by tags so "merging it soon" is not 
> unreasonable.

Oops, I overlooked the notes in cover-letter.  Let's use the approach as
suggested there - applying the dts change after all driver dependencies
are landed.

Patch dropped, sorry.
