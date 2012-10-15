Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:60609 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab2JOCdI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 14 Oct 2012 22:33:08 -0400
Message-ID: <507B75D6.201@huawei.com>
Date: Mon, 15 Oct 2012 10:32:54 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: Add new default PCI-E MPS bus state
References: <1350020155-3782-1-git-send-email-jdmason@kudzu.us> <1350020155-3782-4-git-send-email-jdmason@kudzu.us>
In-Reply-To: <1350020155-3782-4-git-send-email-jdmason@kudzu.us>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2012/10/12 13:35, Jon Mason wrote:
> Add a new default state for the PCI-E MPS determination, PCIE_BUS_WARN.
> This state notifies the user that a suboptimal configuration is
> occurring (most likely due to incorrect configuration in the BIOS), and
> provides them the boot parameter to enable this error to be corrected.
> This provides the users an ability to detect an issue with MPS, without
> forcing them to correct the issue (which may cause system hangs).  This
> is a much more sane default for the distros.
> 
> Also, add debug output to show the default device MPS and MPSS.
> 
> Signed-off-by: Jon Mason <jdmason@kudzu.us>
> CC: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/pci.c    |    2 +-
>  drivers/pci/probe.c  |   10 ++++++++++
>  drivers/pci/quirks.c |    3 ++-
>  include/linux/pci.h  |    1 +
>  4 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ab4bf5a..1723c81 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -78,7 +78,7 @@ unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
>  unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
>  unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
>  
> -enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_TUNE_OFF;
> +enum pcie_bus_config_types pcie_bus_config = PCIE_BUS_WARN;
>  
>  /*
>   * The default CLS is used if arch didn't set CLS explicitly and not
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 5a18652..64bb393 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1448,6 +1448,9 @@ static int pcie_find_smpss(struct pci_dev *dev, void *data)
>  	if (!pci_is_pcie(dev))
>  		return 0;
>  
> +	dev_dbg(&dev->dev, "Device MPS %d and MPSS %d\n",
> +		pcie_get_mps(dev), 128 << dev->pcie_mpss);
> +

What about dev_prinkt(KERN_DEBUG, .....), so users can get this information from dmesg directly?

>  	/* For PCIE hotplug enabled slots not connected directly to a
>  	 * PCI-E root port, there can be problems when hotplugging
>  	 * devices.  This is due to the possibility of hotplugging a
> @@ -1588,6 +1591,7 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>  		smpss = 0;
>  		break;
>  
> +	case PCIE_BUS_WARN:
>  	case PCIE_BUS_SAFE:
>  		smpss = mpss;
>  
> @@ -1600,6 +1604,12 @@ void pcie_bus_configure_settings(struct pci_bus *bus, u8 mpss)
>  		return;
>  	}
>  
> +	if (pcie_bus_config == PCIE_BUS_WARN) {
> +		if (smpss != mpss)
> +			dev_info(&bus->dev, "Non-optimal PCI-E Bus MPS value of %d being used instead of %d.\n"
> +				 "Please use the pci=pcie_bus_safe boot parameter for better performance.\n",
> +				 128 << smpss, 128 << mpss);

test log in my ia64 machine(support pciehp)

 |           +-07.0-[0000:46-4f]----00.0-[0000:47-4f]--+-04.0-[0000:48-49]----00.0-[0000:49]--
 |           |                                         +-08.0-[0000:4a]--
 |           |                                         +-09.0-[0000:4b]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
 |           |                                         |                 \-00.1  Intel Corporation 82576 Gigabit Network Connection


hot add log:
pci 0000:4b:00.0: [8086:10c9] type 00 class 0x020000
pci 0000:4b:00.0: reg 10: [mem 0x00000000-0x0001ffff]
pci 0000:4b:00.0: reg 14: [mem 0x00000000-0x0001ffff]
pci 0000:4b:00.0: reg 18: [io  0x0000-0x001f]
pci 0000:4b:00.0: reg 1c: [mem 0x00000000-0x00003fff]
pci 0000:4b:00.0: reg 30: [mem 0x00000000-0x0001ffff pref]
pci 0000:4b:00.0: PME# supported from D0 D3hot D3cold
pci 0000:4b:00.1: [8086:10c9] type 00 class 0x020000
pci 0000:4b:00.1: reg 10: [mem 0x00000000-0x0001ffff]
pci 0000:4b:00.1: reg 14: [mem 0x00000000-0x0001ffff]
pci 0000:4b:00.1: reg 18: [io  0x0000-0x001f]
pci 0000:4b:00.1: reg 1c: [mem 0x00000000-0x00003fff]
pci 0000:4b:00.1: reg 30: [mem 0x00000000-0x0001ffff pref]
pci 0000:4b:00.1: PME# supported from D0 D3hot D3cold
pcieport 0000:47:09.0: bridge window [mem 0x00100000-0x001fffff pref] to [bus 4b] add_size 200000
pcieport 0000:47:09.0: res[9]=[mem 0x00100000-0x001fffff pref] get_res_add_size add_size 200000
pcieport 0000:47:09.0: BAR 9: can't assign mem pref (size 0x300000)
pcieport 0000:47:09.0: BAR 9: can't assign mem pref (size 0x100000)
pci 0000:4b:00.0: BAR 0: assigned [mem 0x80000000-0x8001ffff]
pci 0000:4b:00.0: BAR 1: assigned [mem 0x80020000-0x8003ffff]
pci 0000:4b:00.0: BAR 6: assigned [mem 0x80040000-0x8005ffff pref]
pci 0000:4b:00.1: BAR 0: assigned [mem 0x80060000-0x8007ffff]
pci 0000:4b:00.1: BAR 1: assigned [mem 0x80080000-0x8009ffff]
pci 0000:4b:00.1: BAR 6: assigned [mem 0x800a0000-0x800bffff pref]
pci 0000:4b:00.0: BAR 3: assigned [mem 0x800c0000-0x800c3fff]
pci 0000:4b:00.1: BAR 3: assigned [mem 0x800c4000-0x800c7fff]
pci 0000:4b:00.0: BAR 2: assigned [io  0x9000-0x901f]
pci 0000:4b:00.1: BAR 2: assigned [io  0x9020-0x903f]
pcieport 0000:47:09.0: PCI bridge to [bus 4b]
pcieport 0000:47:09.0:   bridge window [io  0x9000-0x9fff]
pcieport 0000:47:09.0:   bridge window [mem 0x80000000-0x800fffff]
PCI: No. 2 try to assign unassigned res
pcieport 0000:47:09.0: bridge window [mem 0x00100000-0x001fffff 64bit pref] to [bus 4b] add_size 200000
pcieport 0000:47:09.0: res[9]=[mem 0x00100000-0x001fffff 64bit pref] get_res_add_size add_size 200000
pcieport 0000:47:09.0: BAR 9: can't assign mem pref (size 0x300000)
pcieport 0000:47:09.0: BAR 9: can't assign mem pref (size 0x100000)
pcieport 0000:47:09.0: PCI bridge to [bus 4b]
pcieport 0000:47:09.0:   bridge window [io  0x9000-0x9fff]
pcieport 0000:47:09.0:   bridge window [mem 0x80000000-0x800fffff]
pci_bus 0000:4b: Non-optimal PCI-E Bus MPS value of 128 being used instead of 1024.
Please use the pci=pcie_bus_safe boot parameter for better performance.
pci_bus 0000:4b: Non-optimal PCI-E Bus MPS value of 128 being used instead of 1024.
Please use the pci=pcie_bus_safe boot parameter for better performance.

I think above log has some confusion.
pcieport 0000:47:09.0 device mps current is 256 and mpss is 1024;
the newly hot added igb device 0000:4b:00.0 and 0000:4b:00.1 mps are 128 and mpss is 512;
1、"pci_bus 0000:4b: Non-optimal PCI-E Bus MPS value of 128 being used instead of 1024."  should ".......instead of 256(bridge mps)"？
2、“use the pci=pcie_bus_safe boot parameter for better performance”  should "....use pci=pcie_bus_safe for safe"?
3、above logs is  duplicate.

igb 0000:4b:00.0: enabling device (0100 -> 0102)
igb 0000:4b:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:4b:00.0: eth4: (PCIe:2.5Gb/s:Width x4) 00:0e:0c:ff:ff:ff
igb 0000:4b:00.0: eth4: PBA No: FFFFFF-0FF
igb 0000:4b:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
igb 0000:4b:00.1: enabling device (0100 -> 0102)
GSI 63 (level, low) -> CPU 27 (0x3300) vector 137
igb 0000:4b:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:4b:00.1: eth4: (PCIe:2.5Gb/s:Width x4) 00:0e:0c:ff:ff:fe
igb 0000:4b:00.1: eth4: PBA No: FFFFFF-0FF
igb 0000:4b:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)


Thanks!
Yijing


> +		return;
>  	}
>  
>  	pcie_bus_configure_set(bus->self, &smpss);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 5155317..e4eede0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2787,7 +2787,8 @@ static void __devinit quirk_intel_mc_errata(struct pci_dev *dev)
>  	int err;
>  	u16 rcc;
>  
> -	if (pcie_bus_config == PCIE_BUS_TUNE_OFF)
> +	if (pcie_bus_config == PCIE_BUS_TUNE_OFF ||
> +	    pcie_bus_config == PCIE_BUS_WARN)
>  		return;
>  
>  	/* Intel errata specifies bits to change but does not say what they are.
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5faa831..410eaf9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -662,6 +662,7 @@ extern void pcie_bus_configure_settings(struct pci_bus *bus, u8 smpss);
>  
>  enum pcie_bus_config_types {
>  	PCIE_BUS_TUNE_OFF,
> +	PCIE_BUS_WARN,
>  	PCIE_BUS_SAFE,
>  	PCIE_BUS_PERFORMANCE,
>  	PCIE_BUS_PEER2PEER,
> 


-- 
Thanks!
Yijing

