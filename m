Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 15 Jun 2017 14:37:16 -0600
Message-Id: <20170615203729.9009-1-logang@deltatee.com>
Subject: [RFC PATCH 00/13] Switchtec NTB Support
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

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

This patchset is based off of v4.12-rc5 and can be found in this
git repo:

https://github.com/sbates130272/linux-p2pmem.git switchtec_ntb

Thanks,

Logan


Logan Gunthorpe (13):
  switchtec: move structure definitions into a common header
  switchtec: export class symbol for use in upper layer driver
  switchtec: add ntb hardware register definitions
  switchtec: add link event notifier block
  switchtec_ntb: introduce initial ntb driver
  switchtec_ntb: initialize hardware for memory windows
  switchtec_ntb: initialize hardware for doorbells and messages
  switchtec_ntb: add skeleton ntb driver
  switchtec_ntb: add link management
  switchtec_ntb: implement doorbell registers
  switchtec_ntb: implement scratchpad registers
  switchtec_ntb: add memory window support
  switchtec_ntb: update switchtec documentation with notes for ntb

 Documentation/switchtec.txt         |   12 +
 MAINTAINERS                         |    2 +
 drivers/ntb/hw/Kconfig              |    1 +
 drivers/ntb/hw/Makefile             |    1 +
 drivers/ntb/hw/mscc/Kconfig         |    9 +
 drivers/ntb/hw/mscc/Makefile        |    1 +
 drivers/ntb/hw/mscc/switchtec_ntb.c | 1144 +++++++++++++++++++++++++++++++++++
 drivers/pci/switch/switchtec.c      |  319 ++--------
 include/linux/ntb.h                 |    3 +
 include/linux/switchtec.h           |  365 +++++++++++
 10 files changed, 1601 insertions(+), 256 deletions(-)
 create mode 100644 drivers/ntb/hw/mscc/Kconfig
 create mode 100644 drivers/ntb/hw/mscc/Makefile
 create mode 100644 drivers/ntb/hw/mscc/switchtec_ntb.c
 create mode 100644 include/linux/switchtec.h

--
2.11.0
