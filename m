Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1567 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933577AbeBMPaa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Feb 2018 10:30:30 -0500
Subject: Re: [PATCH V7 2/4] PCI: tegra: Add loadable kernel module support
To: Thierry Reding <thierry.reding@gmail.com>
CC: <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <cyndis@kapsi.fi>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <vidyas@nvidia.com>, <kthota@nvidia.com>
References: <1517289851-14111-1-git-send-email-mmaddireddy@nvidia.com>
 <1517289851-14111-3-git-send-email-mmaddireddy@nvidia.com>
 <20180213130718.GE6764@ulmo>
 <eeab925c-3da4-38ae-2060-f77458abaaea@nvidia.com>
 <20180213135139.GA15842@ulmo>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <b90f8f85-9e8a-3ba3-1e4d-7bd63b61c9b7@nvidia.com>
Date: Tue, 13 Feb 2018 21:00:07 +0530
MIME-Version: 1.0
In-Reply-To: <20180213135139.GA15842@ulmo>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 13-Feb-18 7:21 PM, Thierry Reding wrote:
> On Tue, Feb 13, 2018 at 06:48:49PM +0530, Manikanta Maddireddy wrote:
>>
>>
>> On 13-Feb-18 6:37 PM, Thierry Reding wrote:
>>> On Tue, Jan 30, 2018 at 10:54:09AM +0530, Manikanta Maddireddy wrote:
>>>> Implement remove callback function for Tegra PCIe driver to add
>>>> loadable kernel module support. Change PCI_TEGRA config to tristate to
>>>> allow pci-tegra driver to be build as a module.
>>>>
>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>> ---
>>>> V2:
>>>> * no change in this patch
>>>> V3:
>>>> * use tegra_pcie_debugfs_exit() helper function in tegra_pcie_debugfs_init()
>>>> V4:
>>>> * no change in this patch
>>>> V5:
>>>> * Decoupled from https://patchwork.ozlabs.org/patch/832053/ and
>>>> rebased on linux-next
>>>> V6:
>>>> * no change in this patch
>>>> V7:
>>>> * no change in this patch
>>>>
>>>>  drivers/pci/host/Kconfig     |  2 +-
>>>>  drivers/pci/host/pci-tegra.c | 34 +++++++++++++++++++++++++++++++---
>>>>  2 files changed, 32 insertions(+), 4 deletions(-)
>>>
>>> Trying to build this as a module I get a link failure because
>>> irq_set_msi_desc() is not exported. I thought a patch to do that had
>>> been part of an earlier version of this series. Has that not been merged
>>> yet?
>>>
>>> Thierry
>>>
>> I got a review comment to use generic MSI model instead of deprecated API.
>> source: https://patchwork.ozlabs.org/patch/841111/
>>
>> Also arm32 compilation will fail because of missing EXPORT of
>> tegra_cpuidle_pcie_irqs_in_use()
>> source: https://patchwork.ozlabs.org/patch/841119/
>>
>> I need to put some time to prepare patches for these two cases.
>> Meanwhile I want to get the basic driver structure for LKM to be merged.
>> I verified locally with these two symbols exported.
> 
> Okay, that's fine. However, you can't request these patches to be merged
> if they will break builds. There are people that run automated builders
> that will check random configurations, which is bound to eventually get
> us a bug report about how this fails to build.
> 
> Perhaps in order to get loadable module support merged without these
> issues you could omit the Kconfig change making this a tristate symbol.
> That way we can get all the structural changes ready and you can work
> on the necessary exports or MSI model patches so that we can eventually
> flip the symbol to tristate.
> 
> By the way, if you do respin for the tristate change, do you mind taking
> a look at the blank line changes for readability I mentioned earlier?
> 
> Thierry
> 

Hi Thierry,

Taken care of both and published V8. Since these are simple changes,
I retained your Ack & Tested signoff.

Manikanta
