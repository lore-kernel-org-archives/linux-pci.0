Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
 devices before scanning
Date: Tue, 13 Jun 2017 14:38:26 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
References: <1495712248-5232-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495712248-5232-6-git-send-email-gabriele.paoloni@huawei.com>
 <20170530132408.GA2556@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A7B677@FRAEML521-MBX.china.huawei.com>
 <20170606085553.GA20085@red-moon> <20170612155700.GA31930@red-moon>
 <20170613084831.GP3187@lahna.fi.intel.com>
In-Reply-To: <20170613084831.GP3187@lahna.fi.intel.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "minyard@acm.org" <minyard@acm.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "rafael@kernel.org" <rafael@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 John Garry <john.garry@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "olof@lixom.net" <olof@lixom.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "brian.starkey@arm.com" <brian.starkey@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mika

> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> Sent: 13 June 2017 09:49
> To: Lorenzo Pieralisi
> Cc: Gabriele Paoloni; rafael@kernel.org; Rafael J. Wysocki;
> catalin.marinas@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; arnd@arndb.de; linux-arm-
> kernel@lists.infradead.org; mark.rutland@arm.com;
> brian.starkey@arm.com; olof@lixom.net; benh@kernel.crashing.org; linux-
> kernel@vger.kernel.org; linux-acpi@vger.kernel.org; Linuxarm; linux-
> pci@vger.kernel.org; minyard@acm.org; John Garry; xuwei (O)
> Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
> devices before scanning
> 
> On Mon, Jun 12, 2017 at 04:57:00PM +0100, Lorenzo Pieralisi wrote:
> > I had a more in-depth look at this series and from my understanding
> > the problem are the following to manage the LPC bindings in ACPI.
> >
> > (1) Child devices of an LPC controller require special handling when
> >     filling their resources (ie they need to be translated - in DT
> >     that's guaranteed by the "isa" binding, in ACPI it has to be
> >     done by new code)
> > (2) In DT systems, LPC child devices are created by the LPC bus
> >     controller driver through an of_platform_populate() call with
> >     the LPC controller node as the fwnode root. For ACPI to work
> >     the same way there must be a way to prevent LPC children to
> >     be enumerated in acpi_default_enumeration() something like
> >     I2C does (and then the LPC driver would enumerate its children as
> >     DT does)
> >
> > I am not sure how (1) and (2) can be managed with current ACPI
> bindings
> > and kernel code - I suspect it may be done by mirroring what's done
> > for I2C but I am not sure, that's why I CC'ed Mika (ie the LPC
> adapter
> > is matched as a platform device and it takes care of enumerating its
> > children - problem though is preventing enumeration from core ACPI
> code).
> 
> Is there an example ASL showing how these LPC devices are
> currently presented in ACPI?

Please find below the asl sketch for our LPC and IPMI

//
// LPC
//

Scope(_SB) {
  Device (LPC0) {
    Name (_HID, "HISI0191")  // HiSi LPC
    Name (_CRS, ResourceTemplate () {
      Memory32Fixed (ReadWrite, 0xa01b0000, 0x1000)
    })
  }

  Device (LPC0.IPMI) {
    Name (_HID, "IPI0001")
    Method (_IFT) {
      Return (0x03)
    }
    Name (LORS, ResourceTemplate() {
      QWordIO (
        ResourceConsumer,
	MinNotFixed,     // _MIF
	MaxNotFixed,     // _MAF
	PosDecode,
	EntireRange,
	0x0,             // _GRA
	0xe4,            // _MIN
	0x3fff,          // _MAX
	0x0,             // _TRA
	0x04,            // _LEN
	, ,
	BTIO
      )
    })
    CreateQWordField (LORS, BTIO._MIN, CMIN)
    CreateQWordField (LORS, BTIO._MAX, CMAX)
    CreateQWordField (LORS, BTIO._LEN, CLEN)

    Method (_PRS, 0) {
      Return (LORS)
    }

    Method (_CRS, 0) {
      Return (LORS)
    }
    Method (_SRS, 1) {
      CreateQWordField (Arg0, \_SB.LPC0.IPMI.BTIO._MIN, IMIN)
      Store (IMIN, CMIN)
      CreateQWordField (Arg0, \_SB.LPC0.IPMI.BTIO._MAX, IMAX)
      Store (IMAX, CMAX)
    }
  } 
[...]
}

Many thanks
Gab

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
