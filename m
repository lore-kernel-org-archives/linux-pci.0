Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0071.outbound.protection.outlook.com ([104.47.41.71]:27456
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751784AbeFDPIG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jun 2018 11:08:06 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/7] PCI: cadence: Update cdns_pcie_ep_raise_irq
 function signature
Date: Mon, 4 Jun 2018 15:08:02 +0000
Message-ID: <SN6PR07MB4512F3B395D731FF14EBDB8ED8670@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1526576613.git.gustavo.pimentel@synopsys.com>
 <4994f263efbf6a2cb952d3d9839fb3b1737efde9.1526576613.git.gustavo.pimentel@synopsys.com>
 <aa86d9b7-d715-2a21-6a94-be927e55b51b@ti.com>
In-Reply-To: <aa86d9b7-d715-2a21-6a94-be927e55b51b@ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 31 May 2018 11:51, Kishon Vijay Abraham I  wrote:
> Hi Alan,
>=20
> On Thursday 17 May 2018 10:39 PM, Gustavo Pimentel wrote:
> > Change cdns_pcie_ep_raise_irq() signature, namely the interrupt_num
> > variable type from u8 to u16 to accommodate 2048 maximum MSI-X
> > interrupts.
> >
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Acked-by: Alan Douglas <adouglas@cadence.com>
>=20
> Do you want to add MSI-X support to cadence PCIe?
>=20
I do want to add MSI-X support, in fact I have done some tests with a
modified cadence driver with this set, so plan to submit a patch later.
