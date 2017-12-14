Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35511 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752780AbdLNNpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Dec 2017 08:45:49 -0500
From: Thierry Reding <thierry.reding@gmail.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Saga <vidyas@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 0/4] PCI: tegra: Configuration space mapping cleanups and fixes
Date: Thu, 14 Dec 2017 14:45:41 +0100
Message-Id: <20171214134545.11143-1-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <treding@nvidia.com>

Hi Lorenzo,

This cleans up a few oddities that I found while reviewing and testing
the patch

	[PATCH V3 1/2] PCI: tegra: refactor config space mapping code

that Vidya Sagar sent out earlier. The first three patches are mostly
cleanup and admittedly somewhat bikeshedding in nature. They could've
been just review comments, but I thought I'd just submit them as a
series of patches since I had already typed them up anyway.

The last patch gets rid of an artificial restriction regarding the
mapping address and does a bit of simplification.

These are technically incremental on top of the original patch, but if
you prefer, feel free to squash them into that patch.

I've tested these on all of Tegra20, Tegra30, Tegra124, Tegra210 and
Tegra186.

Thanks,
Thierry

Thierry Reding (4):
  PCI: tegra: Clarify configuration space address computations
  PCI: tegra: Reorder parameters in offset computations
  PCI: tegra: Consolidate I/O register variables
  PCI: tegra: Remove artificial mapping restriction

 drivers/pci/host/pci-tegra.c | 71 ++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 38 deletions(-)

-- 
2.15.1
