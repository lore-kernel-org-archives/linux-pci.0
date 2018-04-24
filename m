Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 00/10] Adds pcitest tool support for MSI-X
Date: Tue, 24 Apr 2018 06:48:59 +0000
Message-ID: <SN6PR07MB45123840F0C9487F1CD119A9D8880@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On 10 April 2018 18:15 Gustavo Pimentel wrote:
> This patch set depends the following series:
> https://lkml.org/lkml/2018/4/10/421> This series aims to add pcitest tool=
 support for MSI-X.
>=20
> Includes new callbacks methods and handlers to trigger the MSI-X
> interruptions on the EP Designware IP driver.
>=20
> Provides new methods on pci_epf_test driver that allows to set/get EP
> maximum number of MSI-X entries (similar to set/get MSI methods).
>=20
> Reworks on MSI set/get and triggering methods on EP Designware IP driver =
to
> be more generic and flexible.
>=20
> Adds a new input parameter (msix) and replicates the whole MSI mechanism
> applied to the MSI-X feature on pcitest tool. Also updates the pcitest sc=
ript
> with the new test set applied to this new feature.
>=20
> Gustavo Pimentel (10):
>   PCI: dwc: Add MSI-X callbacks handler
>   PCI: cadence: Update cdns_pcie_ep_raise_irq function signature
>   PCI: endpoint: Add MSI-X interfaces
>   PCI: dwc: MSI callbacks handler rework
>   PCI: dwc: Add legacy interrupt callback handler
>   misc: pci_endpoint_test: Add MSI-X support
>   misc: pci_endpoint_test: Replace lower into upper case characters
>   PCI: endpoint: functions/pci-epf-test: Add MSI-X support
>   PCI: endpoint: functions/pci-epf-test: Replace lower into upper case
>     characters
>   tools: PCI: Add MSI-X support
>=20
>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>  drivers/misc/pci_endpoint_test.c                 | 120 ++++++++++----
>  drivers/pci/cadence/pcie-cadence-ep.c            |   2 +-
>  drivers/pci/dwc/pci-dra7xx.c                     |   2 +-
>  drivers/pci/dwc/pcie-artpec6.c                   |   2 +-
>  drivers/pci/dwc/pcie-designware-ep.c             | 201
> +++++++++++++++++++++--
>  drivers/pci/dwc/pcie-designware-plat.c           |   9 +-
>  drivers/pci/dwc/pcie-designware.h                |  40 +++--
>  drivers/pci/endpoint/functions/pci-epf-test.c    | 113 +++++++++----
>  drivers/pci/endpoint/pci-ep-cfs.c                |  24 +++
>  drivers/pci/endpoint/pci-epc-core.c              |  60 ++++++-
>  include/linux/pci-epc.h                          |  11 +-
>  include/linux/pci-epf.h                          |   1 +
>  include/uapi/linux/pcitest.h                     |   1 +
>  tools/pci/pcitest.c                              |  18 +-
>  tools/pci/pcitest.sh                             |  25 +++
>  16 files changed, 528 insertions(+), 104 deletions(-)
>=20
> --
> 2.7.4
>=20
Nice set of patches.  I have tested this with the Cadence EP driver after a=
dding MSI-X support, and found a few changes required.
I will send you comments.

Thanks,
Alan
