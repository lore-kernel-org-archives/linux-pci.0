Return-Path: <SRS0=u2l1=3T=vodafone.de=deathsimple@kernel.org>
Return-Path: <SRS0=u2l1=3T=vodafone.de=deathsimple@kernel.org>
Subject: Re: [PATCH 2/4] PCI: add functionality for resizing resources v2
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1489408896-25039-1-git-send-email-deathsimple@vodafone.de>
 <1489408896-25039-3-git-send-email-deathsimple@vodafone.de>
 <CAHp75VcY_P63T3-XcYafxhSFshQyL1dj0B2+Q4iW9hMiig3tRQ@mail.gmail.com>
Cc: helgaas@kernel.org, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Platform Driver <platform-driver-x86@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Message-ID: <b467c769-954b-bd18-1c54-e88d0785a6bf@vodafone.de>
Date: Tue, 11 Apr 2017 11:14:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VcY_P63T3-XcYafxhSFshQyL1dj0B2+Q4iW9hMiig3tRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Sorry for the delayed response, have been busy with other stuff recently.

Am 13.03.2017 um 17:43 schrieb Andy Shevchenko:
>> v2: rebase on changes in rbar support
> This kind of comments usually goes after --- delimiter below.

That would remove it from the commit message which I don't want.


>> +       unsigned i;
>> +       int ret = 0;
>> +
>> +       /* Release all children from the matching bridge resource */
>> +       for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END; ++i) {
>> +               struct resource *res = &bridge->resource[i];
>> +
>
>> +               if ((res->flags & type_mask) != (type & type_mask))
> IIUC it would be
> if ((res->flags ^ type) & type_mask)
>
> (I consider 'diff' as XOR operation is more understandable, but it's up to you)

I think like it is is easier to read.


>> +               res->start = saved.start;
>> +               res->end = saved.end;
>> +               res->flags = saved.flags;
> Would
>   *res = saved;
> work?

No, res also contains a bunch of pointers into the tree which we should 
not override.

>> +int pci_resize_resource(struct pci_dev *dev, int resno, int size)
>> +{
>> +       struct resource *res = dev->resource + resno;
>> +       u32 sizes = pci_rbar_get_possible_sizes(dev, resno);
>> +       int old = pci_rbar_get_current_size(dev, resno);
>> +       u64 bytes = 1ULL << (size + 20);
>> +       int ret = 0;
>> +
> I would put
>   sizes = pci_rbar_get_possible_sizes(dev, resno);
> here

Good idea, done.


>> +       if (!sizes)
>> +               return -ENOTSUPP;
>> +
>> +       if (!(sizes & (1 << size)))
> BIT(size) ?

Done.

> and
>   old = pci_rbar_get_current_size(dev, resno);
> here

Good idea as well.

>> +error_resize:
>> +       pci_rbar_set_size(dev, resno, old);
>> +       res->end = res->start + (1ULL << (old + 20)) - 1;
> BIT_ULL(old + 20) ?

Nope, that is actually a size in bytes. Not a bitfield. So while BIT_ULL 
yields the right result it would be harder to understand.

Christian.
