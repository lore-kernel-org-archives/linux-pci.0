Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 24 Jul 2015 17:42:58 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Tanmay Inamdar <tinamdar@apm.com>
Cc: Duc Dang <dhdang@apm.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: X-Gene: Unhandled fault: synchronous external abort in
 pci_generic_config_read32
Message-ID: <20150724224258.GA23990@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I regularly see faults like this on an APM X-Gene:

  U-Boot 2013.04-mustang_sw_1.14.14 (Dec 16 2014 - 15:59:33)
  CPU0: APM ARM 64-bit Potenza Rev B0 2400MHz PCP 2400MHz
       32 KB ICACHE, 32 KB DCACHE
       SOC 2000MHz IOBAXI 400MHz AXI 250MHz AHB 200MHz GFC 125MHz
  ...
  Unhandled fault: synchronous external abort (0x96000010) at 0xffffff8000110034
  Internal error: : 96000010 [#1] SMP
  Modules linked in:
  CPU: 0 PID: 3723 Comm: ... 4.1.0-smp-DEV #3
  Hardware name: APM X-Gene Mustang board (DT)
  task: ffffffc7dc1a4140 ti: ffffffc7dc118000 task.ti: ffffffc7dc118000
  PC is at pci_generic_config_read32+0x4c/0xb8
  LR is at pci_generic_config_read32+0x40/0xb8
  pc : [<ffffffc00033b90c>] lr : [<ffffffc00033b900>] pstate: 600001c5
  ...
  Call trace:
  [<ffffffc00033b90c>] pci_generic_config_read32+0x4c/0xb8
  [<ffffffc00033bf58>] pci_user_read_config_byte+0x60/0xc4
  [<ffffffc0003496a8>] pci_read_config+0x15c/0x238
  [<ffffffc0002393b4>] sysfs_kf_bin_read+0x68/0xa0
  [<ffffffc00023896c>] kernfs_fop_read+0x9c/0x1ac
  [<ffffffc0001c361c>] __vfs_read+0x44/0x128
  [<ffffffc0001c3e28>] vfs_read+0x84/0x144
  [<ffffffc0001c4764>] SyS_read+0x50/0xb0

  # lspci
  00:00.0 PCI bridge: Applied Micro Circuits Corp. Device e004 (rev 04)
  01:00.0 Ethernet controller: Mellanox Technologies MT27520 Family

I first saw this on an ancient kernel and thought it was likely specific to
my environment, but I'm now using an almost unmodified v4.1 kernel and
still seeing it.  Does anybody else see this?  The box does have a PCI card
installed, but I haven't yet worked out what device's config space we're
trying to read.

Is there anything I can do to debug this?  I'm not an arm64 guy, but my
impression is that this is a page fault, and the address seems to be in the
"cfg" area ioremapped by xgene_pcie_map_reg(), so I'm not sure this is
really a PCI issue -- maybe that page mapping got trashed by somebody else?

Bjorn
