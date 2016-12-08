Return-Path: <SRS0=vIIj=XX=axis.com=niklas.cassel@kernel.org>
Return-Path: <SRS0=vIIj=XX=axis.com=niklas.cassel@kernel.org>
Subject: Re: resume path in dra7xx and other DW-based drivers
To: Bjorn Helgaas <helgaas@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>
References: <20161207220234.GG22129@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Richard
 Zhu <Richard.Zhu@freescale.com>, Lucas Stach <l.stach@pengutronix.de>, Murali
 Karicheri <m-karicheri2@ti.com>, Minghuan Lian <minghuan.Lian@freescale.com>,
	Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jesper Nilsson
	<jespern@axis.com>, Pratyush Anand <pratyush.anand@gmail.com>, Jose Abreu
	<Jose.Abreu@synopsys.com>, Stanimir Varbanov <svarbanov@mm-sol.com>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <7b11c552-4cc5-ade2-76dc-f310fc20e3a1@axis.com>
Date: Thu, 8 Dec 2016 09:25:02 +0100
MIME-Version: 1.0
In-Reply-To: <20161207220234.GG22129@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

On 12/07/2016 11:02 PM, Bjorn Helgaas wrote:
> Hi Kishon, et al,
>
> Does dra7xx suspend/resume work?  I'm not sure dra7xx_pcie_resume()
> and dra7xx_pcie_resume_noirq() restore everything necessary.  For
> example, the probe path has this:
>
>   dra7xx_pcie_probe
>     dra7xx_add_pcie_port
>       dw_pcie_host_init
> 	dra7xx_pcie_host_init         # .host_init
> 	  dw_pcie_setup_rc
> 	    dw_pcie_prog_outbound_atu
>
> so I think it programs the ATU in dw_pcie_setup_rc().  But the resume
> path doesn't call dw_pcie_setup_rc(), so I don't see where the ATU
> setup would be restored.
>
> Related to this, dra7xx_pcie_resume_noirq() contains phy init and
> power-on code that is duplicated in dra7xx_pcie_probe().  It seems
> like that ought to be done by a common function instead of being cut
> and pasted.
>
> I haven't looked in detail at all the other DW-based drivers; dra7xx
> just happens to be first in alphabetical order :)  But I suspect I'd
> have the same question about them.

There doesn't appear to be any DW-based driver supporting
suspend/resume other than dra7xx :)


>
> Bjorn
