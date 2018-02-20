Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1519062520-198902-2-git-send-email-john.garry@huawei.com>
References: <1519062520-198902-1-git-send-email-john.garry@huawei.com> <1519062520-198902-2-git-send-email-john.garry@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Feb 2018 16:33:45 +0200
Message-ID: <CAHp75Vf102MDDZ8d9kXw2K0+0_WkhFMSq7o=Vz=KrzOM=NRW5A@mail.gmail.com>
Subject: Re: [PATCH v14 1/9] LIB: Introduce a generic PIO mapping method
To: John Garry <john.garry@huawei.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Dann Frazier <dann.frazier@canonical.com>,
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Corey Minyard <minyard@acm.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 19, 2018 at 7:48 PM, John Garry <john.garry@huawei.com> wrote:
> From: Zhichang Yuan <yuanzhichang@hisilicon.com>
>
> In commit 41f8bba7f555 ("of/pci: Add pci_register_io_range() and
> pci_pio_to_address()"), a new I/O space management was supported. With
> that driver, the I/O ranges configured for PCI/PCIe hosts on some
> architectures can be mapped to logical PIO, converted easily between
> CPU address and the corresponding logicial PIO. Based on this, PCI
> I/O devices can be accessed in a memory read/write way through the
> unified in/out accessors.
>
> But on some archs/platforms, there are bus hosts which access I/O
> peripherals with host-local I/O port addresses rather than memory
> addresses after memory-mapped.
>
> To support those devices, a more generic I/O mapping method is introduced
> here. Through this patch, both the CPU addresses and the host-local port
> can be mapped into the logical PIO space with different logical/fake PIOs.
> After this, all the I/O accesses to either PCI MMIO devices or host-local
> I/O peripherals can be unified into the existing I/O accessors defined in
> asm-generic/io.h and be redirected to the right device-specific hooks
> based on the input logical PIO.

> +#define PIO_INDIRECT           0x01UL /* indirect IO flag */
> +#define PIO_CPU_MMIO           0x00UL /* memory mapped io flag */

It looks like bitfield, but from use I don't see it.

Perhaps use enum instead?

> +       resource_size_t hwaddr = -1;

> +unsigned long
> +               return -1;
> +               return -1;

> +unsigned long
> +       return -1;

> +type logic_in##bw(unsigned long addr)                                  \
> +       type ret = -1;                                                  \

All types above are unsigned. I'm not sure it's the best approach to
use -1 implicitly casted to unsigned type.

I would rather use ~0UL or alike.

-- 
With Best Regards,
Andy Shevchenko
