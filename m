Return-Path: <SRS0=SqGm=OQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506E2C07E85
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 11:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1255120892
	for <linux-pci@archiver.kernel.org>; Fri,  7 Dec 2018 11:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1255120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbeLGLhJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:37:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42584 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeLGLhJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Dec 2018 06:37:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAADDEBD;
        Fri,  7 Dec 2018 03:37:08 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C63A83F5AF;
        Fri,  7 Dec 2018 03:37:06 -0800 (PST)
Date:   Fri, 7 Dec 2018 11:37:01 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] PCIE support for i.MX8MQ
Message-ID: <20181207113701.GA19058@e107981-ln.cambridge.arm.com>
References: <20181117181225.10737-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117181225.10737-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 17, 2018 at 10:12:22AM -0800, Andrey Smirnov wrote:
> 
> Everyone:
> 
> This series contains changes I made in order to enable support of PCIE
> IP block on i.MX8MQ SoCs (full tree can be found at [github-v0]). This series
> is _very_ preliminary and by no means is ready for inclusion (it also
> has some unmet dependencies).  However is should be in OK enough shape
> to get some early feedback on, which is the intent of this submission.
> 
> Specifically, I'd like to get some feedback on whether newly
> introduced "fsl,iomux-gpr1x" and "fsl,gpr12-device-type" DT
> properties, added to handle differences between PCIE0 and PCIE1, is a
> good (acceptable) solution for the problem.
> 
> All other feedback is appreciated as well!
> 
> Thank you,
> Andrey Smirnov
> 
> [github-v0] https://github.com/ndreys/linux/commits/imx8mq-pcie-v0
> 
> Andrey Smirnov (3):
>   PCI: imx: No-op imx6_setup_phy_mpll() on i.MX7D
>   PCI: imx: No-op imx6_pcie_reset_phy() on i.MX7D
>   PCI: imx: Add support for i.MX8MQ
> 
>  drivers/pci/controller/dwc/Kconfig    |   2 +-
>  drivers/pci/controller/dwc/pci-imx6.c | 119 +++++++++++++++++++++++++-
>  2 files changed, 117 insertions(+), 4 deletions(-)

Applied to pci/dwc for v4.21, thanks.

Lorenzo
