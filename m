Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 16 Jun 2017 15:00:48 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "brian.starkey@arm.com" <brian.starkey@arm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        John Garry <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>
Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
Message-ID: <20170616120048.GC629@lahna.fi.intel.com>
References: <20170606085553.GA20085@red-moon>
 <20170612155700.GA31930@red-moon>
 <20170613084831.GP3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
 <20170616083313.GY3187@lahna.fi.intel.com>
 <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0gWGL=M1+T2DxFfwAi=gCbBBnLFVyp4u+1EVem-mcSNQg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 16, 2017 at 01:24:32PM +0200, Rafael J. Wysocki wrote:
> > In fact it may be that it is not sufficient in this case because the
> > ACPI core might enumerate child devices before the LPC driver even gets
> > a chance to probe so you would need to add also scan handler to the
> > child devices and mark them already enumerated or something like that.
> 
> Or extend the special I2C/SPI handling to them.

Sure but those have I2c/SpiSerialBus() resources which we can use to
identify them but for the ipmi thing there is nothing else than _HID so
we would need to keep a list of such devices in ACPI core.
