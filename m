Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
 devices before scanning
Date: Mon, 3 Jul 2017 16:08:02 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B10487@FRAEML521-MBX.china.huawei.com>
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
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40ACFC3D@FRAEML521-MBX.china.huawei.com>
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
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
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> owner@vger.kernel.org] On Behalf Of Gabriele Paoloni
> Sent: 19 June 2017 11:05
> To: Mika Westerberg
> Cc: Rafael J. Wysocki; Lorenzo Pieralisi; Rafael J. Wysocki;
> catalin.marinas@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; arnd@arndb.de; linux-arm-
> kernel@lists.infradead.org; mark.rutland@arm.com;
> brian.starkey@arm.com; olof@lixom.net; benh@kernel.crashing.org; linux-
> kernel@vger.kernel.org; linux-acpi@vger.kernel.org; Linuxarm; linux-
> pci@vger.kernel.org; minyard@acm.org; John Garry; xuwei (O)
> Subject: RE: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
> devices before scanning
> 
> Hi Mika
> 
> > -----Original Message-----
> > From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> > Sent: 19 June 2017 11:02
> > To: Gabriele Paoloni
> > Cc: Rafael J. Wysocki; Lorenzo Pieralisi; Rafael J. Wysocki;
> > catalin.marinas@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> > frowand.list@gmail.com; bhelgaas@google.com; arnd@arndb.de; linux-
> arm-
> > kernel@lists.infradead.org; mark.rutland@arm.com;
> > brian.starkey@arm.com; olof@lixom.net; benh@kernel.crashing.org;
> linux-
> > kernel@vger.kernel.org; linux-acpi@vger.kernel.org; Linuxarm; linux-
> > pci@vger.kernel.org; minyard@acm.org; John Garry; xuwei (O)
> > Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
> > devices before scanning
> >
> > On Mon, Jun 19, 2017 at 09:50:49AM +0000, Gabriele Paoloni wrote:
> > > Many thanks for your response and your help here.
> > >
> > > I guess that as conclusion with respect to the current v9 patchset
> we
> > can
> > > disregard the idea of MFD and modify the current v9 so that it
> > doesn't
> > > touch directly ACPI resources.
> > > Instead as I proposed before we can have the scan handler to
> > enumerate
> > > the children devices and translate its addresses filling dev-
> > >resources[] and
> > > at the same time we can modify acpi_default_enumeration to check
> > > acpi_device_enumerated() before continuing with device
> > enumeration...?
> > >
> > > Do you think it as a viable solution?
> >
> > No, I think MFD + scan handler inside the MFD driver is the way to
> go.
> > We don't want to trash ACPI core with stuff that does not belong
> there
> > IMHO.
> 
> Ok Many thanks I will investigate this direction

I had a look into the MFD framework. If my understanding is correct the mfd
framework create a platform device for each declared mfd_cell that is passed
to mfd_add_devices().
However there is something that I do not quite understand:
from
http://elixir.free-electrons.com/linux/latest/source/drivers/mfd/mfd-core.c#L207
it seems that mfd_add_device() will create the platform device using the
resources that are statically declared in the respective mfd_cell.

In my case I'd like to have a platform device using the resources that are
parsed from the ACPI table (i.e. as it is done now by 
acpi_create_platform_device()).

If my understanding is correct, if I declared an mfd_cell for my IPMI child
the mfd subsystem would create a platform device for such child and
therefore acpi_create_platform_device() would fail to create a new platform
device as adev->physical_node_count will be non zero.
However as things stand now mfd_cell devices can only use the resources
that are statically defined in the code (and therefore not the ones in the
ACPI nodes)...am I right?

Thanks
Gab

> 
> >
> > Also you don't need to modify acpi_default_enumeration() because you
> > can
> > mark your device enumerated in the MFD driver. So all the dirty
> details
> > will be in the MFD driver and not in ACPI core.
> 
> Ok got it :)
> 
> Cheers
> Gab


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
