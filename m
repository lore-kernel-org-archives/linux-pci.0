Return-Path: <SRS0=2bA7=6G=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=2bA7=6G=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: Re: [PATCH v9 2/3] PCI: Add tango PCIe host bridge support
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Mason <slash.tmp@free.fr>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel
	<ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <987fac41-80dc-f1d0-ec0b-91ae57b91bfd@sigmadesigns.com>
 <b32f9e1c-fdde-3064-f935-c817cf707534@sigmadesigns.com>
 <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
Date: Mon, 3 Jul 2017 11:54:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170702231811.GJ18324@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=WINDOWS-1252
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

On 03/07/2017 01:18, Bjorn Helgaas wrote:

> On Tue, Jun 20, 2017 at 10:17:40AM +0200, Marc Gonzalez wrote:
>=20
>> This driver is required to work around several hardware bugs
>> in the PCIe controller.
>
> [ Snip style issues ]

I wish you had pointed these out in your May 23 review, or in
my March 29 version (or even just alluded to them). I would
have fixed them in time for 2.13.


>> +=09/*
>> +=09 * QUIRK #2
>> +=09 * Unfortunately, config and mem spaces are muxed.
>> +=09 * Linux does not support such a setting, since drivers are free
>> +=09 * to access mem space directly, at any time.
>> +=09 * Therefore, we can only PRAY that config and mem space accesses
>> +=09 * NEVER occur concurrently.
>> +=09 */
>> +=09writel_relaxed(1, pcie->mux);
>> +=09ret =3D pci_generic_config_read(bus, devfn, where, size, val);
>> +=09writel_relaxed(0, pcie->mux);
>=20
> I'm very hesitant about this.  When people stress this, we're going to
> get reports of data corruption.  Even with the disclaimer below, I
> don't feel good about this.  Adding the driver is an implicit claim
> that we support the device, but we know it can't be made reliable.

I can't say I didn't see this coming (I had taken your long silence
as a sign of your reluctance) but back in May, I thought you implied
that a warning + tainting the kernel would be sufficient.

Mark Rutland points out stop_machine. I will test this solution.
Would you find that acceptable?


> What is the benefit of adding this driver?  How many units are in the
> field?  Are you hoping to have support in distros like RHEL?  Are
> these running self-built kernels straight from kernel.org?  Is it
> feasible for you to distribute this driver separately from the
> upstream kernel?

The benefit of upstreaming (for me) is making kernel maintainers
aware that one is using specific internal APIs. Then one may be
notified when these APIs are about to change.

I'm told we have sold ~100k units. Though I don't know how many
are in the field and using PCIe.

There are no plans to use "full-blown" distros, we use embedded
oriented distros, such as buildroot.

Maintaining out-of-tree drivers is what we've been doing for
~15 years, and there are many pain-points involved. Ask Greg
what he thinks of OOT drivers.


>> +static int tango_check_pcie_link(void __iomem *test_out)
>=20
> I think this is checking for link up.  Rename to tango_pcie_link_up()
> to follow the convention of other drivers.  Take a struct tango_pcie *
> instead of an address, if possible.

Anything's possible. NB: if I pass the struct, then I have to store
the address in the struct, which isn't the case now, since I never
need the address later. If you don't mind adding an unnecessary
field to the struct, I can do it. What do you say?


>> +static struct platform_driver tango_pcie_driver =3D {
>> +=09.probe=09=3D tango_pcie_probe,
>> +=09.driver=09=3D {
>> +=09=09.name =3D KBUILD_MODNAME,
>> +=09=09.of_match_table =3D tango_pcie_ids,
>=20
> I think you need ".suppress_bind_attrs =3D true" here to prevent issues
> when unbinding driver.  See
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=3Da5f40e8098fe

Will do. In that case, I can drop tango_pcie_remove() right?

Regards.
