Return-Path: <SRS0=u2l1=3T=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=u2l1=3T=vodafone.de=deathsimple@kernel.org>
Subject: Re: [PATCH 3/4] x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models
 30h-3fh) Processors
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-4-git-send-email-deathsimple@vodafone.de>
 <CAHp75Ve4RXtuh7=8FUDv8RXGFMuYLte9GCOd02Y427BrFtPzYA@mail.gmail.com>
Cc: helgaas@kernel.org, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <a35666e2-9b32-8dbd-232d-013f7298b688@vodafone.de>
Date: Tue, 11 Apr 2017 11:21:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve4RXtuh7=8FUDv8RXGFMuYLte9GCOd02Y427BrFtPzYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Am 13.03.2017 um 17:49 schrieb Andy Shevchenko:
> On Mon, Mar 13, 2017 at 2:41 PM, Christian König
> <deathsimple@vodafone.de> wrote:
>
>> Most BIOS don't enable this because of compatibility reasons.
>>
>> Manually enable a 64bit BAR of 64GB size so that we have
>> enough room for PCI devices.
>> +static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
>> +{
>> +       const uint64_t size = 64ULL * 1024 * 1024 * 1024;
> Perhaps extend <linux/sizes.h> and use SZ_64G here?
>
> It would be nice to do, since some of the drivers already are using
> sizes like 4GB and alike.

Actually using 64GB here was just for testing and to get some initial 
feedback.

I think we want to use all the remaining address space for PCIe, but for 
this we would need a new function in the resource management I think.

Going to take a deeper look when I'm sure we actually want this.

>> +       if (i == 8)
>> +               return;
>> +
>> +       res = kzalloc(sizeof(*res), GFP_KERNEL);
>> +       res->flags = IORESOURCE_MEM | IORESOURCE_PREFETCH | IORESOURCE_MEM_64 |
>> +               IORESOURCE_WINDOW;
>> +       res->name = dev->bus->name;
>> +       r = allocate_resource(&iomem_resource, res, size, 0x100000000,
>> +                             0xfd00000000, size, NULL, NULL);
>> +       if (r) {
>> +               kfree(res);
>> +               return;
>> +       }
>> +
>> +       base = ((res->start >> 8) & 0xffffff00) | 0x3;
>> +       limit = ((res->end + 1) >> 8) & 0xffffff00;
>> +       high = ((res->start >> 40) & 0xff) |
>> +               ((((res->end + 1) >> 40) & 0xff) << 16);
> Perhaps some of constants can be replaced by defines (I think some of
> them are already defined in ioport.h or somewhere else).

Yeah, good idea. But that stuff is purely AMD CPU specific, so won't 
belong into ioport.h or similar common code.

Does anybody have any idea where I could put this?

Regards,

Christian.
