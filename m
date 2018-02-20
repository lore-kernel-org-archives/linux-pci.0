Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH v14 0/9] LPC: legacy ISA I/O support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1519062520-198902-1-git-send-email-john.garry@huawei.com>
 <CAHp75VeFiQocuedW64ePgLO=_FQd7Q_hX-+wMh0zec3XUzhVxw@mail.gmail.com>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Dann Frazier <dann.frazier@canonical.com>,
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linux-pci@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Corey Minyard <minyard@acm.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <55d64c79-87b6-78e0-b13e-77ac7f1c9e90@huawei.com>
Date: Tue, 20 Feb 2018 15:41:18 +0000
MIME-Version: 1.0
In-Reply-To: <CAHp75VeFiQocuedW64ePgLO=_FQd7Q_hX-+wMh0zec3XUzhVxw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20/02/2018 14:54, Andy Shevchenko wrote:
> On Mon, Feb 19, 2018 at 7:48 PM, John Garry <john.garry@huawei.com> wrote:
>> > This patchset supports the IPMI-bt device attached to the Low-Pin-Count
>> > interface implemented on Hisilicon Hip06/Hip07 SoC.
>> >                         -----------
>> >                         | LPC host|
>> >                         |         |
>> >                         -----------
>> >                              |
>> >                 _____________V_______________LPC
>> >                   |                       |
>> >                   V                       V
>> >                                      ------------
>> >                                      |  BT(ipmi)|
>> >                                      ------------
>> >
>> > When master accesses those peripherals beneath the Hip06/Hip07 LPC, a specific
>> > LPC driver is needed to make LPC host generate the standard LPC I/O cycles with
>> > the target peripherals'I/O port addresses. But on curent arm64 world, there is
>> > no real I/O accesses. All the I/O operations through in/out accessors are based
>> > on MMIO ranges; on Hip06/Hip07 LPC the I/O accesses are performed through driver
>> > specific accessors rather than MMIO.
>> > To solve this issue and keep the relevant existing peripherals' drivers untouched,
>> > this patchset:
>> >    - introduces a generic I/O space management framework, logical PIO, to support
>> >       I/O operations on host controllers operating either on MMIO buses or on buses
>> >      requiring specific driver I/O accessors;
>> >    - redefines the in/out accessors to provide a unified interface for both MMIO
>> >      and driver specific I/O operations. Using logical PIO, th call of in/out() from
>> >      the host children drivers, such as ipmi-si, will be redirected to the
>> >      corresponding device-specific I/O hooks to perform the I/O accesses.
>> >
>> > Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC peripherals can
>> > be supported without any changes on the existing ipmi-si driver.
>> >
>> > The whole patchset has been tested on Hip07 D05 board both using DTB and ACPI.
>> >
>> > Differences to v13:
>> > - dropped ACPI scan handler and added patch to not enumerate children
>> >   of indirect IO hosts in ACPI code
>> > - tidied up logic_pio.c a bit for kerneldoc and made some APIs clearer
>> >   to understand
>> > - tided (and simplified) hisi_lpc.c and added new ACPI probe code
>> >   (same as previous ACPI scan handler code, so comments from Rafael
>> >   and Andy included)
>> > - reinstated PCI range upper limit check in pci_pio_to_address()
>> > - dropped Dann Frazier's "tested-by" tag in light of changes
>> > - rebase to linuxnext 20180219 (had to fix locally arm64 build issue)
>> >
> Some minor comments per patches, otherwise FWIW
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>

Thanks, the comments in the other 2 patches I did not reply to are ok.

John
