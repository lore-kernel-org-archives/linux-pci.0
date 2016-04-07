Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:4701 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbcDGHI3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Apr 2016 03:08:29 -0400
Message-ID: <5706076B.3080608@intel.com>
Date: Thu, 07 Apr 2016 15:08:27 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
CC: bhelgaas@google.com
Subject: Re: [RFC v3] PCI: PTM Driver
References: <1458705848-26056-1-git-send-email-jonathan.yong@intel.com>
In-Reply-To: <1458705848-26056-1-git-send-email-jonathan.yong@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/23/2016 12:04, Yong, Jonathan wrote:
> Hello LKML,
>
> This is a preliminary implementation of the PTM[1] support driver, the code
> is obviously hacked together and in need of refactoring. This driver has
> only been tested against a virtual PCI bus.
>
> The drivers job is to get to every PTM capable device, set some PCI config
> space bits, then go back to sleep [2].
>
> PTM capable PCIe devices will get a new sysfs entry to allow PTM to be
> enabled if automatic PTM activation is disabled, or disabled if so desired.
>
> Comments? Should I explain the PTM registers in more details?
> Please CC me, thanks.
>
> [1] Precision Time Measurement: A protocol for synchronizing PCIe endpoint
> clocks against the host clock as specified in the PCI Express Base
> Specification 3.1. It is identified by the 0x001f extended capability ID.
>
> PTM capable devices are split into 3 roles, master, responder and requester.
> Summary as follows:
>
> A master holds the master clock that will be used for all devices under its
> domain (not to be confused with PCI domains). There may be multiple masters
> in a PTM hierarchy, in which case, the highest master closest to the root
> complex will be selected for the PTM domain. A master is also always
> responder capable. Clock precision is signified by a Local Clock
> Granularity field, in nano-seconds.
>
> A responder responds to any PTM synchronization requests from a downstream
> device. A responder is typically a switch device. It may also hold a local
> clock signified by a non-zero Local Clock Granularity field. A value of 0
> signifies that the device simply propagates timing information from
> upstream devices.
>
> A requester is typically an endpoint that will request synchronization
> updates from an upstream PTM capable time source. The driver will update
> the Effective Clock Granularity field based on the same field from the
> PTM domain master. The field should be programmed with a value of 0 if any
> intervening responder has a Local Clock Granularity field value of 0.
>
> [2] The software drivers never see the PTM packets, the PCI Express Base
> Specification 3.1 reads:
> 	PTM capable components can make their PTM context available for
> 	inspection by software, enabling software to translate timing
> 	information between local times and PTM Master Time.
>
> This isn't very informative.
>
> Changes since v1:
> * Moved register constants to pci_regs.h
> * Use pci_dev to hold PTM status
> * PTM initialization now done top-down hierarchy wise.
>
> Changes since v2:
> * Added missing void return in the pci_ptm_init inline stub.
>
> Yong, Jonathan (1):
>    PCI: PTM preliminary implementation
>
>   drivers/pci/pci-sysfs.c       |   7 ++
>   drivers/pci/pci.h             |  25 +++++
>   drivers/pci/pcie/Kconfig      |   8 ++
>   drivers/pci/pcie/Makefile     |   2 +-
>   drivers/pci/pcie/pcie_ptm.c   | 212 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/pci/probe.c           |   3 +
>   include/linux/pci.h           |   9 ++
>   include/uapi/linux/pci_regs.h |  12 +++
>   8 files changed, 277 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/pci/pcie/pcie_ptm.c
>

Ping?

