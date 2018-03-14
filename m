Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Leitner <dev@g0hl1n.net>
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        bhelgaas@google.com, richard.leitner@skidata.com
Subject: [PATCH 0/3] usb: host: pci: PCI ID consolidation
Date: Wed, 14 Mar 2018 11:29:30 +0100
Message-Id: <20180314102933.21367-1-dev@g0hl1n.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Richard Leitner <richard.leitner@skidata.com>

Centralize some hardcoded PCI IDs as definitions in the global
include/linux/pci_ids.h file. This is done to reduce the amount of
scattered PCI ID definitions and hardcoded values across the kernel.

Richard Leitner (3):
  usb: host: pci: use existing Intel PCI ID macros
  usb: host: pci: introduce PCI vendor ID for Netlogic
  usb: host: pci: replace hardcoded renesas PCI IDs

 drivers/usb/host/pci-quirks.c | 16 +++++++++-------
 drivers/usb/host/xhci-pci.c   |  7 ++++---
 include/linux/pci_ids.h       |  5 +++++
 3 files changed, 18 insertions(+), 10 deletions(-)

-- 
2.11.0
