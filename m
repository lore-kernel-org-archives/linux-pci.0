Return-Path: <SRS0=WMCN=3W=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=WMCN=3W=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V8 1/5] PCI/ASPM: introduce pci_aspm_init() and add to
 pci_init_capabilities()
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-2-git-send-email-okaya@codeaurora.org>
 <20170413205125.GC28316@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 mayurkumar.patel@intel.com, David Daney <david.daney@cavium.com>,
 linux-arm-msm@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
 Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
 linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <f6e9637d-8c5e-3363-d448-b910ca53e046@codeaurora.org>
Date: Fri, 14 Apr 2017 15:10:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170413205125.GC28316@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 4/13/2017 4:51 PM, Bjorn Helgaas wrote:
> I think these can go in drivers/pci/pci.h instead of the public
> include/linux/pci.h.  There's no ASPM section in drivers/pci/pci.h
> yet, but I think we should add one.
> 
> It looks like the following things from include/linux/pci-aspm.h could
> be moved there as well, since they're only used by the PCI core:
> 
>   void pcie_aspm_init_link_state(struct pci_dev *pdev);
>   void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>   void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>   void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>   void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
>   void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
> 
> This would be a separate patch.
> 

Sure, let me work on this.

>>  #else
>>  static inline bool pcie_aspm_support_enabled(void) { return false; }
>> +static inline int pci_aspm_init(struct pci_dev *pdev) { return -ENODEV; }
>>  #endif


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
