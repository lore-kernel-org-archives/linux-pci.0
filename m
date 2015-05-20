Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <555C609A.3000203@linux.intel.com>
Date: Wed, 20 May 2015 18:23:22 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [RFC v1 00/25] Optimize irq flow handler
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <20150520101616.GA20163@gmail.com>
In-Reply-To: <20150520101616.GA20163@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/20 18:16, Ingo Molnar wrote:
> 
> * Jiang Liu <jiang.liu@linux.intel.com> wrote:
> 
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
>>   genirq: Kill the first parameter 'irq' of irq_flow_handler_t
> 
> Those kinds of identical titles are not acceptable.
Hi Ingo,
	Those patches with identical titles will be merged into one
when ready for merging, they are split for review only.
Thanks!
Gerry

> 
> Thanks,
> 
> 	Ingo
> 
