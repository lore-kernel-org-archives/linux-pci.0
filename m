Return-Path: <SRS0=Iu0t=KO=gmail.com=andy.shevchenko@kernel.org>
Return-Path: <SRS0=Iu0t=KO=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com> <20180730213028.GC45322@bhelgaas-glaptop.roam.corp.google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 31 Jul 2018 00:54:20 +0300
Message-ID: <CAHp75VfJBdDxgV3dnv5UrG-DHg-_3at+BeO3j8kFAXUn2t11pQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded interrupts
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 31, 2018 at 12:30 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> [+cc Thomas, Christoph, LKML]
>
> On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
>> If we have a threaded interrupt with the handler being NULL, then
>> request_threaded_irq() -> __setup_irq() will complain and bail out
>> if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
>> being NULL and set IRQF_ONESHOT in this case.
>>
>> This change is needed to migrate the mei_me driver to
>> pci_alloc_irq_vectors() and pci_request_irq().
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>
> I'd like an ack from Thomas because this requirement about IRQF_ONESHOT
> usage isn't mentioned in the request_threaded_irq() function doc or
> Documentation/

 * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
 *                Used by threaded interrupts which need to keep the
 *                irq line disabled until the threaded handler has been run.


-- 
With Best Regards,
Andy Shevchenko
