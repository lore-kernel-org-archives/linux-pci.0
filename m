Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 May 2015 17:40:11 +0200 (CEST)
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
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Steve Longerbeam <slongerbeam@gmail.com>,
	Gilad Avidov <gavidov@codeaurora.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC v1 25/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <1432116013-25902-26-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505201737510.4225@nanos>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-26-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 20 May 2015, Jiang Liu wrote:
>  /* Chained IRQ handler for IPU error interrupt */
> -static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
> +static void ipu_irq_err(struct irq_desc *desc)
>  {
> +	unsigned int irq = irq_desc_to_irq(desc);

Why initializing? It's overwritten in the loop.

>  /* Chained IRQ handler for IPU function interrupt */
> -static void ipu_irq_fn(unsigned int irq, struct irq_desc *desc)
> +static void ipu_irq_fn(struct irq_desc *desc)
>  {
> +	unsigned int irq = irq_desc_to_irq(desc);

Ditto.

Thanks,

	tglx
