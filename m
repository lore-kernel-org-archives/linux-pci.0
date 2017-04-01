Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V8 5/6] ACPI: Support the probing on the devices which
 apply indirect-IO
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 "zhichang.yuan" <yuanzhichang@hisilicon.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
 <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
 <1908501.jAQQKvjW4f@aspire.rjw.lan> <58DDFCBE.1030705@hisilicon.com>
 <CAJZ5v0gZdghH7jjd-zMmqXNkuvVVVSPDHfBrJXx5OXR2NE0KgA@mail.gmail.com>
From: "zhichang.yuan" <zhichang.yuan02@gmail.com>
Message-ID: <bfdf2de0-c309-0139-4075-dfcd678b6d51@gmail.com>
Date: Sat, 1 Apr 2017 10:16:53 +0800
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gZdghH7jjd-zMmqXNkuvVVVSPDHfBrJXx5OXR2NE0KgA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Will Deacon <will.deacon@arm.com>,
 linuxarm@huawei.com, Frank Rowand <frowand.list@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 xuwei5@hisilicon.com, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Corey Minyard <minyard@acm.org>, John Garry <john.garry@huawei.com>,
 Zou Rongrong <zourongrong@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kantyzc@163.com,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, Brian Starkey <brian.starkey@arm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>



On 04/01/2017 07:02 AM, Rafael J. Wysocki wrote:
> On Fri, Mar 31, 2017 at 8:52 AM, zhichang.yuan
> <yuanzhichang@hisilicon.com> wrote:
>> Hi, Rafael,
>>
>> Thanks for reviewing this!
>>
>> On 2017/3/31 4:31, Rafael J. Wysocki wrote:
>>> On Thursday, March 30, 2017 11:26:58 PM zhichang.yuan wrote:
>>>> On some platforms(such as Hip06/Hip07), the legacy ISA/LPC devices access I/O
>>>> with some special host-local I/O ports known on x86. To access the I/O
>>>> peripherals, an indirect-IO mechanism is introduced to mapped the host-local
>>>> I/O to system logical/fake PIO similar the PCI MMIO on architectures where no
>>>> separate I/O space exists. Just as PCI MMIO, the host I/O range should be
>>>> registered before probing the downstream devices and set up the I/O mapping.
>>>> But current ACPI bus probing doesn't support these indirect-IO hosts/devices.
>>>>
>>>> This patch introdueces a new ACPI handler for this device category. Through the
>>>> handler attach callback, the indirect-IO hosts I/O registration is done and
>>>> all peripherals' I/O resources are translated into logic/fake PIO before
>>>> starting the enumeration.
>>>
>>> Can you explain to me briefly what exactly this code is expected to be doing?
>>
>> As you know currently for ARM architecture IO space is memory mapped and
>> is only used by pci devices. The port number is dynamically allocated
>> converting the device IO address into a PIO token: i.e.
>> http://lxr.free-electrons.com/source/drivers/acpi/pci_root.c#L745
>> This patch is meant to support a new class of IO host controller
>> that are not PCI based and that still require to have the IO addresses
>> be translated in the same PIO token space as the PCI controller
> 
> IOW, this is ARM-specific, right?

Yes. The current host added in this patch with _HID "HISI0191" is on ARM64.
But, I think the handler driver is architecture dependent.

Thanks,
Zhichang

> 
> Thanks,
> Rafael
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
