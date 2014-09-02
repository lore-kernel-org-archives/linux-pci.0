Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39724 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbaIBOwf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Sep 2014 10:52:35 -0400
Message-ID: <5405D9C8.1000308@ti.com>
Date: Tue, 2 Sep 2014 10:52:56 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [GIT PULL] PCI changes for v3.17 (part 3)
References: <20140819044050.GA15551@google.com> <53F368F7.1070707@ti.com> <CAErSpo6GfCE8yT2Dda1JJsoPQhFD_b0GhB=OZ6w854ZB_B6eqA@mail.gmail.com>
In-Reply-To: <CAErSpo6GfCE8yT2Dda1JJsoPQhFD_b0GhB=OZ6w854ZB_B6eqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/19/2014 12:30 PM, Bjorn Helgaas wrote:
> On Tue, Aug 19, 2014 at 10:10 AM, Murali Karicheri<m-karicheri2@ti.com>  wrote:
>> Hi Bjorn,
>>
>> I see you have pulled in my designware related patches for Keystone PCI in
>> this request. When do you think you can pull in Keystone PCI driver (v8) on
>> the list?
>
> The things in this pull request have been in linux-next for a month.
> I'm ready to apply the Keystone driver, but since we're after the
> merge window and the Keystone driver hasn't been in -next at all, I
> plan to put it in v3.18.
>
BJorn,

Do you have a v3.18 next branch that you can add this patch to? I need 
to send out additional patches on top of this to support PCIe and SATA 
on another K2 platform, K2E and will be good if I can base it on a 
merged branch. Also I am afraid, we will have nasty merge issues to deal 
with if others start making changes in parallel and conflict with this 
patch series.

Thanks and regards,

Murali

> I know I hoped to get this in v3.17, but even if I merged it today I
> would let it soak in -next for a week or so, and then we'd be past
> v3.17-rc2, and that feels past the reasonable point for a pull
> request.
>
> Bjorn
>
>> -------- Original Message --------
>> Subject: [GIT PULL] PCI changes for v3.17 (part 3)
>> Date: Mon, 18 Aug 2014 22:40:50 -0600
>> From: Bjorn Helgaas<bhelgaas@google.com>
>> To: Linus Torvalds<torvalds@linux-foundation.org>
>> CC:<linux-pci@vger.kernel.org>,<linux-kernel@vger.kernel.org>, "Murali
>> Karicheri"<m-karicheri2@ti.com>, Kishon Vijay Abraham I<kishon@ti.com>,
>> Thierry Reding<treding@nvidia.com>, Andrew Lunn<andrew@lunn.ch>
>>
>> Hi Linus,
>>
>> I screwed up.  I intended these changes for v3.17, and I put them in my
>> 'next' branch just before leaving on vacation, but I forgot to include them
>> in my merge window pull request when I returned.  They're low-risk, so I'm
>> sending them to you now (late), but the world won't end if they wait until
>> v3.18.
>>
>> The main reason to include them would be to support the TI DRA7xx.
>>
>> Bjorn
>>
>>
>> The following changes since commit 792688fde431b4fdb2cf10a6f7589a8176b6b14a:
>>
>>    Merge branches 'pci/host-generic', 'pci/host-mvebu', 'pci/host-rcar',
>> 'pci/host-tegra', 'pci/msi', 'pci/misc', 'pci/resource' and
>> 'pci/virtualization' into next (2014-07-16 17:09:47 -0600)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>> tags/pci-v3.17-changes-3
>>
>> for you to fetch changes up to 981c191778a4f92bc82456205a444d522843a630:
>>
>>    Merge branches 'pci/host-designware', 'pci/host-mvebu' and
>> 'pci/host-tegra' into next (2014-07-22 17:55:50 -0600)
>>
>> ----------------------------------------------------------------
>> PCI changes for v3.17 (part 3):
>>
>>    Marvell MVEBU
>>      - Remove ARCH_KIRKWOOD dependency (Andrew Lunn)
>>
>>    NVIDIA Tegra
>>      - Add debugfs support (Thierry Reding)
>>
>>    Synopsys DesignWare
>>      - Look for configuration space in 'reg', not 'ranges' (Kishon Vijay
>> Abraham I)
>>      - Program ATU with untranslated address (Kishon Vijay Abraham I)
>>      - Add config access-related pcie_host_ops for v3.65 hardware (Murali
>> Karicheri)
>>      - Add MSI-related pcie_host_ops for v3.65 hardware (Murali Karicheri)
>>
>>    TI DRA7xx
>>      - Add TI DR7xx PCIe driver (Kishon Vijay Abraham I)
>>
>> ----------------------------------------------------------------
>> Andrew Lunn (1):
>>        PCI: mvebu: Remove ARCH_KIRKWOOD dependency
>>
>> Bjorn Helgaas (1):
>>        Merge branches 'pci/host-designware', 'pci/host-mvebu' and
>> 'pci/host-tegra' into next
>>
>> Kishon Vijay Abraham I (3):
>>        PCI: designware: Look for configuration space in 'reg', not 'ranges'
>>        PCI: designware: Program ATU with untranslated address
>>        PCI: dra7xx: Add TI DRA7xx PCIe driver
>>
>> Murali Karicheri (2):
>>        PCI: designware: Add config access-related pcie_host_ops for v3.65
>> hardware
>>        PCI: designware: Add MSI-related pcie_host_ops for v3.65 hardware
>>
>> Thierry Reding (1):
>>        PCI: tegra: Add debugfs support
>>
>>   .../devicetree/bindings/pci/designware-pcie.txt    |   4 +
>>   Documentation/devicetree/bindings/pci/ti-pci.txt   |  59 +++
>>   MAINTAINERS                                        |   8 +
>>   drivers/pci/host/Kconfig                           |  11 +-
>>   drivers/pci/host/Makefile                          |   1 +
>>   drivers/pci/host/pci-dra7xx.c                      | 458
>> +++++++++++++++++++++
>>   drivers/pci/host/pci-tegra.c                       | 118 ++++++
>>   drivers/pci/host/pcie-designware.c                 | 134 ++++--
>>   drivers/pci/host/pcie-designware.h                 |  11 +
>>   9 files changed, 771 insertions(+), 33 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/pci/ti-pci.txt
>>   create mode 100644 drivers/pci/host/pci-dra7xx.c

