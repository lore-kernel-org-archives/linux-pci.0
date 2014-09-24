Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <54227166.7010901@linux.intel.com>
Date: Wed, 24 Sep 2014 15:23:18 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC Part2 v1 01/21] irqdomain: Introduce new interfaces to support
 hierarchy irqdomains
References: <1410444228-3134-1-git-send-email-jiang.liu@linux.intel.com> <1410444228-3134-2-git-send-email-jiang.liu@linux.intel.com> <54226AE1.4000603@jp.fujitsu.com>
In-Reply-To: <54226AE1.4000603@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 2014/9/24 14:55, Yasuaki Ishimatsu wrote:
> (2014/09/11 23:03), Jiang Liu wrote:
>> +static void irq_domain_free_irq_data(unsigned int virq, unsigned int nr_irqs)
>> +{
>> +	int i;
>> +	struct irq_data *irq_data, *tmp;
>> +
>> +	for (i = 0; i < nr_irqs; i++) {
> 
>> +		irq_data = irq_get_irq_data(virq + i);
>> +		tmp = irq_data->parent_data;
> 
> Why don't you care NULL condition?
Yeah, there's an explicitly assumption that, irq_get_irq_data()
always return valid pointer once we have allocated the irq number
and associated irq_desc. If preferred, I will add a check here.

> 
>> +		irq_data->parent_data = NULL;
>> +		irq_data->domain = NULL;
>> +
>> +		while (tmp) {
>> +			irq_data = tmp;
>> +			tmp = tmp->parent_data;
>> +			kfree(irq_data);
>> +		}
>> +	}
>> +}
>> +
>> +static int irq_domain_alloc_irq_data(struct irq_domain *domain,
>> +				     unsigned int virq, unsigned int nr_irqs)
>> +{
>> +	int i;
>> +	struct irq_data *irq_data;
>> +	struct irq_domain *parent;
>> +
>> +	/* The outmost irq_data is embedded in struct irq_desc */
>> +	for (i = 0; i < nr_irqs; i++) {
> 
> 
>> +		irq_data = irq_get_irq_data(virq + i);
>> +		irq_data->domain = domain;
> 
> ditto.
Seems as above.
Regards!
Gerry

> 
> Thanks,
> Yasuaki Ishimatsu
> 
