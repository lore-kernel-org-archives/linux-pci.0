Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CAFC282C4
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 11:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E48C2080F
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 11:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfBLLdK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:33:10 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfBLLdK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Feb 2019 06:33:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21FE280D;
        Tue, 12 Feb 2019 03:33:10 -0800 (PST)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7966D3F589;
        Tue, 12 Feb 2019 03:33:08 -0800 (PST)
Date:   Tue, 12 Feb 2019 11:33:06 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Agner <stefan@agner.ch>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        tpiepho@impinj.com, leonard.crestez@nxp.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: imx6: limit DBI register length
Message-ID: <20190212113257.GA23658@red-moon>
References: <14fafdf52d19feb9c926c312f4e3ba7ff8a4bad9.1549446867.git.stefan@agner.ch>
 <119211b4f2e9ada55b86041d009656e49c2b5281.1549446867.git.stefan@agner.ch>
 <20190211213900.GA247873@google.com>
 <1549961694.2546.18.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549961694.2546.18.camel@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 12, 2019 at 09:54:54AM +0100, Lucas Stach wrote:
> Hi Bjorn,
> 
> Am Montag, den 11.02.2019, 15:39 -0600 schrieb Bjorn Helgaas:
> > On Wed, Feb 06, 2019 at 10:57:32AM +0100, Stefan Agner wrote:
> > > Define the length of the DBI registers. This makes sure that
> > > the kernel does not access registers beyond that point, avoiding
> > > the following abort on a i.MX 6Quad:
> > >   # cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
> > >   [  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
> > >   ...
> > >   [  100.056423] PC is at dw_pcie_read+0x50/0x84
> > >   [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
> > >   ...
> > 
> > I assume this problem happens when using the pci_read_config() path or
> > something similar?
> > 
> > Could this be solved using pci_dev.cfg_size instead of building a new
> > dwc-specific mechanism?  There are some quirks that set dev->cfg_size
> > to keep from reading past certain points in config space, e.g.,
> > quirk_citrine(), quirk_nfp6000().
> > 
> > I'm not necessarily opposed to doing it in dwc, but maybe there's some
> > advantage in reducing the number of ways of doing the same thing.
> 
> This actually started out as a quirk changing the cfg size. But the
> valid config space size seems to be different between root ports that
> share the same (broken) device ID (Synopsys abcd), so I doubt that this
> would be easier and/or any cleaner to implement as a quirk.

There are two things here: matching the root port and setting
the cfg size limit.

I agree with Bjorn that the cfg size limit, given that it is
implemented in core code should be leveraged instead of reinventing
the wheel to solve the same problem in driver specific code.

In the quirk code I do not think it is that complicated to retrieve
the IMX variant to apply the quirk accordingly on the pci_dev.

Please let me know if that's feasible so that I can drop the
patches from the branch and update it with a new version.

Thanks,
Lorenzo
