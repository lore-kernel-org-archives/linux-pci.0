Return-Path: <SRS0=Y20I=45=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=Y20I=45=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v4 2/2] PCI: Add tango PCIe host bridge support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 linux-pci <linux-pci@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <4a354b33-d59c-4ebb-4b31-0388ac8090d4@sigmadesigns.com>
 <20170523172409.GD24431@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <7a46cfa6-3c8a-33a6-a821-da49535c5c8a@free.fr>
Date: Tue, 23 May 2017 19:43:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170523172409.GD24431@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 23/05/2017 19:24, Bjorn Helgaas wrote:
> On Thu, Apr 20, 2017 at 04:31:25PM +0200, Marc Gonzalez wrote:
>> This driver is required to work around several hardware bugs in the
>> PCIe controller.
>>
>> NB: Revision 1 does not support legacy interrupts, or IO space.
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>>  Documentation/devicetree/bindings/pci/tango-pcie.txt |  32 ++++++++
>>  drivers/pci/host/Kconfig                             |   8 ++
>>  drivers/pci/host/Makefile                            |   1 +
>>  drivers/pci/host/pcie-tango.c                        | 161 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci_ids.h                              |   2 +
>>  5 files changed, 204 insertions(+)
>> ...
> 
>> +static int smp8759_config_read(struct pci_bus *bus,
>> +		unsigned int devfn, int where, int size, u32 *val)
>> +{
>> +	int ret;
>> +	struct pci_config_window *cfg = bus->sysdata;
>> +	struct tango_pcie *pcie = dev_get_drvdata(cfg->parent);
>> +
>> +	/*
>> +	 * QUIRK #1
>> +	 * Reads in configuration space outside devfn 0 return garbage.
>> +	 */
>> +	if (devfn != 0)
>> +		return PCIBIOS_FUNC_NOT_SUPPORTED;
>> +
>> +	/*
>> +	 * QUIRK #2
>> +	 * Unfortunately, config and mem spaces are muxed.
>> +	 * Linux does not support such a setting, since drivers are free
>> +	 * to access mem space directly, at any time.
>> +	 * Therefore, we can only PRAY that config and mem space accesses
>> +	 * NEVER occur concurrently.
>> +	 */
>> +	writel_relaxed(1, pcie->mux);
>> +	ret = pci_generic_config_read(bus, devfn, where, size, val);
>> +	writel_relaxed(0, pcie->mux);
> 
> This is a major issue and possibly even a security problem.
> Unprivileged users can cause config accesses via lspci/setpci.

Since the host bridge doesn't support hotplug in any way,
how about setting a flag once enumeration is complete,
to prevent all future config accesses?

> I don't have a good suggestion for addressing it, but if you can't
> make this work reliably, you need at least a dev_err() in the probe
> function and probably a taint of the kernel (see add_taint()).

There is a chance that the issue will get fixed in rev2
of the bridge. But obviously, that won't help for rev1
already in the wild.

Regards.
