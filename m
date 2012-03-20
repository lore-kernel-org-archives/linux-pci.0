Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60405 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964783Ab2CTQXc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2012 12:23:32 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so215351iag.19
        for <linux-pci@vger.kernel.org>; Tue, 20 Mar 2012 09:23:32 -0700 (PDT)
From: Jiang Liu <liuj97@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Ashok Raj <ashok.raj@intel.com>,
	linux-pci@vger.kernel.org, chenkeping@huawei.com
Subject: [PATCH 0/5] Improvements to Yinghai's IOAPIC hotplug work on x86
Date: Wed, 21 Mar 2012 00:20:57 +0800
Message-Id: <1332260463-13924-2-git-send-email-jiang.liu@huawei.com>
In-Reply-To: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
References: <1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patchset is based on Yinghua's work for IOAPIC hotplug on x86,
please refer to http://lwn.net/Articles/483671/.
The first two patches are minor bugfixes, the third and fourth are
enhancement to Yinghai's implementation, and the fifth is a RFC patch.

I only have an Atom system at hand to build and test the patchset,
so only the boot logic has been tested until now, need more tests
about the hotplug logic when having access to systems which support
IOAPIC hotplug feature.

BTW, it's really a nightmare to build and test kernel on an Atom system.

Jiang Liu (5):
  x86:IRQ: Fix possible invalid memory access when hot-plugging IOAPICs
  x86:IRQ: Mark unused entries in 'ioapics' array as free at startup
  x86:IRQ: Enhance irq allocation policy for hot-added IOAPICs
  x86:IRQ: Correctly manage MMIO resource used by IOAPIC when
    hot-plugging
  x86:IRQ: Use memory barriers to protect searching side code

 arch/x86/kernel/apic/io_apic.c |  159 ++++++++++++++++++++++++++++------------
 1 files changed, 113 insertions(+), 46 deletions(-)

-- 
1.7.5.4

