Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52149 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119AbaK0JMx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Nov 2014 04:12:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] PCI: tegra: Use physical range for I/O mapping
Date: Thu, 27 Nov 2014 10:12:47 +0100
Message-ID: <2095645.ggFcdgUqAP@wuerfel>
In-Reply-To: <1417078449-9556-1-git-send-email-thierry.reding@gmail.com>
References: <1417078449-9556-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 27 November 2014 09:54:09 Thierry Reding wrote:
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

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
