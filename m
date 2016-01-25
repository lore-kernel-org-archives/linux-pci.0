Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52221 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932373AbcAYXAv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jan 2016 18:00:51 -0500
Date: Mon, 25 Jan 2016 17:00:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	linux-pci@vger.kernel.org, kernel@pengutronix.de,
	patchwork-lst@pengutronix.de, dave.mueller@gmx.ch,
	sanjeevsharmaengg@gmail.com, dev@lynxeye.de
Subject: Re: [PATCH 0/4] i.MX6 sleep while atomic bugfix
Message-ID: <20160125230047.GA19776@localhost>
References: <1452884210-11359-1-git-send-email-l.stach@pengutronix.de>
 <20160125225811.GC10272@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160125225811.GC10272@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc bugzilla folks]

On Mon, Jan 25, 2016 at 04:58:11PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 15, 2016 at 07:56:46PM +0100, Lucas Stach wrote:
> > There have been some reports about a possible scheduling while atomic bug
> > in the i.MX6 PCIe host driver, like the following one
> > https://bugzilla.kernel.org/show_bug.cgi?id=100031
> > 
> > Although there were some proposed patches, they all had some flaws, which
> > lead to none of them being included in the mainline kernel. The following
> > patch series fixes this bug in a proper way, instead of papering over the
> > problem, making the fix a bit bigger.
> > 
> > Regards
> > Lucas
> > 
> > Lucas Stach (4):
> >   PCI: imx6: move PHY reset function to other PHY handling functions
> >   PCI: imx6: move PHY reset into establish_link
> >   PCI: imx6: remove broken Gen2 workaround
> >   PCI: imx6: move link up check into establish link path
> > 
> >  drivers/pci/host/pci-imx6.c | 137 +++++++++++++++++---------------------------
> >  1 file changed, 54 insertions(+), 83 deletions(-)
> 
> Applied to pci/host-imx6 for v4.6, thanks!
