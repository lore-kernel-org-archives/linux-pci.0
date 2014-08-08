Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42510 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753974AbaHHNZW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Aug 2014 09:25:22 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by gateway1.nyi.internal (Postfix) with ESMTP id 8608523782
	for <linux-pci@vger.kernel.org>; Fri,  8 Aug 2014 09:25:21 -0400 (EDT)
Date: Fri, 8 Aug 2014 06:24:48 -0700
From: Greg KH <greg@kroah.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: l.stach@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
	shawn.guo@freescale.com, stable@vger.kernel.org, marex@denx.de,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: imx6: fix occasional link failure
Message-ID: <20140808132448.GA3797@kroah.com>
References: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407479800-6730-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 07, 2014 at 11:36:40PM -0700, Tim Harvey wrote:
> According to the IMX6 reference manuals, REF_SSP_EN (Reference clock enable
> for SS function) must remain deasserted until the reference clock is running
> at the appropriate frequency.
> 
> Without this patch we find a high link failure rate (>5%) on certain
> IMX6 boards at various temperatures.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/pci/host/pci-imx6.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
