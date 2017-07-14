Return-Path: <SRS0=/l1V=6R=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=/l1V=6R=kernel.crashing.org=benh@kernel.org>
Message-ID: <1500076473.2865.99.camel@kernel.crashing.org>
Subject: Re: [PATCH v4] PCI: Support hibmc VGA cards behind a misbehaving
 HiSilicon bridge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Alex Williamson
	 <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Daniel Axtens <dja@axtens.net>,
        "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>,
        "Liuxinliang (Matthew Liu)"
 <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
 <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>
Date: Sat, 15 Jul 2017 09:54:33 +1000
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40B39FC4@FRAEML521-MBX.china.huawei.com>
References: <20170712050811.3620-1-dja@axtens.net>
	 <20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
	 <EE11001F9E5DDD47B7634E2F8A612F2E40B35F02@FRAEML521-MBX.china.huawei.com>
	 <20170713112938.GI4486@bhelgaas-glaptop.roam.corp.google.com>
	 <20170713151146.53e9644c@w520.home>
	 <1499980882.2865.65.camel@kernel.crashing.org>
	 <EE11001F9E5DDD47B7634E2F8A612F2E40B399B4@FRAEML521-MBX.china.huawei.com>
	 <1500040204.2865.90.camel@kernel.crashing.org>
	 <EE11001F9E5DDD47B7634E2F8A612F2E40B39FC4@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2017-07-14 at 17:03 +0000, Gabriele Paoloni wrote:
> > I'd rather we have no default device until a driver actually picks up
> > though, and then, if we still have no default, use the first driver to
> > pick up.
> 
> Well from my understanding the PCI host controller driver will enumerate
> all the devices in the PCI hierarchy and call pci_device_add() for each of
> them, that in turn will call device_add(), at this stage if there is a
> driver available for the device such driver will probe otherwise it will not.
> 
> Are you suggesting to add the code above in pci_device_add() after device_add()
> and after checking that a driver has been bound for such dev?

I don't like us turning on MEM/IO decoding on a device that has
potentially not been initialized by its driver.

Ben.
