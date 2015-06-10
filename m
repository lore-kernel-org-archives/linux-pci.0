Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailuogwdur.emc.com ([128.221.224.79]:50492 "EHLO
	mailuogwdur.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964947AbbFJOJH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2015 10:09:07 -0400
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v4 00/19] NTB: Add NTB hardware abstraction layer
Date: Wed, 10 Jun 2015 05:08:05 -0400
Message-Id: <cover.1433925092.git.Allen.Hubbe@emc.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The NTB drivers currently support only one hardware driver, and one
client type.  This patch set adds an abstraction layer, enabling
hardware drivers by other vendors, and clients other than ntb_transport.

The commits in this set may also be pulled from:
github.com/allenbh/linux
tagged ntb-abh-v4

Compare against previous tags ntb-abh-v1..ntb-abh-v3 to see exactly what
changed in the each revised version of this series.

Different in v4:
 - Correct spelling, grammer, and capitalization grammer in commit messages.
 - Zero-initialize device structure in ntb_hw_intel with kzalloc_node.
 - Use __copy_from_user_inatomic_nocache only if the arch has it.
 - Split adding the ntb hardware abstraction layer into two patches:
   NTB: Add NTB hardware abstraction layer
      Adding the abstraction layer now stands alone in its own patch.
   NTB: Split ntb_hw_intel and ntb_transport drivers
      This patch is still rather large, at just under 200k.
   Unfortunately, since the original code in ntb_hw_intel and
   ntb_transport called in both directions, one driver can't be changed
   by itself without breaking the other.

Different in v3:
 - Reschedule long running tasklets to avoid stalls in transport.
 - Initialize driver .owner and .name in ntb_register_client.
 - Eliminate calls to BUG() in ntb_hw_intel.
 - Fix incorrect PBARXLAT split-bar address assignment in ntb_hw_intel.
 - Add bugfix patch: Read peer info from local SPAD in transport.
 - Arrange the above bugfix, and three patches affecting transport link
   down, to earlier in the series, because they are higher importance.
 - Add performance patch: Increase transport MTU to 64k form 16k.
 - Rebase on ff25ea8f4eee to resolve a merge conflict in MAINTAINERS
   (conflicting context lines only, no conflicting changes).

Different in v2:
 - Rewrite shortlog descriptions for spelling and style
 - Remove extraneous NTB dependency from Kconfig files
 - Reindent Kconfig files with leading tabs
 - Reindent some lines in ntb_transport
 - Append patch NTB: Rename intel hw to proper platform names

Allen Hubbe (12):
  NTB: Move files in preparation for NTB abstraction
  NTB: Add NTB hardware abstraction layer
  NTB: Split ntb_hw_intel and ntb_transport drivers
  NTB: Differentiate transport link down messages
  NTB: Do not advance transport RX on link down
  NTB: Reset transport QP link stats on down
  NTB: Add parameters for Intel SNB B2B addresses
  NTB: Add ping pong test client
  NTB: Add tool test client
  NTB: Rate limit ntb_qp_link_work
  NTB: Use NUMA memory and DMA chan in transport
  NTB: Use NUMA memory in Intel driver

Dave Jiang (7):
  NTB: Read peer info from local SPAD in transport
  NTB: Enable link for Intel root port mode in probe
  NTB: Check the device ID to set errata flags
  NTB: Improve performance with write combining
  NTB: Default to CPU memcpy for performance
  NTB: Rename Intel code names to platform names
  NTB: Increase transport MTU to 64k from 16k

 Documentation/ntb.txt               |  127 ++
 MAINTAINERS                         |   16 +-
 drivers/net/ntb_netdev.c            |   58 +-
 drivers/ntb/Kconfig                 |   39 +-
 drivers/ntb/Makefile                |    5 +-
 drivers/ntb/hw/Kconfig              |    1 +
 drivers/ntb/hw/Makefile             |    1 +
 drivers/ntb/hw/intel/Kconfig        |    7 +
 drivers/ntb/hw/intel/Makefile       |    1 +
 drivers/ntb/hw/intel/ntb_hw_intel.c | 2214 +++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/intel/ntb_hw_intel.h |  342 ++++++
 drivers/ntb/ntb.c                   |  251 ++++
 drivers/ntb/ntb_hw.c                | 1896 ------------------------------
 drivers/ntb/ntb_hw.h                |  256 ----
 drivers/ntb/ntb_regs.h              |  177 ---
 drivers/ntb/ntb_transport.c         | 1027 +++++++++-------
 drivers/ntb/test/Kconfig            |   19 +
 drivers/ntb/test/Makefile           |    2 +
 drivers/ntb/test/ntb_pingpong.c     |  250 ++++
 drivers/ntb/test/ntb_tool.c         |  556 +++++++++
 include/linux/ntb.h                 |  970 ++++++++++++++-
 include/linux/ntb_transport.h       |   85 ++
 22 files changed, 5485 insertions(+), 2815 deletions(-)
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

