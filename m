Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:51387 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752591Ab3CFKcm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Mar 2013 05:32:42 -0500
Message-ID: <51371B48.1030003@fold.natur.cuni.cz>
Date: Wed, 06 Mar 2013 11:32:40 +0100
From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Yinghai Lu <yinghai@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linux-pci@vger.kernel.org
Subject: Re: Dell Vostro 3550: pci_hotplug+acpiphp require 'pcie_aspm=force'
 on kernel command-line for hotplug to work
References: <50EDF8FE.6040607@fold.natur.cuni.cz> <CAE9FiQXoEWifAoJQ9-aROBo3KJDcMGPb-5+PH=GiD2PD1Ze9bw@mail.gmail.com> <50EE21AA.2090004@fold.natur.cuni.cz> <1429112.6nE7RrQN1L@vostro.rjw.lan>
In-Reply-To: <1429112.6nE7RrQN1L@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looks I never answered this ... :(

Rafael J. Wysocki wrote:
> On Thursday, January 10, 2013 03:04:26 AM Martin Mokrejs wrote:
>> Hi Yinghai,
>>   thank you for you answer, it is way too late here but a quick answer ...
>>
>> Yinghai Lu wrote:
>>> On Wed, Jan 9, 2013 at 3:10 PM, Martin Mokrejs
>>> <mmokrejs@fold.natur.cuni.cz> wrote:
>>>> - pci0000:00: Requesting ACPI _OSC control (0x1d)
>>>> - pci0000:00: ACPI _OSC control (0x19) granted
>>>> + pci0000:00: Unable to request _OSC control (_OSC support mask: 0x19)
>>>
>>> according to _OSC related game in acpi_pci_root_add()
>>> it will query_osc_support with flags |=
>>>                                 OSC_EXT_PCI_CONFIG_SUPPORT \
>>>                                 | OSC_ACTIVE_STATE_PWR_SUPPORT \
>>>                                 | OSC_CLOCK_PWR_CAPABILITY_SUPPORT \
>>>                                 | OSC_MSI_SUPPORT
>>> and the firmware should not return ACPI FAILURE, and if it return
>>> failure, flags will get reset.
>>>
>>> then if and only if flags keep there five bits, kernel will try to set control
>>> to _OSC for
>>>                         OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
>>>                         | OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
>>>                         | OSC_PCI_EXPRESS_PME_CONTROL;
>>> and may be AER.
>>>
>>> that will let pciehp own the device <pciehp will claim that later...>
>>>
>>> in acpiphp there is module that will check if port is owned by pciehp,
>>> and it will bail out early.
>>> in device_is_managed_by_native_pciehp...
>>>
>>> pcie_aspm=off will stop all _osc setting, like pciehp, pme and aer.
>>>
>>> the checking in acpiphp is introduced by:
>>> commit 0d52f54e2ef64c189dedc332e680b2eb4a34590a
>>> Author: Rafael J. Wysocki <rjw@sisk.pl>
>>> Date:   Sat Oct 22 00:43:38 2011 +0200
>>>
>>>     PCI / ACPI: Make acpiphp ignore root bridges using PCIe native hotplug
>>>
>>> so it is a regression.
>>
>> It is true that since the time around 3.3.x when I reported the problem I had in
>> grub.conf kept pcie_aspm=force.
> 
> Have you tried pcie_ports=compat?
> 
> This is the command line option to use in such cases, in theory.

No, I did not know about this option. I can redo some tests if you want.

Martin
