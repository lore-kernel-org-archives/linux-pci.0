Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 0/2] PCI: dwc: convert remaining dbi read/writes to
 dw_pcie_readX_dbi/dw_pcie_writeX_dbi
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Anand <pratyush.anand@gmail.com>
References: <20170714120735.11993-1-niklas.cassel@axis.com>
 <20170815223946.GQ32525@bhelgaas-glaptop.roam.corp.google.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <90a9daea-d962-07a6-6c5d-be7a16810123@axis.com>
Date: Mon, 4 Sep 2017 18:10:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170815223946.GQ32525@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/16/2017 12:39 AM, Bjorn Helgaas wrote:
> [+cc Kishon, Pratyush]
> 
> On Fri, Jul 14, 2017 at 02:07:33PM +0200, Niklas Cassel wrote:
>> Since the introduction of the dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros,
>> most dw_pcie_read(pci->dbi_base, ..)/dw_pcie_write(pci->dbi_base, ..) calls
>> have been converted to dw_pcie_readX_dbi/dw_pcie_writeX_dbi calls.
>> Convert the remaining calls.
>>
>> Niklas Cassel (2):
>>   PCI: dwc: dra7xx: utilize dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros
>>   PCI: dwc: spear13xx: utilize dw_pcie_readX_dbi/dw_pcie_writeX_dbi
>>     macros
>>
>>  drivers/pci/dwc/pci-dra7xx.c     | 14 ++++++--------
>>  drivers/pci/dwc/pcie-spear13xx.c | 22 ++++++++++------------
>>  2 files changed, 16 insertions(+), 20 deletions(-)
> 
> These patches are short, but obscure, e.g.,
> 
>   - dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_LNKCAP, 4, &val);
>   + val = dw_pcie_readl_dbi(pci, exp_cap_off + PCI_EXP_LNKCAP);
> 
> The original call path was:
> 
>   dw_pcie_read(addr, ...)
>     readl(addr) 
> 
> and we're replacing it with the much more complicated:
> 
>   dw_pcie_readl_dbi
>     __dw_pcie_read_dbi
>       if (pci->ops->read_dbi)
> 	return pci->ops->read_dbi(pci, base, reg, size)
>       dw_pcie_read(base + reg, size, &val)
> 	readl
> 
> This is not functionally equivalent (the new path uses ops->read_dbi
> if it's set), so the changelog should say something about why we need
> this change.
> 
> Neither dra7xx nor spear13xx sets .read_dbi, so my guess is this
> doesn't actually fix anything that's broken and this is just for
> consistency.

Hello Bjorn,

It is just for consistency.

Sorry for my misleading cover letter.
It should have said: "For consistency, convert all
dw_pcie_read(pci->dbi_base, ..)/dw_pcie_write(pci->dbi_base, ..)
calls to use the dw_pcie_readX_dbi/dw_pcie_writeX_dbi macros".

It is true that dw_pcie_readX_dbi/dw_pcie_writeX_dbi will use
ops->read_dbi if it is set. However, if ops->read_dbi is set,
you will most likely want to use that function for reading the dbi.
Anyway, neither spear13xx nor dra7xx has ops->read_dbi set,
so these patches shouldn't change their current behavior.

Do you want me to resend these patches or would you prefer
to just drop them?

Best regards,
Niklas

> 
> That's fine, but I'm confused because I looked for some of the
> previous conversions you mentioned but couldn't find any.  I'm lost in
> a maze of twisty little passages.
> 
> Bjorn
> 
