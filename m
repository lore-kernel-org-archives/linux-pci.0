Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 11 Apr 2017 16:19:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V8 0/5] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Message-ID: <20170411211924.GC14778@bhelgaas-glaptop.roam.corp.google.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
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

On Sat, Apr 08, 2017 at 12:55:46AM -0400, Sinan Kaya wrote:
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
> Changes from v7 (https://www.spinics.net/lists/arm-kernel/msg573034.html)
> ------------------------
> - enable LTSSM as a best effort if the endpoint is not connected during
>   boot
> 
> 
> Sinan Kaya (5):
>   PCI/ASPM: introduce pci_aspm_init() and add to pci_init_capabilities()
>   PCI/ASPM: split pci_aspm_init() into two
>   PCI/ASPM: add init hook to device_add
>   PCI/ASPM: save power on values during bridge init
>   PCI/ASPM: move link_state cleanup to bridge remove
> 
>  drivers/pci/pcie/aspm.c | 149 +++++++++++++++++++++++++++++++++---------------
>  drivers/pci/probe.c     |   3 +
>  drivers/pci/remove.c    |   3 +-
>  include/linux/pci.h     |   2 +
>  4 files changed, 110 insertions(+), 47 deletions(-)

Hi Sinan,

What are these patches based on?  I normally apply things to my "master"
branch, which is typically -rc1 or -rc2.  Right now it's v4.11-rc1, and
these don't apply cleanly:

  04:17:59 ~/linux (master)$ stg branch --create pci/aspm-sk-v8 v4.11-rc1
  Checking for changes in the working directory ... done
  Don't know how to determine parent branch from "v4.11-rc1"
  Branch "pci/aspm-sk-v8" created
  04:18:18 ~/linux (pci/aspm-sk-v8)$ stg import -M --sign m/sk-v8
  Checking for changes in the working directory ... done
  Importing patch "pci-aspm-introduce" ... done
  Importing patch "pci-aspm-split-pci_aspm_init" ... done
  Importing patch "pci-aspm-add-init-hook-to" ... error: patch failed: drivers/pci/pcie/aspm.c:798
  error: drivers/pci/pcie/aspm.c: patch does not apply
  stg import: Diff does not apply cleanly

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
