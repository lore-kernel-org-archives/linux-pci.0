Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751696AbeCNSfG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 14:35:06 -0400
Date: Wed, 14 Mar 2018 18:34:56 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: tegra: add MSI dependency
Message-ID: <20180314183456.GA3056@e107981-ln.cambridge.arm.com>
References: <20180313115218.2246372-1-arnd@arndb.de>
 <20180314114515.GC8564@ulmo>
 <CAK8P3a3Wr8FNRP4ZYDGk9OL+=0w--pzRX=R6ye_+6nCtnHGVjg@mail.gmail.com>
 <20180314121314.GE8564@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314121314.GE8564@ulmo>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 01:13:14PM +0100, Thierry Reding wrote:
> On Wed, Mar 14, 2018 at 01:06:11PM +0100, Arnd Bergmann wrote:
> > On Wed, Mar 14, 2018 at 12:45 PM, Thierry Reding
> > <thierry.reding@gmail.com> wrote:
> > > On Tue, Mar 13, 2018 at 12:52:05PM +0100, Arnd Bergmann wrote:
> > >> Building the tegra PCIe host driver without MSI results in a link
> > >> failure:
> > >>
> > >> drivers/pci/host/pci-tegra.o:(.data+0x70): undefined reference to `pci_msi_unmask_irq'
> > >> drivers/pci/host/pci-tegra.o:(.data+0x74): undefined reference to `pci_msi_mask_irq'
> > >>
> > >> This adds the same dependency that everyone else uses.
> > >>
> > >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >> ---
> > >>  drivers/pci/host/Kconfig | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >
> > > I'm slightly concerned about the dependency. Not that I doubt its
> > > correctness, but because it could mean that PCI_TEGRA is not visible in
> > > the default configuration. The only reason why it is currently visible
> > > is because PCI_MSI is selected by some symbols that also happen to be
> > > enabled. However, what if at some point those symbols are disabled or
> > > removed?
> > >
> > > Some architectures make sure that PCI_MSI is enabled by selecting it,
> > > but that's risky, isn't it, because PCI_MSI is user-visible and could
> > > therefore easily lead to conflicts.
> > >
> > > Enabling PCI_MSI in the arm64 defconfig would solve the issue and is
> > > good enough for me. I've got a couple of changes to that defconfig in
> > > the Tegra tree for v4.17-rc1, I can add a patch to enable PCI_MSI.
> > >
> > > Unless there are any objections.
> > 
> > I looked at it again and found that this on ARM64, PCI_MSI is always
> > selected indirectly by ARM_GIC&&PCI, so there is no problem.
> > 
> > The build failure must have been on 32-bit ARM.
> 
> Okay, I had assumed that ARM_GIC_V2M (which selects PCI_MSI) was user-
> visible and hence could be disabled. But it's not, and always enabled on
> ARM64. On 32-bit we already explicitly enable PCI_MSI via the default
> configurations.
> 
> I withdraw my concerns. I see that Lorenzo already applied the patch, so
> just for the record:

Apologies - it fixed an issue and it seemed harmless hence I applied it
straight away, I should have waited for an ACK.

> Acked-by: Thierry Reding <treding@nvidia.com>

Updated - it is important to keep records, that's what tags are for.

Thanks,
Lorenzo
