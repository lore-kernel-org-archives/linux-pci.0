Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:38121 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdL2Ql6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 11:41:58 -0500
MIME-Version: 1.0
In-Reply-To: <5A40AB83.4070809@huawei.com>
References: <5A40AB83.4070809@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Dec 2017 18:41:57 +0200
Message-ID: <CAHp75VevSxEXTsUvwqP_=54itDiX2KYJsy4VVkqTbf5Mzdq6qw@mail.gmail.com>
Subject: Re: [BUG ? ] Each pci bridge only supports hotplugging 16 numbers of
 virtio-blk/virtio-net devices
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 25, 2017 at 9:40 AM, Hailiang Zhang
<zhang.zhanghailiang@huawei.com> wrote:
> Hi,
>
> We tried to hot add more than 16 numbers of virtio-blk devices to pci
> bridge, but found that only 16 of them are available in VM.

+Cc Mika

I guess it depends to how much resources are available to hotplug initially=
.

>
> There are =E2=80=98no space=E2=80=99 error messages in dmesg:
>
> [    4.666106] pci 0000:00:03.0: PCI bridge to [bus 01]
>
> [    4.666191] pci 0000:00:03.0:   bridge window [io  0x7000-0x7fff]
>
> [    4.670044] pci 0000:00:03.0:   bridge window [mem 0xfe800000-0xfe9fff=
ff]
>
> [    4.672650] pci 0000:00:03.0:   bridge window [mem 0xfcc00000-0xfcdfff=
ff
> 64bit pref]
>
> [    4.677876] pci 0000:00:07.0: PCI bridge to [bus 02]
>
> [    4.677967] pci 0000:00:07.0:   bridge window [io  0x6000-0x6fff]
>
> [    4.681816] pci 0000:00:07.0:   bridge window [mem 0xfe600000-0xfe7fff=
ff]
>
> [    4.684422] pci 0000:00:07.0:   bridge window [mem 0xfca00000-0xfcbfff=
ff
> 64bit pref]
>
> =E2=80=A6 =E2=80=A6
>
> [   85.779103] pci 0000:02:17.0: [1af4:1001] type 00 class 0x010000
>
> [   85.779194] pci 0000:02:17.0: reg 0x10: [io  0x0000-0x003f]
>
> [   85.779235] pci 0000:02:17.0: reg 0x14: [mem 0x00000000-0x00000fff]
>
> [   85.779812] pci 0000:02:17.0: BAR 1: assigned [mem 0xfe60f000-0xfe60ff=
ff]
>
> [   85.779835] pci 0000:02:17.0: BAR 0: assigned [io  0x6cc0-0x6cff]
>
> [   85.779951] virtio-pci 0000:02:17.0: enabling device (0000 -> 0003)
>
> [   85.833435] virtio-pci 0000:02:17.0: virtio_pci: leaving for legacy
> driver
>
> [   85.846894] virtio-pci 0000:02:17.0: irq 61 for MSI/MSI-X
>
> [   85.846927] virtio-pci 0000:02:17.0: irq 62 for MSI/MSI-X
>
> [   86.013107] pci 0000:02:18.0: [1af4:1001] type 00 class 0x010000
>
> [   86.013199] pci 0000:02:18.0: reg 0x10: [io  0x0000-0x003f]
>
> [   86.013241] pci 0000:02:18.0: reg 0x14: [mem 0x00000000-0x00000fff]
>
> [   86.013868] pci 0000:02:18.0: BAR 1: assigned [mem 0xfe610000-0xfe610f=
ff]
>
> [   86.013903] pci 0000:02:18.0: BAR 0: no space for [io  size 0x0040]
>
> [   86.013925] pci 0000:02:18.0: BAR 0: failed to assign [io  size 0x0040=
]
>
> [   86.014010] virtio-pci 0000:02:18.0: enabling device (0000 -> 0002)
>
> [   86.057575] virtio-pci 0000:02:18.0: virtio_pci: leaving for legacy
> driver
>
> [   86.088217] virtio-pci: probe of 0000:02:18.0 failed with error -12
>
> We went through the kernel codes which processing the hotplug pci devices=
,
> the call stack is:
>
> acpi_hotplug_work_fn
>
> =E2=80=93>enable_slot
>
> ->__pci_bus_assign_resources
>
> ->pci_bus_alloc_resource
>
> ->pci_bus_alloc_from_region
>
> ->allocate_resource
>
> ->find_resource
>
> ->pcibios_align_resource
>
> The failure comes with pcibios_align_resource().
>
> resource_size_t
>
> pcibios_align_resource(void *data, const struct resource *res,
>
> resource_size_t size, resource_size_t align)
>
> {
>
> struct pci_dev *dev =3D data;
>
> resource_size_t start =3D res->start;
>
> if (res->flags & IORESOURCE_IO) {
>
> if (skip_isa_ioresource_align(dev))
>
> return start;
>
> if (start & 0x300)
>
> start =3D (start + 0x3ff) & ~0x3ff; =C3=A0here.
>
> With the above logic, Only the bellow IO addresses are available for
> virtio-blk:
>
> [0x6000-0x603f], [0x6040-0x607f], [0x6080-0x60bf], [0x60c0-0x60ff]
>
> [0x6400-0x643f], [0x6440-0x647f], [0x6480-0x64bf], [0x64c0-0x64ff]
>
> [0x6800-0x683f], [0x6840-0x687f], [0x6880-0x68bf], [0x68c0-0x68ff]
>
> [0x6c00-0x6c3f], [0x6c40-0x6c7f], [0x6c80-0x6cbf], [0x6cc0-0x6cff]
>
> So the number is just 16.
>
> We have noticed the comments above pcibios_align_resource():
>
> +/*
>
> + * We need to avoid collisions with `mirrored' VGA ports
>
> + * and other strange ISA hardware, so we always want the
>
> + * addresses to be allocated in the 0x000-0x0ff region
>
> + * modulo 0x400.
>
> + *
>
> But we still didn=E2=80=99t quite understand about this, does anyone know=
 about this
> ?
>
> Or could we skip this checking for standard pci devices ?
>
> Thanks,
>
> Hailiang
>
>



--=20
With Best Regards,
Andy Shevchenko
