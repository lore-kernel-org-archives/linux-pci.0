Return-Path: <krzk@kernel.org>
Return-Path: <krzk@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180730224252.GE45322@bhelgaas-glaptop.roam.corp.google.com>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
 <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com> <20180730224252.GE45322@bhelgaas-glaptop.roam.corp.google.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 31 Jul 2018 10:08:29 +0200
Message-ID: <CAJKOXPfKEeZmk2zo4gdasES6Fx7Tq=wuVAtsq9+tNWMaTj8QnA@mail.gmail.com>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded interrupts
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
	Russell King <linux@armlinux.org.uk>, Sebastian Reichel <sre@kernel.org>, Milo Kim <milo.kim@ti.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On 31 July 2018 at 00:42, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc maintainers of possibly erroneous callers of request_threaded_irq()]
>
> On Mon, Jul 30, 2018 at 04:30:28PM -0500, Bjorn Helgaas wrote:
>> [+cc Thomas, Christoph, LKML]
>>
>> On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
>> > If we have a threaded interrupt with the handler being NULL, then
>> > request_threaded_irq() -> __setup_irq() will complain and bail out
>> > if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
>> > being NULL and set IRQF_ONESHOT in this case.
>> >
>> > This change is needed to migrate the mei_me driver to
>> > pci_alloc_irq_vectors() and pci_request_irq().
>> >
>> > Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>
>> I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
>> usage isn't mentioned in the request_threaded_irq() function doc or
>> Documentation/
>
> Possibly these other request_threaded_irq() callers are similarly
> broken?  I can't tell for sure about tda998x_create(), but all the
> others certainly call request_threaded_irq() with "handler == NULL"
> and irqflags that do not contain IRQF_ONESHOT:
>
>   max8997_muic_probe()
>     request_threaded_irq(virq, NULL, ..., IRQF_NO_SUSPEND, ...)
>
>   tda998x_create()
>     request_threaded_irq(client->irq, NULL, ..., irqd_get_trigger_type(), ...)
>     (I can't tell what irqd_get_trigger_type() does)
>
>   ab8500_btemp_probe()
>   ab8500_charger_probe()
>     request_threaded_irq(irq, NULL, ..., IRQF_SHARED | IRQF_NO_SUSPEND, ...)
>
>   lp8788_set_irqs()
>     request_threaded_irq(virq, NULL, ..., 0, ...)
>
>   max77686_rtc_probe()
>     request_threaded_irq(info->virq, NULL, ..., 0, ...)

max77686 works fine because it it is nested IRQ. Parent has ONESHOT flag set.

Best regards,
Krzysztof
