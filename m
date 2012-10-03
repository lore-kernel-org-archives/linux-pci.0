Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Don Dutile <ddutile@redhat.com>, yuvalmin@broadcom.com,
	bhutchings@solarflare.com, gregory.v.rose@intel.com,
	davem@davemloft.net--no-chain-reply-to,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 0/5] PCI: per pci device sysfs set_max_vfs support
Date: Wed,  3 Oct 2012 10:51:30 -0700
Message-Id: <1349286695-26713-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <506C3B11.9010009@redhat.com>
References: <506C3B11.9010009@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

First two patches are old patches in my queue.
They introduce pci_dev_type and use it with vga in sysfs.

other two will add set_max_vfs in sysfs for device that support siov.

last one is draft version for ixgbe, still need ixgbe guys to sort it
out.

Thanks

Yinghai


Yinghai Lu (5):
  PCI: Add pci_dev_type
  PCI, sys: Use is_visable() with boot_vga attribute for pci_dev
  PCI: add set_max_vfs in pci_driver ops
  PCI: Add max_vfs in sysfs per pci device where supports
  ixgbe: add driver set_max_vfs support

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   44 +++++++++---
 drivers/pci/pci-sysfs.c                       |   96 ++++++++++++++++++++++---
 drivers/pci/pci.h                             |    1 +
 drivers/pci/probe.c                           |    1 +
 include/linux/pci.h                           |    2 +
 6 files changed, 126 insertions(+), 20 deletions(-)

-- 
1.7.7

