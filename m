Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34544 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbETSni (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 14:43:38 -0400
Date: Wed, 20 May 2015 20:43:16 +0200 (CEST)
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
In-Reply-To: <555CAD21.7040907@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505202041280.4225@nanos>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-26-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201737510.4225@nanos> <555CAD21.7040907@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Wed, 20 May 2015, Jiang Liu wrote:

> On 2015/5/20 23:40, Thomas Gleixner wrote:
> > On Wed, 20 May 2015, Jiang Liu wrote:
> >>  /* Chained IRQ handler for IPU error interrupt */
> >> -static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
> >> +static void ipu_irq_err(struct irq_desc *desc)
> >>  {
> >> +	unsigned int irq = irq_desc_to_irq(desc);
> > 
> > Why initializing? It's overwritten in the loop.
> Hi Thomas,
> 
> I'm not familiar with the hardware, but if src2map() returns 0
> on the first call, we need to initialize irq. Otherwise
> generic_handle_irq(irq) will use random value on the first call.
> ---------------------------------------------------------
>                         map = src2map(32 * i + line);
>                         if (map)
>                                 irq = map->irq;

You omitted the following code:

                        raw_spin_unlock(&bank_lock);

                        if (!map) {
                                pr_err("IPU: Interrupt on unmapped source %u bank %d\n",
                                       line, i);
                                continue;
			}

So you it does not use irq if map is 0.

Thanks,

	tglx

