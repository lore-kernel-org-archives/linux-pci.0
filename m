Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:63067 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbEFJ0J (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 05:26:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Gabriel Fernandez <gabriel.fernandez@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"kernel@stlinux.com" <kernel@stlinux.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Lee Jones <lee.jones@linaro.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Russell King <linux@arm.linux.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Muralidharan Karicheri <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Joe Perches <joe@perches.com>,
	Rob Herring <robh+dt@kernel.org>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v3 3/5] PCI: st: Provide support for the sti PCIe controller
Date: Wed, 06 May 2015 11:24:58 +0200
Message-ID: <2236679.A9NfANRyhD@wuerfel>
In-Reply-To: <CAG374jAv9aHBPGV+x+xs2MyRGz+fw1ymwu78fqNXDPtPqehgZA@mail.gmail.com>
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org> <20150505221646.GE24643@google.com> <CAG374jAv9aHBPGV+x+xs2MyRGz+fw1ymwu78fqNXDPtPqehgZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 06 May 2015 11:14:25 Gabriel Fernandez wrote:
> 
> >> +static int __init pcie_init(void)
> >> +{
> >> +     return platform_driver_probe(&st_pcie_driver, st_pcie_probe);
> >> +}
> >> +device_initcall(pcie_init);
> >
> > Can you use module_platform_driver_probe() or module_init() here?
> >
> 
> Yes we can use module_init() here.
> 
> By the way if figure out i removed __init attribute on st_pcie_probe()
> in previous version to follow Arnd's remark.
> But st_pcie_probe calls hook_fault_code() that has __init attribute.
> So I think we need to keep __init for probe routine ?
> Also, we have to restrict bind/unbind with "suppress_bind_attrs" in
> platform_driver structure.
> This is the main reason to not allow module unload/reload.
> 
> If you are ok i will send a v4 ?
> 

If you mark the probe function as __init, you have to use
module_platform_driver_probe() or platform_driver_probe() instead,
to prevent the probe function from being deferred.

Calling hook_fault_code() also means you need to prevent module
unloading, by providing only a module_init but not a module_exit
function, so module_platform_driver_probe() also won't work.

It may be a good idea to work on improving the hook_fault_code()
infrastructure to make it more usable with loadable device drivers.

	Arnd

