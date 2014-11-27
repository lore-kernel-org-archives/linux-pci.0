Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:40336 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665AbaK0JUq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Nov 2014 04:20:46 -0500
Message-ID: <5476ECE4.9060508@arm.com>
Date: Thu, 27 Nov 2014 09:20:36 +0000
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: Arnd Bergmann <arnd@arndb.de>, Liviu Dudau <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: tegra: Use physical range for I/O mapping
References: <1417078449-9556-1-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1417078449-9556-1-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27/11/14 08:54, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Commit 0b0b0893d49b ("of/pci: Fix the conversion of IO ranges into IO
> resources") changed how I/O resources are parsed from DT. Rather than
> containing the physical address of the I/O region, the addresses will
> now be in I/O address space.
> 
> On Tegra the union of all ranges is used to expose a top-level memory-
> mapped resource for the PCI host bridge. This helps to make /proc/iomem
> more readable.
> 
> Combining both of the above, the union would now include the I/O space
> region. This causes a regression on Tegra20, where the physical base
> address of the PCIe controller (and therefore of the union) is located
> at physical address 0x80000000. Since I/O space starts at 0, the union
> will now include all of system RAM which starts at 0x00000000.
> 
> This commit fixes this by keeping two copies of the I/O range: one that
> represents the range in the CPU's physical address space, the other for
> the range in the I/O address space. This allows the translation setup
> within the driver to reuse the physical addresses. The code registering
> the I/O region with the PCI core uses both ranges to establish the
> mapping.
> 
> Fixes: 0b0b0893d49b ("of/pci: Fix the conversion of IO ranges into IO resources")
> Reported-by: Marc Zyngier <marc.zyngier@arm.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Just gave it a go, and it works just fine here. Thanks!

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
