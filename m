Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40B15AA2@FRAEML521-MBX.china.huawei.com>
References: <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
 <20170616120048.GC629@lahna.fi.intel.com>
 <CAJZ5v0g+qVui6RU=Hy3c_3qAAWngqaAu6B3JxGOpqF06kitbzA@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40ACFB8D@FRAEML521-MBX.china.huawei.com>
 <20170619100209.GC629@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40ACFC3D@FRAEML521-MBX.china.huawei.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B10487@FRAEML521-MBX.china.huawei.com>
 <CAHp75VevOno613gk8QHDA7kmLZJj9TLZRiu7oJUs_xaRzcbpnw@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40B15AA2@FRAEML521-MBX.china.huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Jul 2017 18:46:59 +0300
Message-ID: <CAHp75VccwpesvDxMcxZ+349rhrAq8QxNoau9XmquMnv9DBLBfA@mail.gmail.com>
Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "minyard@acm.org" <minyard@acm.org>, John Garry <john.garry@huawei.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "olof@lixom.net" <olof@lixom.net>,
 "brian.starkey@arm.com" <brian.starkey@arm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 4, 2017 at 6:14 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:

>> > In my case I'd like to have a platform device using the resources
>> that are
>> > parsed from the ACPI table (i.e. as it is done now by
>> > acpi_create_platform_device()).
>>
>> So far so good. Nothing prevents you to do that.
>>
>> > If my understanding is correct, if I declared an mfd_cell for my IPMI
>> child
>> > the mfd subsystem would create a platform device for such child and
>> > therefore acpi_create_platform_device() would fail to create a new
>> platform
>> > device as adev->physical_node_count will be non zero.
>> > However as things stand now mfd_cell devices can only use the
>> resources
>> > that are statically defined in the code (and therefore not the ones
>> in the
>> > ACPI nodes)...am I right?
>>
>> You may file resources first and then register MFD cells. See many
>> existing examples in the kernel.
>
> Well I had a look around the Kernel I have seen no mfd cells using
> Resources that are not statically defined:
> i.e. cell->resources in mfd_add_device() always points to statically
> defined resource structures.
>
> Usually for ACPI devices first you need to parse the ACPI resources
> from the table calling acpi_dev_get_resources(), then you iterate
> over the resource list and fill the resource array by calling
> acpi_platform_fill_resurces() (as in acpi_create_platform_device())
>
> With respect to my case are you suggesting dynamically allocate a
> resource array and fill it using the same fashion as
> acpi_create_platform_device(), then point cell->resources to such
> array before calling mfd_add_device() ?

You may do it on stack. Define your cell statically (but not const)
and apply resources just before mfd_add_devices() call.
There are examples in the existing drivers. Intel LPC comes to my mind
and perhaps PMC (Broxton), though latter has too much other stuff
around.

-- 
With Best Regards,
Andy Shevchenko

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
