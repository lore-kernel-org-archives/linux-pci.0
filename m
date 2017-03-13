Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 13 Mar 2017 16:46:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4 0/3] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Message-ID: <20170313214616.GE8232@bhelgaas-glaptop.roam.corp.google.com>
References: <1489438085-2055-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1489438085-2055-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, mayurkumar.patel@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 13, 2017 at 04:48:02PM -0400, Sinan Kaya wrote:
> y
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
> ASPM regardless of the of the power on state.
> 
> ------------------------
> Changes from v3 (https://lkml.org/lkml/2017/3/8/670)
> ------------------------
> - call pcie_aspm_init_link_state() for every device, maybe from
> pci_init_capabilities()
> 
> - for bridges, have pcie_aspm_init_link_state() allocate a
> link_state, regardless of whether it currently has any children,
> and save the ASPM settings done by firmware
> 
> - for endpoints, have pcie_aspm_init_link_state() do the actual ASPM
> setup of the link as it currently does
> 
> - for endpoints, change pcie_aspm_exit_link_state() so it cleans up
> the device's own state and disables ASPM if necessary, but doesn't
> remove the parent's link_state
> 
> - for bridges, change pcie_aspm_exit_link_state() so it frees the
> bridge's own link_state
> 
> Sinan Kaya (3):
>   PCI/ASPM: divide ASPM capability init into pre and post init
>   PCI/ASPM: move part of ASPM initialization to pci_init_capabilities
>   PCI/ASPM: move link_state cleanup to bridge remove
> 
>  drivers/pci/pcie/aspm.c | 175 +++++++++++++++++++++++++++++++++++-------------
>  drivers/pci/probe.c     |   3 +
>  include/linux/pci.h     |   6 ++
>  3 files changed, 136 insertions(+), 48 deletions(-)

What is this series based on?  Unless they depend on other in-flight
patches, I apply patches to branches based on my "master" branch,
which is typically -rc1 or -rc2 (it's currently v4.11-rc1).  These
don't apply to either.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
