Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Yuanzhichang <yuanzhichang@hisilicon.com>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "minyard@acm.org" <minyard@acm.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
        "zourongrong@gmail.com" <zourongrong@gmail.com>,
        John Garry <john.garry@huawei.com>,
        "zhichang.yuan02@gmail.com" <zhichang.yuan02@gmail.com>,
        "kantyzc@163.com" <kantyzc@163.com>,
        "xuwei (O)" <xuwei5@hisilicon.com>
Subject: RE: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices whose
  dependency has not met
Date: Tue, 14 Mar 2017 08:14:51 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E204822B1@FRAEML521-MBX.china.huawei.com>
References: <1489372963-9000-1-git-send-email-yuanzhichang@hisilicon.com>
 <1489372963-9000-6-git-send-email-yuanzhichang@hisilicon.com>
 <4600523.rWNiWKrYZC@aspire.rjw.lan>
In-Reply-To: <4600523.rWNiWKrYZC@aspire.rjw.lan>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rafael

Many thanks for your review

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: 13 March 2017 21:25
> To: Yuanzhichang
> Cc: catalin.marinas@arm.com; will.deacon@arm.com; robh+dt@kernel.org;
> frowand.list@gmail.com; bhelgaas@google.com; rafael@kernel.org;
> mark.rutland@arm.com; arnd@arndb.de; linux-arm-
> kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
> lorenzo.pieralisi@arm.com; benh@kernel.crashing.org; linux-
> kernel@vger.kernel.org; Linuxarm; devicetree@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-serial@vger.kernel.org; minyard@acm.org;
> liviu.dudau@arm.com; zourongrong@gmail.com; John Garry; Gabriele
> Paoloni; zhichang.yuan02@gmail.com; kantyzc@163.com; xuwei (O)
> Subject: Re: [PATCH V7 5/7] ACPI: Delay the enumeration on the devices
> whose dependency has not met
> 
> On Monday, March 13, 2017 10:42:41 AM zhichang.yuan wrote:
> > In commit 40e7fcb1929(ACPI: Add _DEP support to fix battery issue on
> Asus
> > T100TA), the '_DEP' was supported to solve the dependency of Asus
> battery. But
> > this patch is specific to Asus battery device.
> > In the real world, there are other devices which need the dependency
> to play the
> > role on the enumeration order. For example, all the Hip06 LPC
> > periperals(IPMI-BT, uart, etc) must be scanned after the LPC host
> driver
> > finished the probing. So, it makes sense to add a checking whether
> the ACPI
> > device meet all the dependencies during its enumeration slot, if not,
> the
> > enumeration will be delayed till all dependency master finish their
> work.
> >
> > This patch adds the dependency checking in ACPI enumeration, also the
> > corresponding handling to retrigger the Hip06 LPC peripherals'
> scanning.
> 
> AFAICS, _DEP is generally abused in the wild and cannot be made
> generic.  Sorry.

Another option here would be to revert this patch and add a dependency
check in the probe functions of the LPC possible children nodes (e.g. 
in the IPMI driver:
http://elixir.free-electrons.com/source/drivers/char/ipmi/ipmi_si_intf.c?v=4.10#L2683
)  

we could add 

	if (device->dep_unmet)
		return -EPROBE_DEFER;

as we now have in acpi/battery.c...

I think this should not make any difference for current shipped FW that has
got no DEP method...

What do you think?

Many Thanks
Gab

> 
> Thanks,
> Rafael

