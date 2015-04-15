Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36435 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933346AbbDOQbM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Apr 2015 12:31:12 -0400
Date: Wed, 15 Apr 2015 17:31:05 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Cc: <linux-pci@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Zang Roy-R61911 <r61911@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Scott Wood <scottwood@freescale.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip/gicv3-its: Decrease page size when needed
Message-ID: <20150415173105.2069df0c@arm.com>
In-Reply-To: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1429091364-31939-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 15 Apr 2015 17:49:22 +0800
Minghuan Lian <Minghuan.Lian@freescale.com> wrote:

[adding Jason and Thomas to the party, since they shoud be cc'd the
first place]

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
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 596b0a9..d0374a6 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -844,6 +844,9 @@ static int its_alloc_tables(struct its_node *its)
>  
>  		its->tables[i] = base;
>  
> +		while (alloc_size < psz)
> +			psz = psz >> 1;
> +
>  retry_baser:
>  		val = (virt_to_phys(base) 				 |
>  		       (type << GITS_BASER_TYPE_SHIFT)			 |

This doesn't make sense to me. psz is the page size that your HW
supports, not necessarily something that you can actually change as you
wish (some, if not most, ITSs only support one page size). Also, you
now have to psz go via unsupported page sizes (like 32K and 8K), and
you may end up programming junk in the registers. Good job! ;-)

So making it vary to accommodate your allocation size is slightly
doomed. If your allocation is smaller than your ITS page size, it is
the allocation that has to be bumped up, not the page size that has to
be reduced.

So overall, this is a NAK. Please come up with a better fix.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
