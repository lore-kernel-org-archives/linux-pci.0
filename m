Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 20 May 2015 17:12:12 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org
Subject: Re: [RFC v1 10/25] sh: intc: Use irq_desc_get_xxx() to avoid redundant
 lookup of irq_desc
In-Reply-To: <1432116013-25902-11-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505201705110.4225@nanos>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-11-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 20 May 2015, Jiang Liu wrote:

> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
> already have a pointer to corresponding irq_desc.
> 
> Also replace generic_handle_irq with generic_handle_irq_desc() to avoid
> looking up irq_desc again.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/sh/intc/core.c |    2 +-
>  drivers/sh/intc/virq.c |   14 ++++++++------
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> index 81f22980b2de..e4ca964ca840 100644
> --- a/drivers/sh/intc/core.c
> +++ b/drivers/sh/intc/core.c
> @@ -67,7 +67,7 @@ void intc_set_prio_level(unsigned int irq, unsigned int level)
>  
>  static void intc_redirect_irq(unsigned int irq, struct irq_desc *desc)
>  {
> -	generic_handle_irq((unsigned int)irq_get_handler_data(irq));
> +	generic_handle_irq_desc(irq, desc);

This looks wrong. It's a redirector of irq to some other irq.

     	redir_irq = (unsigned int)irq_get_handler_data(irq);

which should be:

        redir_irq = (unsigned int)irq_desc_get_irq_handler_data(desc);

And redir_irq is certainly not the same as irq. So this wants a
conversion to irq_desc_get_irq_handler_data() first. That makes the
irq argument unused.

Thanks,

	tglx
