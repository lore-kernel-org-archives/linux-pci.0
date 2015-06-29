Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwdur.emc.com ([128.221.224.79]:46704 "EHLO
	mailuogwdur.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbbF2Ouh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Jun 2015 10:50:37 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 0/9] NTB: Fix and cleanup ntb drivers
Date: Mon, 29 Jun 2015 10:49:56 -0400
Message-Id: <cover.1435587291.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series includes the following changes to fix bugs, add new hardware
support, and improve usability and performance of the ntb drivers.

Bug Fixes (issues preexisting the new ntb api):
NTB: Fix ntb_transport out-of-order RX update
NTB: Schedule to receive on QP link up
NTB: ntb_netdev not covering all receive errors
NTB: Fix oops in debugfs when transport is half-up

Bug Fixes (regressions since the new ntb api):
NTB: Fix transport stats for multiple devices

Additions:
NTB: Add PCI Device IDs for Broadwell Xeon
NTB: Add flow control to the ntb_netdev
NTB: Make the transport list in order of discovery
NTB: Clean up QP stats info


Allen Hubbe (2):
  NTB: Fix ntb_transport out-of-order RX update
  NTB: Schedule to receive on QP link up

Dave Jiang (7):
  NTB: Add flow control to the ntb_netdev
  NTB: Fix transport stats for multiple devices
  NTB: ntb_netdev not covering all receive errors
  NTB: Fix oops in debugfs when transport is half-up
  NTB: Add PCI Device IDs for Broadwell Xeon
  NTB: Make the transport list in order of discovery
  NTB: Clean up QP stats info

 drivers/net/ntb_netdev.c            |  80 ++++++++++++-
 drivers/ntb/hw/intel/ntb_hw_intel.c |  15 +++
 drivers/ntb/hw/intel/ntb_hw_intel.h |   3 +
 drivers/ntb/ntb_transport.c         | 228 +++++++++++++++++++++++-------------
 include/linux/ntb_transport.h       |   1 +
 5 files changed, 246 insertions(+), 81 deletions(-)

-- 
2.4.0.rc0.43.gcf8a8c6

