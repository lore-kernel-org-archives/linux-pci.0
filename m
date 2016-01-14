Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 14 Jan 2016 13:44:40 +0000
From: Graeme Gregory <gg@slimlogic.co.uk>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com,
	robert.richter@caviumnetworks.com, mw@semihalf.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de,
	wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	jchandra@broadcom.com, jcm@redhat.com
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
Message-ID: <20160114134440.GA8520@xora-haswell.xora.org.uk>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452691267-32240-1-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 13, 2016 at 02:20:46PM +0100, Tomasz Nowicki wrote:
> From the functionality point of view this series might be split into the
> following logic parts:
> 1. Make MMCONFIG code arch-agnostic which allows all architectures to collect
>    PCI config regions and used when necessary.
> 2. Move non-arch specific bits to the core code.
> 3. Use MMCONFIG code and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
> 
> Patches has been built on top of 4.4 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v3)
> 
> NOTE, this patch set depends on Matthew's patches:
> http://www.spinics.net/lists/linux-pci/msg45950.html
> https://github.com/Vality/linux/tree/pci-fixes
> 
> This has been tested on Cavium ThunderX server and QEMU.
> Any help in reviewing and testing is very appreciated.

I have tested this on my AMD Overdrive so

Tested-by: Graeme Gregory <graeme.gregory@linaro.org>

But to actually get my r8169 network card working I also need the
following patch.

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 2fbf840..40e24e2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1717,7 +1717,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
        set_dev_node(&dev->dev, pcibus_to_node(bus));
        dev->dev.dma_mask = &dev->dma_mask;
        dev->dev.dma_parms = &dev->dma_parms;
-       dev->dev.coherent_dma_mask = 0xffffffffull;
+       dev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
        pci_dma_configure(dev);

        pci_set_dma_max_seg_size(dev, 65536);

I suspect we need to set coherent_dma_mask somewhere in the platform but I do
not know where this should happen. Hopefully an ARM64 expert can help.

Graeme

