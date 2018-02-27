Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753081AbeB0NZg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Feb 2018 08:25:36 -0500
Subject: Re: MSI-X diagnostic problems
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>, lorenzo.pieralisi@arm.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <959dfbab-7d90-f10c-f4aa-7f0bf5a6af3e@synopsys.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <2050bd39-12cd-4d21-3127-4282392c555f@arm.com>
Date: Tue, 27 Feb 2018 13:25:33 +0000
MIME-Version: 1.0
In-Reply-To: <959dfbab-7d90-f10c-f4aa-7f0bf5a6af3e@synopsys.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On 27/02/18 12:42, Gustavo Pimentel wrote:
> Hi Marc,
> 
> I'm having some problems in my setup related to MSI-X, maybe you could help me
> debugging where could be the problem.
> 
> Currently I have a RC (bridge) with 1 MSI-X interrupt and a commercial USB 3.0
> EP capable of 8 MSI-X interrupts, however the xhci driver only uses 2 interrupts.
> 
> I have posted below some debug info gathered during my tests.
> 
> 
> # cat /proc/interrupts
>            CPU0
>   3:      10014  ARC In-core Intc   3  Timer0 (per-cpu-tick)
>   4:          0  dw-apb-ictl   4  eth0
>   8:          1  dw-apb-ictl   8  ehci_hcd:usb1, ohci_hcd:usb2
>   9:         38  dw-apb-ictl   7  dw-mci
>  14:          0  dw-apb-ictl  14  e001d000.i2c
>  16:          0  dw-apb-ictl  16  e001f000.i2c
>  19:       4065  dw-apb-ictl  19  ttyS3
>  46:          0   PCI-MSI   0  aerdrv
>  47:          1   PCI-MSI 524288  xhci_hcd
>  48:          0   PCI-MSI 524289  xhci_hcd
> #
> #
> # find /sys/ | grep msi
> /sys/devices/platform/haps_tunnel/dfc00000.pcie/pci0000:00/0000:00:00.0/msi_bus
> /sys/devices/platform/haps_tunnel/dfc00000.pcie/pci0000:00/0000:00:00.0/msi_irqs
> /sys/devices/platform/haps_tunnel/dfc00000.pcie/pci0000:00/0000:00:00.0/msi_irqs/46
> /sys/devices/platform/haps_tunnel/dfc00000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/msi_bus
> /sys/devices/platform/haps_tunnel/dfc00000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/msi_irqs
> /sys/devices/platform/haps_tunnel/dfc00000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/msi_irqs/48
> /sys/devices/platform/haps_tunnel/dfc00000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/msi_irqs/47
> #
> #
> # cat /sys/devices/platform/haps_tunnel/dfc00000.pcie/pci0000:00/0000:00:00.0/ms
> i_bus
> 1
> #
> #
> # cat /sys/devices/platform/haps_tunnel/dfc00000.pcie/pci0000:00/0000:00:00.0/ms
> i_irqs/46
> msix
> #
> # cat /sys/devices/platform/haps_tunnel/dfc00000.pcie/pci0000:00/0000:00:00.0/00
> 00:01:00.0/msi_bus
> 1
> #
> # cat /sys/devices/platform/haps_tunnel/dfc00000.pcie/pci0000:00/0000:00:00.0/00
> 00:01:00.0/msi_irqs/48
> msix
> #
> #
> # cat /sys/devices/platform/haps_tunnel/dfc00000.pcie/pci0000:00/0000:00:00.0/00
> 00:01:00.0/msi_irqs/47
> msix
> 
> 
> (GP:irq_domain_activate_irq:1552) NOT ACTIVATED
> (GP:__irq_domain_activate_irq:1516)
> (GP:irq_domain_activate_irq:1552) NOT ACTIVATED
> (GP:__irq_domain_activate_irq:1516)
> (GP:irq_domain_activate_irq:1552) NOT ACTIVATED
> (GP:__irq_domain_activate_irq:1516)
> (GP:irq_domain_activate_irq:1552) NOT ACTIVATED
> (GP:__irq_domain_activate_irq:1516)
> (GP:dw_pcie_host_init:449) pp->num_vectors = 64
> (GP:dw_pcie_host_init:453) dw_pcie_allocate_domains
> (GP:dw_pcie_allocate_domains:277) pp->num_vectors = 64
> (GP:irq_domain_activate_irq:1552) NOT ACTIVATED
> (GP:__irq_domain_activate_irq:1516)
> (GP:pci_alloc_irq_vectors_affinity:1214) MSI-X
> (GP:__pci_enable_msix_range:1132) min=1, max=32
> (GP:__pci_enable_msix:975)
> (GP:__pci_enable_msix:981) nr_entries = 1, nvec = 32
> (GP:__pci_enable_msix_range:1145) rc=1
> (GP:__pci_enable_msix:975)
> (GP:__pci_enable_msix:981) nr_entries = 1, nvec = 1
> (GP:__pci_enable_msix:987)
> (GP:msix_capability_init:773)
> (GP:msix_capability_init:777) Disable MSI-X
> (GP:msix_capability_init:780) Control register 0x00000000
> (GP:msix_map_region:682) Table offset = 0x00000000, bir = 0)
> (GP:msix_map_region:685) phys_addr = 0xD0500000, nr_entries = 1, ENTRY_SIZE = 16
> bytes, table size = 16 bytes)
> (GP:msix_setup_entries:701) Allocate MSI entries 0/1
> (GP:msix_setup_entries:719)
> (GP:msix_setup_entries:725) dev->irq = 45, base = d0500000,
> entry->msi_attrib.entry_nr = 0
> (GP:pci_msi_setup_msi_irqs:53) msi_domain_alloc_irqs
> (GP:dw_pcie_irq_domain_alloc:231) nr_irqs = 1
> (GP:dw_pcie_irq_domain_alloc:232) pp->num_vectors = 64
> (GP:dw_pcie_irq_domain_alloc:233) order_base_2(nr_irqs) = 0
> (GP:dw_pcie_irq_domain_alloc:245) virq + 0 = 46, bit + 0 = 0
> (GP:msi_domain_alloc_irqs:399) IRQ_DOMAIN_ACTIVATE_IRQ
> (GP:irq_domain_activate_irq:1552) NOT ACTIVATED
> (GP:__irq_domain_activate_irq:1516)
> (GP:__irq_domain_activate_irq:1521)
> (GP:__irq_domain_activate_irq:1516)
> (GP:msi_domain_activate:107)
> (GP:dw_pci_setup_msi_msg:142) msg_lo = 0x00000000, msg->address_hi = 0x9A228000,
> msg->data = 0x00000000, hwirq = 0
> (GP:__pci_write_msi_msg:320) msg->address_lo = 0x9A228000, msg->address_hi =
> 0x00000000, msg->data = 0x00000000
> (GP:msix_capability_init:804) Mask all MSI-X and enable MSI-X
> (GP:msix_program_entries:743)
> (GP:msix_capability_init:810) Populating MSI sysfs
> (GP:msix_capability_init:818) Unmask all MSI-X
> (GP:__pci_enable_msix_range:1145) rc=0
> (GP:irq_domain_activate_irq:1556) ALREADY ACTIVATED
> (GP:irq_domain_activate_irq:1552) NOT ACTIVATED
> (GP:__irq_domain_activate_irq:1516)
> (GP:xhci_setup_msix:264)
> (GP:pci_alloc_irq_vectors_affinity:1214) MSI-X
> (GP:__pci_enable_msix_range:1132) min=2, max=2
> (GP:__pci_enable_msix:975)
> (GP:__pci_enable_msix:981) nr_entries = 8, nvec = 2
> (GP:__pci_enable_msix:987)
> (GP:msix_capability_init:773)
> (GP:msix_capability_init:777) Disable MSI-X
> (GP:msix_capability_init:780) Control register 0x00000007
> (GP:msix_map_region:682) Table offset = 0x00002000, bir = 0)
> (GP:msix_map_region:685) phys_addr = 0xD0402000, nr_entries = 8, ENTRY_SIZE = 16
> bytes, table size = 128 bytes)
> (GP:msix_setup_entries:701) Allocate MSI entries 0/2
> (GP:msix_setup_entries:719)
> (GP:msix_setup_entries:725) dev->irq = 45, base = d0402000,
> entry->msi_attrib.entry_nr = 0
> (GP:msix_setup_entries:701) Allocate MSI entries 1/2
> (GP:msix_setup_entries:719)
> (GP:msix_setup_entries:725) dev->irq = 45, base = d0402000,
> entry->msi_attrib.entry_nr = 1
> (GP:pci_msi_setup_msi_irqs:53) msi_domain_alloc_irqs
> (GP:dw_pcie_irq_domain_alloc:231) nr_irqs = 1
> (GP:dw_pcie_irq_domain_alloc:232) pp->num_vectors = 64
> (GP:dw_pcie_irq_domain_alloc:233) order_base_2(nr_irqs) = 0
> (GP:dw_pcie_irq_domain_alloc:245) virq + 0 = 47, bit + 0 = 1
> (GP:dw_pcie_irq_domain_alloc:231) nr_irqs = 1
> (GP:dw_pcie_irq_domain_alloc:232) pp->num_vectors = 64
> (GP:dw_pcie_irq_domain_alloc:233) order_base_2(nr_irqs) = 0
> (GP:dw_pcie_irq_domain_alloc:245) virq + 0 = 48, bit + 0 = 2
> (GP:msi_domain_alloc_irqs:399) IRQ_DOMAIN_ACTIVATE_IRQ
> (GP:irq_domain_activate_irq:1552) NOT ACTIVATED
> (GP:__irq_domain_activate_irq:1516)
> (GP:__irq_domain_activate_irq:1521)
> (GP:__irq_domain_activate_irq:1516)
> (GP:msi_domain_activate:107)
> (GP:dw_pci_setup_msi_msg:142) msg_lo = 0x00000001, msg->address_hi = 0x9A228000,
> msg->data = 0x00000000, hwirq = 1
> (GP:__pci_write_msi_msg:320) msg->address_lo = 0x9A228000, msg->address_hi =
> 0x00000000, msg->data = 0x00000001
> (GP:msi_domain_alloc_irqs:399) IRQ_DOMAIN_ACTIVATE_IRQ
> (GP:irq_domain_activate_irq:1552) NOT ACTIVATED
> (GP:__irq_domain_activate_irq:1516)
> (GP:__irq_domain_activate_irq:1521)
> (GP:__irq_domain_activate_irq:1516)
> (GP:msi_domain_activate:107)
> (GP:dw_pci_setup_msi_msg:142) msg_lo = 0x00000002, msg->address_hi = 0x9A228000,
> msg->data = 0x00000000, hwirq = 2
> (GP:__pci_write_msi_msg:320) msg->address_lo = 0x9A228000, msg->address_hi =
> 0x00000000, msg->data = 0x00000002
> (GP:msix_capability_init:804) Mask all MSI-X and enable MSI-X
> (GP:msix_program_entries:743)
> (GP:msix_capability_init:810) Populating MSI sysfs
> (GP:msix_capability_init:818) Unmask all MSI-X
> (GP:__pci_enable_msix_range:1145) rc=0
> (GP:xhci_setup_msix:285) 0/2
> (GP:irq_domain_activate_irq:1556) ALREADY ACTIVATED
> (GP:xhci_setup_msix:285) 1/2
> (GP:irq_domain_activate_irq:1556) ALREADY ACTIVATED
> (GP:irq_domain_activate_irq:1552) NOT ACTIVATED
> (GP:__irq_domain_activate_irq:1516)
> (GP:irq_domain_activate_irq:1552) NOT ACTIVATED
> (GP:__irq_domain_activate_irq:1516)
> (GP:irq_domain_activate_irq:1552) NOT ACTIVATED
> (GP:__irq_domain_activate_irq:1516)
> 
> Me and João have looked to the sequence and this seems to be correct, however we
> are not receiving any interrupts and that originates the xhci to abort...
> 
> xhci_hcd 0000:01:00.0: Abort failed to stop command ring: -110
> xhci_hcd 0000:01:00.0: xHCI host controller not responding, assume dead
> xhci_hcd 0000:01:00.0: HC died; cleaning up
> xhci_hcd 0000:01:00.0: Error while assigning device slot ID
> xhci_hcd 0000:01:00.0: Max number of devices this xHCI host supports is 64.
> usb usb3-port1: couldn't allocate usb_device
> 
> Any clue? Thanks in advance.
It is hard to dig in such a trace. One thing that strikes me is that I
don't see any trace that suggest that the interrupts get unmasked. That
should happen when the driver issues a request_irq.

I'd suggest you investigate that area.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
