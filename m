Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42624 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754006AbdK0SIj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Nov 2017 13:08:39 -0500
Date: Mon, 27 Nov 2017 18:09:08 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: thierry.reding@gmail.com, bhelgaas@google.com,
        jonathanh@nvidia.com, vidyas@nvidia.com, mperttunen@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com
Subject: Re: [PATCH V3 00/12] Enable Tegra root port features and apply SW
 fixups
Message-ID: <20171127180908.GB4123@red-moon>
References: <1509371843-22931-1-git-send-email-mmaddireddy@nvidia.com>
 <912eb378-2b12-0474-8c33-34113d23476b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <912eb378-2b12-0474-8c33-34113d23476b@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Manikanta,

On Sun, Nov 26, 2017 at 01:29:26AM +0530, Manikanta Maddireddy wrote:
> Hi Bjorn, Thierry,
> 
> Could you please review this series of patches?

It is new code correct (ie there are not any fixes in the series) ?
I will mark it as code to review for the next kernel cycle on my side.

Thanks,
Lorenzo

> On 30-Oct-17 7:27 PM, Manikanta Maddireddy wrote:
> > These series of patches does the following things,
> > - Deasserting pcie_xrst after programming root port to make sure that
> >   register programming is reflected during LTSSM
> > - Apply REFCLK pad settings to make sure P2P amplitude requirement is met
> > - Enable Gen2 link speed
> > - Advertise AER capability
> > - Program UPHY electrical settings for meeting eye diagram requirements
> > - Bunch of SW fixups explained in their respective commit log
> > 
> > Testing done on Tegra124, 210 and 186:
> > - PCIe link up, config read, BAR read and basic functionality of Ethernet
> >   card
> > - Link speed switch to Gen2 after link retrain
> > - Link speed stays in Gen1 after retrain if end point is only Gen1 capable
> > - Simulated AER errors and verified dmesg logs for them
> > - Rest of the programming is verified by dumping the registers after PCIe
> > link up
> > 
> > Manikanta Maddireddy (12):
> >   PCI: tegra: Start LTSSM after programming root port
> >   PCI: tegra: Move REFCLK pad settings out of phy_power_on()
> >   PCI: tegra: Retrain link for Gen2 speed
> >   PCI: tegra: Advertise AER capability
> >   PCI: tegra: Program UPHY electrical settings in Tegra210
> >   PCI: tegra: Enable opportunistic update FC and ACK
> >   PCI: tegra: Disable AFI dynamic clock gating
> >   PCI: tegra: Wait for DLLP to finish before entering L1 or L2
> >   PCI: tegra: Enable PCIe xclk clock clamping
> >   PCI: tegra: Add SW fixup for RAW violations
> >   PCI: tegra: Increase the deskew retry time
> >   PCI: tegra: Update flow control threshold in Tegra210
> > 
> >  drivers/pci/host/pci-tegra.c | 306 ++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 288 insertions(+), 18 deletions(-)
> > 
