Return-Path: <SRS0=rPrl=7X=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=rPrl=7X=codeaurora.org=okaya@kernel.org>
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
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <eca38319-9e78-1a9c-b275-43944fd0a63d@codeaurora.org>
Date: Mon, 21 Aug 2017 15:37:06 -0400
MIME-Version: 1.0
In-Reply-To: <20170821191806.GC28977@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 8/21/2017 3:18 PM, Bjorn Helgaas wrote:
>> pci_bus_read_dev_vendor_id()
>> {
>> 	...
>> 	if (pci_bus_crs_visibility_supported())
>> 		return pci_bus_wait_crs(dev->bus, dev->devfn, &id, 60000);
>>
>> 	return true
>> }
>>
>> Similar pattern for pci_flr_wait().

Sorry for the poor choice of function name. 

I was thinking of something like this.

bool pci_bus_crs_pending(u32 l)
{
	return (l & 0xFFFF) == 0x0001
}

if (pci_bus_crs_pending(id))
	return pci_bus_wait_crs(dev->bus, dev->devfn, &id, 60000);

> I think that makes sense.  We'd want to check for CRS SV being
> enabled, e.g., maybe read PCI_EXP_RTCTL_CRSSVE back in
> pci_enable_crs() and cache it somewhere.  Maybe a crs_sv_enabled bit
> in the root port's pci_dev, and check it with something like what
> pcie_root_rcb_set() does?
> 

You can observe CRS under the following conditions

1. root port <-> endpoint 
2. bridge <-> endpoint 
3. root port<->bridge

I was relying on the fact that we are reading 0x001 as an indication that
this device detected CRS. Maybe, this is too indirect.

If we also want to capture the capability, I think the right thing is to
check the parent capability.

bool pci_bus_crs_vis_supported(struct pci_dev *bridge)
{
	if (device type(bridge) == root port)
		return read(root_crs_register_reg);

	if (device type(bridge) == switch)
		return read(switch_crs_register);

	return false;
}

bool pci_bus_crs_pending(struct pci_dev *dev, u32 l)
{
	if !pci_bus_crs_vis_supported(dev->parent)
		return false;

	return (l & 0xFFFF) == 0x0001;
}

I'll prototype this. Let me know if you have concerns.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
