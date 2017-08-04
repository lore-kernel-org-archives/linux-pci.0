Return-Path: <SRS0=5VDd=7G=ti.com=kishon@kernel.org>
Return-Path: <SRS0=5VDd=7G=ti.com=kishon@kernel.org>
Subject: Re: [PATCH 0/2] PCI: dwc: convert remaining dbi read/writes to
 dw_pcie_readX_dbi/dw_pcie_writeX_dbi
To: Bjorn Helgaas <helgaas@kernel.org>, Niklas Cassel <niklas.cassel@axis.com>
References: <20170714120735.11993-1-niklas.cassel@axis.com>
 <20170802213255.GB7667@bhelgaas-glaptop.roam.corp.google.com>
 <20170803201215.GX20308@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Niklas Cassel
	<niklass@axis.com>, <linux-kernel@vger.kernel.org>,
        Pratyush Anand
	<pratyush.anand@gmail.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c074c3cb-f6fe-cb1e-f664-fc6f80ad1500@ti.com>
Date: Fri, 4 Aug 2017 10:49:21 +0530
MIME-Version: 1.0
In-Reply-To: <20170803201215.GX20308@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>



On Friday 04 August 2017 01:42 AM, Bjorn Helgaas wrote:
> Adding Kishon & Pratyush for real this time.
> 
> On Wed, Aug 02, 2017 at 04:32:56PM -0500, Bjorn Helgaas wrote:
>> [+cc Kishon, Pratyush]
>>
>> On Fri, Jul 14, 2017 at 02:07:33PM +0200, Niklas Cassel wrote:
>>> Since the introduction of the dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros,
>>> most dw_pcie_read(pci->dbi_base, ..)/dw_pcie_write(pci->dbi_base, ..) calls
>>> have been converted to dw_pcie_readX_dbi/dw_pcie_writeX_dbi calls.
>>> Convert the remaining calls.
>>>
>>> Niklas Cassel (2):
>>>   PCI: dwc: dra7xx: utilize dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros
>>>   PCI: dwc: spear13xx: utilize dw_pcie_readX_dbi/dw_pcie_writeX_dbi
>>>     macros
>>>
>>>  drivers/pci/dwc/pci-dra7xx.c     | 14 ++++++--------
>>>  drivers/pci/dwc/pcie-spear13xx.c | 22 ++++++++++------------
>>>  2 files changed, 16 insertions(+), 20 deletions(-)
>>
>> Waiting for ack from maintainers (cc'd).

Tested this in dra7xx
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
