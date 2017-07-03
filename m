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
 <79382219-c730-da78-3e5f-5abf3173d7ac@sigmadesigns.com>
 <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <16622817-8ccd-107b-be08-676b576f6e8a@sigmadesigns.com>
Date: Mon, 3 Jul 2017 16:34:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170703134031.GG13824@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=WINDOWS-1252
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas wrote:

> Marc Gonzalez wrote:
>
>> On 03/07/2017 01:18, Bjorn Helgaas wrote:
>>
>>> On Tue, Jun 20, 2017 at 10:17:40AM +0200, Marc Gonzalez wrote:
>>>
>>>> +static int tango_check_pcie_link(void __iomem *test_out)
>>>
>>> I think this is checking for link up.  Rename to tango_pcie_link_up()
>>> to follow the convention of other drivers.  Take a struct tango_pcie *
>>> instead of an address, if possible.
>>
>> Anything's possible. NB: if I pass the struct, then I have to store
>> the address in the struct, which isn't the case now, since I never
>> need the address later. If you don't mind adding an unnecessary
>> field to the struct, I can do it. What do you say?
>=20
> The benefit of following the same formula as other drivers is pretty
> large.  Most drivers save the equivalent of "base" in the struct.  If
> you did that, you wouldn't need an extra pointer; you would just use
> "base + SMP8759_MUX" in the config accessors and "base + SMP8759_TEST_OUT=
"
> in tango_pcie_link_up().

The problem is that TEST_OUT is at 0x74 on SMP8759, but at 0x138
on my other chip. In fact, all registers have been "reshuffled",
and none have the same offsets on the two chips.

My solution was to define specific registers in the struct.

In my [RFC PATCH v0.2] posted March 23, I tried illustrating
the issue:

+static const struct of_device_id tango_pcie_ids[] =3D {
+=09{ .compatible =3D "sigma,smp8759-pcie" },
+=09{ .compatible =3D "sigma,rev2-pcie" },
+=09{ /* sentinel */ },
+};
+
+static void smp8759_init(struct tango_pcie *pcie, void __iomem *base)
+{
+=09pcie->mux=09=09=3D base + 0x48;
+=09pcie->msi_status=09=3D base + 0x80;
+=09pcie->msi_mask=09=09=3D base + 0xa0;
+=09pcie->msi_doorbell=09=3D 0xa0000000 + 0x2e07c;
+}
+
+static void rev2_init(struct tango_pcie *pcie, void __iomem *base)
+{
+=09void __iomem *misc_irq=09=3D base + 0x40;
+=09void __iomem *doorbell=09=3D base + 0x8c;
+
+=09pcie->mux=09=09=3D base + 0x2c;
+=09pcie->msi_status=09=3D base + 0x4c;
+=09pcie->msi_mask=09=09=3D base + 0x6c;
+=09pcie->msi_doorbell=09=3D 0x80000000;
+
+=09writel(lower_32_bits(pcie->msi_doorbell), doorbell + 0);
+=09writel(upper_32_bits(pcie->msi_doorbell), doorbell + 4);
+
+=09/* Enable legacy PCI interrupts */
+=09writel(BIT(15), misc_irq);
+=09writel(0xf << 4, misc_irq + 4);
+}


Do you agree that the 'base + OFFSET' idiom does not work in
this specific situation? Would you handle it differently?

Regards.
