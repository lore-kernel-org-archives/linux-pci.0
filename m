Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45438 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753799AbcGZUIL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jul 2016 16:08:11 -0400
Date: Tue, 26 Jul 2016 15:08:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [GIT PULL] PCI: tegra: Changes for v4.8-rc1
Message-ID: <20160726200807.GC15037@localhost>
References: <20160701150056.26537-3-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160701150056.26537-3-thierry.reding@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 01, 2016 at 05:00:56PM +0200, Thierry Reding wrote:
> Hi Bjorn,
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.8-pci
> 
> for you to fetch changes up to 0f32700faed919946e21e9d1dc4d74ae8f1b1226:
> 
>   PCI: tegra: Correctly program PADS_REFCLK_CFG* registers (2016-06-30 15:30:16 +0200)
> 
> There's a minor conflict between this and your pci/host-request-windows
> branch, let me know if you'd like me to rebase on top of that.
> 
> Thierry
> 
> ----------------------------------------------------------------
> PCI: tegra: Changes for v4.8-rc1
> 
> A couple of cleanups and preparation work for 64-bit ARM support, as
> well as fixes for writing the PADS_REFCLK_CFG* registers.
> 
> ----------------------------------------------------------------
> Stephen Warren (2):
>       PCI: tegra: Actually program PADS_REFCLK_CFG* on recent SoCs
>       PCI: tegra: Correctly program PADS_REFCLK_CFG* registers
> 
> Thierry Reding (3):
>       PCI: tegra: Make register definitions consistent
>       PCI: tegra: Use pci_remap_iospace()
>       PCI: tegra: Stop setting pcibios_min_mem

I applied these with the changelog updates I mentioned to
pci/host-tegra for v4.8, thanks!

Bjorn
