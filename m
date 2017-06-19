Return-Path: <SRS0=/uOW=5Y=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=/uOW=5Y=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: Re: [PATCH v5 2/3] PCI: Add tango PCIe host bridge support
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, David Laight
	<david.laight@aculab.com>, linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, LKML <linux-kernel@vger.kernel.org>, Mason
	<slash.tmp@free.fr>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <1802aae0-f97b-c437-c00e-5fa7c867286d@sigmadesigns.com>
 <654acba8-68b9-fb4c-4681-35af94b6bd74@sigmadesigns.com>
Message-ID: <6abfe9ce-5c32-9be0-e276-ed14253aa773@sigmadesigns.com>
Date: Mon, 19 Jun 2017 16:50:15 +0200
MIME-Version: 1.0
In-Reply-To: <654acba8-68b9-fb4c-4681-35af94b6bd74@sigmadesigns.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 07/06/2017 10:19, Marc Gonzalez wrote:

> On 31/05/2017 15:33, Marc Gonzalez wrote:
>=20
>> +static int tango_pcie_probe(struct platform_device *pdev)
>> +{
>> +=09int ret =3D -EINVAL;
>> +=09void __iomem *base;
>> +=09struct resource *res;
>> +=09struct tango_pcie *pcie;
>> +=09struct device *dev =3D &pdev->dev;
>> +
>> +=09pr_err("MAJOR ISSUE: PCIe config and mem spaces are muxed\n");
>> +=09pr_err("Tainting kernel... Use driver at your own risk\n");
>> +=09add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
>=20
> Hello Bjorn,
>=20
> In v4, your only comment was
> "[muxing config and mem spaces] is a major issue and possibly even
> a security problem [which requires at least an error message and a
> kernel taint].
>=20
> Were there any other issues with the host bridge support?

Hello Bjorn,

I imagine you are now only waiting for Marc Z's Ack of patch 3/3 ?
(AFAIU, all issues have been addressed as of v8 3/3.)

Rob has Acked patch 1/3 -- thanks Rob.

Assuming all issues with patch 2/3 have already been addressed,
then this driver can land in time for 4.13 right?

Regards.
