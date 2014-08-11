Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:42708 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbaHKRX7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Aug 2014 13:23:59 -0400
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] PCI: imx6: fix occasional link failure
Date: Mon, 11 Aug 2014 19:15:46 +0200
Cc: Tim Harvey <tharvey@gateworks.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawn.guo@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1407479800-6730-1-git-send-email-tharvey@gateworks.com> <CAOMZO5A+++cABSKFZR8-NUeNw1sASr_32Odymdp=JDXGGSJoNg@mail.gmail.com>
In-Reply-To: <CAOMZO5A+++cABSKFZR8-NUeNw1sASr_32Odymdp=JDXGGSJoNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201408111915.46321.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, August 08, 2014 at 05:59:23 PM, Fabio Estevam wrote:
> On Fri, Aug 8, 2014 at 3:36 AM, Tim Harvey <tharvey@gateworks.com> wrote:
> > According to the IMX6 reference manuals, REF_SSP_EN (Reference clock
> > enable for SS function) must remain deasserted until the reference clock
> > is running at the appropriate frequency.
> > 
> > Without this patch we find a high link failure rate (>5%) on certain
> > IMX6 boards at various temperatures.
> > 
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> 
> Thanks, Tim.
> 
> Marek,
> 
> Does this fix the PCI linkup failures you reported earlier?

I currently don't have the board available, so I will moan later if this is 
still broken. Please go ahead and apply, the patch looks good to me:

Acked-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
