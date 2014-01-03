Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 3 Jan 2014 17:50:08 +0000
From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
To: Yinghai Lu <yinghai@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, <xen-devel@lists.xensource.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH v5 16/33] xen, irq: Call irq_alloc_reserved_desc_at()
 at first
In-Reply-To: <1388707565-16535-17-git-send-email-yinghai@kernel.org>
Message-ID: <alpine.DEB.2.02.1401031749340.8667@kaball.uk.xensource.com>
References: <1388707565-16535-1-git-send-email-yinghai@kernel.org> <1388707565-16535-17-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2 Jan 2014, Yinghai Lu wrote:
> To make x86 irq allocation to be same with booting path and ioapic
> hot add path, We will pre-reserve irq for all gsi at first.
> We have to use alloc_reserved here, otherwise irq_alloc_desc_at will fail
> because bit is already get marked for pre-reserved in irq bitmaps.
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: xen-devel@lists.xensource.com
> ---
>  drivers/xen/events.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/events.c b/drivers/xen/events.c
> index 4035e83..020cd77 100644
> --- a/drivers/xen/events.c
> +++ b/drivers/xen/events.c
> @@ -508,8 +508,12 @@ static int __must_check xen_allocate_irq_gsi(unsigned gsi)
>  	/* Legacy IRQ descriptors are already allocated by the arch. */
>  	if (gsi < NR_IRQS_LEGACY)
>  		irq = gsi;
> -	else
> -		irq = irq_alloc_desc_at(gsi, -1);
> +	else {
> +		/* for x86, irq already get reserved for gsi */
> +		irq = irq_alloc_reserved_desc_at(gsi, -1);
> +		if (irq < 0)
> +			irq = irq_alloc_desc_at(gsi, -1);
> +	}

This is common code. On ARM I get:

drivers/xen/events.c: In function 'xen_allocate_irq_gsi':
drivers/xen/events.c:513:3: error: implicit declaration of function 'irq_alloc_reserved_desc_at' [-Werror=implicit-function-declaration]
   irq = irq_alloc_reserved_desc_at(gsi, -1);
   ^
cc1: some warnings being treated as errors

