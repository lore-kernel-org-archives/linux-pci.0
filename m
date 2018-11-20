Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B7EC43441
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 12:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCB8208E3
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 12:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCB8208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeKTXEC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:04:02 -0500
Received: from foss.arm.com ([217.140.101.70]:48216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbeKTXEB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Nov 2018 18:04:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA4C380D;
        Tue, 20 Nov 2018 04:35:06 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 161683F5B7;
        Tue, 20 Nov 2018 04:35:03 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:34:58 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
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
Subject: Re: [PATCH v2 0/4] ARM: dts: imx6sx: Add DISPLAY power domain support
Message-ID: <20181120123458.GA22597@e107981-ln.cambridge.arm.com>
References: <cover.1539020938.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1539020938.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 06:06:18PM +0000, Leonard Crestez wrote:
> Now that mxsfb has functional runtime_pm support we can enable power
> gating for the DISPLAY power domain on imx6sx.
> 
> Since pci-imx doesn't support runtime power gating this is still
> always-on unless PCI is disabled/unused. But it's reasonable for an imx
> board to not have PCI.
> 
> The current pd_pcie is actually only for PCIE_PHY, the PCIE ip block is
> actually inside the DISPLAY domain. This is handled by adding the pcie
> node in both power domains, using multi-pd support.
> 
> Series is against linux-next. The last patch needs runtime PM in all
> drivers or it will cause hangs. This means Shawn should hold back on it
> until the PCI and mxsfb dependencies get merged (both might take a long
> time). So you can just review that patch and I will resend it later,
> perhaps in another cycle.
> 
> ---
> 
> Changes since v1:
> * Document multi-pd in imx6q-pcie bindings and add DT list
> * Don't refer to "DISPLAY" as "DISPMIX" because the Reference Manual
> doesn't do that.
> * Link to v1: https://lore.kernel.org/patchwork/cover/994092/
> 
> This is independent of other imx6-pci PM patches such as this one:
> * https://lore.kernel.org/patchwork/patch/996806/
> Device links are quite nice!
> 
> Link to mxsfb thread: https://lkml.org/lkml/2018/9/26/1185
> 
> Leonard Crestez (4):
>   soc: imx: gpc: Increase GPC_CLK_MAX to 7
>   dt-bindings: imx6q-pcie: Add multi-pd bindings for imx6sx
>   PCI: imx: Add multi-pd support
>   ARM: dts: imx6sx: Add DISPLAY power domain support
> 
>  .../bindings/pci/fsl,imx6q-pcie.txt           |  4 +-
>  arch/arm/boot/dts/imx6sx.dtsi                 | 19 +++++++-
>  drivers/pci/controller/dwc/pci-imx6.c         | 48 +++++++++++++++++++
>  drivers/soc/imx/gpc.c                         |  2 +-
>  4 files changed, 70 insertions(+), 3 deletions(-)

As agreed with Shawn, I have applied patches 2-3 to pci/dwc for v4.21,
thanks.

Lorenzo
