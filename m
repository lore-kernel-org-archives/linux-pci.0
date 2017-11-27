Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13581 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752671AbdK0S2E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Nov 2017 13:28:04 -0500
Subject: Re: [PATCH V3 00/12] Enable Tegra root port features and apply SW
 fixups
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <kthota@nvidia.com>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <912eb378-2b12-0474-8c33-34113d23476b@nvidia.com>
 <20171127180908.GB4123@red-moon>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <19e2abfe-29ce-80e0-585a-3749e06cf740@nvidia.com>
Date: Mon, 27 Nov 2017 23:57:48 +0530
MIME-Version: 1.0
In-Reply-To: <20171127180908.GB4123@red-moon>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

Except "PCI: tegra: Move REFCLK pad settings out of phy_power_on()"
all other patches in the series is new code.

Thanks,
Manikanta

On 27-Nov-17 11:39 PM, Lorenzo Pieralisi wrote:
> Hi Manikanta,
> 
> On Sun, Nov 26, 2017 at 01:29:26AM +0530, Manikanta Maddireddy wrote:
>> Hi Bjorn, Thierry,
>>
>> Could you please review this series of patches?
> 
> It is new code correct (ie there are not any fixes in the series) ?
> I will mark it as code to review for the next kernel cycle on my side.
> 
> Thanks,
> Lorenzo
> 
>> On 30-Oct-17 7:27 PM, Manikanta Maddireddy wrote:
>>> These series of patches does the following things,
>>> - Deasserting pcie_xrst after programming root port to make sure that
>>>   register programming is reflected during LTSSM
>>> - Apply REFCLK pad settings to make sure P2P amplitude requirement is met
>>> - Enable Gen2 link speed
>>> - Advertise AER capability
>>> - Program UPHY electrical settings for meeting eye diagram requirements
>>> - Bunch of SW fixups explained in their respective commit log
>>>
>>> Testing done on Tegra124, 210 and 186:
>>> - PCIe link up, config read, BAR read and basic functionality of Ethernet
>>>   card
>>> - Link speed switch to Gen2 after link retrain
>>> - Link speed stays in Gen1 after retrain if end point is only Gen1 capable
>>> - Simulated AER errors and verified dmesg logs for them
>>> - Rest of the programming is verified by dumping the registers after PCIe
>>> link up
>>>
>>> Manikanta Maddireddy (12):
>>>   PCI: tegra: Start LTSSM after programming root port
>>>   PCI: tegra: Move REFCLK pad settings out of phy_power_on()
>>>   PCI: tegra: Retrain link for Gen2 speed
>>>   PCI: tegra: Advertise AER capability
>>>   PCI: tegra: Program UPHY electrical settings in Tegra210
>>>   PCI: tegra: Enable opportunistic update FC and ACK
>>>   PCI: tegra: Disable AFI dynamic clock gating
>>>   PCI: tegra: Wait for DLLP to finish before entering L1 or L2
>>>   PCI: tegra: Enable PCIe xclk clock clamping
>>>   PCI: tegra: Add SW fixup for RAW violations
>>>   PCI: tegra: Increase the deskew retry time
>>>   PCI: tegra: Update flow control threshold in Tegra210
>>>
>>>  drivers/pci/host/pci-tegra.c | 306 ++++++++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 288 insertions(+), 18 deletions(-)
>>>
