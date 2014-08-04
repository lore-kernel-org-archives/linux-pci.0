Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <53DEFECB.3030201@huawei.com>
Date: Mon, 4 Aug 2014 11:32:27 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Jiang Liu <jiang.liu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>, <Paul.Mundt@huawei.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	<linux-pci@vger.kernel.org>,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	<virtualization@lists.linux-foundation.org>,
	Xinwei Hu <huxinwei@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Wuyun <wuyun.wu@huawei.com>
Subject: Re: [RFC PATCH 00/11] Refactor MSI to support Non-PCI device
References: <1406344128-27055-1-git-send-email-wangyijing@huawei.com> <53D89502.60506@linux.intel.com> <53D89CA1.7000501@huawei.com> <201408011516.26253.arnd@arndb.de>
In-Reply-To: <201408011516.26253.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/8/1 21:16, Arnd Bergmann wrote:
> On Wednesday 30 July 2014, Yijing Wang wrote:
>>>>>
>>>>> The other part I'm not completely sure about is how you want to
>>>>> have MSIs map into normal IRQ descriptors. At the moment, all
>>>>> MSI users are based on IRQ numbers, but this has known scalability problems.
>>>>
>>>> Hmmm, I still use the IRQ number to map the MSIs to IRQ description.
>>>> I'm sorry, I don't understand you meaning.
>>>> What are the scalability problems you mentioned ?
>>> We have soft limitation of nr_irqs or hard limitation NR_IRQS,
>>> we couldn't allocate as much irq number as we need in some cases,
>>> such as to support MSI-x.
>>
>> Oh, yes, this is a potential issue. Gerry, thanks for you explanation. :)
> 
> This should no longer be an issue, as arm64 uses CONFIG_SPARSE_IRQ
> and the number of interrupts is not limited in any form.
> 
> My point was more that the device driver should not need to care about
> the interrupt number: it gets made up on the spot when the MSI is
> needed, and then it is only used to request the IRQ. This can be
> simplified into one interface at the device driver level, even though
> the internal still use numbers somewhere. If we ever remove IRQ numbers
> from the driver API, this part doesn't need to get touched again.
> 

Hi Arnd, I have another question is some drivers will request more than one
MSI/MSI-X IRQ, and the driver will use them to process different things.
Eg. network driver generally uses one of them to process trivial network thins,
and others to transmit/receive data.

So, in this case, it seems to driver need to touch the IRQ numbers.

wr-linux:~ # cat /proc/interrupts
            CPU0       CPU1       CPU2     ....      CPU17      CPU18      CPU19      CPU20      CPU21      CPU22      CPU23
 ......
 100:          0          0          0               0          0          0          0          0          0          0  IR-PCI-MSI-edge      eth0
 101:          2          0          0               0          0          0  302830488          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-0
 102:        110          0          0               0          0  360675897          0          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-1
 103:        109          0          0               0          0          0          0          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-2
 104:        107          0          0         9678933          0          0          0          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-3
 105:        107          0          0               0  357838258          0          0          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-4
 106:        115          0          0               0          0          0          0          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-5
 107:        114          0          0               0          0          0          0  337866096          0          0  IR-PCI-MSI-edge      eth0-TxRx-6
 108:  373801199          0          0               0          0          0          0          0          0          0  IR-PCI-MSI-edge      eth0-TxRx-7

Thanks!
Yijing.

> 
> .
> 


-- 
Thanks!
Yijing

