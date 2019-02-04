Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFC5C282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 12:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62FF2082E
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 12:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfBDMT4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:19:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54914 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728492AbfBDMT4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 07:19:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3675915AB;
        Mon,  4 Feb 2019 04:19:55 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22E223F675;
        Mon,  4 Feb 2019 04:19:52 -0800 (PST)
Date:   Mon, 4 Feb 2019 12:19:47 +0000
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
Subject: Re: [PATCH v7 0/4] PCIE support for i.MX8MQ
Message-ID: <20190204121947.GA16219@e107981-ln.cambridge.arm.com>
References: <20190202001523.12517-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202001523.12517-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 01, 2019 at 04:15:19PM -0800, Andrey Smirnov wrote:
> Everyone:
> 
> This series contains changes I made in order to enable support of PCIE
> IP block on i.MX8MQ SoCs.
> 
> Changes since [v6]:
> 
>  - Patches rebased on Lorenzo's pci/dwc branch
> 
>  - Reworded commit message of "PCI: imx6: Mark PHY functions as i.MX6
>    specific"

Applied to pci/dwc for v5.1, thanks.

Lorenzo

> Changes since [v5]:
> 
>  - Reformatted commit messages to adhere to
>    https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/
> 
> Changes since [v4]:
> 
>  - Collected Reviewed-by from Lucas
> 
>  - Replaced ((ARM || ARM64) && COMPILE_TEST) with COMPILE_TEST as per
>    suggestion from Rob
> 
> Changes since [v3]:
> 
>  - Based on feedback from NXP, DIRECT_SPEED_CHANGE quirk was expanded
>    to cover both i.MX7 and i.MX8MQ
> 
>  - Code setting device type in GPR12 moved to a standalone function
> 
>  - Explicit "fsl,controller-id" binding was dropped, replaced by using
>    controller physical address to determine logical ID
> 
>  - Dropped Reviewed-by from Lucas for patch 4/4 due to the change
>    above (haven't heard explicit "yea" for it from him)
> 
> Changes since [v2], [fixes]:
> 
>  - Incorporated [patch] introducing drvdata
> 
>  - i.MX6 PHY operation gating converted to a single patch and to use a
>    dedicated flag instead of doing explicit variant check
> 
>  - Kconfig entry changed to use ARM64 && ARCH_MXC
> 
>  - Dropped FALLTHROUGH annotations
> 
> Changes since [v1]:
> 
>  - Driver changed to use single "fsl,controller-id" property to
>    distinguish between two intances of PCIE IP block
> 
>  - All code pertaining to L1SS was dropped to simplify the patch
> 
>  - Documented additions to DT bindings
> 
> Feedback is welcome!
> 
> Thanks,
> Andrey Smirnov
> 
> [v6] https://lore.kernel.org/linux-arm-kernel/https://lore.kernel.org/linux-arm-kernel/20190124201522.8973-1-andrew.smirnov@gmail.com
> [v5] https://lore.kernel.org/linux-arm-kernel/20190112215601.9535-1-andrew.smirnov@gmail.com
> [v4] https://lore.kernel.org/linux-arm-kernel/20190104165335.13205-1-andrew.smirnov@gmail.com
> [v3] https://lore.kernel.org/linux-arm-kernel/20181218040702.29231-1-andrew.smirnov@gmail.com
> [patch] https://patchwork.kernel.org/patch/10712261/
> [fixes] https://lore.kernel.org/linux-arm-kernel/20181216230916.22982-1-andrew.smirnov@gmail.com
> [v2] https://lore.kernel.org/linux-arm-kernel/20181206073545.10967-1-andrew.smirnov@gmail.com
> [v1] https://lore.kernel.org/linux-arm-kernel/20181117181225.10737-1-andrew.smirnov@gmail.com/
> 
> Andrey Smirnov (4):
>   PCI: imx6: Introduce drvdata
>   PCI: imx6: Mark PHY functions as i.MX6 specific
>   PCI: imx6: Convert DIRECT_SPEED_CHANGE quirk code to use a flag
>   PCI: imx6: Add support for i.MX8MQ
> 
>  .../bindings/pci/fsl,imx6q-pcie.txt           |   3 +-
>  drivers/pci/controller/dwc/Kconfig            |   4 +-
>  drivers/pci/controller/dwc/pci-imx6.c         | 150 +++++++++++++++---
>  3 files changed, 133 insertions(+), 24 deletions(-)
> 
> -- 
> 2.20.1
> 
