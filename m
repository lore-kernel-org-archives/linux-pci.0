Return-Path: <SRS0=xyCL=RH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B0DC43381
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 19:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5263206B6
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 19:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfCDTjw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:39:52 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50087 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCDTjw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Mar 2019 14:39:52 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h0tRC-0003Pa-Ld; Mon, 04 Mar 2019 20:39:46 +0100
Message-ID: <1551728385.9298.18.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly
 disabled
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de,
        Marc Zyngier <marc.zyngier@arm.com>
Date:   Mon, 04 Mar 2019 20:39:45 +0100
In-Reply-To: <20190304192548.GB26569@google.com>
References: <20190227165219.31911-1-l.stach@pengutronix.de>
         <20190304192548.GB26569@google.com>
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

Hi Bjorn,

Am Montag, den 04.03.2019, 13:25 -0600 schrieb Bjorn Helgaas:
> [+cc Marc, in case you have any suggestions]
> 
> Hi Lucas,
> 
> Nit: this has already been merged, but next time please make the
> subject line match the convention wrt capitalization.  This is not a
> PCI-specific idea; all it takes is "git log --oneline <file>", and
> that should be common practice anywhere in the kernel.

Sorry about that. I didn't really notice the capitalization, but
focused on the prefix.

> On Wed, Feb 27, 2019 at 05:52:19PM +0100, Lucas Stach wrote:
> > Since 7c5925afbc58 (PCI: dwc: Move MSI IRQs allocation to IRQ domains
> > hierarchical API) the MSI init claims one of the controller IRQs as a
> > chained IRQ line for the MSI controller. On some designs, like the i.MX6,
> > this line is shared with a PCIe legacy IRQ. When the line is claimed for
> > the MSI domain, any device trying to use this legacy IRQs will fail to
> > request this IRQ line.
> > 
> > As MSI and legacy IRQs are already mutually exclusive on the DWC core,
> > as the core won't forward any legacy IRQs once any MSI has been enabled,
> > users wishing to use legacy IRQs already need to explictly disable MSI
> > support (usually via the pci=nomsi kernel commandline option). To avoid
> > any issues with MSI conflicting with legacy IRQs, just skip all of the
> > DWC MSI initalization, including the IRQ line claim, when MSI is disabled.
> 
> Does this mean that if we have a device that uses legacy IRQs, the
> user has to figure out to boot with "pci=nomsi"?

As long as there is only a single device connected and there are no
port services things will work. If port services are active, those will
start to use MSIs, breaking legacy IRQs in the process.

I've asked Synopsys if there is a workaround for this, but it seems
that the core is working "as designed" with no workaround for this icky
behavior.

> I don't like kernel command line parameters.  If we need that
> parameter to make devices with legacy IRQs work, what happens without
> the parameter?  How obvious is it that the fix is to use "pci=nomsi"?

Totally non-obvious currently. Maybe this warrants a warning in the
kernel log.

> Is it impossible for Linux to figure this out and make it work
> automatically?
> 
> If we can't do it automatically, fine, maybe we have to live with the
> parameter.  But if there's any way we can avoid it, we should.

I don't think there is a practical way to make this work
automatically. 

At PCIe enumeration time we can only know if all devices in the
hierarchy are able to use MSIs, but this doesn't mean the device driver
will use MSIs. This is something we only get to know at driver probe
time, at which point it may already be too late, as another device
might already use some MSIs, so we can't revert to legacy IRQs only
mode.

Regards,
Lucas
