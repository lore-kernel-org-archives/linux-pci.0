Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Mar 2017 09:39:15 +0100
Message-ID: <CAK8P3a1f33ipk3Q8+wj9L6zP=ccn_AuhTfV0CC0+wAqrO-2beg@mail.gmail.com>
Subject: Re: [PATCH V7 0/7] LPC: legacy ISA I/O support
To: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, rjw@rjwysocki.net,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@huawei.com, devicetree@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-serial@vger.kernel.org, Corey Minyard <minyard@acm.org>,
        liviu.dudau@arm.com, Zou Rongrong <zourongrong@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        zhichang.yuan02@gmail.com, kantyzc@163.com,
        Wei Xu <xuwei5@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 3:42 AM, zhichang.yuan
<yuanzhichang@hisilicon.com> wrote:
> This patchset supports the IPMI-bt device attached to the Low-Pin-Count
> interface implemented on Hisilicon Hip06/Hip07 SoC.
>                         -----------
>                         | LPC host|
>                         |         |
>                         -----------
>                              |
>                 _____________V_______________LPC
>                   |                       |
>                   V                       V
>                                      ------------
>                                      |  BT(ipmi)|
>                                      ------------
>
> When master accesses those peripherals beneath the Hip06/Hip07 LPC, a specific
> LPC driver is needed to make LPC host generate the standard LPC I/O cycles with
> the target peripherals'I/O port addresses. But on curent arm64 world, there is
> no real I/O accesses. All the I/O operations through in/out pair are based on
> MMIO which is not satisfied the I/O mechanism on Hip06/Hip07 LPC.
> To solve this issue and keep the relevant existing peripherals' driver
> untouched, this patchset implements:
>   - introduces a generic I/O space management framwork, LIBIO, to support I/O
>     operations of both MMIO buses and the host controllers which access their
>     peripherals with host local I/O addresses;
>   - redefines the in/out accessors to provide unified interfaces for MMIO and
>     legacy I/O. Based on the LIBIO, the calling of in/out() from upper-layer
>     drivers, such as ipmi-si, will be redirected to the corresponding
>     device-specific I/O hooks to perfrom the I/O accesses.
> Based on this patch-set, all the I/O accesses to Hip06/Hip07 LPC peripherals
> can be supported without any changes on the existing ipmi-si driver.

Thanks for reposting this. I have a few high-level comments first, based on
the walk through the code I did with Gabriele and John last week:

- I think the libio framework is more generic than it needs to be, but as
  Alex really liked it this way and it was done like this based on his earlier
  comments, I think that's ok.

- after we went back and forth on the ACPI implementation, we concluded
  that it is correct to do the same as on DT and completely abstract the
  number space for I/O ports. No code should rely on a Linux port number
  to have any particular relation to the physical address or the the address
  on a PCI or LPC bus.

- The name "libio" still needs to be changed, this is way too generic, as
  "I/O" can refer to many things in the kernel, and almost none of them
  are related to x86 programmed I/O ports in any way. My suggestion
  would be "generic_ioport", or possibly "libioport", "libpio" or "pci_io". Any
  of them would work for me, or someone else could come up with a better
  name that describes what it is.

- I'm pretty sure the current implementation is broken for the ioport_map
  function that tries to turn an IORESOURCE_IO number into a pointer.
  Forcing CONFIG_GENERIC_IOMAP on would solve this, but also
  make all MMIO operations slower, which we probably don't want.
  It's probably enough to add a check in ioport_map() to see if the range
  is mapped into a virtual address or not.

- We could simplify the lookup a bit by using the trick from arch/ia64
  of using an array instead of linked list for walking the port numbers.
  There, the upper bits of the port number refer to an address space
  number while the lower bits refer to the bus address within that
  address space. This should work just as well as the current
  implementation but would be a little easier to understand. Maybe
  Bjorn can comment on this too, as I think he was involved with the
  ia64 implementation.

      Arnd
