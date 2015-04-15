Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from tkt-001-i374.relay.mailchannels.net ([174.136.5.177]:54536 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755963AbbDOLvY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Apr 2015 07:51:24 -0400
Date: Wed, 15 Apr 2015 11:51:18 +0000
From: Jason Cooper <jason@lakedaemon.net>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip/gicv3-its: Decrease page size when needed
Message-ID: <20150415115118.GN18660@io.lakedaemon.net>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Minghuan Lian,

On Wed, Apr 15, 2015 at 05:49:22PM +0800, Minghuan Lian wrote:
> The default page size of ITS table has been changed to 64KB,
> but for some platforms the real size of allocate memory which
> calculated by DEVBITS of register GITS_TYPER may smaller than
> default size. In this case, psz must be decreased, otherwise,
> the wrong page number will cause kernel hang.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 3 +++
>  1 file changed, 3 insertions(+)

Please run scripts/get_maintainer.pl on your patches before sending.  This
needs to be sent to myself and Thomas Gleixner for review.

The merge window just opened, so nothing new is being added to the tree
currently.  Go ahead and resend after a few days.

thx,

Jason.
