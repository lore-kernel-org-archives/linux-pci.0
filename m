Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Hubbe <Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <Allen.Hubbe@emc.com>
Subject: RE: [PATCH v2 00/17] NTB: Add NTB hardware abstraction layer
Date: Thu, 21 May 2015 05:45:03 -0400
Message-Id: <cover.1432196075.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432192681.git.Allen.Hubbe@emc.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The patches in this set (v2) reply to a different message id than the 
cover letter I sent.  Please pardon my mistake.  Other than that, I hope 
the patches are ok this time around.

I wrote the cover letter, and then kept the same copy after fixing a few 
more things.  This has the email id of the cover letter generated before 
the fixes.

I should have instead copied the subject line and body into the new cover 
letter that was generated for the fixed patch set.  Now I have learned my 
lesson.

In addition to the email id, the diff stat is also for the patch set that 
I didn't send, before the last fixes.  The diff stat doesn't differ by 
much.  If anybody cares, here is the exact diff stat for the v2.

 Documentation/ntb.txt               |  127 +++
 MAINTAINERS                         |   16 +-
 drivers/net/ntb_netdev.c            |   58 +-
 drivers/ntb/Kconfig                 |   39 +-
 drivers/ntb/Makefile                |    4 +-
 drivers/ntb/hw/Kconfig              |    1 +
 drivers/ntb/hw/Makefile             |    1 +
 drivers/ntb/hw/intel/Kconfig        |    7 +
 drivers/ntb/hw/intel/Makefile       |    1 +
 drivers/ntb/hw/intel/ntb_hw_intel.c | 2222 
+++++++++++++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/intel/ntb_hw_intel.h |  342 +++++++
 drivers/ntb/ntb.c                   |  251 +++++
 drivers/ntb/ntb_hw.c                | 1896 ------------------------------
--------
 drivers/ntb/ntb_hw.h                |  256 ------
 drivers/ntb/ntb_regs.h              |  177 ----
 drivers/ntb/ntb_transport.c         | 1023 +++++++++++++--------
 drivers/ntb/test/Kconfig            |   19 +
 drivers/ntb/test/Makefile           |    2 +
 drivers/ntb/test/ntb_pingpong.c     |  251 +++++
 drivers/ntb/test/ntb_tool.c         |  557 ++++++++++++
 include/linux/ntb.h                 |  969 +++++++++++++++++++-
 include/linux/ntb_transport.h       |   85 ++
 22 files changed, 5494 insertions(+), 2810 deletions(-)
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

Finally, I've faked the email id of this message, so the patches appear to 
reply to this one.  I hope this will clean up any threading for people who 
use that feature in their email clients.

From: Allen Hubbe [mailto:Allen.Hubbe@emc.com]
> The NTB drivers currently support only one hardware driver, and one
> client type.  This patch set adds an abstraction layer, enabling
> hardware drivers by other vendors, and clients other than ntb_transport.
> 
> The commits in this set may also be pulled from:
> github.com/allenbh/linux
> tagged ntb-abh-v2
> 
> The differences can be seen by comparing against the tag ntb-abh-v1.
> 
> Different in v2:
>  - Rewrite shortlog descriptions for spelling and style
>  - Remove extraneous NTB dependency from Kconfig files
>  - Reindent Kconfig files with leading tabs
>  - Reindent some lines in ntb_transport
>  - Append patch NTB: Rename intel hw to proper platform names
> 
> Allen Hubbe (12):
>   NTB: Move files in preparation for NTB abstraction
>   NTB: Add NTB hardware abstraction layer
>   NTB: Add parameters for Intel SNB B2B addresses
>   NTB: Add ping pong test client
>   NTB: Add tool test client
>   NTB: Rate limit ntb_qp_link_work
>   NTB: Differentiate transport link down messages
>   NTB: Do not advance transport RX on link down
>   NTB: Reset transport QP link stats on down
>   NTB: Use NUMA memory and DMA chan in transport
>   NTB: Use NUMA memory in Intel driver
>   NTB: Fix small code format issues in transport
> 
> Dave Jiang (5):
>   NTB: Enable link for Intel root port mode in probe
>   NTB: Check the device ID to set errata flags
>   NTB: Improve performance with write combining
>   NTB: Default to CPU memcpy for performance
>   NTB: Rename intel hw to proper platform names
> 
>  Documentation/ntb.txt               |  127 ++
>  MAINTAINERS                         |   16 +-
>  drivers/net/ntb_netdev.c            |   58 +-
>  drivers/ntb/Kconfig                 |   39 +-
>  drivers/ntb/Makefile                |    4 +-
>  drivers/ntb/hw/Kconfig              |    1 +
>  drivers/ntb/hw/Makefile             |    1 +
>  drivers/ntb/hw/intel/Kconfig        |    7 +
>  drivers/ntb/hw/intel/Makefile       |    1 +
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 2222
> +++++++++++++++++++++++++++++++++++
>  drivers/ntb/hw/intel/ntb_hw_intel.h |  342 ++++++
>  drivers/ntb/ntb.c                   |  251 ++++
>  drivers/ntb/ntb_hw.c                | 1896 ----------------------------
> --
>  drivers/ntb/ntb_hw.h                |  256 ----
>  drivers/ntb/ntb_regs.h              |  177 ---
>  drivers/ntb/ntb_transport.c         | 1018 +++++++++-------
>  drivers/ntb/test/Kconfig            |   19 +
>  drivers/ntb/test/Makefile           |    2 +
>  drivers/ntb/test/ntb_pingpong.c     |  251 ++++
>  drivers/ntb/test/ntb_tool.c         |  557 +++++++++
>  include/linux/ntb.h                 |  969 ++++++++++++++-
>  include/linux/ntb_transport.h       |   85 ++
>  22 files changed, 5491 insertions(+), 2808 deletions(-)
>  create mode 100644 Documentation/ntb.txt
>  create mode 100644 drivers/ntb/hw/Kconfig
>  create mode 100644 drivers/ntb/hw/Makefile
>  create mode 100644 drivers/ntb/hw/intel/Kconfig
>  create mode 100644 drivers/ntb/hw/intel/Makefile
>  create mode 100644 drivers/ntb/hw/intel/ntb_hw_intel.c
>  create mode 100644 drivers/ntb/hw/intel/ntb_hw_intel.h
>  create mode 100644 drivers/ntb/ntb.c
>  delete mode 100644 drivers/ntb/ntb_hw.c
>  delete mode 100644 drivers/ntb/ntb_hw.h
>  delete mode 100644 drivers/ntb/ntb_regs.h
>  create mode 100644 drivers/ntb/test/Kconfig
>  create mode 100644 drivers/ntb/test/Makefile
>  create mode 100644 drivers/ntb/test/ntb_pingpong.c
>  create mode 100644 drivers/ntb/test/ntb_tool.c
>  create mode 100644 include/linux/ntb_transport.h
> 
> --
> 2.4.0.rc0.43.gcf8a8c6

