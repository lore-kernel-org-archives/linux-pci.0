Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36496 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbcBEIno (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Feb 2016 03:43:44 -0500
Received: by mail-yw0-f178.google.com with SMTP id q190so45836440ywd.3
        for <linux-pci@vger.kernel.org>; Fri, 05 Feb 2016 00:43:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160205001907.GJ7031@localhost>
References: <1454058340-7904-1-git-send-email-jchandra@broadcom.com>
 <1454058340-7904-6-git-send-email-jchandra@broadcom.com> <20160205001907.GJ7031@localhost>
From: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
Date: Fri, 5 Feb 2016 14:05:37 +0530
Message-ID: <CAKc_7PXYtFt1MQE-UGO0O5vvQ+xFKa2b5=F8wXB=EN-JUJVzZw@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] PCI: ACPI: Add a generic ACPI based host controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jayachandran C <jchandra@broadcom.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On Fri, Feb 5, 2016 at 5:49 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Jayachandran,
>
> On Fri, Jan 29, 2016 at 02:35:40PM +0530, Jayachandran C wrote:
>> Add a simple ACPI based PCI host controller under config option
>> ACPI_PCI_HOST_GENERIC. This is done by providing an implementation
>> of pci_acpi_scan_root().
>>
>> The pci_mmcfg_list handling is done by the ACPI code, so we keep a
>> reference to the pci_mmcfg_region in sysdata. The ECAM region will
>> be already mapped, so map_bus can be implemented by using the
>> virt pointer for the pci_mmcfg_region. pci_generic_config_read
>> and pci_generic_config_write are used for config space read/write.
>>
>> Also, we provide implementations of raw_pci_read and raw_pci_write
>> hat are needed by ACPI based on the pci_mmcfg_list.
>>
>> pci_acpi_set_companion() and acpi_pci_get_segment() are defined
>> using sysdata of generic ACPI host controller so that PCI domain
>> and ACPI companion are set in PCI code rather than platform code.
>>
>> This code is currently enabled only for ARM64.
>>
>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
>> ---
>>  drivers/acpi/Kconfig         |   8 ++
>>  drivers/acpi/Makefile        |   1 +
>>  drivers/acpi/pci_host_acpi.c | 186 +++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci-acpi.h     |  17 ++++
>>  4 files changed, 212 insertions(+)
>>  create mode 100644 drivers/acpi/pci_host_acpi.c
>
> I'm speaking a little bit out of turn here, because this is ACPI code,
> but I'm confused about pci_host_acpi.c.  We already have pci_root.c,
> which is *supposed* to be arch-independent.  I know pci_root.c is
> crufty and could be improved, but it does work today on x86 and ia64,
> and it handles some generic things that pci_host_acpi.c does not,
> e.g., _OSC, NUMA, host bridge hotplug, etc.
>
> I'd really like to see pci_root.c improved so it could work on x86,
> ia64, and arm64.  I'm sure that was probably the first thing you
> tried, so likely there are issues there.  Are they insurmountable?

pci_root.c leaves the implementation of pci_acpi_scan_root() to the
architecture. Implementing pci_acpi_scan_root needs a
pci_acpi_root_ops instance and a pci_ops instance and related functions.
The architecture is also expected to implement raw_pci_read and
raw_pci_write.

pci_host_acpi.c is a generic implementation of these using a sysdata
pointing to acpi_pci_root_info, and using a pointer to the pci_mmcfg_region
to access ECAM area, Maybe I can rename this file to
pci_acpi_host_generic.c to reflect this better.

arm64 is the only user of this generic implementation now. The config
option CONFIG_ACPI_PCI_HOST_GENERIC has to be set on the
architecture that chooses to use this generic code instead of its own
implementation.

JC.
{Sorry if the formatting is wrong, using webmail due to internal IT changes]
