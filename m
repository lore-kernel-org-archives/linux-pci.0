Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C72C433EF
	for <linux-pci@archiver.kernel.org>; Mon, 11 Apr 2022 15:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347906AbiDKP2H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348363AbiDKP2A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 11:28:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95E3F18E2B;
        Mon, 11 Apr 2022 08:25:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 613B01570;
        Mon, 11 Apr 2022 08:25:00 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.6.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46CAE3F73B;
        Mon, 11 Apr 2022 08:24:57 -0700 (PDT)
Date:   Mon, 11 Apr 2022 16:25:01 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     l.stach@pengutronix.de, hongxing.zhu@nxp.com, robh@kernel.org,
        bhelgaas@google.com, helgaas@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH v3] PCI: imx6: Replace legacy gpio interface for gpiod
 interface
Message-ID: <YlRITQq650DCWg75@lpieralisi>
References: <YYCOTx68LXu1Tn1i@fedora>
 <YlBFa46v5NtWxGLt@lpieralisi>
 <YlBKyBtbxMpvauLv@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YlBKyBtbxMpvauLv@fedora>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Linus]

On Fri, Apr 08, 2022 at 11:46:32AM -0300, Maíra Canal wrote:
> On Fri, Apr 08, 2022 at 03:23:39PM +0100, Lorenzo Pieralisi wrote:
> > On Mon, Nov 01, 2021 at 10:03:11PM -0300, Maíra Canal wrote:
> > > Considering the current transition of the GPIO subsystem, remove all
> > > dependencies of the legacy GPIO interface (linux/gpio.h and linux
> > > /of_gpio.h) and replace it with the descriptor-based GPIO approach.
> > > 
> > > Signed-off-by: Maíra Canal <maira.canal@usp.br>
> > > ---
> > > V1 -> V2: Rewrite commit log and subject line to match PCI subsystem standard
> > > V2 -> v3: Change gpiod_set_value_cansleep for gpiod_set_raw_value_cansleep
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 30 +++++++++------------------
> > >  1 file changed, 10 insertions(+), 20 deletions(-)
> > 
> > Maira, Lucas,
> > 
> > what's this patch status ? Please let me know.
> 
> 
> Lorenzo,
> 
> Thank you for the feedback. Since I sent v3, I didn't get any feedback from the community.
> 
> If you have any feedback, I would gladly work on it.

I would ask Linus to have a look please given that it is GPIO code.

Original thread:
https://lore.kernel.org/linux-pci/YYCOTx68LXu1Tn1i@fedora

Thanks,
Lorenzo
