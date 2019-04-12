Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B835FC10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 09:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895B8205F4
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 09:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDLJct (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:32:49 -0400
Received: from foss.arm.com ([217.140.101.70]:56220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfDLJct (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 05:32:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 053F915AB;
        Fri, 12 Apr 2019 02:32:49 -0700 (PDT)
Received: from red-moon (unknown [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E32ED3F59C;
        Fri, 12 Apr 2019 02:32:46 -0700 (PDT)
Date:   Fri, 12 Apr 2019 10:32:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] i.MX6, DesignWare PCI improvements
Message-ID: <20190412093242.GA8113@red-moon>
References: <20190401042547.14067-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401042547.14067-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 31, 2019 at 09:25:36PM -0700, Andrey Smirnov wrote:
> Everyone:
> 
> This is the series containing various small improvements that I made
> while reading the code and researching commit history of pci-imx6.c
> and pcie-designware*.c files. All changes are optional, so commits
> that don't seem like an improvement can be easily dropped. Hopefully
> each patch is self-explanatory.
> 
> I tested this series on i.MX6Q, i.MX7D and i.MX8MQ.
> 
> Feedback is welcome!
> 
> Thanks,
> Andrey Smirnov
> 
> Changes since [v2]:
> 
>     - All non i.MX6 patches dropped, since they were accepted as a
>       seprarte series
>       
>     - Series rebased on lates 'dwc-pci' branch of PCI tree
>     
>     - Patches "PCI: imx6: Use flags to indicate support for suspend"
>       and "PCI: imx6: Replace calls to udelay() with usleep_range()"
>       added to the series
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
> [v2] lkml.kernel.org/r/20190104174925.17153-1-andrew.smirnov@gmail.com
> [v1] lkml.kernel.org/r/20181221072716.29017-1-andrew.smirnov@gmail.com
> 
> Andrey Smirnov (11):
>   PCI: imx6: Simplify imx7d_pcie_wait_for_phy_pll_lock()
>   PCI: imx6: Remove redundant debug tracing
>   PCI: imx6: Return -ETIMEOUT from imx6_pcie_wait_for_speed_change()
>   PCI: imx6: Remove PCIE_PL_PFLR_* constants
>   PCI: dwc: imx6: Share PHY debug register definitions
>   PCI: imx6: Make use of BIT() in constant definitions
>   PCI: imx6: Simplify bit operations in PHY functions
>   PCI: imx6: Simplify pcie_phy_poll_ack()
>   PCI: imx6: Restrict PHY register data to 16-bit
>   PCI: imx6: Use flags to indicate support for suspend
>   PCI: imx6: Replace calls to udelay() with usleep_range()
> 
>  drivers/pci/controller/dwc/pci-imx6.c        | 119 ++++++++-----------
>  drivers/pci/controller/dwc/pcie-designware.c |  12 +-
>  drivers/pci/controller/dwc/pcie-designware.h |   3 +
>  3 files changed, 54 insertions(+), 80 deletions(-)

I am waiting for Lucas's review/ACKs to proceed with this
series.

Thanks,
Lorenzo
