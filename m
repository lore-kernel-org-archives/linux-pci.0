Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "timur@codeaurora.org" <timur@codeaurora.org>
Subject: RE: [PATCH V6 0/5] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Date: Thu, 30 Mar 2017 13:07:47 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B2846675E0C4@IRSMSX101.ger.corp.intel.com>
References: <1490828667-30973-1-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1490828667-30973-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan

>
>When the operating system is booted with the default ASPM policy
>(POLICY_DEFAULT), current code is querying the enable/disable
>states from ASPM registers to determine the policy.
>
>For example, a BIOS could set the power saving state to performance
>and clear all ASPM control registers. A balanced ASPM policy could
>enable L0s and disable L1. A power conscious BIOS could enable both
>L0s and L1 to trade off latency and performance vs. power.
>
>After hotplug removal, pcie_aspm_exit_link_state() function clears
>the ASPM registers. An insertion following hotplug removal reads
>incorrect policy as ASPM disabled even though ASPM was enabled
>during boot.
>
>This is caused by the fact that same function is used for reconfiguring
>ASPM regardless of the power on state.
>
>------------------------
>Changes from v5 (https://www.spinics.net/lists/arm-kernel/msg571758.html)
>------------------------
>- rebase to 4.11-rc3
>- Split pci_aspm_init() body into pci_aspm_init_upstream()
>  and pci_aspm_init_downstream() for bridge and endpoint
>  specific code behavior.
>- Get rid of function0 function.
>  Detect downstream link in pci_aspm_init_upstream() instead
>
>Sinan Kaya (5):
>  PCI/ASPM: introduce pci_aspm_init() and add to pci_init_capabilities()
>  PCI/ASPM: split pci_aspm_init() into two
>  PCI/ASPM: add init hook to device_add
>  PCI/ASPM: save power on values during bridge init
>  PCI/ASPM: move link_state cleanup to bridge remove
>

Thanks for quick patches. I can boot up now without any crash. I will test actual
functionality by next week as I am out for this week.




> drivers/pci/pcie/aspm.c | 137 ++++++++++++++++++++++++++++++++----------------
> drivers/pci/probe.c     |   3 ++
> drivers/pci/remove.c    |   3 +-
> include/linux/pci.h     |   2 +
> 4 files changed, 98 insertions(+), 47 deletions(-)
>
>--
>1.9.1

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
