Return-Path: <SRS0=+xF7=7Z=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=+xF7=7Z=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v11 2/4] PCI: Factor out pci_bus_wait_crs()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Timur Tabi <timur@codeaurora.org>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20170818212310.15145.21732.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170818213210.15145.15340.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <9cb3006d-31d0-e57a-fd3e-c32914e8ba42@codeaurora.org>
 <20170821191806.GC28977@bhelgaas-glaptop.roam.corp.google.com>
 <eca38319-9e78-1a9c-b275-43944fd0a63d@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <b9cbd3d8-dec5-65db-efec-b84f1e96985d@codeaurora.org>
Date: Wed, 23 Aug 2017 00:40:45 -0400
MIME-Version: 1.0
In-Reply-To: <eca38319-9e78-1a9c-b275-43944fd0a63d@codeaurora.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/21/2017 3:37 PM, Sinan Kaya wrote:
> bool pci_bus_crs_pending(struct pci_dev *dev, u32 l)
> {
> 	if !pci_bus_crs_vis_supported(dev->parent)
> 		return false;

Apparently, I can't do this. By the time, we come to here from vendor id read
function, the topology has not been set up yet. 

I'm getting an exception:

[    6.067392] [<ffff00000846c878>] pci_bus_crs_visibility_pending+0x4/0x7c
[    6.074085] [<ffff00000846cccc>] pci_scan_single_device+0x40/0xb4
[    6.080170] [<ffff00000846cd90>] pci_scan_slot+0x50/0xe8
[    6.085474] [<ffff00000846dc14>] pci_scan_child_bus+0x30/0x108
[    6.091300] [<ffff0000084bab94>] acpi_pci_root_create+0x184/0x1f0
[    6.097388] [<ffff000008091dc8>] pci_acpi_scan_root+0x188/0x1d4
[    6.103298] [<ffff0000084ba7a8>] acpi_pci_root_add+0x38c/0x44c
[    6.109125] [<ffff0000084b4d94>] acpi_bus_attach+0xe0/0x1ac
[    6.114689] [<ffff0000084b4e08>] acpi_bus_attach+0x154/0x1ac
[    6.120340] [<ffff0000084b4e08>] acpi_bus_attach+0x154/0x1ac
[    6.125991] [<ffff0000084b6608>] acpi_bus_scan+0x60/0x70
[    6.131297] [<ffff0000091c87f8>] acpi_scan_init+0xd8/0x228
[    6.136774] [<ffff0000091c84e0>] acpi_init+0x2d4/0x328
[    6.141905] [<ffff0000091a0c88>] do_one_initcall+0x80/0x108
[    6.147469] [<ffff0000091a0e98>] kernel_init_freeable+0x188/0x228
[    6.153556] [<ffff000008c9bcbc>] kernel_init+0x10/0xfc
[    6.158687] [<ffff000008082ec0>] ret_from_fork+0x10/0x50



> 
> 	return (l & 0xFFFF) == 0x0001;
> }


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
