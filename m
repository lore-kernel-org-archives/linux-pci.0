Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED1FC43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F8B218C3
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 15:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeLSPwQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:52:16 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59749 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbeLSPwQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 10:52:16 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gZe8q-0006dU-M4; Wed, 19 Dec 2018 16:52:12 +0100
Message-ID: <1545234725.5874.38.camel@pengutronix.de>
Subject: Re: [v4] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Smirnov <andrew.smirnov@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Trent Piepho <tpiepho@impinj.com>
Date:   Wed, 19 Dec 2018 16:52:05 +0100
In-Reply-To: <20181219141241.GB12763@google.com>
References: <1544768762-18124-1-git-send-email-hongxing.zhu@nxp.com>
         <20181219141241.GB12763@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Mittwoch, den 19.12.2018, 08:12 -0600 schrieb Bjorn Helgaas:
> [+cc Sven, Trent, et al from related report:
> https://lore.kernel.org/linux-pci/20181218210444.5950-1-TheSven73@googlemail.com]
> 
> On Fri, Dec 14, 2018 at 06:44:15AM +0000, Richard Zhu wrote:
> > Assertion of the MSI Enable bit of RC's MSI CAP is mandatory required to
> > trigger MSI on i.MX6 PCIe.
> > This bit would be asserted when CONFIG_PCIEPORTBUS=y.
> > Thus, the MSI works fine on i.MX6 PCIe before the commit "f3fdfc4".
> > 
> > Assert it unconditionally when MSI is enabled.
> > Otherwise, the MSI wouldn't be triggered although the EP is present and
> > the MSIs are assigned.
> 
> OK, I think I finally understand most of what's going on.  Please
> check the following possible changelog text:
> 
>   The MSI Enable bit in the MSI Capability (PCIe r4.0, sec 7.7.1.2)
>   controls whether a Function can request service using MSI.
> 
>   i.MX6 Root Ports implement the MSI Capability and may use MSI to
>   request service for events like PME, hotplug, AER, etc.  In
>   addition, on i.MX6, the MSI Enable bit controls delivery of MSI
>   interrupts from components below the Root Port.
> 
>   Prior to f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection of
>   CONFIG_PCIEPORTBUS"), enabling CONFIG_PCI_IMX6 automatically also
>   enabled CONFIG_PCIEPORTBUS, and when portdrv claimed the Root Ports,
>   it set the MSI Enable bit so it could use PME, hotplug, AER, etc.
>   As a side effect, that also enabled delivery of MSI interrupts from
>   downstream components.
> 
>   After f3fdfc4ac3a2, the imx6q-pcie driver can operate without
>   portdrv, but that means imx6q-pcie must set the MSI Enable bit
>   itself if downstream components use MSI.
> 
>   Fixes: f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection of CONFIG_PCIEPORTBUS")
> 
> I still don't understand exactly *how* MSI Enable affects MSI from
> downstream components, since the downstream component just does a DMA
> write, and the Root Port can't tell whether the write is to memory or
> interrupt controller unless the Root Port knows where the MSI targets
> are, e.g., if the interrupt controller is actually part of the RC.

The controller terminating the MSI write is part of the DWC PCIe host
controller on i.MX6, which is questionable at least when you think
about how a MSI should be self-synchronizing to memory writes, but
that's reality...

As to why the controller needs the MSI Enable bit set, I have no idea.
But then the DWC controller is known to have some funky design
limitations regarding MSI, like not forwarding legacy PCI interrupts
anymore when MSI is enabled, so it's not totally surprising that we
need some quirky setup here.

Regards,
Lucas
