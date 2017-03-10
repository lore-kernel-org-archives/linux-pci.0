Return-Path: <SRS0=7var=2T=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=7var=2T=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH V3] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1489005551-23598-1-git-send-email-okaya@codeaurora.org>
 <20170309222751.GD19517@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-arm-msm@vger.kernel.org, Mayurkumar Patel
 <mayurkumar.patel@intel.com>, open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <ec7ee607-60f3-7e1a-b1cd-8e4534ab98eb@codeaurora.org>
Date: Fri, 10 Mar 2017 09:36:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170309222751.GD19517@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 3/9/2017 5:27 PM, Bjorn Helgaas wrote:
> How hard do you think it would be to rework this path slightly so we:
> 
>   - call pcie_aspm_init_link_state() for every device, maybe from
>     pci_init_capabilities()
> 
>   - for bridges, have pcie_aspm_init_link_state() allocate a
>     link_state, regardless of whether it currently has any children,
>     and save the ASPM settings done by firmware
> 
>   - for endpoints, have pcie_aspm_init_link_state() do the actual ASPM
>     setup of the link as it currently does
> 
>   - for endpoints, change pcie_aspm_exit_link_state() so it cleans up
>     the device's own state and disables ASPM if necessary, but doesn't
>     remove the parent's link_state
> 
>   - for bridges, change pcie_aspm_exit_link_state() so it frees the
>     bridge's own link_state

Thanks for the feedback, Let me take a stab at this. 
Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
