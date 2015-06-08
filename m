Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33406 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbbFHIGk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jun 2015 04:06:40 -0400
Received: by wiwd19 with SMTP id d19so77027123wiw.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2015 01:06:39 -0700 (PDT)
Message-ID: <55754D06.9050201@monstr.eu>
Date: Mon, 08 Jun 2015 10:06:30 +0200
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/7] microblaze/PCI: Remove unused declarations
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150604214929.2399.85988.stgit@bhelgaas-glaptop2.roam.corp.google.com> <55714AA3.1070407@monstr.eu> <CAErSpo6pMzOUwwxD0snOpcpdoCH5mBQhH2eXO74SVRnXvazX=A@mail.gmail.com>
In-Reply-To: <CAErSpo6pMzOUwwxD0snOpcpdoCH5mBQhH2eXO74SVRnXvazX=A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xD4GjdoCpLbSnTpnIaCGGsvFUdlcOKRP9"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xD4GjdoCpLbSnTpnIaCGGsvFUdlcOKRP9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/05/2015 05:11 PM, Bjorn Helgaas wrote:
> On Fri, Jun 5, 2015 at 2:07 AM, Michal Simek <monstr@monstr.eu> wrote:
>> On 06/04/2015 11:49 PM, Bjorn Helgaas wrote:
>>> The following declarations were copied from powerpc but are unused on=

>>> microblaze:
>>>
>>>   struct pci_controller *init_phb_dynamic(struct device_node *dn)
>>>   int remove_phb_dynamic(struct pci_controller *phb)
>>>   struct pci_dev *of_create_pci_dev(struct device_node *node, ...)
>>>   void of_scan_pci_bridge(struct device_node *node, ...)
>>>   void of_scan_bus(struct device_node *node, struct pci_bus *bus)
>>>   void of_rescan_bus(struct device_node *node, struct pci_bus *bus)
>>>
>>> Remove them.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> CC: Michal Simek <monstr@monstr.eu>
>>> ---
>>>  arch/microblaze/include/asm/pci.h |   12 ------------
>>>  1 file changed, 12 deletions(-)
>>
>> Reviewed-by: Michal Simek <michal.simek@xilinx.com>
>>
>> Bjorn: Do you want me to take this via Microblaze tree?
>=20
> Sure, it'd be great if you take all the Microblaze-specific patches.
> There aren't any dependencies on them, so there shouldn't be any
> problem.

Ok. Added these 3 patches to microblaze next branch - it will be in
linux-next tmr.

>=20
> I do have a Microblaze hunk in "PCI: Remove unused
> pci_dma_burst_advice()" and if you agree, I'll merge that one through
> my tree since the change for each arch is essentially identical.

No problem at all. Feel free to add there my acked-by line for microblaze=
=2E

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--xD4GjdoCpLbSnTpnIaCGGsvFUdlcOKRP9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlV1TQoACgkQykllyylKDCGjQACeKqvLqRFB8H/FjjmBmHU+IN09
AjIAn1jQXoGXwqL4OyVmlkjMnnZO6oz9
=aMAQ
-----END PGP SIGNATURE-----

--xD4GjdoCpLbSnTpnIaCGGsvFUdlcOKRP9--
