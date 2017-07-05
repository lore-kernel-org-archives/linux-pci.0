Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751964AbdGETr4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jul 2017 15:47:56 -0400
Date: Wed, 5 Jul 2017 14:47:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 00/16]
Message-ID: <20170705194753.GM13824@bhelgaas-glaptop.roam.corp.google.com>
References: <20170629032648.3073-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629032648.3073-1-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 28, 2017 at 09:26:32PM -0600, Logan Gunthorpe wrote:
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
> Also, please note, the first patch in the series will conflict with
> switchtec patches that are queued up for 4.13. So this shouldn't
> be merged until I can rebase it onto a later kernel. However, it
> is suitable for review.
> 
> @Bjorn: per the discussion on the RFC, I think it's best if
> this series goes through the NTB tree. Therefore, we just need an ack
> from you when you have time.
> 
> Thanks,
> 
> Logan
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
> https://github.com/sbates130272/linux-p2pmem.git switchtec_ntb_next
> 
> Logan Gunthorpe (16):
>   switchtec: move structure definitions into a common header
>   switchtec: export class symbol for use in upper layer driver
>   switchtec: add ntb hardware register definitions
>   switchtec: add link event notifier callback
>   ntb: ensure ntb_mw_get_align is only called when the link is up
>   ntb: add check and comment for link up to mw_count and mw_get_align
>   ntb: ntb_test: ensure the link is up before trying to configure the
>     mws
>   switchtec_ntb: introduce initial ntb driver
>   switchtec_ntb: initialize hardware for memory windows
>   switchtec_ntb: initialize hardware for doorbells and messages
>   switchtec_ntb: add skeleton ntb driver
>   switchtec_ntb: add link management
>   switchtec_ntb: implement doorbell registers
>   switchtec_ntb: implement scratchpad registers
>   switchtec_ntb: add memory window support
>   switchtec_ntb: update switchtec documentation with notes for ntb
> 
>  Documentation/switchtec.txt             |   12 +
>  MAINTAINERS                             |    2 +
>  drivers/ntb/hw/Kconfig                  |    1 +
>  drivers/ntb/hw/Makefile                 |    1 +
>  drivers/ntb/hw/mscc/Kconfig             |    9 +
>  drivers/ntb/hw/mscc/Makefile            |    1 +
>  drivers/ntb/hw/mscc/switchtec_ntb.c     | 1188 +++++++++++++++++++++++++++++++
>  drivers/ntb/ntb_transport.c             |   20 +-
>  drivers/ntb/test/ntb_perf.c             |   18 +-
>  drivers/ntb/test/ntb_tool.c             |    6 +-
>  drivers/pci/switch/switchtec.c          |  304 ++------
>  include/linux/ntb.h                     |   14 +-
>  include/linux/switchtec.h               |  364 ++++++++++
>  tools/testing/selftests/ntb/ntb_test.sh |    4 +
>  14 files changed, 1670 insertions(+), 274 deletions(-)
>  create mode 100644 drivers/ntb/hw/mscc/Kconfig
>  create mode 100644 drivers/ntb/hw/mscc/Makefile
>  create mode 100644 drivers/ntb/hw/mscc/switchtec_ntb.c
>  create mode 100644 include/linux/switchtec.h

For the drivers/pci changes:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

A few trivial nits:

The subject lines and changelogs are inconsistent in ntb/NTB, api/API,
switchtec/Switchtec, idb/IDB, db/DB, etc.  My personal preference is
to capitalize acronyms and initialisms in English text.

I think it also makes the text easier to read when function names have
"()" after them, e.g., peer_mw_trans() vs peer_mw_trans.

"This patch adds ..." is superfluous; "Add ..." would be sufficient,
given the context.

Bjorn
