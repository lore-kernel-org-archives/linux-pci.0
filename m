Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753911AbdLNRhG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Dec 2017 12:37:06 -0500
Date: Thu, 14 Dec 2017 17:37:45 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Saga <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: tegra: Configuration space mapping cleanups and
 fixes
Message-ID: <20171214173745.GA17018@red-moon>
References: <20171214134545.11143-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171214134545.11143-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thierry,

On Thu, Dec 14, 2017 at 02:45:41PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Hi Lorenzo,
> 
> This cleans up a few oddities that I found while reviewing and testing
> the patch
> 
> 	[PATCH V3 1/2] PCI: tegra: refactor config space mapping code
> 
> that Vidya Sagar sent out earlier. The first three patches are mostly
> cleanup and admittedly somewhat bikeshedding in nature. They could've
> been just review comments, but I thought I'd just submit them as a
> series of patches since I had already typed them up anyway.
> 
> The last patch gets rid of an artificial restriction regarding the
> mapping address and does a bit of simplification.
> 
> These are technically incremental on top of the original patch, but if
> you prefer, feel free to squash them into that patch.

I took some time to have a look at all of them and actually I am happy
with the end result, except that I would prefer if you squash them all
in and rewrite the logs since I can easily miss something (eg I have no
insights into the Tegra config space FPCI windowing mechanism) - I will
merge the resulting patch(es).

I have a question: after merging both series, are

tegra_pcie_{add/remove}_bus()

(and struct tegra_pcie_bus)

still needed ? I do not think so.

> I've tested these on all of Tegra20, Tegra30, Tegra124, Tegra210 and
> Tegra186.

If the testing goes OK please send me unified series and will merge
that one.

This brings me to a question for you and Bjorn: how do you usually
handle DT updates ? I assume we send them via the PCI tree but I am
asking to prevent any issue upfront.

Thanks,
Lorenzo
