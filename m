Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 06/10] misc: pci_endpoint_test: Add MSI-X support
Date: Mon, 30 Apr 2018 15:35:21 +0000
Message-ID: <SN6PR07MB45124A237879C78453495C50D8820@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
 <633ea6faef782de5ea753bffe5028aceff09115a.1524845816.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <633ea6faef782de5ea753bffe5028aceff09115a.1524845816.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On April 27, 2018, 4:57 p.m. Gustavo Pimentel wrote:
> Add MSI-X support and update driver documentation accordingly.
>=20
> Add new driver parameter to allow interruption type selection.
>=20
> Modify the Legacy/MSI/MSI-X test process, by:
>  - Add and use a specific register located in a BAR, which defines the in=
terrupt
> type is been triggered.
>  - Move the interrupt ID number from the command section to a register
> located in a BAR.
>=20
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>  drivers/misc/pci_endpoint_test.c                 | 121 +++++++++++++++--=
------
>  drivers/pci/endpoint/functions/pci-epf-test.c    |  78 +++++++++++----
>  3 files changed, 143 insertions(+), 59 deletions(-)
>=20
In testing these changes  I found that pci_epc_raise_irq() also needs to be
updated in pci-epc-core.c, since it has interrupt_num parameter as u8

Thanks,
Alan
