Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 22 Apr 2016 18:08:59 +0200
From: Robert Richter <robert.richter@caviumnetworks.com>
To: Tomasz Nowicki <tn@semihalf.com>
CC: <helgaas@kernel.org>, <arnd@arndb.de>, <will.deacon@arm.com>,
	<catalin.marinas@arm.com>, <rafael@kernel.org>,
	<hanjun.guo@linaro.org>, <Lorenzo.Pieralisi@arm.com>,
	<okaya@codeaurora.org>, <jiang.liu@linux.intel.com>,
	<jchandra@broadcom.com>, <mw@semihalf.com>, <Liviu.Dudau@arm.com>,
	<ddaney@caviumnetworks.com>, <wangyijing@huawei.com>,
	<Suravee.Suthikulpanit@amd.com>, <msalter@redhat.com>,
	<linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linaro-acpi@lists.linaro.org>, <jcm@redhat.com>
Subject: Re: [PATCH V6 00/13] Support for generic ACPI based PCI host
 controller
Message-ID: <20160422160859.GF24726@rric.localdomain>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1460740008-19489-1-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 15.04.16 19:06:35, Tomasz Nowicki wrote:
> From the functionality point of view this series might be split into the
> following logic parts:
> 1. Necessary fixes as the preparation for using driver on ARM64.
> 2. New ECAM API and update for users of the pci-host-common API
> 3. Use new MCFG interface and implement generic ACPI based PCI host controller driver.
> 4. Enable above driver on ARM64
> 
> Patches has been built on top of 4.6-rc2 and can be found here:
> git@github.com:semihalf-nowicki-tomasz/linux.git (pci-acpi-v6)
> 
> This has been tested on Cavium ThunderX server. Any help in reviewing and
> testing is very appreciated.

For the whole series:

Tested-by: Robert Richter <rrichter@cavium.com>
Acked-by: Robert Richter <rrichter@cavium.com>

-Robert

> v5 -> v6
> - dropped idea of x86 MMCONFIG code refactoring
> - integrated JC's patches which introduce new ECAM API:
>   https://lkml.org/lkml/2016/4/11/907
>   git: https://github.com/jchandra-brcm/linux/ (arm64-acpi-pci-v3)
> - integrated Sinan's fix for releasing IO resources, see patch [06/13]
> - added ACPI support for ThunderX ECAM and PEM drivers
> - rebased to 4.6-rc2
> 
> v4 -> v5
> - dropped MCFG refactoring group patches 1-6 from series v4 and integrated Jayachandran's patch
>   https://patchwork.ozlabs.org/patch/575525/
> - rewrite PCI legacy IRQs allocation
> - squashed two patches 11 and 12 from series v4, fixed bisection issue
> - changelog improvements
> - rebased to 4.5-rc3
> 
> v3 -> v4
> - dropped Jiang's fix http://lkml.iu.edu/hypermail/linux/kernel/1601.1/04318.html
> - added Lorenzo's fix patch 19/24
> - ACPI PCI bus domain number assigning cleanup
> - changed resource management, we now claim and reassign resources
> - improvements for applying quirks
> - dropped Matthew's http://www.spinics.net/lists/linux-pci/msg45950.html dependency
> - rebased to 4.5-rc1
> 
> v2 -> v3
> - fix legacy IRQ assigning and IO ports registration
> - remove reference to arch specific companion device for ia64
> - move ACPI PCI host controller driver to pci_root.c
> - drop generic domain assignment for x86 and ia64 as I am not
>   able to run all necessary test variants
> - drop patch which cleaned legacy IRQ assignment since it belongs to
>   Mathew's series:
>   https://patchwork.ozlabs.org/patch/557504/
> - extend MCFG quirk code
> - rebased to 4.4
> 
> v1 -> v2
> - moved non-arch specific piece of code to dirver/acpi/ directory
> - fixed IO resource handling
> - introduced PCI config accessors quirks matching
> - moved ACPI_COMPANION_SET to generic code
> 
> v1 - https://lkml.org/lkml/2015/10/27/504
> v2 - https://lkml.org/lkml/2015/12/16/246
> v3 - http://lkml.iu.edu/hypermail/linux/kernel/1601.1/04308.html
> v4 - https://lkml.org/lkml/2016/2/4/646
> v5 - https://lkml.org/lkml/2016/2/16/426
