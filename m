Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: hosts: mark pcie/pci (msi) irq cascade handler as
 IRQF_NO_THREAD
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <1449775100-30877-1-git-send-email-grygorii.strashko@ti.com>
 <20160106221827.GD16231@localhost> <20160113133904.GD29964@linutronix.de>
 <20160113175016.GB28453@localhost> <56969BE3.6000804@ti.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<tony@atomide.com>, <nsekhar@ti.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-sh@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Richard Zhu <Richard.Zhu@freescale.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <56973DEC.2000108@ti.com>
Date: Thu, 14 Jan 2016 11:49:24 +0530
MIME-Version: 1.0
In-Reply-To: <56969BE3.6000804@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thursday 14 January 2016 12:18 AM, Grygorii Strashko wrote:
> On 01/13/2016 07:50 PM, Bjorn Helgaas wrote:
>> On Wed, Jan 13, 2016 at 02:39:04PM +0100, Sebastian Andrzej Siewior wrote:
>>> * Bjorn Helgaas | 2016-01-06 16:18:27 [-0600]:
>>>
>>>> Hi Bjorn,
>>>
>>>>> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
>>>>> index 8c36880..0415192 100644
>>>>> --- a/drivers/pci/host/pci-dra7xx.c
>>>>> +++ b/drivers/pci/host/pci-dra7xx.c
>>>>> @@ -301,8 +301,19 @@ static int __init dra7xx_add_pcie_port(struct
>>>>> dra7xx_pcie *dra7xx,
>>>>>           return -EINVAL;
>>>>>       }
>>>>>
>>>>> +    /*
>>>>> +     * Mark dra7xx_pcie_msi IRQ as IRQF_NO_THREAD
>>>>> +     * On -RT and if kernel is booting with "threadirqs" cmd line parameter
>>>>> +     * the dra7xx_pcie_msi_irq_handler() will be forced threaded but,
>>>>> +     * in the same time, it's IRQ dispatcher and calls generic_handle_irq(),
>>>>> +     * which, in turn, will be resolved to handle_simple_irq() call.
>>>>> +     * The handle_simple_irq() expected to be called with IRQ disabled, as
>>>>> +     * result kernle will display warning:
>>>>> +     * "irq XXX handler YYY+0x0/0x14 enabled interrupts".
>>>>> +     */
>>>
>>> could you _please_ remove this coment? This kind of comment (if at all)
>>> should be part of the commit message (which is the case more or less).
>>
>> IIRC, Grygorii specifically wanted to keep this comment in dra7xx, but
> 
> True.
> 
>> I do agree that this level of detail is more appropriate for a changelog.
>>
>> If Grygorii and Kishon don't object, I can update the patch to remove it.
> 
> But no objections from my side. Thanks a lot.

I don't have any objections.

Thanks
Kishon
