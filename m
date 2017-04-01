Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bfdf2de0-c309-0139-4075-dfcd678b6d51@gmail.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
 <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
 <1908501.jAQQKvjW4f@aspire.rjw.lan> <58DDFCBE.1030705@hisilicon.com>
 <CAJZ5v0gZdghH7jjd-zMmqXNkuvVVVSPDHfBrJXx5OXR2NE0KgA@mail.gmail.com> <bfdf2de0-c309-0139-4075-dfcd678b6d51@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 1 Apr 2017 11:52:04 +0200
Message-ID: <CAJZ5v0iYD=2HVP9D-2fBBDUzkOJLrzzH7Rwg1ALQ-kBx-iSeTg@mail.gmail.com>
Subject: Re: [PATCH V8 5/6] ACPI: Support the probing on the devices which
 apply indirect-IO
To: "zhichang.yuan" <zhichang.yuan02@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "zhichang.yuan" <yuanzhichang@hisilicon.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linuxarm@huawei.com,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Corey Minyard <minyard@acm.org>,
        Zou Rongrong <zourongrong@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        kantyzc@163.com, xuwei5@hisilicon.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 1, 2017 at 4:16 AM, zhichang.yuan <zhichang.yuan02@gmail.com> wrote:
>
>
> On 04/01/2017 07:02 AM, Rafael J. Wysocki wrote:
>> On Fri, Mar 31, 2017 at 8:52 AM, zhichang.yuan
>> <yuanzhichang@hisilicon.com> wrote:
>>> Hi, Rafael,
>>>
>>> Thanks for reviewing this!
>>>
>>> On 2017/3/31 4:31, Rafael J. Wysocki wrote:
>>>> On Thursday, March 30, 2017 11:26:58 PM zhichang.yuan wrote:
>>>>> On some platforms(such as Hip06/Hip07), the legacy ISA/LPC devices access I/O
>>>>> with some special host-local I/O ports known on x86. To access the I/O
>>>>> peripherals, an indirect-IO mechanism is introduced to mapped the host-local
>>>>> I/O to system logical/fake PIO similar the PCI MMIO on architectures where no
>>>>> separate I/O space exists. Just as PCI MMIO, the host I/O range should be
>>>>> registered before probing the downstream devices and set up the I/O mapping.
>>>>> But current ACPI bus probing doesn't support these indirect-IO hosts/devices.
>>>>>
>>>>> This patch introdueces a new ACPI handler for this device category. Through the
>>>>> handler attach callback, the indirect-IO hosts I/O registration is done and
>>>>> all peripherals' I/O resources are translated into logic/fake PIO before
>>>>> starting the enumeration.
>>>>
>>>> Can you explain to me briefly what exactly this code is expected to be doing?
>>>
>>> As you know currently for ARM architecture IO space is memory mapped and
>>> is only used by pci devices. The port number is dynamically allocated
>>> converting the device IO address into a PIO token: i.e.
>>> http://lxr.free-electrons.com/source/drivers/acpi/pci_root.c#L745
>>> This patch is meant to support a new class of IO host controller
>>> that are not PCI based and that still require to have the IO addresses
>>> be translated in the same PIO token space as the PCI controller
>>
>> IOW, this is ARM-specific, right?
>
> Yes. The current host added in this patch with _HID "HISI0191" is on ARM64.

But the underlying mechanism is ARM-specific as well AFAICS.

> But, I think the handler driver is architecture dependent.

I guess you mean "independent"?  That doesn't matter.

If ARM64 is the only architecture to use it in foreseeable future
(which is the case for all I can say), it should go into acpi/arm64/
and please ask the maintainers thereof to review it.

Thanks,
Rafael
