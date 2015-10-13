Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:37671 "EHLO
	lhrrgout.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764AbbJMG7V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 13 Oct 2015 02:59:21 -0400
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: "Wangzhou (B)" <wangzhou1@hisilicon.com>,
	Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"pratyush.anand@gmail.com" <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
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
Subject: RE: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
Date: Tue, 13 Oct 2015 06:58:42 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E162428B1@lhreml503-mbs>
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com>
 <1444445957-239522-5-git-send-email-wangzhou1@hisilicon.com>
 <20151012213545.GA17479@localhost> <561CA5AF.2080300@hisilicon.com>
In-Reply-To: <561CA5AF.2080300@hisilicon.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> >> +
> >> +static int __init hisi_pcie_init(void)
> >> +{
> >> +	return platform_driver_probe(&hisi_pcie_driver, hisi_pcie_probe);
> >> +}
> >> +subsys_initcall(hisi_pcie_init);
> >
> > Can you use module_platform_driver() or module_platform_driver_probe()
> > here instead of the subsys_initcall()?  No, I don't really know what
> > the difference between module_platform_driver() and
> > module_platform_driver_probe() is, sorry :)
> 
> In fact, I used module_platform_driver_probe in previous version, but
> A PCIe VGA card of HiSilicon will use Hip05 PCIe host, so we modified
> module_platform_driver_probe to subsys_initcall which will be called
> before module_platform_driver_probe.
> 
> We will upstream the driver of above PCIe VGA card soon.
> 
> Many thanks for your reviewing,
> Zhou

Hi Bjorn, firstly many thanks for looking at this.

About this last bit the reason why we use subsys_initcall() is that
our host bridge is embedded in the SoC and as such is not hot-pluggable
for instance see:
http://lxr.free-electrons.com/source/Documentation/driver-model/platform.txt#L59

Our approach is also used by Exynos:
http://lxr.free-electrons.com/source/drivers/pci/host/pci-exynos.c#L644

Cheers

Gab

> 
> >
> > Bjorn
> >
> > .
> >
> 

