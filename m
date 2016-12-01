Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753256AbcLAQbS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 11:31:18 -0500
Date: Thu, 1 Dec 2016 10:31:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v10 00/12] PCI: ARM64 ECAM quirks
Message-ID: <20161201163105.GB19681@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <d3f1a4ca-99e6-f0a5-d20b-d2753058d93d@huawei.com>
 <8f4a67d4-549a-34e9-8ef7-ec99961d60e5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8f4a67d4-549a-34e9-8ef7-ec99961d60e5@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 10:04:48PM +0800, Dongdong Liu wrote:
> ... 
> Aftet fixing the compile errors. I tested on HiSilicon D03 board. It works ok.
> The dmesg is as below

Thanks very much for testing this!  A few comments below.

> root@(none)$ dmesg
> [    0.000000] Booting Linux on physical CPU 0x10000
> [    0.000000] Linux version 4.9.0-rc1-gaf05ef2-dirty (l00290354@linux-ioko) (gcc version 4.9.3 20150211 (prerelease) (20150316) ) #257 SMP PREEMPT Thu Dec 1 22:13:05 CST 2016
> [    0.000000] Boot CPU: AArch64 Processor [411fd071]
> [    0.000000] earlycon: hisilpcuart0 at MMIO 0x00000000a01b0000 (options '0,0x2f8')
> [    0.000000] bootconsole [hisilpcuart0] enabled
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: EFI v2.60 by EDK II
> [    0.000000] efi:  SMBIOS=0x3f110000  SMBIOS 3.0=0x39ce0000  ACPI=0x39db0000  ACPI 2.0=0x39db0014  MEMATTR=0x3c945018

On x86 we normally have info about the machine and BIOS, e.g.,

  DMI: LENOVO 20FCS12V03/20FCS12V03, BIOS N1FET40W (1.14 ) 04/18/2016

I think this comes from dmi_present(), and it looks like we should
call that via arm64_dmi_init().  Any idea why we don't see that info?
Is it just missing from the SMBIOS table?  I think it's useful to
have for debugging problems.

> [    2.109466] ACPI: MCFG table detected, 3 entries
> [    2.132280] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
> [    2.139416] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments MSI]
> [    2.147563] acpi PNP0A08:00: _OSC failed (AE_NOT_FOUND); disabling ASPM

Per the PCI Firmware spec, r3.2, sec 4.5.1, _OSC is required for host
bridges that originate PCIe hierarchies.  So the lack of one here
looks like a firmware defect.

> [    2.155225] acpi PNP0A08:00: MCFG quirk: ECAM at [mem 0xb0000000-0xb1ffffff] for [bus 00-1f] with hisi_pcie_ops
> [    2.167558] acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0xb0000000-0xb1ffffff] not reserved in ACPI namespace

This is what I expected.  Apparently your DSDT doesn't contain a
PNP0C02 device that reserves the ECAM space, so we warn about it.  I
expect that if you look at /proc/iomem, we should still see the
reservation done by pci_ecam_create().

> [    2.179629] acpi PNP0A08:00: ECAM at [mem 0xb0000000-0xb1ffffff] for [bus 00-1f]

> [    2.297714] ACPI: PCI Root Bridge [PCI1] (domain 0001 [bus e0-ff])
> [    2.320388] acpi PNP0A08:01: MCFG quirk: ECAM at [mem 0xbe000000-0xbfffffff] for [bus e0-ff] with hisi_pcie_ops
> [    2.332547] acpi PNP0A08:01: [Firmware Bug]: ECAM area [mem 0xbe000000-0xbfffffff] not reserved in ACPI namespace
> [    2.344507] acpi PNP0A08:01: ECAM at [mem 0xbe000000-0xbfffffff] for [bus e0-ff]

> [    2.494568] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 80-9f])
> [    2.517222] acpi PNP0A08:02: MCFG quirk: ECAM at [mem 0xa8000000-0xa9ffffff] for [bus 80-9f] with hisi_pcie_ops
> [    2.529349] acpi PNP0A08:02: [Firmware Bug]: ECAM area [mem 0xa8000000-0xa9ffffff] not reserved in ACPI namespace
> [    2.541330] acpi PNP0A08:02: ECAM at [mem 0xa8000000-0xa9ffffff] for [bus 80-9f]

> [    3.015076] system 00:00: [mem 0xa0090000-0xa009ffff] has been reserved
> [    3.022595] system 00:00: [mem 0xb0000000-0xb01fffff] could not be reserved
> [    3.030505] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)

Huh.  This PNP0C02 device reserves *part* of the PNP0A08:00 ECAM
space, but not all of it.  Is this just a typo in the PNP0C02 _CRS,
i.e., somebody wrote a size of "0x001fffff" instead of "0x01ffffff"?

> [    3.030567] system 00:01: [mem 0xa0200000-0xa020ffff] has been reserved
> [    3.038058] system 00:01: [mem 0xbe000000-0xbe1fffff] could not be reserved
> [    3.045967] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)

Same here?  This reserves part of the PNP0A08:01 ECAM space.

> [    3.046031] system 00:02: [mem 0xa00a0000-0xa00affff] has been reserved
> [    3.053529] system 00:02: [mem 0xa8000000-0xa81fffff] could not be reserved
> [    3.061424] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)

And here for PNP0A08:02?

> [    3.681559] pcieport 0000:00:00.0: can't derive routing for PCI INT A
> [    3.688840] pcieport 0000:00:00.0: PCI INT A: no GSI

Is something wrong with your _PRT?

> [    3.694505] pcieport 0001:e0:00.0: can't derive routing for PCI INT A
> [    3.701786] pcieport 0001:e0:00.0: PCI INT A: no GSI
> [    3.707428] pcieport 0002:80:00.0: can't derive routing for PCI INT A
> [    3.714707] pcieport 0002:80:00.0: PCI INT A: no GSI
> [    3.720344] pcieport 0002:80:00.0: can't derive routing for PCI INT A
> [    3.727624] pcieport 0002:81:00.0: PCI INT A: no GSI
> [    3.733413] pcieport 0002:80:00.0: can't derive routing for PCI INT A
> [    3.740694] pcieport 0002:82:00.0: PCI INT A: no GSI
> [    3.746451] pcieport 0002:80:00.0: can't derive routing for PCI INT A
> [    3.753735] pcieport 0002:82:01.0: PCI INT A: no GSI
> [    3.759489] pcieport 0002:80:00.0: can't derive routing for PCI INT A
> [    3.766772] pcieport 0002:82:02.0: PCI INT A: no GSI
> [    3.772524] pcieport 0002:80:00.0: can't derive routing for PCI INT A
> [    3.779807] pcieport 0002:82:08.0: PCI INT A: no GSI
