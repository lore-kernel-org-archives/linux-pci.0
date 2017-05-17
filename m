Return-Path: <SRS0=+b9I=4X=sigmadesigns.com=marc_gonzalez@kernel.org>
Return-Path: <SRS0=+b9I=4X=sigmadesigns.com=marc_gonzalez@kernel.org>
Subject: Re: [PATCH v4 1/2] PCI: Add tango MSI controller support
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <helgaas@kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi
	<lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, David Laight
	<david.laight@aculab.com>, linux-pci <linux-pci@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Thibaud Cornic
	<thibaud_cornic@sigmadesigns.com>, Phuong Nguyen
	<phuong_nguyen@sigmadesigns.com>, LKML <linux-kernel@vger.kernel.org>, Mason
	<slash.tmp@free.fr>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <1f6b50c7-4887-838e-8c7d-c014d82b6d8e@sigmadesigns.com>
Message-ID: <8e56647d-3b2d-9bfc-b59e-79a2efaa7826@sigmadesigns.com>
Date: Wed, 17 May 2017 16:56:08 +0200
MIME-Version: 1.0
In-Reply-To: <1f6b50c7-4887-838e-8c7d-c014d82b6d8e@sigmadesigns.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 20/04/2017 16:28, Marc Gonzalez wrote:

> +static int tango_set_affinity(struct irq_data *data,
> +=09=09const struct cpumask *mask, bool force)
> +{
> +=09return -EINVAL;
> +}
> +
> +static struct irq_chip tango_chip =3D {
> +=09.irq_ack=09=09=3D tango_ack,
> +=09.irq_mask=09=09=3D tango_mask,
> +=09.irq_unmask=09=09=3D tango_unmask,
> +=09.irq_set_affinity=09=3D tango_set_affinity,
> +=09.irq_compose_msi_msg=09=3D tango_compose_msi_msg,
> +};

Hmmm... I'm wondering why .irq_set_affinity is required.

static int setup_affinity(struct irq_desc *desc, struct cpumask *mask)
first calls __irq_can_set_affinity() to check whether
desc->irq_data.chip->irq_set_affinity) exists.

then calls irq_do_set_affinity(&desc->irq_data, mask, false);
which calls chip->irq_set_affinity(data, mask, force);
=3D msi_domain_set_affinity()
which calls parent->chip->irq_set_affinity() unconditionally.

Would it make sense to test that the callback is implemented
before calling it?


[    0.723895] Unable to handle kernel NULL pointer dereference at virtual =
address 00000000
...
[    1.135809] [<c0160eb4>] (msi_domain_set_affinity) from [<c015a864>] (ir=
q_do_set_affinity+0x18/0x48)
[    1.144990] [<c015a864>] (irq_do_set_affinity) from [<c015a918>] (setup_=
affinity+0x84/0xd4)
[    1.153384] [<c015a918>] (setup_affinity) from [<c015b20c>] (__setup_irq=
+0x40c/0x5d4)
[    1.161254] [<c015b20c>] (__setup_irq) from [<c015b57c>] (request_thread=
ed_irq+0xe4/0x184)
[    1.169569] [<c015b57c>] (request_threaded_irq) from [<c03102e0>] (aer_p=
robe+0x9c/0x218)
[    1.177704] [<c03102e0>] (aer_probe) from [<c030e4bc>] (pcie_port_probe_=
service+0x34/0x70)
[    1.186017] [<c030e4bc>] (pcie_port_probe_service) from [<c0351cd0>] (re=
ally_probe+0x1c4/0x250)
[    1.194763] [<c0351cd0>] (really_probe) from [<c0351ec8>] (__device_atta=
ch_driver+0xa4/0xe0)
[    1.203245] [<c0351ec8>] (__device_attach_driver) from [<c0350274>] (bus=
_for_each_drv+0x60/0x94)
[    1.212076] [<c0350274>] (bus_for_each_drv) from [<c0351abc>] (__device_=
attach+0x9c/0xdc)
[    1.220296] [<c0351abc>] (__device_attach) from [<c0351ff0>] (device_ini=
tial_probe+0xc/0x10)
[    1.228777] [<c0351ff0>] (device_initial_probe) from [<c0351090>] (bus_p=
robe_device+0x84/0x8c)
[    1.237433] [<c0351090>] (bus_probe_device) from [<c034f484>] (device_ad=
d+0x3cc/0x548)
[    1.245390] [<c034f484>] (device_add) from [<c034f614>] (device_register=
+0x14/0x18)
[    1.253086] [<c034f614>] (device_register) from [<c030e8b8>] (pcie_port_=
device_register+0x3b0/0x450)
[    1.262267] [<c030e8b8>] (pcie_port_device_register) from [<c030ecfc>] (=
pcie_portdrv_probe+0x2c/0x50)
[    1.271539] [<c030ecfc>] (pcie_portdrv_probe) from [<c0302ba8>] (pci_dev=
ice_probe+0x7c/0xc8)
[    1.280022] [<c0302ba8>] (pci_device_probe) from [<c0351c84>] (really_pr=
obe+0x178/0x250)
[    1.288154] [<c0351c84>] (really_probe) from [<c0351ec8>] (__device_atta=
ch_driver+0xa4/0xe0)
[    1.296635] [<c0351ec8>] (__device_attach_driver) from [<c0350274>] (bus=
_for_each_drv+0x60/0x94)
[    1.305465] [<c0350274>] (bus_for_each_drv) from [<c0351abc>] (__device_=
attach+0x9c/0xdc)
[    1.313684] [<c0351abc>] (__device_attach) from [<c0351b08>] (device_att=
ach+0xc/0x10)
[    1.321559] [<c0351b08>] (device_attach) from [<c02f9a20>] (pci_bus_add_=
device+0x44/0x90)
[    1.329778] [<c02f9a20>] (pci_bus_add_device) from [<c02f9aa8>] (pci_bus=
_add_devices+0x3c/0x80)
[    1.338523] [<c02f9aa8>] (pci_bus_add_devices) from [<c0312dfc>] (pci_ho=
st_common_probe+0x100/0x314)
[    1.347703] [<c0312dfc>] (pci_host_common_probe) from [<c0313550>] (tang=
o_pcie_probe+0x138/0x340)
[    1.356624] [<c0313550>] (tango_pcie_probe) from [<c03532c4>] (platform_=
drv_probe+0x34/0x6c)
