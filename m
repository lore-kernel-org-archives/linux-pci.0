Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V5 0/4] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Date: Tue, 28 Mar 2017 06:02:03 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B2846675AEDC@IRSMSX101.ger.corp.intel.com>
References: <1490477893-9517-1-git-send-email-okaya@codeaurora.org>
 <f062dc8f-df66-bfd8-a0d7-50ac1cadf975@codeaurora.org>
In-Reply-To: <f062dc8f-df66-bfd8-a0d7-50ac1cadf975@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "timur@codeaurora.org" <timur@codeaurora.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan

>Hi Mayurkumkar,
>
>On 3/25/2017 5:38 PM, Sinan Kaya wrote:
>> When the operating system is booted with the default ASPM policy
>> (POLICY_DEFAULT), current code is querying the enable/disable
>> states from ASPM registers to determine the policy.
>>
>> For example, a BIOS could set the power saving state to performance
>> and clear all ASPM control registers. A balanced ASPM policy could
>> enable L0s and disable L1. A power conscious BIOS could enable both
>> L0s and L1 to trade off latency and performance vs. power.
>>
>> After hotplug removal, pcie_aspm_exit_link_state() function clears
>> the ASPM registers. An insertion following hotplug removal reads
>> incorrect policy as ASPM disabled even though ASPM was enabled
>> during boot.
>>
>> This is caused by the fact that same function is used for reconfiguring
>> ASPM regardless of the power on state.
>>
>> ------------------------
>> Changes from v4 (http://www.spinics.net/lists/linux-pci/msg59245.html)
>> ------------------------
>> - pci_aspm_init(): Fix function comment.  Called for every device we
>>   enumerate.
>> 	Upstream link partner:  Shouldn't need to check pdev->link_state
>>         (should always be NULL for a brand-new device).
>>
>> - pcie_aspm_init_link_state(): Called for bridges (upstream end of
>>     link) after all children have been enumerated.  No longer needs to
>>     check aspm_support_enabled or pdev->has_secondary_link or the VIA
>>     quirk: pci_aspm_init() already checked that stuff, so we only need
>>     to check pdev->link_state here.
>>
>> - split the last patch into two
>>   PCI/ASPM: move link_state cleanup to bridge remove
>>   PCI/ASPM: save power on values during bridge init
>>
>> - create bugzilla (https://bugzilla.kernel.org/show_bug.cgi?id=194895)
>> - add fixes tags
>>
>> Sinan Kaya (4):
>>   PCI/ASPM: introduce pci_aspm_init() and add to pci_init_capabilities()
>>   PCI/ASPM: add init hook to device_add
>>   PCI/ASPM: save power on values during bridge init
>>   PCI/ASPM: move link_state cleanup to bridge remove
>>
>>  drivers/pci/pcie/aspm.c | 93 +++++++++++++++++++++++++++++++++----------------
>>  drivers/pci/probe.c     |  3 ++
>>  drivers/pci/remove.c    |  3 +-
>>  include/linux/pci.h     |  2 ++
>>  4 files changed, 69 insertions(+), 32 deletions(-)
>>
>
>Can you test this on your system and provide your tested-by if all good?
>
>Sinan
>

Thanks for your patches. I am seeing kernel panic after applying
these patches (on top of latest kernel) each time during early boot in pci_aspm_init() (any hints already?) function.
Need to check if it's something related to my local setup or it's because of these changes.
For now I don't have more details why it crashes but I will dig in further and I will provide
you more data as soon as I have it.

>--
>Sinan Kaya
>Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
>Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
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
