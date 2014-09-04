Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:39946 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbaIDUYn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 16:24:43 -0400
Received: by mail-pa0-f54.google.com with SMTP id fb1so20726097pad.27
        for <linux-pci@vger.kernel.org>; Thu, 04 Sep 2014 13:24:43 -0700 (PDT)
Date: Thu, 4 Sep 2014 14:24:36 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pci@vger.kernel.org,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Shawn Guo <Shawn.Guo@freescale.com>
Subject: Re: [PATCH 2/2] PCI: imx6: fix boot hang when link already enabled
Message-ID: <20140904202436.GA17125@google.com>
References: <1406830565-23450-1-git-send-email-l.stach@pengutronix.de>
 <1406830565-23450-3-git-send-email-l.stach@pengutronix.de>
 <20140814202248.GA2071@google.com>
 <1409743007.1535.1.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409743007.1535.1.camel@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 03, 2014 at 01:16:47PM +0200, Lucas Stach wrote:
> Am Donnerstag, den 14.08.2014, 14:22 -0600 schrieb Bjorn Helgaas:
> > On Thu, Jul 31, 2014 at 08:16:05PM +0200, Lucas Stach wrote:
> > > This fixes a boot hang observed when the bootloader
> > > already enabled the PCIe link for it's own use. The
> > > fundamental problem is that Freescale forgot to wire
> > > up the core reset, so software doesn't have a sane way
> > > to get the core into a defined state.
> > > 
> > > According to the DW PCIe core reference manual configuration
> > > of the core may only happen when the LTSSM is disabled, so
> > > this is one of the first things we need to do. Apparently
> > > this isn't safe to do when the LTSSM is in any other state
> > > than "detect" as we observe an instant machine hang when
> > > trying to do so while the link is already up.
> > > 
> > > As a workaround force LTSSM into detect state right before
> > > hitting the disable switch.
> > 
> 
> Bjorn,
> 
> I would have expected for this to show up in 3.17 as it fixes a real bug
> and has been posted some time ago. While you have picked it up into your
> pci/host-imx6 branch it doesn't show up in Linus tree nor in any pull
> requests AFAICS.
> Was it intentional from you to hold this patch or is this just an
> oversight?

Nope, I just missed it, thanks for the reminder.  I put in my
for-linus branch and will ask Linus to pull it after it's been
in -next for a few days.

Bjorn
