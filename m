Return-Path: <SRS0=yxZv=3R=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=yxZv=3R=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: Add tango PCIe host bridge support
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci
 <linux-pci@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Prarit Bhargava <prarit@redhat.com>
References: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
 <65114e62-7458-b6f7-327c-f07a5096a452@sigmadesigns.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <b10928a1-7f74-2dee-678f-4cadc9f7f44b@free.fr>
Date: Sun, 9 Apr 2017 15:09:42 +0200
MIME-Version: 1.0
In-Reply-To: <65114e62-7458-b6f7-327c-f07a5096a452@sigmadesigns.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 29/03/2017 13:34, Marc Gonzalez wrote:

> +	/*
> +	 * QUIRK #1
> +	 * Reads in configuration space outside devfn 0 return garbage.
> +	 */
> +	if (devfn != 0) {
> +		*val = ~0; /* Is this required even if we return an error? */
> +		return PCIBIOS_FUNC_NOT_SUPPORTED; /* Error seems appropriate */
> +	}

AFAICT, the relevant caller is:

bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
				int crs_timeout)

	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
		return false;

Therefore, I believe updating *val is unnecessary.
What matters is returning an error when appropriate.
PCIBIOS_FUNC_NOT_SUPPORTED fits my purpose.


> +
> +	/*
> +	 * QUIRK #2
> +	 * The root complex advertizes a fake BAR, which is used to filter
> +	 * bus-to-system requests. Hide it from Linux.
> +	 */
> +	if (where == PCI_BASE_ADDRESS_0 && bus->number == 0) {
> +		*val = 0; /* 0 or ~0 to hide the BAR from Linux? */
> +		return PCIBIOS_SUCCESSFUL; /* Should we return error or success? */
> +	}
AFAICT, the relevant caller is:

int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
		    struct resource *res, unsigned int pos)

	u32 l, sz, mask;

	pci_read_config_dword(dev, pos, &l);
	pci_write_config_dword(dev, pos, l | mask);
	pci_read_config_dword(dev, pos, &sz);
	pci_write_config_dword(dev, pos, l);


Several things are note-worthy:

1) __pci_read_base() ignores the config accessors return value.
Of the existing PCIBIOS errors, none seem to be a good fit for
my use-case (hiding a non-standard BAR).

Tangent:

Maybe I should set dev->non_compliant_bars = true; instead
of messing around in the accessor...

I would likely set the flag in a PCI_FIXUP_EARLY function.
/* Early fixups, before probing the BARs */


1b) Perhaps a generic error could be added to the PCIBIOS_*
error family, to signal that the requested operation was not
completed, and *val remains unchanged.
=> Maybe PCIBIOS_FAILURE or PCIBIOS_NOP ?


2) Some drivers are not aware that *val needs to be updated
for BAR accesses.

e.g. drivers/pci/host/pcie-altera.c

if altera_pcie_hide_rc_bar() is true, 'l' and 'sz' are not updated,
and therefore contain garbage (uninitialized stack variables).

I think we should apply the following trivial patch.

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -175,7 +175,7 @@ static inline unsigned long decode_bar(struct pci_dev *dev, u32 bar)
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
                    struct resource *res, unsigned int pos)
 {
-       u32 l, sz, mask;
+       u32 l = 0, sz = 0, mask;
        u64 l64, sz64, mask64;
        u16 orig_cmd;
        struct pci_bus_region region, inverted_region;


Regards.
