Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwhop.emc.com ([168.159.213.141]:55602 "EHLO
	mailuogwhop.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812AbbEUNWK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2015 09:22:10 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 00/17] NTB: Add NTB hardware abstraction layer
Date: Thu, 21 May 2015 04:20:44 -0400
Message-Id: <cover.1432192681.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The NTB drivers currently support only one hardware driver, and one
client type.  This patch set adds an abstraction layer, enabling
hardware drivers by other vendors, and clients other than ntb_transport.

The commits in this set may also be pulled from:
github.com/allenbh/linux
tagged ntb-abh-v2

The differences can be seen by comparing against the tag ntb-abh-v1.

Different in v2:
 - Rewrite shortlog descriptions for spelling and style
 - Remove extraneous NTB dependency from Kconfig files
 - Reindent Kconfig files with leading tabs
 - Reindent some lines in ntb_transport
 - Append patch NTB: Rename intel hw to proper platform names

Allen Hubbe (12):
  NTB: Move files in preparation for NTB abstraction
  NTB: Add NTB hardware abstraction layer
  NTB: Add parameters for Intel SNB B2B addresses
  NTB: Add ping pong test client
  NTB: Add tool test client
  NTB: Rate limit ntb_qp_link_work
  NTB: Differentiate transport link down messages
  NTB: Do not advance transport RX on link down
  NTB: Reset transport QP link stats on down
  NTB: Use NUMA memory and DMA chan in transport
  NTB: Use NUMA memory in Intel driver
  NTB: Fix small code format issues in transport

Dave Jiang (5):
  NTB: Enable link for Intel root port mode in probe
  NTB: Check the device ID to set errata flags
  NTB: Improve performance with write combining
  NTB: Default to CPU memcpy for performance
  NTB: Rename intel hw to proper platform names

 Documentation/ntb.txt               |  127 ++
 MAINTAINERS                         |   16 +-
 drivers/net/ntb_netdev.c            |   58 +-
 drivers/ntb/Kconfig                 |   39 +-
 drivers/ntb/Makefile                |    4 +-
 drivers/ntb/hw/Kconfig              |    1 +
 drivers/ntb/hw/Makefile             |    1 +
 drivers/ntb/hw/intel/Kconfig        |    7 +
 drivers/ntb/hw/intel/Makefile       |    1 +
 drivers/ntb/hw/intel/ntb_hw_intel.c | 2222 +++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/intel/ntb_hw_intel.h |  342 ++++++
 drivers/ntb/ntb.c                   |  251 ++++
 drivers/ntb/ntb_hw.c                | 1896 ------------------------------
 drivers/ntb/ntb_hw.h                |  256 ----
 drivers/ntb/ntb_regs.h              |  177 ---
 drivers/ntb/ntb_transport.c         | 1018 +++++++++-------
 drivers/ntb/test/Kconfig            |   19 +
 drivers/ntb/test/Makefile           |    2 +
 drivers/ntb/test/ntb_pingpong.c     |  251 ++++
 drivers/ntb/test/ntb_tool.c         |  557 +++++++++
 include/linux/ntb.h                 |  969 ++++++++++++++-
 include/linux/ntb_transport.h       |   85 ++
 22 files changed, 5491 insertions(+), 2808 deletions(-)
 create mode 100644 Documentation/ntb.txt
 create mode 100644 drivers/ntb/hw/Kconfig
 create mode 100644 drivers/ntb/hw/Makefile
 create mode 100644 drivers/ntb/hw/intel/Kconfig
 create mode 100644 drivers/ntb/hw/intel/Makefile
 create mode 100644 drivers/ntb/hw/intel/ntb_hw_intel.c
 create mode 100644 drivers/ntb/hw/intel/ntb_hw_intel.h
 create mode 100644 drivers/ntb/ntb.c
 delete mode 100644 drivers/ntb/ntb_hw.c
 delete mode 100644 drivers/ntb/ntb_hw.h
 delete mode 100644 drivers/ntb/ntb_regs.h
 create mode 100644 drivers/ntb/test/Kconfig
 create mode 100644 drivers/ntb/test/Makefile
 create mode 100644 drivers/ntb/test/ntb_pingpong.c
 create mode 100644 drivers/ntb/test/ntb_tool.c
 create mode 100644 include/linux/ntb_transport.h

-- 
2.4.0.rc0.43.gcf8a8c6

