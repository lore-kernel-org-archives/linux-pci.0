Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <56A281B6.6070709@gmail.com>
Date: Fri, 22 Jan 2016 11:23:34 -0800
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
	Cao jin <caoj.fnst@cn.fujitsu.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Chen Fan <chen.fan.fnst@cn.fujitsu.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, izumi.taku@jp.fujitsu.com,
	wency@cn.fujitsu.com, Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH] pci: fix unavailable irq number 255 reported by BIOS
References: <1453167913-16248-1-git-send-email-chen.fan.fnst@cn.fujitsu.com> <6239489.QX2A2kAHWp@vostro.rjw.lan> <20160120002431.GA7973@localhost> <56A0EE00.80709@cn.fujitsu.com> <CAJZ5v0iq29mq_sFzk=mEbjPGJV9vPL9MCgU4WamrGV_fWcpEMA@mail.gmail.com> <20160122175332.GA11004@localhost>
In-Reply-To: <20160122175332.GA11004@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/22/2016 09:53 AM, Bjorn Helgaas wrote:
> On Thu, Jan 21, 2016 at 11:58:26PM +0100, Rafael J. Wysocki wrote:
>> On Thu, Jan 21, 2016 at 3:41 PM, Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
>>> Hi,
>>>
>>>      IMHO, I think maybe modification on i801_smbus driver is easier.
>>>
>>>      Because when i801_smbus request_irq using pci_dev->irq, this
>>> pci_dev->irq seems still holds the value read from register(
>>> pci_setup_device->pci_read_irq), if the value is 255, it is invalid in
>>> register,
>>
>> Right.
>>
>> Which is why the PCI core should not leak it into the driver's ->probe callback.
>
> Is there a reserved IRQ value we could use to mean "invalid"?

In many (most) cases, zero indicates no irq.




>
> I guess we have NR_IRQS as a ceiling, so the range of valid IRQs would be
> [0 .. NR_IRQS - 1].  It looks like irq_desc() and a few drivers already
> rely on NR_IRQS being the bound:
>
>    lpc32xx_kscan_probe
>    lpc32xx_nand_probe
>    pcmcia_setup_isa_irq
>    lpc32xx_rtc_probe
>    apbuart_verify_port
>    ar933x_uart_verify_port
>    lqasc_verify_port
>
> So I guess we could use ~0 as "invalid IRQ", and maybe the PCI core could
> set dev->irq to ~0 in these cases, and drivers like i801_smbus could check
> for that.  Maybe a wrapper like irq_valid() would be useful.
>
> Bjorn
>
>
