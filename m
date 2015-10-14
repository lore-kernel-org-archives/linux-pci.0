Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:62230 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553AbbJNJFZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2015 05:05:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: "Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"thomas.petazzoni@free-electrons.com"
	<thomas.petazzoni@free-electrons.com>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"jason@lakedaemon.net" <jason@lakedaemon.net>,
	"robh@kernel.org" <robh@kernel.org>,
	"gabriel.fernandez@linaro.org" <gabriel.fernandez@linaro.org>,
	"Minghuan.Lian@freescale.com" <Minghuan.Lian@freescale.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"liudongdong (C)" <liudongdong3@huawei.com>,
	qiujiang <qiujiang@huawei.com>,
	"xuwei (O)" <xuwei5@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	"Wangkefeng (Kevin)" <wangkefeng.wang@huawei.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for HiSilicon SoC Hip05
Date: Wed, 14 Oct 2015 11:04:22 +0200
Message-ID: <7409042.iUdOP6FlU8@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E162435E7@lhreml503-mbs>
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com> <5549505.Kpo7ci0v8h@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E162435E7@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 14 October 2015 08:34:43 Gabriele Paoloni wrote:
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd@arndb.de]
> > Sent: Tuesday, October 13, 2015 12:19 PM
> > To: Gabriele Paoloni
> > Cc: Wangzhou (B); Bjorn Helgaas; Bjorn Helgaas; jingoohan1@gmail.com;
> > pratyush.anand@gmail.com; linux@arm.linux.org.uk;
> > thomas.petazzoni@free-electrons.com; lorenzo.pieralisi@arm.com;
> > james.morse@arm.com; Liviu.Dudau@arm.com; jason@lakedaemon.net;
> > robh@kernel.org; gabriel.fernandez@linaro.org;
> > Minghuan.Lian@freescale.com; linux-pci@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; zhangjukuo; qiuzhenfa; liudongdong (C);
> > qiujiang; xuwei (O); Liguozhu (Kenneth); Wangkefeng (Kevin); Rob
> > Herring
> > Subject: Re: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for
> > HiSilicon SoC Hip05
> > 
> > On Tuesday 13 October 2015 06:58:42 Gabriele Paoloni wrote:
> > >
> > > > >> +
> > > > >> +static int __init hisi_pcie_init(void)
> > > > >> +{
> > > > >> +      return platform_driver_probe(&hisi_pcie_driver,
> > hisi_pcie_probe);
> > > > >> +}
> > > > >> +subsys_initcall(hisi_pcie_init);
> > > > >
> > > > > Can you use module_platform_driver() or
> > module_platform_driver_probe()
> > > > > here instead of the subsys_initcall()?  No, I don't really know
> > what
> > > > > the difference between module_platform_driver() and
> > > > > module_platform_driver_probe() is, sorry 
> > 
> > module_platform_driver_probe() will only call the probe function once
> > (and fail in case of -EPROBE_DEFER), while module_platform_driver()
> > installs the platform driver in a way that the device can be bound
> > and unbound at any point.
> > 
> > > > In fact, I used module_platform_driver_probe in previous version,
> > but
> > > > A PCIe VGA card of HiSilicon will use Hip05 PCIe host, so we
> > modified
> > > > module_platform_driver_probe to subsys_initcall which will be
> > called
> > > > before module_platform_driver_probe.
> > > >
> > > > We will upstream the driver of above PCIe VGA card soon.
> > 
> > I don't see a reason why a VGA driver would need the PCI host to be
> > probed this early, unless it is the only usable console in the system.
> > 
> > > Hi Bjorn, firstly many thanks for looking at this.
> > >
> > > About this last bit the reason why we use subsys_initcall() is that
> > > our host bridge is embedded in the SoC and as such is not hot-
> > pluggable
> > > for instance see:
> > > http://lxr.free-electrons.com/source/Documentation/driver-
> > model/platform.txt#L59
> > 
> > We should still be able to build the driver as a loadable module,
> > even if you don't do that on your own kernels.
> 
> Hi Arnd, I don't see the point of having loadable KOs for platform
> devices that are integrated into SoCs (like PCIe Host Controllers...)

Mainly we want as many drivers as possible to be loadable modules,
and there is no reason why PCI needs to be different from other
subsystems here.

> > This doesn't mean that it has to be module_platform_driver,
> > subsys_initcall
> > will also work in a loadable module, it just won't be as early. However,
> > we should try to come up with a consistent approach for all PCI host
> > drivers,
> > I don't see any reason for hisi to be different from the others here.
> 
> To me it sounds more appropriate to adopt subsys_initcall() for all the
> PCI Host Bridge controllers rather than having them as loadable modules...
> 
> What is your view?

subsys_initcall() sounds odd because it's a driver rather than a subsystem,
but I realize that most of the other levels don't fit any better.

As I said, it's not really a choice we have to make in the source code,
we can use subsys_initcall together with module_exit(), or we can
create a helper macro that is similar to module_platform_driver()
specifically for PCI that uses a particular initcall level.

	Arnd
