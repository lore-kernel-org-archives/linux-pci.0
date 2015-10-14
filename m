Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:54561 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbbJNJpr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2015 05:45:47 -0400
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
Date: Wed, 14 Oct 2015 11:42:27 +0200
Message-ID: <5959363.QRL4hSioHL@wuerfel>
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1624367C@lhreml503-mbs>
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com> <7409042.iUdOP6FlU8@wuerfel> <EE11001F9E5DDD47B7634E2F8A612F2E1624367C@lhreml503-mbs>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 14 October 2015 09:31:48 Gabriele Paoloni wrote:
> > 
> > > To me it sounds more appropriate to adopt subsys_initcall() for all
> > the
> > > PCI Host Bridge controllers rather than having them as loadable
> > modules...
> > >
> > > What is your view?
> > 
> > subsys_initcall() sounds odd because it's a driver rather than a
> > subsystem,
> > but I realize that most of the other levels don't fit any better.
> 
> Yes well I was seeing for example the vgaarb 
> http://lxr.free-electrons.com/source/drivers/gpu/vga/vgaarb.c#L1357
> 
> That in the init is calling pci_get_subsys()
> 
> So I was wondering that the PCI devices may not be registered unless
> we also init the PCI host bridge through subsys_initcall()...

I think this should work as is: the code first looks for devices
that are already there and then registers a notifier for devices
that show up later. This is meant to work for both devices that
are hotplugged at a later point as well as PCI buses that are
already there but not yet probed.

> But then maybe is the vgaarb to be buggy...

Possible. It may well be that the code is only tested on x86,
which always probes its PCI very early.

> > As I said, it's not really a choice we have to make in the source code,
> > we can use subsys_initcall together with module_exit(), or we can
> > create a helper macro that is similar to module_platform_driver()
> > specifically for PCI that uses a particular initcall level.
> 
> Ok got it. But I guess this needs to be thought and applied to all
> the PCI host bridge controllers...
> 
> So maybe for this driver I can use module_platform_driver_probe()
> and then we can see...

Sounds good. Let's focus on getting the driver merged first and
then follow up with a patch to get this right for all PCI hosts.

	Arnd
