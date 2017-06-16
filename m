Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:17401 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752877AbdFPIft (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jun 2017 04:35:49 -0400
Date: Fri, 16 Jun 2017 11:33:13 +0300
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
Message-ID: <20170616083313.GY3187@lahna.fi.intel.com>
References: <20170530132408.GA2556@red-moon>
 <EE11001F9E5DDD47B7634E2F8A612F2E40A7B677@FRAEML521-MBX.china.huawei.com>
 <20170606085553.GA20085@red-moon>
 <20170612155700.GA31930@red-moon>
 <20170613084831.GP3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAE3DA@FRAEML521-MBX.china.huawei.com>
 <20170613151013.GT3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AAF0BF@FRAEML521-MBX.china.huawei.com>
 <20170613200339.GX3187@lahna.fi.intel.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40AB537A@FRAEML521-MBX.china.huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 15, 2017 at 06:01:02PM +0000, Gabriele Paoloni wrote:
> Hi Mika
> 
> > -----Original Message-----
> > From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> > owner@vger.kernel.org] On Behalf Of Mika Westerberg
> > Sent: 13 June 2017 21:04
> > To: Gabriele Paoloni
> > Cc: Lorenzo Pieralisi; rafael@kernel.org; Rafael J. Wysocki;
> > catalin.marinas@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> > frowand.list@gmail.com; bhelgaas@google.com; arnd@arndb.de; linux-arm-
> > kernel@lists.infradead.org; mark.rutland@arm.com;
> > brian.starkey@arm.com; olof@lixom.net; benh@kernel.crashing.org; linux-
> > kernel@vger.kernel.org; linux-acpi@vger.kernel.org; Linuxarm; linux-
> > pci@vger.kernel.org; minyard@acm.org; John Garry; xuwei (O)
> > Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
> > devices before scanning
> > 
> > On Tue, Jun 13, 2017 at 07:01:38PM +0000, Gabriele Paoloni wrote:
> > > I am not very familiar with Linux MFD however the main issue here is
> > that
> > > 1) for IPMI we want to re-use the standard IPMI driver without
> > touching it:
> > >    see
> > >
> > >    static const struct acpi_device_id acpi_ipmi_match[] = {
> > >          { "IPI0001", 0 },
> > >          { },
> > >    };
> > >
> > >    in "drivers/char/ipmi/ipmi_si_intf.c" (and in general any standard
> > driver
> > >    of an LPC child)
> > >
> > > 2) We need a way to guarantee that all LPC children are not
> > enumerated
> > >    by acpi_default_enumeration() (so for example if an ipmi node is
> > an LPC#
> > >    child it should not be enumerated, otherwise it should be)
> > >    Currently acpi_default_enumeration() skips spi/i2c slaves by
> > checking:
> > >    1) if the acpi resource type is a serial bus
> > >    2) if the type of serial bus descriptor is I2C or SPI
> > >
> > >    For LPC we cannot leverage on any ACPI property to "recognize"
> > that our
> > >    devices are LPC children; hence before I proposed for
> > acpi_default_enumeration()
> > >    to skip devices that have already been enumerated (by calling
> > >    acpi_device_enumerated() ).
> > >
> > > So in the current scenario, how do you think that MFD can help?
> > 
> > If you look at Documentation/acpi/enumeration.txt there is a chapter
> > "MFD devices". I think it pretty much maches what you have here. An LPC
> > device (MFD device) and bunch of child devices. The driver for your LPC
> > device can specify _HID for each child device. Those are then mached by
> > the MFD ACPI code to the corresponding ACPI nodes from which platform
> > devices are created including "IPI0001".
> 
> So I guess here in the LPC driver I would have an MFD cell for IPMI. I.e.:
> 
> 	static struct mfd_cell_acpi_match hisi_lpc_ipmi_acpi_match = {
> 		.pnpid = "IPI0001",
> 	};
> 
> correct?

Yes.

> > 
> > It causes acpi_default_enumeration() to be called but it should be fine
> > as we are dealing with platform device anyway.
> 
> I do not quite understand how declaring such MFD cell above would make sure
> that the LPC probe is called before the IPMI device is enumerated...

In fact it may be that it is not sufficient in this case because the
ACPI core might enumerate child devices before the LPC driver even gets
a chance to probe so you would need to add also scan handler to the
child devices and mark them already enumerated or something like that.

> Could you point me to the code that does this?

Check for example drivers/mfd/intel-lpss.c.
