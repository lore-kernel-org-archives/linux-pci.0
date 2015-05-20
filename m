Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <555CA929.3080306@linux.intel.com>
Date: Wed, 20 May 2015 23:32:57 +0800
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
	Russell King <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Roland Stigge <stigge@antcom.de>,
	Tony Lindgren <tony@atomide.com>,
	Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [RFC v1 15/25] genirq: Kill the first parameter 'irq' of irq_flow_handler_t
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201715380.4225@nanos>
In-Reply-To: <alpine.DEB.2.11.1505201715380.4225@nanos>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/20 23:28, Thomas Gleixner wrote:
> On Wed, 20 May 2015, Jiang Liu wrote:
>> -static void locomo_handler(unsigned int irq, struct irq_desc *desc)
>> +static void locomo_handler(struct irq_desc *desc)
>>  {
>>  	struct locomo *lchip = irq_desc_get_chip_data(desc);
>> +	unsigned int irq;
>>  	int req, i;
> 
> That leaves irq unitialized ....
That should be OK, 'irq' here is just a local variable.
Actually it may be changed as:
        if (req) {
                /* generate the next interrupt(s) */
-                irq = lchip->irq_base;
+                unsigned int irq = lchip->irq_base;
                for (i = 0; i <= 3; i++, irq++) {
                        if (req & (0x0100 << i)) {
                                generic_handle_irq(irq);
                        }

                }
        }

> 
> Thanks,
> 
> 	tglx
> 
