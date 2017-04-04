Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: RE: [PATCH V7 0/5] PCI/ASPM: reconfigure ASPM following hotplug for
 POLICY_DEFAULT
Date: Tue, 4 Apr 2017 15:02:45 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B28466761383@IRSMSX101.ger.corp.intel.com>
References: <1490880636-30542-1-git-send-email-okaya@codeaurora.org>
 <7c48ca8b-b834-3257-91dc-77e9d19def6c@codeaurora.org>
In-Reply-To: <7c48ca8b-b834-3257-91dc-77e9d19def6c@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "timur@codeaurora.org" <timur@codeaurora.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan

>Hi Mayurkumar,
>
>On 3/30/2017 9:30 AM, Sinan Kaya wrote:
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
>> Changes from v6 (https://www.spinics.net/lists/arm-kernel/msg572876.html)
>> ------------------------
>> - revert the accidental parent check in bridge remove
>>
>> Sinan Kaya (5):
>>   PCI/ASPM: introduce pci_aspm_init() and add to pci_init_capabilities()
>>   PCI/ASPM: split pci_aspm_init() into two
>>   PCI/ASPM: add init hook to device_add
>>   PCI/ASPM: save power on values during bridge init
>>   PCI/ASPM: move link_state cleanup to bridge remove
>>
>>  drivers/pci/pcie/aspm.c | 137 ++++++++++++++++++++++++++++++++----------------
>>  drivers/pci/probe.c     |   3 ++
>>  drivers/pci/remove.c    |   3 +-
>>  include/linux/pci.h     |   2 +
>>  4 files changed, 98 insertions(+), 47 deletions(-)
>>
>
>Did you get a chance to test?
>

Not yet. Will get back in this week sometimes to give you some feedback.



Thanks
Mayur

>Sinan
>
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
