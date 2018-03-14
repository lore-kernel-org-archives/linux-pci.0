Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42929 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeCNMGM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Mar 2018 08:06:12 -0400
MIME-Version: 1.0
In-Reply-To: <20180314114515.GC8564@ulmo>
References: <20180313115218.2246372-1-arnd@arndb.de> <20180314114515.GC8564@ulmo>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 13:06:11 +0100
Message-ID: <CAK8P3a3Wr8FNRP4ZYDGk9OL+=0w--pzRX=R6ye_+6nCtnHGVjg@mail.gmail.com>
Subject: Re: [PATCH] pci: tegra: add MSI dependency
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:45 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Mar 13, 2018 at 12:52:05PM +0100, Arnd Bergmann wrote:
>> Building the tegra PCIe host driver without MSI results in a link
>> failure:
>>
>> drivers/pci/host/pci-tegra.o:(.data+0x70): undefined reference to `pci_msi_unmask_irq'
>> drivers/pci/host/pci-tegra.o:(.data+0x74): undefined reference to `pci_msi_mask_irq'
>>
>> This adds the same dependency that everyone else uses.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/pci/host/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>
> I'm slightly concerned about the dependency. Not that I doubt its
> correctness, but because it could mean that PCI_TEGRA is not visible in
> the default configuration. The only reason why it is currently visible
> is because PCI_MSI is selected by some symbols that also happen to be
> enabled. However, what if at some point those symbols are disabled or
> removed?
>
> Some architectures make sure that PCI_MSI is enabled by selecting it,
> but that's risky, isn't it, because PCI_MSI is user-visible and could
> therefore easily lead to conflicts.
>
> Enabling PCI_MSI in the arm64 defconfig would solve the issue and is
> good enough for me. I've got a couple of changes to that defconfig in
> the Tegra tree for v4.17-rc1, I can add a patch to enable PCI_MSI.
>
> Unless there are any objections.

I looked at it again and found that this on ARM64, PCI_MSI is always
selected indirectly by ARM_GIC&&PCI, so there is no problem.

The build failure must have been on 32-bit ARM.

       Arnd
