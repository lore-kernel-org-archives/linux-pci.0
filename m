Return-Path: <mathias.koehrer@etas.com>
Return-Path: <mathias.koehrer@etas.com>
From: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"xyjxie@linux.vnet.ibm.com" <xyjxie@linux.vnet.ibm.com>
Subject: Re: [PATCH resend v2] Extending kernel option pci=resource_alignment
 to be able to specify PCI device/vendor IDs
Date: Mon, 25 Jul 2016 06:05:21 +0000
Message-ID: <00e437fe05f54c6a9df12bf48cf28dc5@FE-MBX1012.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Gavin,

> Mathias, The code change would conflict with Yongji's patch where the
> wildcard introduced to identify PCI devices.
>=20
> https://patchwork.ozlabs.org/patch/642473/
That's true, however it is also true the other way round. The first sending=
 of my patch was =20
22-June 2016 and thus before Yongji's patch...
See also the comment of Bjorn Helgaas on my patch (v1):
http://marc.info/?l=3Dlinux-pci&m=3D146654644431550&w=3D2=20

However it looks as if there are a couple of (conflicting) approaches for t=
he issue with the alignment of PCI addresses flying around...
My personal opinion is that the need to adapt the alignment of PCI addresse=
s should be done on PCI device/vendor ids of relevant PCI devices and not o=
n PCI addresses.
The PCI addresses are likely to change e.g. by inserting another PCI board.=
 The device/vendor id of the devices will not change.

Regards

Mathias
