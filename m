Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 19 Jun 2017 13:02:09 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
Message-ID: <20170619100209.GC629@lahna.fi.intel.com>
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
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40ACFB8D@FRAEML521-MBX.china.huawei.com>
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

On Mon, Jun 19, 2017 at 09:50:49AM +0000, Gabriele Paoloni wrote:
> Many thanks for your response and your help here.
> 
> I guess that as conclusion with respect to the current v9 patchset we can
> disregard the idea of MFD and modify the current v9 so that it doesn't
> touch directly ACPI resources.
> Instead as I proposed before we can have the scan handler to enumerate
> the children devices and translate its addresses filling dev->resources[] and
> at the same time we can modify acpi_default_enumeration to check
> acpi_device_enumerated() before continuing with device enumeration...?
> 
> Do you think it as a viable solution?

No, I think MFD + scan handler inside the MFD driver is the way to go.
We don't want to trash ACPI core with stuff that does not belong there
IMHO.

Also you don't need to modify acpi_default_enumeration() because you can
mark your device enumerated in the MFD driver. So all the dirty details
will be in the MFD driver and not in ACPI core.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
