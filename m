Return-Path: <SRS0=obOR=L7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC73FECE560
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 15:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1174214C2
	for <linux-pci@archiver.kernel.org>; Mon, 17 Sep 2018 15:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1174214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeIQUhd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:37:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60668 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbeIQUhc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Sep 2018 16:37:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E9E4ED1;
        Mon, 17 Sep 2018 08:09:47 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19D3D3F5BD;
        Mon, 17 Sep 2018 08:09:43 -0700 (PDT)
Date:   Mon, 17 Sep 2018 16:09:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        linux-pci@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 0/6] PCI: imx: Initial imx7d suspend/resume support
Message-ID: <20180917150941.GH7239@e107981-ln.cambridge.arm.com>
References: <cover.1534264292.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1534264292.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180917150941.NLeaMtujdvKY5D--4nKZODGP9p4mfp7X25Uo4y4r7-0@z>

On Tue, Aug 14, 2018 at 07:50:14PM +0300, Leonard Crestez wrote:
> On imx7d the pcie-phy power domain is turned off in suspend and this can
> make the system hang on resume when attempting any read from PCI.
> 
> Fix this by adding PM_SLEEP support to the imx6 pci driver. This is
> currently only enabled for imx7d but the suspend/resume sequence also
> applies to other socs.
> 
> V3 of this series was reviewed by Lucas but stalled because the merge
> window opened.
> 
> There was also some confusion about how to deal with the dependence on
> commit 26fce0557fa6 ("reset: imx7: Fix always writing bits as 0"). To
> clarify: both patch 2 and 26fce0557fa6 are required to fix imx7d suspend
> but merging one without the other shouldn't cause other issues.
> 
> 
> V4 adds 4 more patches with PME_Turn_Off support on top, using a new
> reset bit. I generally try to keep series short but in this case some
> planning might be needed to get patches into 4.20.
> 
> Since the new reset is treated as optional with old DTB there should be
> again no problem if reset and pci are merged out of order.
> 
> 
> Shawn/Philipp/Lorenzo: Would it make sense to merge this series through a
> single specific tree, such as the one for imx?

This series is a bit of a mixture of multiple things hard to discern
(actually I already merged patch 2 and patch 1 seems completely
unrelated).

I would take the series through the PCI tree but I need an ACK for
patches 5 and 6, please let me know how you want to handle it.

Lorenzo

> Link to v3: https://lkml.org/lkml/2018/7/24/713
> 
> Leonard Crestez (6):
>   Revert "ARM: dts: imx7d: Invert legacy PCI irq mapping"
>   PCI: imx: Initial imx7d pm support
>   reset: imx7: Add PCIE_CTRL_APPS_TURNOFF
>   dt-bindings: imx6q-pcie: Add turnoff reset for imx7d
>   ARM: dts: imx7d: Add turnoff reset
>   PCI: imx: Add PME_Turn_Off support
> 
>  .../bindings/pci/fsl,imx6q-pcie.txt           |   1 +
>  arch/arm/boot/dts/imx7d.dtsi                  |  17 ++-
>  drivers/pci/controller/dwc/pci-imx6.c         | 112 +++++++++++++++++-
>  drivers/reset/reset-imx7.c                    |   1 +
>  include/dt-bindings/reset/imx7-reset.h        |   4 +-
>  5 files changed, 123 insertions(+), 12 deletions(-)
> 
> -- 
> 2.17.1
> 
