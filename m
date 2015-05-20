Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 00/16] ntb: NTB Abstraction Layer
Date: Wed, 20 May 2015 11:41:01 -0400
Message-Id: <cover.1432135631.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The NTB drivers currently support only one hardware driver, and one client
type.  This patch set adds an abstraction layer, enabling different hardware
drivers by other vendors, and clients other than ntb_transport.

The commits in this set may also be pulled from:
github.com/allenbh/linux
in the branch ntb-abh, or tag ntb-abh-v1

Allen Hubbe (12):
  Move files in preparation for NTB Abstraction
  NTB Abstraction Layer
  Intel NTB params for snb b2b addresses
  NTB Pingpong Client
  NTB Tool Client
  ntb_transport: rate limit ntb_qp_link_work
  ntb_transport: differentiate link down messages
  ntb_transport: don't advance rx on link down
  ntb_transport: reset qp link stats on down
  ntb_transport: numa aware memory and dma chan
  ntb_hw_intel: numa aware memory allocation
  ntb_transport: fix small code format issues

Dave Jiang (4):
  ntb: Enable link training for RP mode in the driver probe
  Check the DID for certain workaround error flags to be set.
  ntb: performance improvement by write combining
  ntb: default to cpu memcpy for performance

 Documentation/ntb.txt               |  127 ++
 MAINTAINERS                         |   16 +-
 drivers/net/ntb_netdev.c            |   58 +-
 drivers/ntb/Kconfig                 |   22 +-
 drivers/ntb/Makefile                |    4 +-
 drivers/ntb/hw/Kconfig              |    1 +
 drivers/ntb/hw/Makefile             |    1 +
 drivers/ntb/hw/intel/Kconfig        |    8 +
 drivers/ntb/hw/intel/Makefile       |    1 +
 drivers/ntb/hw/intel/ntb_hw_intel.c | 2222 +++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/intel/ntb_hw_intel.h |  342 ++++++
 drivers/ntb/ntb.c                   |  251 ++++
 drivers/ntb/ntb_hw.c                | 1896 ------------------------------
 drivers/ntb/ntb_hw.h                |  256 ----
 drivers/ntb/ntb_regs.h              |  177 ---
 drivers/ntb/ntb_transport.c         | 1018 +++++++++-------
 drivers/ntb/test/Kconfig            |   21 +
 drivers/ntb/test/Makefile           |    2 +
 drivers/ntb/test/ntb_pingpong.c     |  251 ++++
 drivers/ntb/test/ntb_tool.c         |  557 +++++++++
 include/linux/ntb.h                 |  969 ++++++++++++++-
 include/linux/ntb_transport.h       |   85 ++
 22 files changed, 5486 insertions(+), 2799 deletions(-)
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

