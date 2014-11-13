Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:62857 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaKMRJZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 12:09:25 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Zang Roy-R61911 <r61911@freescale.com>,
	Hu Mingkai-B21284 <B21284@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [PATCH v6] PCI: Layerscape: Add Layerscape PCIe driver
Date: Thu, 13 Nov 2014 18:08:54 +0100
Message-ID: <1504614.TjszoPYyHM@wuerfel>
In-Reply-To: <20141113163833.GA5064@google.com>
References: <1415177111-28730-1-git-send-email-Minghuan.Lian@freescale.com> <20141113163833.GA5064@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 13 November 2014 09:38:33 Bjorn Helgaas wrote:
> On Wed, Nov 05, 2014 at 04:45:11PM +0800, Minghuan Lian wrote:
> > Add support for Freescale Layerscape PCIe controller. This driver
> > re-uses the designware core code.
> > 
> > Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> 
> Applied with Arnd's ack to pci/host-layerscape for v3.19, thanks!
> 

the build bot just came back with an error:

  make.cross ARCH=xtensa 

All error/warnings:

>> drivers/pci/host/pcie-designware.c:168:52: warning: 'struct pci_sys_data' declared inside parameter list
    static inline struct pcie_port *sys_to_pcie(struct pci_sys_data *sys)
                                                       ^
>> drivers/pci/host/pcie-designware.c:168:52: warning: its scope is only this definition or declaration, which is probably not what you want
   drivers/pci/host/pcie-designware.c: In function 'sys_to_pcie':
   drivers/pci/host/pcie-designware.c:170:12: error: dereferencing pointer to incomplete type
     return sys->private_data;
               ^
   drivers/pci/host/pcie-designware.c: At top level:
>> drivers/pci/host/pcie-designware.c:397:45: warning: 'struct pci_sys_data' declared inside parameter list


The new Kconfig symbol evidently needs a 'depends on ARM'.

	Arnd
