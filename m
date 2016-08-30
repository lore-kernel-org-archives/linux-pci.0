Return-Path: <emil.l.velikov@gmail.com>
Return-Path: <emil.l.velikov@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160830130634.GA16426@localhost>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost> <1cca943f-eab4-4054-4a13-31370d7ae057@desertbit.com>
 <20160829190737.GA4053@localhost> <a0079ace-3062-4792-5c33-3a5e350daac3@desertbit.com>
 <20160829235403.GA14177@localhost> <1d1bfdc2-f23d-9816-e4e3-ae676105dc39@desertbit.com>
 <20160830130634.GA16426@localhost>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 30 Aug 2016 15:08:27 +0100
Message-ID: <CACvgo51b4XLz2PwH1dkcK4_FknfZkSUKsFepYz-AGfPr7ux2kA@mail.gmail.com>
Subject: Re: Kernel Freeze with American Megatrends BIOS
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Roland Singer <roland.singer@desertbit.com>, linux-pci@vger.kernel.org,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	ML dri-devel <dri-devel@lists.freedesktop.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On 30 August 2016 at 14:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Aug 30, 2016 at 12:08:57PM +0200, Roland Singer wrote:
>> Thanks for pointing it out.
>>
>> Yeah that's right. The system will hang randomly a few minutes later,
>> because some certain actions in the graphical user session will trigger
>> the freeze.
>>
>> I had a look at the function body of pci_read_config_dword:
>>
>>   #define PCI_OP_READ(size, type, len) \
>>   int pci_bus_read_config_##size \
>>       (struct pci_bus *bus, unsigned int devfn, int pos, type *value) \
>>   {                                                                   \
>>       int res;                                                        \
>>       unsigned long flags;                                            \
>>       u32 data = 0;                                                   \
>>       if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;       \
>>       raw_spin_lock_irqsave(&pci_lock, flags);                        \
>>       res = bus->ops->read(bus, devfn, pos, len, &data);              \
>>       *value = (type)data;                                            \
>>       raw_spin_unlock_irqrestore(&pci_lock, flags);           \
>>       return res;                                                     \
>>   }
>>
>> I guess, that bus->ops->read(...) might be the trigger.
>> Any hints how to continue debugging?
>
> It's not likely that the problem is in the bus->ops->read() path.  That
> is used by every device driver, so a problem there would cause more
> serious problems than what you're seeing.
>
> My guess would be some problem in the video driver or the bbswitch
> thing.
>
FWIW I'm inclined to call it a bbswitch bug. It can (and does when
needed) power off the dedicated GPU.

Depending on the platform different methods are used:

Sometimes the GPU driver will get 0xffffffff (or similar) when trying
to read from the device mmio space. While one can say that the driver
should attribute for this, IMHO it's a bad idea to have two drivers
controlling the same hardware, let alone without any coordination
between them.

IIRC in some cases the device can disappear from the PCI bus (not 100%
sure this one). In which case a simple read can lead to a wide range
of fireworks.

Disclaimer: it's been a while since I've looked into bbswitch so
things might have changed/improved.

Regards,
Emil
