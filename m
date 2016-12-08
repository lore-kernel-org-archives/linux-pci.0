Return-Path: <SRS0=o9Sn=XX=ti.com=kishon@kernel.org>
Return-Path: <SRS0=o9Sn=XX=ti.com=kishon@kernel.org>
Subject: Re: resume path in dra7xx and other DW-based drivers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20161207220234.GG22129@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-pci@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Richard
 Zhu <Richard.Zhu@freescale.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Murali
 Karicheri <m-karicheri2@ti.com>,
        Minghuan Lian <minghuan.Lian@freescale.com>,
        Mingkai Hu <mingkai.hu@freescale.com>,
        Roy Zang <tie-fei.zang@freescale.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Niklas Cassel
	<niklas.cassel@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Pratyush
 Anand <pratyush.anand@gmail.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <58491E7C.1070700@ti.com>
Date: Thu, 8 Dec 2016 14:19:00 +0530
MIME-Version: 1.0
In-Reply-To: <20161207220234.GG22129@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Thursday 08 December 2016 03:32 AM, Bjorn Helgaas wrote:
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

DRA7xx only supported shallow power state and not deep power state. In shallow
power state, the register settings are not lost and hence we didn't have to
restore anything.
> 
> Related to this, dra7xx_pcie_resume_noirq() contains phy init and
> power-on code that is duplicated in dra7xx_pcie_probe().  It seems
> like that ought to be done by a common function instead of being cut
> and pasted.

yeah, that has to be cleaned up.

Thanks
Kishon
