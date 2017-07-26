Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:55130 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751367AbdGZNLQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2017 09:11:16 -0400
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
To: "'Logan Gunthorpe'" <logang@deltatee.com>,
        <linux-ntb@googlegroups.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc: "'Jon Mason'" <jdmason@kudzu.us>,
        "'Dave Jiang'" <dave.jiang@intel.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>,
        "'Kurt Schwemmer'" <kurt.schwemmer@microsemi.com>,
        "'Stephen Bates'" <sbates@raithlin.com>,
        "'Serge Semin'" <fancer.lancer@gmail.com>
References: <20170725205753.4735-1-logang@deltatee.com>
In-Reply-To: <20170725205753.4735-1-logang@deltatee.com>
Subject: RE: [PATCH v3 00/16] Switchtec NTB Support
Date: Wed, 26 Jul 2017 09:09:59 -0400
Message-ID: <000001d30610$7cd65120$7682f360$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Logan Gunthorpe
> Changes since v2:
> 
> - Reordered the ntb_test link patch per Allen
> - Removed an extra call to switchtec_ntb_init_mw
> - Fixed a typo in the switchtec.txt documentation.

Patches 5..16 (also 5 [was 6], and 14, objections notwithstanding):

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> --
> 
> Changes since v1:
> 
> - Rebased onto latest ntb-next branch (with v4.13-rc1)
> - Reworked ntb_mw_count() function so that it can be called all the
>   time (per discussion with Allen)
> - Various spelling and formatting cleanups from Bjorn
> - Added request_module() call such that the NTB module is automatically
>   loaded when appropriate hardware exists.
> 
> --
> 
> Changes since the rfc:
> 
> - Rebased on ntb-next
> - Switched ntb_part_op to use sleep instead of delay
> - Dropped a number of useless dbg __func__ prints
> - Went back to the dynamic instead of the static class
> - Swapped the notifier block for a simple callback
> - Modified the new ntb api so that a couple functions with pidx
>   now must be called after link up. Per our discussion on the list.
> 
> --
> 
> This patchset implements Non-Transparent Bridge (NTB) support for the
> Microsemi Switchtec series of switches. We're looking for some
> review from the community at this point but hope to get it upstreamed
> for v4.14.
> 
> Switchtec NTB support is configured over the same function and bar
> as the management endpoint. Thus, the new driver hooks into the
> management driver which we had merged in v4.12. We use the class
> interface API to register an NTB device for every switchtec device
> which supports NTB (not all do).
> 
> The Switchtec hardware supports doorbells, memory windows and messages.
> Seeing there is no native scratchpad support, 128 spads are emulated
> through the use of a pre-setup memory window. The switch has 64
> doorbells which are shared between the two partitions and a
> configurable set of memory windows. While the hardware supports more
> than 2 partitions, this driver only supports the first two seeing
> the current NTB API only supports two hosts.
> 
> The driver has been tested with ntb_netdev and fully passes the
> ntb_test script.
> 
> This patchset is based off of ntb-next and can be found in this
> git repo:
> 
> https://github.com/sbates130272/linux-p2pmem.git switchtec_ntb_v3
> 
> *** BLURB HERE ***
> 
> Logan Gunthorpe (16):
>   switchtec: move structure definitions into a common header
>   switchtec: export class symbol for use in upper layer driver
>   switchtec: add NTB hardware register definitions
>   switchtec: add link event notifier callback
>   ntb: ntb_test: ensure the link is up before trying to configure the
>     mws
>   ntb: ensure ntb_mw_get_align() is only called when the link is up
>   ntb: add check and comment for link up to mw_count() and
>     mw_get_align()
>   switchtec_ntb: introduce initial NTB driver
>   switchtec_ntb: initialize hardware for memory windows
>   switchtec_ntb: initialize hardware for doorbells and messages
>   switchtec_ntb: add skeleton NTB driver
>   switchtec_ntb: add link management
>   switchtec_ntb: implement doorbell registers
>   switchtec_ntb: implement scratchpad registers
>   switchtec_ntb: add memory window support
>   switchtec_ntb: update switchtec documentation with notes for NTB
> 
>  Documentation/switchtec.txt             |   12 +
>  MAINTAINERS                             |    2 +
>  drivers/ntb/hw/Kconfig                  |    1 +
>  drivers/ntb/hw/Makefile                 |    1 +
>  drivers/ntb/hw/mscc/Kconfig             |    9 +
>  drivers/ntb/hw/mscc/Makefile            |    1 +
>  drivers/ntb/hw/mscc/switchtec_ntb.c     | 1211 +++++++++++++++++++++++++++++++
>  drivers/ntb/ntb_transport.c             |   20 +-
>  drivers/ntb/test/ntb_perf.c             |   18 +-
>  drivers/ntb/test/ntb_tool.c             |    6 +-
>  drivers/pci/switch/switchtec.c          |  316 ++------
>  include/linux/ntb.h                     |   11 +-
>  include/linux/switchtec.h               |  373 ++++++++++
>  tools/testing/selftests/ntb/ntb_test.sh |    4 +
>  14 files changed, 1702 insertions(+), 283 deletions(-)
>  create mode 100644 drivers/ntb/hw/mscc/Kconfig
>  create mode 100644 drivers/ntb/hw/mscc/Makefile
>  create mode 100644 drivers/ntb/hw/mscc/switchtec_ntb.c
>  create mode 100644 include/linux/switchtec.h
> 
> --
> 2.11.0
