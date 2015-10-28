Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFiDJ5_vCqh=uKkF2E_BQkJUv692r3yr26bBj8boK2DY_Dj+gA@mail.gmail.com>
References: <1445596035-27733-1-git-send-email-lftan@altera.com>
 <20151027142644.GA8660@localhost> <CAFiDJ5_vCqh=uKkF2E_BQkJUv692r3yr26bBj8boK2DY_Dj+gA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 27 Oct 2015 20:02:33 -0500
Message-ID: <CAErSpo5okE86k846hs28s4jvL59hmm+4az-dDsymzNayPCPCzw@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] Altera PCIe host controller driver with MSI support
To: Ley Foon Tan <lftan@altera.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 27, 2015 at 7:56 PM, Ley Foon Tan <lftan@altera.com> wrote:
> On Tue, Oct 27, 2015 at 10:26 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> Hi Ley,
>>
>> On Fri, Oct 23, 2015 at 06:27:09PM +0800, Ley Foon Tan wrote:
>>> This is the 12th version of patch set to add support for Altera PCIe host
>>> controller with MSI feature on Altera FPGA device families. This patchset
>>> mainly resovle the comments from Bjorn.
>>>
>>>
>>> This patchset is based on v4.3-rc6.
>>>
>>> v11->v12 changes:
>>> - pcie-altera: use DECLARE_PCI_FIXUP_EARLY for pcie retrain fixup
>>> - pcie-altera: move pcie_bus_configure_settings before pci_bus_add_devices
>>> - pcie-altera: add %d for irq bit in dev_err()
>>> - pcie-altera: prevent enumeration of root complex resources in config accessors
>>> - Documentation: add Acked-by from Rob Herring
>>>
>>> History:
>>> -------
>>> [v1]: https://lkml.org/lkml/2015/7/28/395
>>> [v2]: https://lkml.org/lkml/2015/7/31/267
>>> [v3]: http://www.kernelhub.org/?msg=811940&p=2
>>> [v4]: https://lkml.org/lkml/2015/8/17/141
>>> [v5]: https://lkml.org/lkml/2015/8/25/238
>>> [v6]: https://lkml.org/lkml/2015/9/1/177
>>> [v7]: https://lkml.org/lkml/2015/9/20/193
>>> [v8]: http://www.kernelhub.org/?msg=853553&p=2
>>> [v9]: https://lkml.org/lkml/2015/10/13/998
>>> [v10]: https://lkml.org/lkml/2015/10/19/139
>>> [v11]: https://lkml.org/lkml/2015/10/22/206
>>>
>>>
>>> Ley Foon Tan (6):
>>>   arm: add msi.h to Kbuild
>>>   pci: add Altera PCI vendor ID
>>>   pci:host: Add Altera PCIe host controller driver
>>>   pci: altera: Add Altera PCIe MSI driver
>>>   Documentation: dt-bindings: pci: altera pcie device tree binding
>>>   MAINTAINERS: Add Altera PCIe and MSI drivers maintainer
>>>
>>>  .../devicetree/bindings/pci/altera-pcie-msi.txt    |  28 +
>>>  .../devicetree/bindings/pci/altera-pcie.txt        |  49 ++
>>>  MAINTAINERS                                        |  16 +
>>>  arch/arm/include/asm/Kbuild                        |   1 +
>>>  drivers/pci/host/Kconfig                           |  16 +
>>>  drivers/pci/host/Makefile                          |   2 +
>>>  drivers/pci/host/pcie-altera-msi.c                 | 314 +++++++++++
>>>  drivers/pci/host/pcie-altera.c                     | 580 +++++++++++++++++++++
>>>  include/linux/pci_ids.h                            |   2 +
>>>  9 files changed, 1008 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
>>>  create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
>>>  create mode 100644 drivers/pci/host/pcie-altera-msi.c
>>>  create mode 100644 drivers/pci/host/pcie-altera.c
>>
>> I applied these to pci/host-altera for v4.4, thanks!
>>
>> I squashed these into three patches:
>>
>>   - add msi.h to Kbuild
>>   - add Altera host driver (including DT binding and MAINTAINERS update)
>>   - add Altera MSI driver (including DT binding and MAINTAINERS update)
>>
>> Since the convention is to add PCI ID #defines only when they are used in
>> multiple places, I replaced PCI_VENDOR_ID_ALTERA with 0x1172 in the single
>> place it is used.
> Hi Bjorn
>
> Thanks for applied these.
>
> By the way, I can't see pci/host-altera branch in your pci.git tree
> yet. It takes some time to appear there?

Sorry, I forgot to push it.  It should be there now!

Bjorn
