Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45611 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962AbaICLS7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Sep 2014 07:18:59 -0400
Message-ID: <1409743007.1535.1.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] PCI: imx6: fix boot hang when link already enabled
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>,
	Shawn Guo <Shawn.Guo@freescale.com>
Date: Wed, 03 Sep 2014 13:16:47 +0200
In-Reply-To: <20140814202248.GA2071@google.com>
References: <1406830565-23450-1-git-send-email-l.stach@pengutronix.de>
	 <1406830565-23450-3-git-send-email-l.stach@pengutronix.de>
	 <20140814202248.GA2071@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Donnerstag, den 14.08.2014, 14:22 -0600 schrieb Bjorn Helgaas:
> On Thu, Jul 31, 2014 at 08:16:05PM +0200, Lucas Stach wrote:
> > This fixes a boot hang observed when the bootloader
> > already enabled the PCIe link for it's own use. The
> > fundamental problem is that Freescale forgot to wire
> > up the core reset, so software doesn't have a sane way
> > to get the core into a defined state.
> > 
> > According to the DW PCIe core reference manual configuration
> > of the core may only happen when the LTSSM is disabled, so
> > this is one of the first things we need to do. Apparently
> > this isn't safe to do when the LTSSM is in any other state
> > than "detect" as we observe an instant machine hang when
> > trying to do so while the link is already up.
> > 
> > As a workaround force LTSSM into detect state right before
> > hitting the disable switch.
> 

Bjorn,

I would have expected for this to show up in 3.17 as it fixes a real bug
and has been posted some time ago. While you have picked it up into your
pci/host-imx6 branch it doesn't show up in Linus tree nor in any pull
requests AFAICS.
Was it intentional from you to hold this patch or is this just an
oversight?

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

