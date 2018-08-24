Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr680048.outbound.protection.outlook.com ([40.107.68.48]:22652
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726504AbeHXPus (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Aug 2018 11:50:48 -0400
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH 0/4] Add support to register platform service IRQ
Date: Fri, 24 Aug 2018 12:16:20 +0000
Message-ID: <BL0PR02MB48498C30DD4082D3215B5444A5360@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <1533915580-31805-1-git-send-email-bharat.kumar.gogada@xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Subject: [PATCH 0/4] Add support to register platform service IRQ
>=20
> Some platforms have dedicated IRQ lines for PCIe services like AER/PME et=
c.
> The root complex on these platform will use these seperate IRQ lines to
> report AER/PME etc., interrupts and will not generate MSI/MSI-X/INTx
> interrupts for these services.
> These patches will add new method for these kind of platforms to register
> the platform IRQ number with respective PCIe services.
>=20
> Bharat Kumar Gogada (4):
>   PCI: Add setup_platform_service_irq hook to struct pci_host_bridge
>   PCI: Add pci_check_platform_service_irqs
>   PCI/portdrv: Check platform supported service IRQ's
>   PCI: xilinx-nwl: Add method to setup_platform_service_irq hook
>=20
>  drivers/pci/controller/pcie-xilinx-nwl.c |   16 ++++++++++++++++
>  drivers/pci/pcie/portdrv_core.c          |   19 +++++++++++++++++--
>  include/linux/pci.h                      |   25 ++++++++++++++++++++++++=
+
>  3 files changed, 58 insertions(+), 2 deletions(-)

Hi Bjorn,
Can you comment on this series.

Bharat
