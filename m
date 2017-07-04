Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [PATCH v9 5/7] ACPI: Translate the I/O range of non-MMIO
 devices before scanning
Date: Tue, 4 Jul 2017 16:22:11 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B16310@FRAEML521-MBX.china.huawei.com>
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
 <CAHp75VccwpesvDxMcxZ+349rhrAq8QxNoau9XmquMnv9DBLBfA@mail.gmail.com>
In-Reply-To: <CAHp75VccwpesvDxMcxZ+349rhrAq8QxNoau9XmquMnv9DBLBfA@mail.gmail.com>
MIME-Version: 1.0
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

Hi Andy

[...]

> 
> You may do it on stack. Define your cell statically (but not const)
> and apply resources just before mfd_add_devices() call.

Ok thanks got it

> There are examples in the existing drivers. Intel LPC comes to my mind
> and perhaps PMC (Broxton), though latter has too much other stuff
> around.

Uh yes I see now in lpc_ich.c (base address is read from PCI config space
and resources are set accordingly).

Cheers
Gab

> 
> --
> With Best Regards,
> Andy Shevchenko
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
