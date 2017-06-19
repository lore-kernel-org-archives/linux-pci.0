Return-Path: <SRS0=zZ1W=5Y=ti.com=kishon@kernel.org>
Return-Path: <SRS0=zZ1W=5Y=ti.com=kishon@kernel.org>
Subject: Re: [PATCH v3] PCI: dwc: dra7xx: Fix compilation warning.
To: Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Bjorn Helgaas
	<helgaas@kernel.org>
References: <a2736e3907827e7b39dd85381101c1080012584c.1497514167.git.arvind.yadav.cs@gmail.com>
 <20170615204951.GD12735@bhelgaas-glaptop.roam.corp.google.com>
 <16817169-9f2e-5406-f61c-b2d683559815@gmail.com>
CC: <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <277fbefd-cbd8-47ee-2707-937c2b014b89@ti.com>
Date: Mon, 19 Jun 2017 14:49:25 +0530
MIME-Version: 1.0
In-Reply-To: <16817169-9f2e-5406-f61c-b2d683559815@gmail.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 16 June 2017 01:48 PM, Arvind Yadav wrote:
> Hi Kishon/Bjorn,
> 
> What is correct Setting for these two PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI and
> PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN register.
> 
> Value of register After change:
>  register[PCIECTRL_DRA7XX_CONF_IRQSTATUS_MSI] = LEG_EP_INTERRUPTS |  MSI
>                                           = 0x1f
> register[PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN] =  INTERRUPTS
>                   =  0x1fff
> Is this correct?

That's correct. That patch as such is correct but the changelog and subject has
to be fixed. You can use something like below for subject and changelog.

"PCI: dwc: dra7xx: Fix incorrect usage of IRQSTATUS_* registers

commit 47ff3de911 ("PCI: dra7xx: Add TI DRA7xx PCIe driver") in order to clear
MSI and MAIN interrupts requests wrote '0' to PCIECTRL_TI_CONF_IRQSTATUS_MSI
and PCIECTRL_TI_CONF_IRQSTATUS_MAIN registers. However the TRM has mentioned to
write '1' to clear pending event in these two registers. Fix it here.

This also helps to get rid of the following compilation warning:
drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_msi_interrupts’:
drivers/pci/dwc/pci-dra7xx.c:177:7: warning: large integer implicitly truncated
to unsigned type [-Woverflow]
       ~LEG_EP_INTERRUPTS & ~MSI);
       ^
drivers/pci/dwc/pci-dra7xx.c: In function ‘dra7xx_pcie_enable_wrapper_interrupts’:
drivers/pci/dwc/pci-dra7xx.c:187:7: warning: large integer implicitly truncated
to unsigned type [-Woverflow]
       ~INTERRUPTS);"

For the patch itself
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
