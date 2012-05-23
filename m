Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:50299 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab2EWCaq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2012 22:30:46 -0400
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 708BE3EE0BC
	for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 11:30:45 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5B15A45DE4F
	for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 11:30:45 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 44EEE45DE4E
	for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 11:30:45 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 38DF71DB803B
	for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 11:30:45 +0900 (JST)
Received: from m0001.s.css.fujitsu.com (m0001.s.css.fujitsu.com [10.23.4.186])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id ECE7F1DB802F
	for <linux-pci@vger.kernel.org>; Wed, 23 May 2012 11:30:44 +0900 (JST)
Message-ID: <4FBC4C86.9050206@jp.fujitsu.com>
Date: Wed, 23 May 2012 11:33:42 +0900
From: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	jbarnes@virtuousgeek.org, benh@kernel.crashing.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] Add pcibios_device_change_notifier
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset is for PCI hotplug.


pcibios_setup_bus_devices which sets DMA and IRQs of PCI device is called
only when boot. DMA setting in probe for PCI driver, like dma_set_mask,
does not work on powerpc platform. So it is need to set DMA and IRQs of
PCI device when hotplug.

1. Moving pcibios_setup_bus_devices code to pcibios_device_change_notifier
   which is registered to bus notifier in pcibios_init.
2. Removing caller and callee of pcibios_setup_bus_devices bus notifier
   works instead of pcibios_setup_bus_devices.
3. Using this bus notifier for microblaze because microblaze/PCI is similer
   with powerpc/PCI.

[PATCH v2 1/2] powerpc/PCI: Add pcibios_device_change_notifier for powerpc
[PATCH v2 2/2] microblaze/PCI: Add pcibios_device_change_notifier for microblaze


Regards.

Hiroo MATSUMOTO

