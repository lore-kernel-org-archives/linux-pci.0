Return-Path: <m-karicheri2@ti.com>
Return-Path: <m-karicheri2@ti.com>
Subject: Re: ks_dw_pcie_initiate_link_train() question
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20161004174051.GE3449@localhost>
CC: <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <57F4248C.1010203@ti.com>
Date: Tue, 4 Oct 2016 17:52:12 -0400
MIME-Version: 1.0
In-Reply-To: <20161004174051.GE3449@localhost>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

On 10/04/2016 01:40 PM, Bjorn Helgaas wrote:
> Hi Murali,
> 
> This code looks suspicious.  Can you comment?
> 
>     void ks_dw_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
>     {
>         u32 val;
> 
>         /* Disable Link training */
>         val = readl(ks_pcie->va_app_base + CMD_STATUS);
>         val &= ~LTSSM_EN_VAL;
>         writel(LTSSM_EN_VAL | val,  ks_pcie->va_app_base + CMD_STATUS);
> 
> Here we cleared the LTSSM_EN_VAL bit in "val", but then we add it
> right back in before writing it back to CMD_STATUS.
> 
> That looks like a cut and paste error to me, but of course I don't
> know the hardware.
> 
>         /* Initiate Link Training */
>         val = readl(ks_pcie->va_app_base + CMD_STATUS);
>         writel(LTSSM_EN_VAL | val,  ks_pcie->va_app_base + CMD_STATUS);
>     }
> 
> 
Bjorn,

Good catch! That is a cut-n-paste error. Here is the description from
device manual

================
Disable link training by de-asserting the LTSSM_EN bit in the PCIESS
Command Status Register (CMD_STATUS[LTSSM_EN]=0). Upon reset, the
LTSSM_EN is de-asserted automatically by hardware.

Initiate link training can be initiated by asserting LTSSM_EN bit in the
CMD_STATUS register (CMD_STATUS[LTSSM_EN]=1).
================================================

Probably it works because it is de-asserted automatically upon
reset by hardware. Let me test this and send you a patch? 

-- 
Murali Karicheri
Linux Kernel, Keystone
