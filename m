Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.bemta12.messagelabs.com ([216.82.251.1]:15217 "EHLO
	mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754699AbcDFWyu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 6 Apr 2016 18:54:50 -0400
From: Andrew Wray <awray@lenovo.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: FW: lspci doesn't decode physical slot correctly for adapters with
 PLX bridges
Date: Wed, 6 Apr 2016 22:53:52 +0000
Message-ID: <9B943C44AF111241BB5478325481A9DD288AF8A8@AEMAILMBX03.lenovo.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On a Lenovo x3550 M5 system, with a multiport SAS HBA, lspci didn't decode the physical slot for the adapter correctly.

To clarify, the issue isn't with the dmidecode output, or the ACPI/SMBIOS tables on our systems, or the 'lspci' or 'lspci -t' output, but specficially the output of:

lspci -s <PCI bus:dev.func> -vvv | grep 'Physical Slot'

when the PCI bus:dev.func is used for an adapter that has a PLX bridge on it.  That is, the PCI bus:dev.func is used from running lspci | grep <substring of name of adapter> (that is, the PCI bus:dev.func is that of one of the PCI devices on the adapter, not the values for the slot, or the PLX itself).

The expectation is that if lspci is going to report a physical slot, it needs to back trace the PCI tree to a PCI bus:dev.func that corresponds to a slot, and report the information from there.

Here's an example:

In a particular DaAn (node n505) there is an Outback-4 card (N2226 12 Gbps SAS HBA) in slot 2.  The card can be found in lspci as follows:

> n505:~ # lspci | grep -i LSI
> 83:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS3008 PCI-Express Fusion-MPT SAS-3 (rev 02)
> 86:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS3008 PCI-Express Fusion-MPT SAS-3 (rev 02)

When checking the physical slot with lspci, for the first ASIC on the card (both lines above are from the same adapter), a clearly incorrect slot is shown:

> n505:~ # lspci -s 83:00.0 -vvv | grep 'Physical Slot'
>         Physical Slot: 64

Checking lspci -t -vvv, the PCI hierarchy for the card can be seen:

>  +-[0000:80]-+-02.0-[81-87]----00.0-[82-87]--+-00.0-[83-84]----00.0  LSI Logic / Symbios Logic SAS3008 PCI-Express Fusion-MPT SAS-3
>  |           |                               +-08.0-[85]--
>  |           |                               \-09.0-[86-87]----00.0  LSI Logic / Symbios Logic SAS3008 PCI-Express Fusion-MPT SAS-3

Going back up towards the root, we see 81-87, which is the only match to the dmidecode -t 9 output:

> # dmidecode 2.12
> # SMBIOS entry point at 0x793fe000
> SMBIOS 3.0 present.
> # SMBIOS implementations newer than version 2.8 are not
> # fully supported by this version of dmidecode.
>
> Handle 0x0039, DMI type 9, 17 bytes
> System Slot Information
>       Designation: Slot 1
>       Type: x16 PCI Express 3 x16
>       Current Usage: In Use
>       Length: <OUT OF SPEC>
>       ID: 1
>       Characteristics:
>               3.3 V is provided
>       Bus Address: 0000:06:00.0
>
> Handle 0x003A, DMI type 9, 17 bytes
> System Slot Information
>       Designation: Slot 2
>       Type: x16 PCI Express 3 x16
>       Current Usage: In Use
>       Length: <OUT OF SPEC>
>       ID: 2
>       Characteristics:
>               3.3 V is provided
>       Bus Address: 0000:81:00.0
>
> Handle 0x003B, DMI type 9, 17 bytes
> System Slot Information
>       Designation: Slot 3
>       Type: x16 PCI Express 3 x16
>       Current Usage: In Use
>       Length: <OUT OF SPEC>
>       ID: 3
>       Characteristics:
>               3.3 V is provided
>       Bus Address: 0000:0b:00.0
>
> Handle 0x003C, DMI type 9, 17 bytes
> System Slot Information
>       Designation: Slot 4
>       Type: x8 PCI Express 3 x8
>       Current Usage: Available
>       Length: <OUT OF SPEC>
>       ID: 4
>       Characteristics:
>               3.3 V is provided
>       Bus Address: 0000:ff:1e.7

Which then does correspond to slot 2.

If lspci went back up towards the PCI root to get the 81-87 value, it could have reported the correct PCI slot.

The latest pciutils package from http://mj.ucw.cz/sw/pciutils/ (version 3.4.1) was download and built from source (the above output was from the built-in pciutils packages in RHELS 7.2 and SLES 12.1).  This version has the same issue.


Thanks,

Andy  Wray

