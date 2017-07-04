Return-Path: <SRS0=5qxz=6H=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=5qxz=6H=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v9 0/3] Tango PCIe controller support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, DT <devicetree@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <20170704202412.GK13824@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <6256cab3-dd77-c0f6-66b8-be261695bbb1@free.fr>
Date: Wed, 5 Jul 2017 00:55:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170704202412.GK13824@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 04/07/2017 22:24, Bjorn Helgaas wrote:

> On Tue, Jun 20, 2017 at 10:12:57AM +0200, Marc Gonzalez wrote:
>
>> Marc Z pointed out that posting partial series is not ideal.
>> Collect last-minute fixups into a single patch series.
>>
>> - Bump series to v9 to avoid any ambiguity
>> - Add Rob's Ack on patch 1
>>
>> Marc Gonzalez (3):
>>   PCI: Add DT binding for tango PCIe controller
>>   PCI: Add tango PCIe host bridge support
>>   PCI: Add tango MSI controller support
>>
>>  .../devicetree/bindings/pci/tango-pcie.txt         |  29 ++
>>  drivers/pci/host/Kconfig                           |   8 +
>>  drivers/pci/host/Makefile                          |   1 +
>>  drivers/pci/host/pcie-tango.c                      | 390 +++++++++++++++++++++
>>  include/linux/pci_ids.h                            |   2 +
>>  5 files changed, 430 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
>>  create mode 100644 drivers/pci/host/pcie-tango.c
> 
> I made the trivial changes I mentioned, added a dependency on
> CONFIG_BROKEN (for the config/MMIO muxing issue), and put these on
> pci/host-tango.  I can't build or test this, so I probably broke
> something in the process.  I think the combination of the boot-time
> warning, the taint, and CONFIG_BROKEN is a reasonable amount of
> warning that a user should expect issues.
> 
> Can you take a look and see if it works for you?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/host-tango

Thanks. I'll take it for a spin ASAP.

TAINT_CRAP... Smirk. I didn't see that one in the docs:
https://www.kernel.org/doc/html/latest/admin-guide/tainted-kernels.html

Oh wait... TAINT_CRAP is "C" => a staging driver has been loaded

The one issue I anticipate with "depends on BROKEN" is
when I add support for revision 2, which isn't broken.

Regards.
