Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C58C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 11:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5C9206A2
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 11:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeLQLBq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:01:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53180 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbeLQLBq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 06:01:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F77DEBD;
        Mon, 17 Dec 2018 03:01:46 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AC3E3F6A8;
        Mon, 17 Dec 2018 03:01:44 -0800 (PST)
Date:   Mon, 17 Dec 2018 11:00:28 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] Fixes for "PCIE support for i.MX8MQ"
Message-ID: <20181217110028.GA14261@e107981-ln.cambridge.arm.com>
References: <20181216230916.22982-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216230916.22982-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 16, 2018 at 03:09:13PM -0800, Andrey Smirnov wrote:
> Lorenzo:
> 
> These are patches fixing things pointed out by Bjorn in [1] and [2] as
> well as something I noticed while giving pci/next branch a try (#endif
> placement). Hopefully this is at least somewhat helpful.
> 
> Thanks,
> Andrey Smirnov
> 
> [1] lkml.kernel.org/r/20181214203828.GD20725@google.com
> [2] lkml.kernel.org/r/20181214203042.GC20725@google.com
> 
> Andrey Smirnov (3):
>   PCI: imx6: Fixup Kconfig and #endif placement
>   PCI: imx6: Invert checks in imx6_pcie_reset_phy() and
>     imx6_setup_phy_mpll()
>   PCI: imx6: Make fallthrough comments more consistent
> 
>  drivers/pci/controller/dwc/Kconfig    |  4 ++--
>  drivers/pci/controller/dwc/pci-imx6.c | 29 ++++++++++++++++++---------
>  2 files changed, 21 insertions(+), 12 deletions(-)

Andrey,

please follow-up Lucas' remarks and submit a self-consistent patchset
that I can apply on top of my pci/dwc branch (where I removed your
previously queued patches).

Thanks,
Lorenzo
