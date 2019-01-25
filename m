Return-Path: <SRS0=mKlk=QB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38862C282C0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 17:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12300218B0
	for <linux-pci@archiver.kernel.org>; Fri, 25 Jan 2019 17:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfAYR7W (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:59:22 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51650 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAYR7W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jan 2019 12:59:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACE2DEBD;
        Fri, 25 Jan 2019 09:59:21 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E057F3F5AF;
        Fri, 25 Jan 2019 09:59:19 -0800 (PST)
Date:   Fri, 25 Jan 2019 17:59:14 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     "Lukas F . Hartmann" <lukas@mntmn.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 0/2] PCI: imx: imx6_pcie_attach_pd
Message-ID: <20190125175914.GA25128@e107981-ln.cambridge.arm.com>
References: <cover.1548110502.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548110502.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 21, 2019 at 10:50:03PM +0000, Leonard Crestez wrote:
> This fixes pci probing on imx6qp as reported by Lukas Hartmann.
> 
> The second patch fixes a check that shouldn't actually fail.
> 
> Leonard Crestez (2):
>   PCI: imx: Fix probe failure without power domain
>   PCI: imx: Fix checking pd_pcie_phy device_link
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

I have applied them to pci/controller-fixes and Bjorn already
queued them for one of the upcoming -rc*.

Thanks,
Lorenzo
