Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:41534 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdHCSUD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:03 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu,  3 Aug 2017 12:19:39 -0600
Message-Id: <20170803181954.4154-1-logang@deltatee.com>
Subject: [PATCH v4 00/15] Switchtec NTB Support
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Changes since v3:

- Rebased onto the Jon's ntb branch that contains one of the patches
  that was in v3
- Various spelling and commit log mistakes noticed by Bjorn
- Renamed switchtec_ntb to ntb_hw_switchtec per Dave's suggestion
- Fixed a number of code nits pointed out by Jon

--

Changes since v2:

- Reordered the ntb_test link patch per Allen
- Removed an extra call to switchtec_ntb_init_mw
- Fixed a typo in the switchtec.txt documentation.

--

Changes since v1:

- Rebased onto latest ntb-next branch (with v4.13-rc1)
- Reworked ntb_mw_count() function so that it can be called all the
  time (per discussion with Allen)
- Various spelling and formatting cleanups from Bjorn
- Added request_module() call such that the NTB module is automatically
  loaded when appropriate hardware exists.

--

Changes since the rfc:

- Rebased on ntb-next
- Switched ntb_part_op to use sleep instead of delay
- Dropped a number of useless dbg __func__ prints
- Went back to the dynamic instead of the static class
- Swapped the notifier block for a simple callback
- Modified the new ntb api so that a couple functions with pidx
  now must be called after link up. Per our discussion on the list.

--

This patchset implements Non-Transparent Bridge (NTB) support for the
Microsemi Switchtec series of switches. We're looking for some
review from the community at this point but hope to get it upstreamed
for v4.14.

Switchtec NTB support is configured over the same function and bar
as the management endpoint. Thus, the new driver hooks into the
management driver which we had merged in v4.12. We use the class
interface API to register an NTB device for every switchtec device
which supports NTB (not all do).

The Switchtec hardware supports doorbells, memory windows and messages.
Seeing there is no native scratchpad support, 128 spads are emulated
through the use of a pre-setup memory window. The switch has 64
doorbells which are shared between the two partitions and a
configurable set of memory windows. While the hardware supports more
than 2 partitions, this driver only supports the first two seeing
the current NTB API only supports two hosts.

The driver has been tested with ntb_netdev and fully passes the
ntb_test script.

This patchset is based off of ntb-next and can be found in this
git repo:

https://github.com/sbates130272/linux-p2pmem.git switchtec_ntb_v4

Logan Gunthorpe (15):
  NTB: switchtec: Move structure definitions into a common header
  NTB: switchtec: Export class symbol for use in upper layer driver
  NTB: switchtec: Add NTB hardware register definitions
  NTB: switchtec: Add link event notifier callback
  NTB: Ensure ntb_mw_get_align() is only called when the link is up
  NTB: Add check and comment for link up to mw_count() and
    mw_get_align()
  NTB: switchtec_ntb: Introduce initial NTB driver
  NTB: switchtec_ntb: Initialize hardware for memory windows
  NTB: switchtec_ntb: Initialize hardware for doorbells and messages
  NTB: switchtec_ntb: Add skeleton NTB driver
  NTB: switchtec_ntb: Add link management
  NTB: switchtec_ntb: Implement doorbell registers
  NTB: switchtec_ntb: Implement scratchpad registers
  NTB: switchtec_ntb: Add memory window support
  NTB: switchtec_ntb: Update switchtec documentation with notes for NTB

 Documentation/switchtec.txt            |   12 +
 MAINTAINERS                            |    2 +
 drivers/ntb/hw/Kconfig                 |    1 +
 drivers/ntb/hw/Makefile                |    1 +
 drivers/ntb/hw/mscc/Kconfig            |    9 +
 drivers/ntb/hw/mscc/Makefile           |    1 +
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 1216 ++++++++++++++++++++++++++++++++
 drivers/ntb/ntb_transport.c            |   20 +-
 drivers/ntb/test/ntb_perf.c            |   18 +-
 drivers/ntb/test/ntb_tool.c            |    6 +-
 drivers/pci/switch/switchtec.c         |  316 ++-------
 include/linux/ntb.h                    |   11 +-
 include/linux/switchtec.h              |  373 ++++++++++
 13 files changed, 1703 insertions(+), 283 deletions(-)
 create mode 100644 drivers/ntb/hw/mscc/Kconfig
 create mode 100644 drivers/ntb/hw/mscc/Makefile
 create mode 100644 drivers/ntb/hw/mscc/ntb_hw_switchtec.c
 create mode 100644 include/linux/switchtec.h

--
2.11.0
