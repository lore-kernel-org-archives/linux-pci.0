Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] ACPI based PCI support for arm64
To: Jayachandran C <jchandra@broadcom.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1451884403-21437-1-git-send-email-jchandra@broadcom.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <568A125A.9090608@linaro.org>
Date: Mon, 4 Jan 2016 14:34:02 +0800
MIME-Version: 1.0
In-Reply-To: <1451884403-21437-1-git-send-email-jchandra@broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi JC,

On 2016/1/4 13:13, Jayachandran C wrote:
> This patchset provides a generic ACPI based PCI host controller
> implementation and uses it on arm64.
>
> The first patch moves the common code to handle MCFG ACPI table from
> arch/x86 to drivers/acpi/pci_mcfg.c. The last patch in the patchset
> provides the generic implementation of an ACPI based PCI host
> controller with a new file drivers/acpi/pci_host_acpi.c. The other
> patches are to fix up arm64 and ACPI code to work with these two
> patches.
>
> The pci host controller implementation keeps a reference to
> pci_mmcfg_region entry so that config space access is done with a
> simple mapping and generic PCI config read/write. There is also an
> implementation of raw_pci_read/raw_pci_write provided by walking the
> pci_mmcfg_list
>
> The patchset is against 4.4-rc6, but it can be applied to pci/next
> with a very minor fixup.  This is tested with arm64 QEMU and OVMF
> and on x86 with qemu.

Are there any specific problems that Tomasz didn't address in this
patch set?

https://lkml.org/lkml/2015/12/16/246

As Lorenzo pointed out, that patch set was going several rounds and
addressed lots of comments, why not comment on it and push it forward
together?

Thanks
Hanjun
