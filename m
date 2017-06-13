Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
Subject: RE: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
 devices before scanning
Date: Tue, 13 Jun 2017 19:01:38 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495712248-5232-6-git-send-email-gabriele.paoloni@huawei.com>
 <20170530132408.GA2556@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A7B677@FRAEML521-MBX.china.huawei.com>
 <20170606085553.GA20085@red-moon> <20170612155700.GA31930@red-moon>
 <20170613084831.GP3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
In-Reply-To: <20170613151013.GT3187@lahna.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mika

> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> Sent: 13 June 2017 16:10
> To: Gabriele Paoloni
> Cc: Lorenzo Pieralisi; rafael@kernel.org; Rafael J. Wysocki;
> catalin.marinas@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; arnd@arndb.de; linux-arm-
> kernel@lists.infradead.org; mark.rutland@arm.com;
> brian.starkey@arm.com; olof@lixom.net; benh@kernel.crashing.org; linux-
> kernel@vger.kernel.org; linux-acpi@vger.kernel.org; Linuxarm; linux-
> pci@vger.kernel.org; minyard@acm.org; John Garry; xuwei (O)
> Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
> devices before scanning
> 
> On Tue, Jun 13, 2017 at 02:38:26PM +0000, Gabriele Paoloni wrote:
> > > Is there an example ASL showing how these LPC devices are
> > > currently presented in ACPI?
> >
> > Please find below the asl sketch for our LPC and IPMI
> >
> > //
> > // LPC
> > //
> >
> > Scope(_SB) {
> >   Device (LPC0) {
> >     Name (_HID, "HISI0191")  // HiSi LPC
> >     Name (_CRS, ResourceTemplate () {
> >       Memory32Fixed (ReadWrite, 0xa01b0000, 0x1000)
> >     })
> >   }
> >
> >   Device (LPC0.IPMI) {
> >     Name (_HID, "IPI0001")
> >     Method (_IFT) {
> >       Return (0x03)
> >     }
> >     Name (LORS, ResourceTemplate() {
> >       QWordIO (
> >         ResourceConsumer,
> > 	MinNotFixed,     // _MIF
> > 	MaxNotFixed,     // _MAF
> > 	PosDecode,
> > 	EntireRange,
> > 	0x0,             // _GRA
> > 	0xe4,            // _MIN
> > 	0x3fff,          // _MAX
> > 	0x0,             // _TRA
> > 	0x04,            // _LEN
> > 	, ,
> > 	BTIO
> >       )
> >     })
> >     CreateQWordField (LORS, BTIO._MIN, CMIN)
> >     CreateQWordField (LORS, BTIO._MAX, CMAX)
> >     CreateQWordField (LORS, BTIO._LEN, CLEN)
> >
> >     Method (_PRS, 0) {
> >       Return (LORS)
> >     }
> >
> >     Method (_CRS, 0) {
> >       Return (LORS)
> >     }
> >     Method (_SRS, 1) {
> >       CreateQWordField (Arg0, \_SB.LPC0.IPMI.BTIO._MIN, IMIN)
> >       Store (IMIN, CMIN)
> >       CreateQWordField (Arg0, \_SB.LPC0.IPMI.BTIO._MAX, IMAX)
> >       Store (IMAX, CMAX)
> >     }
> >   }
> > [...]
> > }
> 
> Thanks. So this looks pretty much like normal Linux MFD device which we
> already have support for adding ACPI bindings to child devices. It
> should also support splitting resources to child devices IIRC.

I am not very familiar with Linux MFD however the main issue here is that
1) for IPMI we want to re-use the standard IPMI driver without touching it:
   see 

   static const struct acpi_device_id acpi_ipmi_match[] = {
         { "IPI0001", 0 },
         { },
   };

   in "drivers/char/ipmi/ipmi_si_intf.c" (and in general any standard driver
   of an LPC child)

2) We need a way to guarantee that all LPC children are not enumerated
   by acpi_default_enumeration() (so for example if an ipmi node is an LPC#
   child it should not be enumerated, otherwise it should be)
   Currently acpi_default_enumeration() skips spi/i2c slaves by checking:
   1) if the acpi resource type is a serial bus
   2) if the type of serial bus descriptor is I2C or SPI

   For LPC we cannot leverage on any ACPI property to "recognize" that our
   devices are LPC children; hence before I proposed for acpi_default_enumeration()
   to skip devices that have already been enumerated (by calling 
   acpi_device_enumerated() ).

So in the current scenario, how do you think that MFD can help?
Do you see any possible solution?

Many thanks
Gab
  


