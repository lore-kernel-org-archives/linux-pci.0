Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:62093 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503AbbLRMmP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2015 07:42:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net,
	hanjun.guo@linaro.org, Lorenzo.Pieralisi@arm.com,
	okaya@codeaurora.org, jiang.liu@linux.intel.com,
	Stefano.Stabellini@eu.citrix.com, jchandra@broadcom.com,
	jcm@redhat.com, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	wangyijing@huawei.com, tglx@linutronix.de, mw@semihalf.com
Subject: Re: [PATCH V2 21/23] pci, acpi: Support for ACPI based PCI hostbridge init
Date: Fri, 18 Dec 2015 13:40:50 +0100
Message-ID: <2277339.U6fWlSIDzy@wuerfel>
In-Reply-To: <1450278993-12664-22-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com> <1450278993-12664-22-git-send-email-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 16 December 2015 16:16:31 Tomasz Nowicki wrote:
> Because of two patch series:
> 1. Jiang Liu's common interface to support PCI host bridge init
> 2. MMCONFIG refactoring (part of this patch set)
> now we can think about generic ACPI based PCI host bridge driver
> out of arch/ directory.
> 
> This driver use information from MCFG table (PCI config space regions)
> and _CRS method (IO/irq resources) to initialize PCI hostbridge.
> 
> TBD: We are still not sure whether we should reassign resources
> after PCI bus enumeration or trust firmware to do all that work for
> us properly.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Liviu Dudau <Liviu.Dudau@arm.com>
> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 

I think this code could better live in drivers/acpi/pci_root.c
along with all the related functions. It's not really a driver
by itself and cannot be a loadable module or built on other
architectures.

You can put all the code inside an #ifdef ARCH_PCI_HOST_GENERIC_ACPI
there.

	Arnd
