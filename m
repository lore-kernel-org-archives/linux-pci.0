Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:51894 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224Ab3AJAkp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 19:40:45 -0500
Received: by mail-bk0-f50.google.com with SMTP id jf3so1268477bkc.37
        for <linux-pci@vger.kernel.org>; Wed, 09 Jan 2013 16:40:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50EDF8FE.6040607@fold.natur.cuni.cz>
References: <50EDF8FE.6040607@fold.natur.cuni.cz>
Date: Wed, 9 Jan 2013 16:40:44 -0800
Message-ID: <CAE9FiQXoEWifAoJQ9-aROBo3KJDcMGPb-5+PH=GiD2PD1Ze9bw@mail.gmail.com>
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
From: Yinghai Lu <yinghai@kernel.org>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 9, 2013 at 3:10 PM, Martin Mokrejs
<mmokrejs@fold.natur.cuni.cz> wrote:
> - pci0000:00: Requesting ACPI _OSC control (0x1d)
> - pci0000:00: ACPI _OSC control (0x19) granted
> + pci0000:00: Unable to request _OSC control (_OSC support mask: 0x19)

according to _OSC related game in acpi_pci_root_add()
it will query_osc_support with flags |=
                                OSC_EXT_PCI_CONFIG_SUPPORT \
                                | OSC_ACTIVE_STATE_PWR_SUPPORT \
                                | OSC_CLOCK_PWR_CAPABILITY_SUPPORT \
                                | OSC_MSI_SUPPORT
and the firmware should not return ACPI FAILURE, and if it return
failure, flags will get reset.

then if and only if flags keep there five bits, kernel will try to set control
to _OSC for
                        OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
                        | OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
                        | OSC_PCI_EXPRESS_PME_CONTROL;
and may be AER.

that will let pciehp own the device <pciehp will claim that later...>

in acpiphp there is module that will check if port is owned by pciehp,
and it will bail out early.
in device_is_managed_by_native_pciehp...

pcie_aspm=off will stop all _osc setting, like pciehp, pme and aer.

the checking in acpiphp is introduced by:
commit 0d52f54e2ef64c189dedc332e680b2eb4a34590a
Author: Rafael J. Wysocki <rjw@sisk.pl>
Date:   Sat Oct 22 00:43:38 2011 +0200

    PCI / ACPI: Make acpiphp ignore root bridges using PCIe native hotplug

so it is a regression.

Rafael,

can you fix that? otherwise user will have specify weird
"pcie_aspm=off" to make acpiphp working.

looks like we need to have other way to do handshaking between pciehp
and acpiphp.

Thanks

Yinghai
