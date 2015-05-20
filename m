Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <555CAD21.7040907@linux.intel.com>
Date: Wed, 20 May 2015 23:49:53 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [RFC v1 25/25] genirq: Kill the first parameter 'irq' of irq_flow_handler_t
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-26-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201737510.4225@nanos>
In-Reply-To: <alpine.DEB.2.11.1505201737510.4225@nanos>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/20 23:40, Thomas Gleixner wrote:
> On Wed, 20 May 2015, Jiang Liu wrote:
>>  /* Chained IRQ handler for IPU error interrupt */
>> -static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
>> +static void ipu_irq_err(struct irq_desc *desc)
>>  {
>> +	unsigned int irq = irq_desc_to_irq(desc);
> 
> Why initializing? It's overwritten in the loop.
Hi Thomas,

I'm not familiar with the hardware, but if src2map() returns 0
on the first call, we need to initialize irq. Otherwise
generic_handle_irq(irq) will use random value on the first call.
---------------------------------------------------------
                        map = src2map(32 * i + line);
                        if (map)
                                irq = map->irq;
---------------------------------------------------------
Thanks!
Gerry

> 
>>  /* Chained IRQ handler for IPU function interrupt */
>> -static void ipu_irq_fn(unsigned int irq, struct irq_desc *desc)
>> +static void ipu_irq_fn(struct irq_desc *desc)
>>  {
>> +	unsigned int irq = irq_desc_to_irq(desc);
> 
> Ditto.
> 
> Thanks,
> 
> 	tglx
> 
