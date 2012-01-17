Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from coyote.quickmin.net ([217.14.112.24]:53775 "EHLO
	coyote.quickmin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab2AQKAW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2012 05:00:22 -0500
From: Roman Fietze <roman.fietze@telemotive.de>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: PCIe ASPM, PCI Bridges, e.g. PEX8311
Date: Tue, 17 Jan 2012 10:53:38 +0100
Cc: linux-pci@vger.kernel.org
MIME-Version: 1.0
Message-Id: <201201171053.38531.roman.fietze@telemotive.de>
Content-Type: Text/Plain;
  charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Kenji, hello Linux PCI list members,

Using the current code it seems, that I cannot use ASPM on links
between any PCIe node and a PCI(e) bridge.

The current ASPM code in drivers/pci/pcie/aspm.c contains the
following statements inside pcie_aspm_cap_init(), as of the current
HEAD around line 402-410:

	list_for_each_entry(child, &linkbus->devices, bus_list) {
		if (child->pcie_type == PCI_EXP_TYPE_PCI_BRIDGE) {
			link->aspm_disable = ASPM_STATE_ALL;
			break;
		}
	}

I simply do not yet understand, why this is necessary. Is this
required by the PCI(e) specification (1), or would enabling ASPM cause
problems with the current code as it is right now (2)?

If (2), would it be a solution to check which kind of PCI- bridge the
device is, mainly checking if it is a PCIe-PCIe bridge or if it
connects only to one PCIe link?

Anything that could get me started, or stops me right here, would be
very helpful.


PCI layout of our board:

00:00.0 Host bridge: Intel Corporation System Controller Hub (SCH Poulsbo) (rev 07)
..
00:1c.1 PCI bridge: Intel Corporation System Controller Hub (SCH Poulsbo) PCI Express Port 2 (rev 07)
..
02:00.0 PCI bridge: PLX Technology, Inc. PEX 8509 8-lane, 8-port PCI Express Switch (rev aa)
03:01.0 PCI bridge: PLX Technology, Inc. PEX 8509 8-lane, 8-port PCI Express Switch (rev aa)
03:02.0 PCI bridge: PLX Technology, Inc. PEX 8509 8-lane, 8-port PCI Express Switch (rev aa)
..
.. (8 -ports, downstream on on 03:0[1-7].0, see below)
..
03:07.0 PCI bridge: PLX Technology, Inc. PEX 8509 8-lane, 8-port PCI Express Switch (rev aa)
04:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
05:00.0 PCI bridge: PLX Technology, Inc. PEX 8111 PCI Express-to-PCI Bridge (rev 21)
06:04.0 Bridge: PLX Technology, Inc. Device 3456 (rev ba)
07:00.0 PCI bridge: PLX Technology, Inc. PEX 8111 PCI Express-to-PCI Bridge (rev 21)
08:04.0 Bridge: PLX Technology, Inc. Device 3455 (rev ba)
..

-[0000:00]-+-00.0
           +-02.0
           +-1a.0
           +-1c.0-[01]----00.0
           +-1c.1-[02-0c]----00.0-[03-0c]--+-01.0-[04]----00.0
           |                               +-02.0-[05-06]--*--00.0-[06]----04.0
           |                               +-03.0-[07-08]--*--00.0-[08]----04.0
           |                               +-04.0-[09]----00.0
           |                               +-05.0-[0a]--
           |                               +-06.0-[0b]--
           |                               \-07.0-[0c]--
           +-1d.0
           +-1d.1
           +-1d.2
           +-1d.7
           +-1f.0
           \-1f.1

The two devices 05:00.0 and 07:00.0 are members of a PEX8311, which
internally contains a PEX8111 PCIe-PCI-X bridge and a PCI-X-Localbus
bridge, the EP 04.0). They both are marked as PCI_EXP_TYPE_PCI_BRIDGE,
and therefore I cannot enable ASPM on the PCIe links on the buses 05
and 07 (marked with a * in the lspci -t output above).

Test scenario:

- enable ASPM by setting the appropriate bits in the 8509 and the 8111
  PECS of 03:03.0, 03:04.0, 05:00.0 and 07:00.0

- enable ASPM in the kernel using /sys/module/pcie_aspm/parameters/policy


Roman

-- 
Roman Fietze              Telemotive AG Buero Muehlhausen
Breitwiesen                             73347 Muehlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
