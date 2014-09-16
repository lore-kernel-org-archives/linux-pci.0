Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54394 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032AbaIPXxe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Sep 2014 19:53:34 -0400
From: Marek Vasut <marex@denx.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: imx6: fix occasional link failure
Date: Wed, 17 Sep 2014 01:53:12 +0200
Cc: Tim Harvey <tharvey@gateworks.com>, l.stach@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>, shawn.guo@freescale.com,
	stable@vger.kernel.org, linux-pci@vger.kernel.org
References: <1407479800-6730-1-git-send-email-tharvey@gateworks.com> <20140916232859.GI5050@google.com>
In-Reply-To: <20140916232859.GI5050@google.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201409170153.12783.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 17, 2014 at 01:28:59 AM, Bjorn Helgaas wrote:
> On Thu, Aug 07, 2014 at 11:36:40PM -0700, Tim Harvey wrote:
> > According to the IMX6 reference manuals, REF_SSP_EN (Reference clock
> > enable for SS function) must remain deasserted until the reference clock
> > is running at the appropriate frequency.
> > 
> > Without this patch we find a high link failure rate (>5%) on certain
> > IMX6 boards at various temperatures.
> > 
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> 
> Applied to pci/host-imx6 for v3.18 with acks from Marek and Lucas, thanks!

Thanks!

Best regards,
Marek Vasut
