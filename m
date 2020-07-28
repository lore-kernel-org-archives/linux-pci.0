Return-Path: <SRS0=zOpN=BH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73D0C433E0
	for <linux-pci@archiver.kernel.org>; Tue, 28 Jul 2020 10:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9226620656
	for <linux-pci@archiver.kernel.org>; Tue, 28 Jul 2020 10:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgG1Kxw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:53:52 -0400
Received: from foss.arm.com ([217.140.110.172]:60856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbgG1Kxv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 06:53:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A2C11FB;
        Tue, 28 Jul 2020 03:53:51 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 223213F66E;
        Tue, 28 Jul 2020 03:53:48 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:53:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Anson Huang <Anson.Huang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, robh@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, bjorn.andersson@linaro.org, leoyang.li@nxp.com,
        vkoul@kernel.org, geert+renesas@glider.be, olof@lixom.net,
        amurray@thegoodpenguin.co.uk, treding@nvidia.com,
        vidyas@nvidia.com, hayashi.kunihiko@socionext.com,
        jonnyc@amazon.com, eswara.kota@linux.intel.com, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V3 1/3] reset: imx7: Support module build
Message-ID: <20200728105345.GC905@e121166-lin.cambridge.arm.com>
References: <1595254921-26050-1-git-send-email-Anson.Huang@nxp.com>
 <e89fa4f3ba2b1b6fe94e662c6ab3cfbaa25867fa.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89fa4f3ba2b1b6fe94e662c6ab3cfbaa25867fa.camel@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 24, 2020 at 10:03:11AM +0200, Philipp Zabel wrote:
> On Mon, 2020-07-20 at 22:21 +0800, Anson Huang wrote:
> > Use module_platform_driver(), add module device table, author,
> > description and license to support module build, and
> > CONFIG_RESET_IMX7 is changed to default 'y' ONLY for i.MX7D,
> > other platforms need to select it in defconfig.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > Changes since V2:
> > 	- use module_platform_driver() instead of builtin_platform_driver().
> 
> Thank you, applied to reset/next.

I think you should pick up patch (3) as well please if PCI_IMX6
maintainers ACK it - merging just patch(1) will trigger regressions
AFAICS.

Lorenzo
