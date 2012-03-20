Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60405 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760273Ab2CTQXY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2012 12:23:24 -0400
Received: by iagz16 with SMTP id z16so215351iag.19
        for <linux-pci@vger.kernel.org>; Tue, 20 Mar 2012 09:23:24 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	chenkeping@huawei.com
Subject: [PATCH 0/6] Improvements to Yinghai's x86 IOAPIC hotplug work
Date: Wed, 21 Mar 2012 00:20:56 +0800
Message-Id: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
References: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset is based on Yinghua's work for IOAPIC hotplug on x86 systems,
please refer to http://lwn.net/Articles/483671/. It applies to:
94738bb PCI: Disable mem in the ioapic removing path
at
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-x86-irq

Due to resource limitation, (only an Intel Atom system available for building
and testing), only the boot logic has been tested until now, so need more tests
for the hotplug logic when having access to systems with IOAPIC hotplug feature.

BTW, it's really a nightmare to build and test kernel on an Intel Atom system.

Jiang Liu (6):
  x86,IRQ: Fix possible invalid memory access after IOAPIC hot-plugging
  x86,IRQ: Mark unused entries in 'ioapics' array as free at startup
  x86,IRQ: Enhance irq allocation policy for hot-added IOAPICs
  x86,IRQ: split out function ioapic_setup_resource()
  x86,IRQ: Correctly manage MMIO resource used by IOAPIC when
    hot-plugging IOPAICs
  x86,IRQ: Use memory barriers to protect searching side code

 arch/x86/kernel/apic/io_apic.c |  150 +++++++++++++++++++++++++++++-----------
 1 files changed, 110 insertions(+), 40 deletions(-)

-- 
1.7.5.4

