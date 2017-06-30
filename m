Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20170612155700.GA31930@red-moon>
 <20170613084831.GP3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
 <808a7db0-7844-b263-0216-1fe943ac819a@huawei.com>
 <20170630090515.GU629@lahna.fi.intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <b2bc9134-9944-bd6a-2daf-8f1a1ff49a62@huawei.com>
Date: Fri, 30 Jun 2017 10:28:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170630090515.GU629@lahna.fi.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, "minyard@acm.org" <minyard@acm.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "olof@lixom.net" <olof@lixom.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "brian.starkey@arm.com" <brian.starkey@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 30/06/2017 10:05, Mika Westerberg wrote:
> On Thu, Jun 29, 2017 at 05:16:15PM +0100, John Garry wrote:
>> On 16/06/2017 12:24, Rafael J. Wysocki wrote:
>>>>>>>>>
>>>>>>>>> It causes acpi_default_enumeration() to be called but it should be fine
>>>>>>>>> as we are dealing with platform device anyway.
>>>>>>>
>>>>>>> I do not quite understand how declaring such MFD cell above would make sure
>>>>>>> that the LPC probe is called before the IPMI device is enumerated...
>>>>>
>>>>> In fact it may be that it is not sufficient in this case because the
>>>>> ACPI core might enumerate child devices before the LPC driver even gets
>>>>> a chance to probe so you would need to add also scan handler to the
>>>>> child devices and mark them already enumerated or something like that.
>>> Or extend the special I2C/SPI handling to them.
>>>
>>
>> For this, is it possible to just configure the ACPI table so we spoof that
>> the LPC slave (IPI0001), is an i2c/spi slave? Could we just add a resource
>> of type ACPI_RESOURCE_TYPE_SERIAL_BUS, and common serial bus type i2c/spi to
>> solve this?
>
> But is the device connected to a I2C or SPI bus? If not, then it does
> not make much sense to declare it as I2C or SPI slave. Instead it should
> be platform device which is the type we use when there is no explicit
> bus specified in ACPI.
>

No, it's not a SPI nor an I2C bus. I actually would say that my idea is 
generally wrong, as the ACPI definition is not a real reflection of the 
bus/slave.

However, Rafael did suggest extending special I2C/SPI handling to them. 
In this case, I don't see how the LPC slave can be identified like an 
I2C or SPI slave is.

Thanks,
John

> .
>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
