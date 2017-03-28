Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V5 0/4] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
To: linux-pci@vger.kernel.org, mayurkumar.patel@intel.com
References: <1490477893-9517-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <f062dc8f-df66-bfd8-a0d7-50ac1cadf975@codeaurora.org>
Date: Tue, 28 Mar 2017 00:37:31 -0400
MIME-Version: 1.0
In-Reply-To: <1490477893-9517-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, timur@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mayurkumkar,

On 3/25/2017 5:38 PM, Sinan Kaya wrote:
> When the operating system is booted with the default ASPM policy
> (POLICY_DEFAULT), current code is querying the enable/disable
> states from ASPM registers to determine the policy.
> 
> For example, a BIOS could set the power saving state to performance
> and clear all ASPM control registers. A balanced ASPM policy could
> enable L0s and disable L1. A power conscious BIOS could enable both
> L0s and L1 to trade off latency and performance vs. power.
> 
> After hotplug removal, pcie_aspm_exit_link_state() function clears
> the ASPM registers. An insertion following hotplug removal reads
> incorrect policy as ASPM disabled even though ASPM was enabled
> during boot.
> 
> This is caused by the fact that same function is used for reconfiguring
> ASPM regardless of the power on state.
> 
> ------------------------
> Changes from v4 (http://www.spinics.net/lists/linux-pci/msg59245.html)
> ------------------------
> - pci_aspm_init(): Fix function comment.  Called for every device we
>   enumerate.
> 	Upstream link partner:  Shouldn't need to check pdev->link_state
>         (should always be NULL for a brand-new device).
> 
> - pcie_aspm_init_link_state(): Called for bridges (upstream end of
>     link) after all children have been enumerated.  No longer needs to
>     check aspm_support_enabled or pdev->has_secondary_link or the VIA
>     quirk: pci_aspm_init() already checked that stuff, so we only need
>     to check pdev->link_state here.
> 
> - split the last patch into two
>   PCI/ASPM: move link_state cleanup to bridge remove
>   PCI/ASPM: save power on values during bridge init
> 
> - create bugzilla (https://bugzilla.kernel.org/show_bug.cgi?id=194895)
> - add fixes tags
> 
> Sinan Kaya (4):
>   PCI/ASPM: introduce pci_aspm_init() and add to pci_init_capabilities()
>   PCI/ASPM: add init hook to device_add
>   PCI/ASPM: save power on values during bridge init
>   PCI/ASPM: move link_state cleanup to bridge remove
> 
>  drivers/pci/pcie/aspm.c | 93 +++++++++++++++++++++++++++++++++----------------
>  drivers/pci/probe.c     |  3 ++
>  drivers/pci/remove.c    |  3 +-
>  include/linux/pci.h     |  2 ++
>  4 files changed, 69 insertions(+), 32 deletions(-)
> 

Can you test this on your system and provide your tested-by if all good?

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
