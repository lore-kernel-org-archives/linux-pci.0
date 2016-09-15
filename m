Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Thu, 15 Sep 2016 11:58:58 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, helgaas@kernel.org,
	will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
	arnd@arndb.de, hanjun.guo@linaro.org, okaya@codeaurora.org,
	jchandra@broadcom.com, cov@codeaurora.org, dhdang@apm.com,
	ard.biesheuvel@linaro.org, robert.richter@caviumnetworks.com,
	mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	wangyijing@huawei.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linaro-acpi@lists.linaro.org, jcm@redhat.com,
	andrea.gallo@linaro.org, jeremy.linton@arm.com,
	gabriele.paoloni@huawei.com, jhugo@codeaurora.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 2/5] PCI/ACPI: Check platform specific ECAM quirks
Message-ID: <20160915105849.GA10345@red-moon>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-3-git-send-email-tn@semihalf.com>
 <57D76626.1050109@huawei.com>
 <bac9f822-ce0a-7070-94df-4d66fc30f774@semihalf.com>
 <57D7E53F.1000106@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57D7E53F.1000106@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 07:38:39PM +0800, Dongdong Liu wrote:

[...]

> Our host bridge is non ECAM only for the RC bus config space;
> for any other bus underneath the root bus we support ECAM access.
> 
> RC config resource with hardcode as DEFINE_RES_MEM(0xb0070000, SZ_4K),
> EP config resource we get it from MCFG table.
> So we need to override ops, but config resource we only need to hardcode with RC config resource.
> 
> Our host controller ACPI support patch can be found:
> https://lkml.org/lkml/2016/8/31/340

Sorry I misread your code. IIUC you create an array of resources that
represent non-ECAM config space (and incidentally contain debug
registers to check the link status - that you need to check for every
given config access (?)), but you still need to have an MCFG entry that
covers the bus number subject to quirk to make sure this mechanism
works. Correct ?

This also means that, with the MCFG tables you have and current
mainline kernel you are able to probe a root bridge (because the MCFG
table covers the bus number that is not ECAM), with enumeration
going haywire because it is trying to carry out ECAM accesses on
non-ECAM space.

Is my reading correct ?

Anyway, that's not stricly related to this discussion, it is time we
converge on this patchset, we can add a domain range if that
simplifies things.

Thanks,
Lorenzo

> This patch is based on RFC V5 quirk mechanism.
> 
> Based on V6 quirk mechanism, we have to change it as below:
> 
> #ifdef CONFIG_PCI_HISI_ACPI
> 	{ "HISI ", "HIP05 ", 0, 0, MCFG_BUS_ANY, &hisi_pcie_hip05_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP05 ", 0, 1, MCFG_BUS_ANY, &hisi_pcie_hip05_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP05 ", 0, 2, MCFG_BUS_ANY, &hisi_pcie_hip05_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP05 ", 0, 3, MCFG_BUS_ANY, &hisi_pcie_hip05_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP06 ", 0, 0, MCFG_BUS_ANY, &hisi_pcie_hip06_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP06 ", 0, 1, MCFG_BUS_ANY, &hisi_pcie_hip06_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP06 ", 0, 2, MCFG_BUS_ANY, &hisi_pcie_hip06_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP06 ", 0, 3, MCFG_BUS_ANY, &hisi_pcie_hip06_ops,
>          MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP07 ", 0, 0, MCFG_BUS_ANY, &hisi_pcie_hip07_ops,
> 	  MCFG_RES_EMPTY},
> 	{ "HISI ", "HIP07 ", 0, 1, MCFG_BUS_ANY, &hisi_pcie_hip07_ops,
> 	  MCFG_RES_EMPTY},
> 	....
> 	
> 	{ "HISI ", "HIP07 ", 0, 15, MCFG_BUS_ANY, &hisi_pcie_hip07_ops,
> 	  MCFG_RES_EMPTY},
> 
> #endif
> 
> struct pci_ecam_ops hisi_pci_hip05_ops = {
> 	.bus_shift	= 20,
> 	.init		=  hisi_pci_hip05_init,
> 	.pci_ops	= {
> 		.map_bus	= pci_ecam_map_bus,
> 		.read		= hisi_pcie_acpi_rd_conf,
> 		.write		= hisi_pcie_acpi_wr_conf,
> 	}
> };
> 
> struct pci_ecam_ops hisi_pci_hip06_ops = {
> 	.bus_shift = 20,
> 	.init = hisi_pci_hip06_init,
> 	.pci_ops = {
> 		.map_bus = pci_ecam_map_bus,
> 		.read = hisi_pcie_acpi_rd_conf,
> 		.write = hisi_pcie_acpi_wr_conf,
> 	}
> };
> 
> hisi_pci_hipxx_init function is used to get RC config resource with hardcode.
> .....
> 
> So I hope we can use MCFG_DOM_RANGE, Then I can change it as below.
> 
> #ifdef CONFIG_PCI_HISI_ACPI
> 	{ "HISI  ", "HIP05   ", 0, MCFG_DOM_RANGE(0, 3), MCFG_BUS_ANY,
> 	 &hisi_pcie_hip05_ops, MCFG_RES_EMPTY},
> 	{ "HISI  ", "HIP06   ", 0, MCFG_DOM_RANGE(0, 3), MCFG_BUS_ANY,
> 	 &hisi_pcie_hip06_ops, MCFG_RES_EMPTY},
> 	{ "HISI  ", "HIP07   ", 0, MCFG_DOM_RANGE(0, 15), MCFG_BUS_ANY,
> 	  &hisi_pcie_hip07_ops, MCFG_RES_EMPTY},
> #endif
> 
> Thanks
> Dongdong
> >
> >Thanks,
> >Tomasz
> >
> >.
> >
> 
