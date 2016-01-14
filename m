Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38101 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371AbcANOYp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 14 Jan 2016 09:24:45 -0500
Message-ID: <1452781481.28109.8.camel@redhat.com>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
From: Mark Salter <msalter@redhat.com>
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: Tomasz Nowicki <tn@semihalf.com>, linaro-acpi@lists.linaro.org,
	catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org,
	wangyijing@huawei.com, Lorenzo.Pieralisi@arm.com,
	ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org,
	robert.richter@caviumnetworks.com, linux-pci@vger.kernel.org,
	jcm@redhat.com, arnd@arndb.de, Stefano.Stabellini@eu.citrix.com,
	Liviu.Dudau@arm.com, bhelgaas@google.com, tglx@linutronix.de,
	mw@semihalf.com, linux-arm-kernel@lists.infradead.org,
	jchandra@broadcom.com, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, hanjun.guo@linaro.org,
	Suravee.Suthikulpanit@amd.com, jiang.liu@linux.intel.com
Date: Thu, 14 Jan 2016 09:24:41 -0500
In-Reply-To: <20160114141501.GC8520@xora-haswell.xora.org.uk>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
	 <20160114134440.GA8520@xora-haswell.xora.org.uk>
	 <1452780100.28109.3.camel@redhat.com>
	 <20160114141501.GC8520@xora-haswell.xora.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2016-01-14 at 14:15 +0000, Graeme Gregory wrote:
> On Thu, Jan 14, 2016 at 09:01:40AM -0500, Mark Salter wrote:
> > On Thu, 2016-01-14 at 13:44 +0000, Graeme Gregory wrote:
> > > On Wed, Jan 13, 2016 at 02:20:46PM +0100, Tomasz Nowicki wrote:
> > > > From the functionality point of view this series might be split into the
> > > > following logic parts:
> > > > 1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
> > > >    PCI config regions and used when necessary.
> > > > 2. Move non-arch specific bits to the core code.
> > > > 3. Use MMCONFIG code and implement generic ACPI based PCI host controller driver.
> > > > 4. Enable above driver on ARM64
> > > > 
> > > > Patches has been built on top of 4.4 and can be found here:
> > > > git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
> > > > 
> > > > NOTE, this patch set depends on Matthew's patches:
> > > > http://www.spinics.net/lists/linux-pci/msg45950.html
> > > > https://github.com/Vality/linux/tree/pci-fixes
> > > > 
> > > > This has been tested on Cavium ThunderX server and QEMU.
> > > > Any help in reviewing and testing is very appreciated.
> > > 
> > > I have tested this on my AMD Overdrive so
> > > 
> > > Tested-by: Graeme Gregory <graeme.gregory@linaro.org>
> > > 
> > > But to actually get my r8169 network card working I also need the
> > > following patch.
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 2fbf840..40e24e2 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -1717,7 +1717,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
> > >         set_dev_node(&dev->dev, pcibus_to_node(bus));
> > >         dev->dev.dma_mask = &dev->dma_mask;
> > >         dev->dev.dma_parms = &dev->dma_parms;
> > > -       dev->dev.coherent_dma_mask = 0xffffffffull;
> > > +       dev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
> > >         pci_dma_configure(dev);
> > > 
> > >         pci_set_dma_max_seg_size(dev, 65536);
> > > 
> > > I suspect we need to set coherent_dma_mask somewhere in the platform but I do
> > > not know where this should happen. Hopefully an ARM64 expert can help.
> > 
> > I've run into a number of cards which don't work on some arm64 machines where there are
> > no DMA address below 4G. For the realtek card you can use r8169.use_dac=1 on the cmdline
> > to get it to work.
> > 
> I need r8169.use_dac=1 and this patch to get card to work.
> 

Hmm. I didn't need a patch in the past but I don't think I've used that card with
this patch series. I will try that when I get a chance...

> Graeme
> 

