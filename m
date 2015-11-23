Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55850 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066AbbKWNtX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 23 Nov 2015 08:49:23 -0500
Date: Mon, 23 Nov 2015 13:49:21 +0000
From: Will Deacon <will.deacon@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/3] arm/arm64: pci: remove arch specific
 pcibios_enable_device()
Message-ID: <20151123134921.GB4236@arm.com>
References: <1447779838-15585-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1447779838-15585-3-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447779838-15585-3-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 17, 2015 at 05:03:58PM +0000, Lorenzo Pieralisi wrote:
> The arm/arm64 pcibios_enable_device() implementations exist solely
> to prevent enabling PCI resources on PROBE_ONLY systems, since
> on those systems the PCI resources are currently not claimed (ie
> validated and inserted in the PCI resource tree) therefore they can
> not be enabled since this would trigger PCI set-ups failures.
> 
> By introducing resources claiming in the PCI host controllers set-ups
> that have PROBE_ONLY as a probe option, there is no need for arch specific
> pcibios_enable_device() implementations anymore in that the kernel can
> rely on the generic pcibios_enable_device() implementation without
> resorting to arch specific code to work around the missing resources
> claiming enumeration step.
> 
> This patch removes the pcibios_enable_device() implementations from
> the arm/arm64 arch back-ends.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm/kernel/bios32.c | 12 ------------
>  arch/arm64/kernel/pci.c  | 13 -------------
>  2 files changed, 25 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
