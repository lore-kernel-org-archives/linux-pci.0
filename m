Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:40087 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307AbaFYVbN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jun 2014 17:31:13 -0400
From: Marek Vasut <marex@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
Date: Wed, 25 Jun 2014 23:28:11 +0200
Cc: bhelgaas@google.com, r65037@freescale.com, shawn.guo@freescale.com,
	d.mueller@elsoft.ch, kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	tharvey@gateworks.com, Fabio Estevam <fabio.estevam@freescale.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1403637507-9424-1-git-send-email-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201406252328.11777.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, June 24, 2014 at 09:18:27 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> When the mx6 PCI conctroller is initialized in the bootloader we see a
> kernel hang inside imx6_add_pcie_port().
> 
> Adding a 30ms delay allows the kernel to boot.
> 
> Suggested-by: David Müller <d.mueller@elsoft.ch>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> I am happy to get feedback on how to properly fix this.

Honestly, I have no clue. I would expect Freescale to help us in solving this as 
they are the chip vendor, but they cannot help either :-(

Apologies, I really have no idea .

Best regards,
Marek Vasut
