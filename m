Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817BCC43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 10:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CF62147C
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 10:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfBTK0l (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:26:41 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55284 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfBTK0l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Feb 2019 05:26:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF140A78;
        Wed, 20 Feb 2019 02:26:40 -0800 (PST)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06C393F575;
        Wed, 20 Feb 2019 02:26:38 -0800 (PST)
Date:   Wed, 20 Feb 2019 10:26:49 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/5] DesignWare PCI improvements
Message-ID: <20190220102648.GA27079@red-moon>
References: <20190219200242.17243-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219200242.17243-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 19, 2019 at 12:02:37PM -0800, Andrey Smirnov wrote:
> Everyone:
> 
> This is the series is a spin-off from [imx6-dwc] containing only small
> improvements that I made while reading the code and researching commit
> history of pcie-designware*.c. All changes are optional, so
> commits that don't seem like an improvement can be easily
> dropped. Hopefully each patch is self-explanatory.
> 
> I tested this series on i.MX6Q, i.MX7D and i.MX8MQ.
> 
> Feedback is welcome!
> 
> Thanks,
> Andrey Smirnov
> 
> [imx6-dwc] https://lore.kernel.org/lkml/20190104174925.17153-1-andrew.smirnov@gmail.com
> 
> Andrey Smirnov (5):
>   PCI: dwc: Make use of IS_ALIGNED()
>   PCI: dwc: Share code for dw_pcie_rd/wr_other_conf()
>   PCI: dwc: Make use of BIT() in constant definitions
>   PCI: dwc: Make use of GENMASK/FIELD_PREP
>   PCI: dwc: Remove superfluous shifting in definitions
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 61 +++++++------------
>  drivers/pci/controller/dwc/pcie-designware.c  |  6 +-
>  drivers/pci/controller/dwc/pcie-designware.h  | 57 +++++++++--------
>  3 files changed, 56 insertions(+), 68 deletions(-)
 

Applied to pci/dwc for v5.1, thanks.

Lorenzo
