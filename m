Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC 00/10] Adds pcitest tool support for MSI-X
To: Alan Douglas <adouglas@cadence.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <SN6PR07MB45123840F0C9487F1CD119A9D8880@SN6PR07MB4512.namprd07.prod.outlook.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <767b50e3-8890-c241-bc97-1687bd0661c1@synopsys.com>
Date: Tue, 24 Apr 2018 09:49:45 +0100
MIME-Version: 1.0
In-Reply-To: <SN6PR07MB45123840F0C9487F1CD119A9D8880@SN6PR07MB4512.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

On 24/04/2018 07:48, Alan Douglas wrote:
> Hi Gustavo,
> 
> On 10 April 2018 18:15 Gustavo Pimentel wrote:
>> This patch set depends the following series:
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2018_4_10_421&d=DwIFAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=R3h7a4AkN9--FFv6jtHaknKIzx6NieDdkYxyCe4obB8&s=J2A11L2_WwzMdaBheYSTwfjPDA7sx3_DyoGPAYsJ9A4&e=> This series aims to add pcitest tool support for MSI-X.
>>
>> Includes new callbacks methods and handlers to trigger the MSI-X
>> interruptions on the EP Designware IP driver.
>>
>> Provides new methods on pci_epf_test driver that allows to set/get EP
>> maximum number of MSI-X entries (similar to set/get MSI methods).
>>
>> Reworks on MSI set/get and triggering methods on EP Designware IP driver to
>> be more generic and flexible.
>>
>> Adds a new input parameter (msix) and replicates the whole MSI mechanism
>> applied to the MSI-X feature on pcitest tool. Also updates the pcitest script
>> with the new test set applied to this new feature.
>>
>> Gustavo Pimentel (10):
>>   PCI: dwc: Add MSI-X callbacks handler
>>   PCI: cadence: Update cdns_pcie_ep_raise_irq function signature
>>   PCI: endpoint: Add MSI-X interfaces
>>   PCI: dwc: MSI callbacks handler rework
>>   PCI: dwc: Add legacy interrupt callback handler
>>   misc: pci_endpoint_test: Add MSI-X support
>>   misc: pci_endpoint_test: Replace lower into upper case characters
>>   PCI: endpoint: functions/pci-epf-test: Add MSI-X support
>>   PCI: endpoint: functions/pci-epf-test: Replace lower into upper case
>>     characters
>>   tools: PCI: Add MSI-X support
>>
>>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>>  drivers/misc/pci_endpoint_test.c                 | 120 ++++++++++----
>>  drivers/pci/cadence/pcie-cadence-ep.c            |   2 +-
>>  drivers/pci/dwc/pci-dra7xx.c                     |   2 +-
>>  drivers/pci/dwc/pcie-artpec6.c                   |   2 +-
>>  drivers/pci/dwc/pcie-designware-ep.c             | 201
>> +++++++++++++++++++++--
>>  drivers/pci/dwc/pcie-designware-plat.c           |   9 +-
>>  drivers/pci/dwc/pcie-designware.h                |  40 +++--
>>  drivers/pci/endpoint/functions/pci-epf-test.c    | 113 +++++++++----
>>  drivers/pci/endpoint/pci-ep-cfs.c                |  24 +++
>>  drivers/pci/endpoint/pci-epc-core.c              |  60 ++++++-
>>  include/linux/pci-epc.h                          |  11 +-
>>  include/linux/pci-epf.h                          |   1 +
>>  include/uapi/linux/pcitest.h                     |   1 +
>>  tools/pci/pcitest.c                              |  18 +-
>>  tools/pci/pcitest.sh                             |  25 +++
>>  16 files changed, 528 insertions(+), 104 deletions(-)
>>
>> --
>> 2.7.4
>>
> Nice set of patches.  I have tested this with the Cadence EP driver after adding MSI-X support, and found a few changes required.
> I will send you comments.

Ok, great news!

Maybe after this patch series submission we could start a new thread about new
features that could be tested/verified using pcitest. I think this could be
helpful for everybody.

> 
> Thanks,
> Alan
> 

Thanks,
Gustavo
