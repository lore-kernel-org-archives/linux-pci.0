Return-Path: <SRS0=vkpo=G7=linux.ee=mroos@kernel.org>
Return-Path: <SRS0=vkpo=G7=linux.ee=mroos@kernel.org>
Date: Tue, 10 Apr 2018 21:45:09 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
    sparclinux@vger.kernel.org
Subject: Re: sparc64 PCI BAR allocation is still problematic
In-Reply-To: <20180410173437.GB24642@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.LRH.2.21.1804102144240.32411@math.ut.ee>
References: <alpine.LRH.2.21.1804081219340.17185@math.ut.ee> <20180410173437.GB24642@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
List-ID: <linux-pci.vger.kernel.org>

> commit bc270e0028cd0856d5689cab38f0071f0d07b3be
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Apr 10 08:47:34 2018 -0500
>=20
>     sparc/PCI: Request legacy VGA framebuffer only for VGA devices

Thank you.

It does not seem to compile for me:

  CC      arch/sparc/kernel/pci.o
arch/sparc/kernel/pci.c: In function =A1pci_claim_legacy_resources=A2:
arch/sparc/kernel/pci.c:644:26: error: =A1bus=A2 undeclared (first use in=
 this function)
  pcibios_bus_to_resource(bus, p, &region);


--=20
Meelis Roos (mroos@linux.ee)
