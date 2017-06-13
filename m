Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 13 Jun 2017 18:10:13 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
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
Message-ID: <20170613151013.GT3187@lahna.fi.intel.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495712248-5232-6-git-send-email-gabriele.paoloni@huawei.com>
 <20170530132408.GA2556@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A7B677@FRAEML521-MBX.china.huawei.com>
 <20170606085553.GA20085@red-moon>
 <20170612155700.GA31930@red-moon>
 <20170613084831.GP3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 13, 2017 at 02:38:26PM +0000, Gabriele Paoloni wrote:
> > Is there an example ASL showing how these LPC devices are
> > currently presented in ACPI?
> 
> Please find below the asl sketch for our LPC and IPMI
> 
> //
> // LPC
> //
> 
> Scope(_SB) {
>   Device (LPC0) {
>     Name (_HID, "HISI0191")  // HiSi LPC
>     Name (_CRS, ResourceTemplate () {
>       Memory32Fixed (ReadWrite, 0xa01b0000, 0x1000)
>     })
>   }
> 
>   Device (LPC0.IPMI) {
>     Name (_HID, "IPI0001")
>     Method (_IFT) {
>       Return (0x03)
>     }
>     Name (LORS, ResourceTemplate() {
>       QWordIO (
>         ResourceConsumer,
> 	MinNotFixed,     // _MIF
> 	MaxNotFixed,     // _MAF
> 	PosDecode,
> 	EntireRange,
> 	0x0,             // _GRA
> 	0xe4,            // _MIN
> 	0x3fff,          // _MAX
> 	0x0,             // _TRA
> 	0x04,            // _LEN
> 	, ,
> 	BTIO
>       )
>     })
>     CreateQWordField (LORS, BTIO._MIN, CMIN)
>     CreateQWordField (LORS, BTIO._MAX, CMAX)
>     CreateQWordField (LORS, BTIO._LEN, CLEN)
> 
>     Method (_PRS, 0) {
>       Return (LORS)
>     }
> 
>     Method (_CRS, 0) {
>       Return (LORS)
>     }
>     Method (_SRS, 1) {
>       CreateQWordField (Arg0, \_SB.LPC0.IPMI.BTIO._MIN, IMIN)
>       Store (IMIN, CMIN)
>       CreateQWordField (Arg0, \_SB.LPC0.IPMI.BTIO._MAX, IMAX)
>       Store (IMAX, CMAX)
>     }
>   } 
> [...]
> }

Thanks. So this looks pretty much like normal Linux MFD device which we
already have support for adding ACPI bindings to child devices. It
should also support splitting resources to child devices IIRC.
