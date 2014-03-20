Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-de.keymile.com ([195.8.104.250]:47495 "EHLO
	mail-de.keymile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbaCTKoM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Mar 2014 06:44:12 -0400
Message-ID: <532AC673.5070308@keymile.com>
Date: Thu, 20 Mar 2014 11:44:03 +0100
From: Valentin Longchamp <valentin.longchamp@keymile.com>
MIME-Version: 1.0
To: Johannes Thumshirn <johannes.thumshirn@men.de>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: EDAC PCIe errors when scannning the bus
References: <532991AD.6020903@keymile.com> <20140319155404.GA2045@jtlinux>
In-Reply-To: <20140319155404.GA2045@jtlinux>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Johannes,

On 03/19/2014 04:54 PM, Johannes Thumshirn wrote:
> On Wed, Mar 19, 2014 at 01:46:37PM +0100, Valentin Longchamp wrote:
>> Hello,
>>
>> We have a board that is based on Freescale's P2041 SoC. The boards has 2 PCIe
>> buses with this topology:
>>
>> PCIe 0 <---> PEX8505 switch <---> 4 network devices
>> PCIE 2 <---> FPGA
>>
>> On 3.10.33 + a subset of the Freescale SDK 1.4 patches, both PCIe buses work
>> well and we are able to use the devices on them.
>>
>> For each bus, I however keep getting EDAC PCIe errors at the very first stage of
>> bus enumeration (please see the attached kernel log, with some debug output from
>> arch/powerpc/kernel/pci-common.c and drivers/pci/probe.c) for both buses.
>>
>> My current "understanding" of the situation is such: since PCI_PROBE_NORMAL is
>> used, pcibios_scan_phb() calls pci_scan_child_bus() that does a pci_scan_slot()
>> on the bus for 32 slots. The first pci_scan_slot() is successful and it
>> discovers the P2041's PCIe Controller. All the 31 other pci_scan_slot() calls
>> generate an EDAC PCIe error, that is triggered by the configuration read
>> transaction to read an hypothetical vendor ID of a device on the bus. This is
>> relevant with that is reported by the EDAC error handler (all the 31 are the same):
>>
>>> PCIE error(s) detected
>>> PCIE ERR_DR register: 0x00020000
>>
>> ICCA bit is set: Access to an illegal configuration space from
>> PEX_CONFIG_ADDR/PEX_CONFIG_DATA was detected.
>>
>>> PCIE ERR_CAP_STAT register: 0x80000001
>>
>> To is set: Transaction originated from PEX_CONFIG_ADDR/PEX_CONFIG_DATA.
>>
>>> PCIE ERR_CAP_R0 register: 0x00000800
>>
>> FMT: 0b00, TYPE: 0b00100 (Config read I guess)
>>
>>> PCIE ERR_CAP_R1 register: 0x00000000
>>> PCIE ERR_CAP_R2 register: 0x00000000
>>> PCIE ERR_CAP_R3 register: 0x00000000
>>
>> Afterwards, pci_scan_child_bus() calls pcibios_fixup_bus (that maybe helps ?).
>> From here, since the P2041's PCIe Controller is a bridge, pci_scan_bridge is
>> called for this bus and all the devices are detected without having any
>> configuration transaction causing EDAC errors.
>>
>> Has someone already observed such a behavior ? Why do these initial transaction
>> generate an error ? What would be a possible fix to avoid these transaction
>> errors for these 31 (unneded ?) pci_scan_slot() calls on the initial bus ?
>>
> 
> I've encountered similar problems on a P4080 based design (mine has additional
> machine checks that cause an oops). I haven't solved it yet, so I unfortunately
> can't offer you a fix. But I was told there are some errata workarounds that
> more or less could have an impact on PCIe behavior. Could you show me the output
> of U-Boot's errata command?

Here is the output for the errata command:

> => errata
> Work-around for Erratum CPU-A003999 enabled
> Work-around for Erratum DDR-A003473 enabled
> Work-around for Erratum ESDHC111 enabled
> Work-around for Erratum DDR-A003 enabled
> Work-around for Erratum A004510 enabled
> Work-around for Erratum SRIO-A004034 enabled
> Work-around for Erratum A004849 is not enabled
> Work-around for Erratum A004580 is not enabled
> Work-around for Erratum USB14 enabled

> 
> Especially if the workarounds for A-004580 and A-004849 are in place.
> 

So both are not enabled, I am going to fix that. Surprisingly, A-004580 is not
defined for the P2041 in u-boot even though it is also present in the P2041's
errata sheet, I had to enable it myself.

However, I expect that enabling the workarounds for these 2 Errata are good for
the system but it will not solve the PCIe EDAC problem.

Thank you for the input.

Valentin
