Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32861 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533AbcBCJZF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 3 Feb 2016 04:25:05 -0500
Date: Wed, 3 Feb 2016 09:25:02 +0000
From: Will Deacon <will.deacon@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] Clean up warnings (part 2, asm/pci-bridge.h)
Message-ID: <20160203092502.GA11376@arm.com>
References: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160202193026.9258.7573.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 02, 2016 at 01:38:26PM -0600, Bjorn Helgaas wrote:
> We've had some non-arch-specific stuff (pci_has_flag() and associated
> definitions like PCI_PROBE_ONLY) in asm/pci-bridge.h.  This leads to
> warnings like:
> 
>   drivers/pci/host/pcie-designware.c:562:20: error: 'PCI_PROBE_ONLY' undeclared (first use in this function)
>   drivers/pci/host/pcie-designware.c:562:7: error: implicit declaration of function 'pci_has_flag' [-Werror=implicit-function-declaration]
> 
> because arches don't consistently supply asm/pci-bridge.h, and several
> drivers include it when they shouldn't.
> 
> This series moves the generic stuff to linux/pci.h, so it's the same for
> everybody, and removes the now-empty asm-generic/pci-bridge.h.
> 
> There still a few arches that provide asm/pci-bridge.h (microblaze,
> powerpc, and xtensa), but now they contain truly arch-dependent things like
> struct pci_controller definitions, and they're only included by
> arch-specific files.

For the arm64 bits:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
