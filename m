Return-Path: <SRS0=7cta=YD=ti.com=kishon@kernel.org>
Return-Path: <SRS0=7cta=YD=ti.com=kishon@kernel.org>
Subject: Re: resume path in dra7xx and other DW-based drivers
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20161207220234.GG22129@bhelgaas-glaptop.roam.corp.google.com>
 <58491E7C.1070700@ti.com>
 <20161208204304.GC30533@bhelgaas-glaptop.roam.corp.google.com>
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
Message-ID: <5858CED7.4020004@ti.com>
Date: Tue, 20 Dec 2016 11:55:27 +0530
MIME-Version: 1.0
In-Reply-To: <20161208204304.GC30533@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Friday 09 December 2016 02:13 AM, Bjorn Helgaas wrote:
> On Thu, Dec 08, 2016 at 02:19:00PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Bjorn,
>>
>> On Thursday 08 December 2016 03:32 AM, Bjorn Helgaas wrote:
>>> Hi Kishon, et al,
>>>
>>> Does dra7xx suspend/resume work?  I'm not sure dra7xx_pcie_resume()
>>> and dra7xx_pcie_resume_noirq() restore everything necessary.  For
>>> example, the probe path has this:
>>>
>>>   dra7xx_pcie_probe
>>>     dra7xx_add_pcie_port
>>>       dw_pcie_host_init
>>> 	dra7xx_pcie_host_init         # .host_init
>>> 	  dw_pcie_setup_rc
>>> 	    dw_pcie_prog_outbound_atu
>>>
>>> so I think it programs the ATU in dw_pcie_setup_rc().  But the resume
>>> path doesn't call dw_pcie_setup_rc(), so I don't see where the ATU
>>> setup would be restored.
>>
>> DRA7xx only supported shallow power state and not deep power state. In shallow
>> power state, the register settings are not lost and hence we didn't have to
>> restore anything.
> 
> I'm not really a PM guy, so I'm not familiar with shallow power state.
> Could I have discovered from the code somehow that dra7xx suspend to
> shallow power state preserves register state?  It's nice if a reader
> can verify correctness without knowing the system-specific details.

Some drivers like drivers/mmc/host/omap_hsmmc.c saves the register contents
(omap_hsmmc_context_save) and then in runtime_resume checks if the register
contents are still same (omap_hsmmc_context_restore). Do you think we have to
do something like that for dra7xx?

omap_hsmmc.c is used by a lot of platforms some of which loses the context
during suspend. Since dra7xx doesn't loose context, not sure if we have to do
something like omap_hsmmc.

Thanks
Kishon
