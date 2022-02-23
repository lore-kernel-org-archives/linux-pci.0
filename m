Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C17C433F5
	for <linux-pci@archiver.kernel.org>; Wed, 23 Feb 2022 13:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiBWNBe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Feb 2022 08:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236296AbiBWNBe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 08:01:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D95B45B3FE;
        Wed, 23 Feb 2022 05:01:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0B34ED1;
        Wed, 23 Feb 2022 05:01:06 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF2AE3F70D;
        Wed, 23 Feb 2022 05:01:04 -0800 (PST)
Date:   Wed, 23 Feb 2022 13:00:59 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v1] PCI: imx6: Handle the abort from user-space
Message-ID: <20220223130059.GA28032@lpieralisi>
References: <20220131075235.787432-1-francesco.dolcini@toradex.com>
 <20220210080050.GA7275@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210080050.GA7275@francesco-nb.int.toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 10, 2022 at 09:00:50AM +0100, Francesco Dolcini wrote:
> Hello Lorenzo,
> just a gently ping on this patch.
> 
> Francesco
> 
> On Mon, Jan 31, 2022 at 08:52:35AM +0100, Francesco Dolcini wrote:
> > From: Jason Liu <jason.hui.liu@nxp.com>
> > 
> > The driver install one hook to handle the external abort, but issue
> > is that if the abort introduced from user space code, the following
> > code unsigned long instr = *(unsigned long *)pc; which will created
> > another data-abort(page domain fault) if CONFIG_CPU_SW_DOMAIN_PAN.
> > 
> > The patch does not intent to use copy_from_user and then do the hack
> > due to the security consideration. In fact, we can just return and
> > report the external abort to user-space.

Apologies for the delay in replying.

This commit log should be rewritten - it is not clear.

Isn't this an issue for all PCI host controllers that install a fault
hook ?

Is this referring to accessing config space directly from user space ?

Can you explain the triggering conditions a bit better please ?

Thanks,
Lorenzo

> > Link: https://lore.kernel.org/all/20220128082920.591115-1-francesco.dolcini@toradex.com
> > Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
> > Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > Acked-by: Lucas Stach <l.stach@pengutronix.de>
