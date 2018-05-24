Return-Path: <SRS0=rZ3w=IL=linux.ee=mroos@kernel.org>
Return-Path: <SRS0=rZ3w=IL=linux.ee=mroos@kernel.org>
Date: Thu, 24 May 2018 11:34:26 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
    "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [PATCH v1 0/4] sparc/PCI: VGA resource and other fixes
In-Reply-To: <20180522130217.GA161672@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <alpine.LRH.2.21.1805241133450.13830@math.ut.ee>
References: <152694888798.59585.8779818482732387864.stgit@bhelgaas-glaptop.roam.corp.google.com> <20180522130217.GA161672@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7
List-ID: <linux-pci.vger.kernel.org>

> [+cc sparclinux, sorry I missed this first time around]

> >       sparc/PCI: Use dev_printk() when possible

This patch causes compile errors for me:

  CC      arch/sparc/kernel/pci.o
In file included from ./include/linux/pci.h:31:0,
                 from arch/sparc/kernel/pci.c:18:
arch/sparc/kernel/pci.c: In function =A1pcibios_enable_device=A2:
arch/sparc/kernel/pci.c:754:53: error: =A1old_cmd=A2 undeclared (first us=
e in this function)
   pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
                                                     ^
./include/linux/device.h:1384:58: note: in definition of macro =A1dev_inf=
o=A2
 #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                          ^
arch/sparc/kernel/pci.c:754:3: note: in expansion of macro =A1pci_info=A2
   pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
   ^
arch/sparc/kernel/pci.c:754:53: note: each undeclared identifier is repor=
ted only once for each function it appears in
   pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
                                                     ^
./include/linux/device.h:1384:58: note: in definition of macro =A1dev_inf=
o=A2
 #define dev_info(dev, fmt, arg...) _dev_info(dev, fmt, ##arg)
                                                          ^
arch/sparc/kernel/pci.c:754:3: note: in expansion of macro =A1pci_info=A2
   pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd, cmd);
   ^
scripts/Makefile.build:312: recipe for target 'arch/sparc/kernel/pci.o' f=
ailed


--=20
Meelis Roos (mroos@linux.ee)
