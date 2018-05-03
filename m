Return-Path: <SRS0=bQz4=HW=kontron.com=gilles.buloz@kernel.org>
Return-Path: <SRS0=bQz4=HW=kontron.com=gilles.buloz@kernel.org>
From: Gilles Buloz <Gilles.Buloz@kontron.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci
	<linux-pci@vger.kernel.org>, "Minghuan.Lian@nxp.com" <Minghuan.Lian@nxp.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Ard Biesheuvel
	<ard.biesheuvel@linaro.org>
Subject: Re: LS1043A : "synchronous abort" at boot due to PCI config read
Date: Thu, 3 May 2018 12:40:27 +0000
Message-ID: <5AEB033A.4060407@kontron.com>
References: <CAKv+Gu_v4V8DUa6f4WxvjZHoJbbqT0mKpOwYVmaLaE20CB3U_g@mail.gmail.com>
 <5AE317AB.4020404@kontron.com>
 <20180427165627.GA8199@bhelgaas-glaptop.roam.corp.google.com>
 <5AE6D7E2.9030506@kontron.com> <5AE71BF4.2010200@kontron.com>
 <20180430170447.GA95643@bhelgaas-glaptop.roam.corp.google.com>
 <5AE75809.30701@kontron.com> <5AE9B5BB.2080003@kontron.com>
 <20180502132501.GE11698@bhelgaas-glaptop.roam.corp.google.com>
 <5AE9C1AB.8020403@kontron.com>
 <20180502172341.GA123831@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180502172341.GA123831@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
List-ID: <linux-pci.vger.kernel.org>

Subject:    [PATCH] For exception at PCI probe due to bridge reporting UR

Even if a device supports extended config access, no such access must be
done to this device If there's a bridge not supporting that in the path
to this device. Doing such access with UR reporting enabled on the root
bridge leads to an exception.

This is the case on a LS1043A CPU (NXP QorIQ Layerscape) platform with
the following bus topology :
  LS1043 PCIe root
    -> PEX8112 PCIe-to-PCI bridge (not supporting ext cfg on PCI side)
      -> PMC slot connector (for legacy PMC modules)
With a PMC module topology as follows :
  PMC connector
    -> PCI-to-PCIe bridge
      -> PCIe switch (4 ports)
        -> 4 PCIe devices (one on each port)
In this case all devices behind the PEX8112 are supporting extended config
access but this is prohibited by the PEX8112. Without this patch, an
exception (synchronous abort) occurs in pci_cfg_space_size_ext().

This patch checks the parent bridge of each allocated child bus to know if
extended config access is supported on the child bus, and sets a flag in
child->bus_flags if not supported. This  flag is inherited by all children
buses of this child bus and then is checked to avoid this unsupported
accesses to every device on these buses.

Thanks

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Gilles BULOZ
Senior software engineer
Kontron France
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Signed-off-by: Gilles Buloz <gilles.buloz@kontron.com>

--- linux-4.17-rc1/include/linux/pci.h.orig=092018-04-16 01:24:20.000000000=
 +0000
+++ linux-4.17-rc1/include/linux/pci.h=092018-05-03 09:53:03.270000000 +000=
0
@@ -217,6 +217,7 @@ enum pci_bus_flags {
  =09PCI_BUS_FLAGS_NO_MSI=09=3D (__force pci_bus_flags_t) 1,
  =09PCI_BUS_FLAGS_NO_MMRBC=09=3D (__force pci_bus_flags_t) 2,
  =09PCI_BUS_FLAGS_NO_AERSID=09=3D (__force pci_bus_flags_t) 4,
+=09PCI_BUS_FLAGS_NO_EXTCFG=09=3D (__force pci_bus_flags_t) 8,
  };
 =20
  /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
--- linux-4.17-rc1/drivers/pci/probe.c.orig=092018-05-03 09:45:21.110000000=
 +0000
+++ linux-4.17-rc1/drivers/pci/probe.c=092018-05-03 09:46:50.550000000 +000=
0
@@ -882,6 +882,24 @@ free:
  =09return err;
  }
 =20
+static bool pci_bridge_child_bus_ext_cfg_accessible(struct pci_dev *bridge=
)
+{
+=09int pos;
+=09u32 status;
+
+=09if (pci_is_pcie(bridge) &&
+=09    (pci_pcie_type(bridge) !=3D PCI_EXP_TYPE_PCIE_BRIDGE) &&
+=09    (pci_pcie_type(bridge) !=3D PCI_EXP_TYPE_PCI_BRIDGE))
+=09=09return true;
+
+=09/* PCI/PCI, or PCIe/PCI (forward), or PCI/PCIe (reverse) bridge */
+=09pos =3D pci_find_capability(bridge, PCI_CAP_ID_PCIX);
+=09if (pos)
+=09=09pci_read_config_dword(bridge, pos + PCI_X_STATUS, &status);
+
+=09return pos && (status & (PCI_X_STATUS_266MHZ | PCI_X_STATUS_533MHZ));
+}
+
  static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
  =09=09=09=09=09   struct pci_dev *bridge, int busnr)
  {
@@ -930,6 +948,20 @@ static struct pci_bus *pci_alloc_child_b
  =09}
  =09bridge->subordinate =3D child;
 =20
+=09/*
+=09 * if bus_flags inherited from parent bus do not already report lack of
+=09 * extended config space support, check if supported by child bus by
+=09 * checking its parent bridge
+=09 */
+=09if (child->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG) {
+=09=09pci_info(child, "extended config space not accessible due to parent =
bus\n");
+=09} else {
+=09=09if (!pci_bridge_child_bus_ext_cfg_accessible(bridge)) {
+=09=09=09child->bus_flags |=3D PCI_BUS_FLAGS_NO_EXTCFG;
+=09=09=09pci_info(child, "extended config space not accessible due to pare=
nt bridge\n");
+=09=09}
+=09}
+
  add_dev:
  =09pci_set_bus_msi_domain(child);
  =09ret =3D device_register(&child->dev);
@@ -1393,6 +1425,9 @@ int pci_cfg_space_size(struct pci_dev *d
  =09u32 status;
  =09u16 class;
 =20
+=09if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
+=09=09return PCI_CFG_SPACE_SIZE;
+
  =09class =3D dev->class >> 8;
  =09if (class =3D=3D PCI_CLASS_BRIDGE_HOST)
  =09=09return pci_cfg_space_size_ext(dev);
