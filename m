Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38614 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbdHaRyB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2017 13:54:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id d15so250077qta.5
        for <linux-pci@vger.kernel.org>; Thu, 31 Aug 2017 10:54:00 -0700 (PDT)
Date: Thu, 31 Aug 2017 13:53:57 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v4 00/15] Switchtec NTB Support
Message-ID: <20170831175356.GA28190@kudzu.us>
References: <20170803181954.4154-1-logang@deltatee.com>
 <58ab6a33-4de5-8fd8-65c2-079f6f6301c4@deltatee.com>
 <50ba7618-b5c3-1779-ad79-0f32254ebbaf@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50ba7618-b5c3-1779-ad79-0f32254ebbaf@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 30, 2017 at 01:18:28PM -0600, Logan Gunthorpe wrote:
> Hey Jon,
> 
> Any update on this? The merge window is likely very soon and it would be
> good to know where we stand. As far as I know I've addressed all the
> feedback I've been given. Let me know if there's anything I can do to
> further this process.

My apologies for the delay.  I've pulled the series into my ntb-next
branch.

When you get a chance, please pulldown and verify that I didn't miss
anything (and a smoke test that it works as desired would be nice
too).

Thanks,
Jon

> 
> Thanks,
> 
> Logan
> 
> On 22/08/17 10:59 AM, Logan Gunthorpe wrote:
> > Hi,
> > 
> > Just wanted to give this a poke as I haven't received any feedback in a
> > couple weeks on v4. What are people's thoughts on this? Is it suitable
> > to make it into the next merge window?
> > 
> > Thanks,
> > 
> > Logan
> > 
> > 
> > On 03/08/17 12:19 PM, Logan Gunthorpe wrote:
> > > Changes since v3:
> > > 
> > > - Rebased onto the Jon's ntb branch that contains one of the patches
> > >    that was in v3
> > > - Various spelling and commit log mistakes noticed by Bjorn
> > > - Renamed switchtec_ntb to ntb_hw_switchtec per Dave's suggestion
> > > - Fixed a number of code nits pointed out by Jon
> > > 
> > > -- 
> > > 
> > > Changes since v2:
> > > 
> > > - Reordered the ntb_test link patch per Allen
> > > - Removed an extra call to switchtec_ntb_init_mw
> > > - Fixed a typo in the switchtec.txt documentation.
> > > 
> > > -- 
> > > 
> > > Changes since v1:
> > > 
> > > - Rebased onto latest ntb-next branch (with v4.13-rc1)
> > > - Reworked ntb_mw_count() function so that it can be called all the
> > >    time (per discussion with Allen)
> > > - Various spelling and formatting cleanups from Bjorn
> > > - Added request_module() call such that the NTB module is automatically
> > >    loaded when appropriate hardware exists.
> > > 
> > > -- 
> > > 
> > > Changes since the rfc:
> > > 
> > > - Rebased on ntb-next
> > > - Switched ntb_part_op to use sleep instead of delay
> > > - Dropped a number of useless dbg __func__ prints
> > > - Went back to the dynamic instead of the static class
> > > - Swapped the notifier block for a simple callback
> > > - Modified the new ntb api so that a couple functions with pidx
> > >    now must be called after link up. Per our discussion on the list.
> > > 
> > > -- 
> > > 
> > > This patchset implements Non-Transparent Bridge (NTB) support for the
> > > Microsemi Switchtec series of switches. We're looking for some
> > > review from the community at this point but hope to get it upstreamed
> > > for v4.14.
> > > 
> > > Switchtec NTB support is configured over the same function and bar
> > > as the management endpoint. Thus, the new driver hooks into the
> > > management driver which we had merged in v4.12. We use the class
> > > interface API to register an NTB device for every switchtec device
> > > which supports NTB (not all do).
> > > 
> > > The Switchtec hardware supports doorbells, memory windows and messages.
> > > Seeing there is no native scratchpad support, 128 spads are emulated
> > > through the use of a pre-setup memory window. The switch has 64
> > > doorbells which are shared between the two partitions and a
> > > configurable set of memory windows. While the hardware supports more
> > > than 2 partitions, this driver only supports the first two seeing
> > > the current NTB API only supports two hosts.
> > > 
> > > The driver has been tested with ntb_netdev and fully passes the
> > > ntb_test script.
> > > 
> > > This patchset is based off of ntb-next and can be found in this
> > > git repo:
> > > 
> > > https://github.com/sbates130272/linux-p2pmem.git switchtec_ntb_v4
> > > 
> > > Logan Gunthorpe (15):
> > >    NTB: switchtec: Move structure definitions into a common header
> > >    NTB: switchtec: Export class symbol for use in upper layer driver
> > >    NTB: switchtec: Add NTB hardware register definitions
> > >    NTB: switchtec: Add link event notifier callback
> > >    NTB: Ensure ntb_mw_get_align() is only called when the link is up
> > >    NTB: Add check and comment for link up to mw_count() and
> > >      mw_get_align()
> > >    NTB: switchtec_ntb: Introduce initial NTB driver
> > >    NTB: switchtec_ntb: Initialize hardware for memory windows
> > >    NTB: switchtec_ntb: Initialize hardware for doorbells and messages
> > >    NTB: switchtec_ntb: Add skeleton NTB driver
> > >    NTB: switchtec_ntb: Add link management
> > >    NTB: switchtec_ntb: Implement doorbell registers
> > >    NTB: switchtec_ntb: Implement scratchpad registers
> > >    NTB: switchtec_ntb: Add memory window support
> > >    NTB: switchtec_ntb: Update switchtec documentation with notes for NTB
> > > 
> > >   Documentation/switchtec.txt            |   12 +
> > >   MAINTAINERS                            |    2 +
> > >   drivers/ntb/hw/Kconfig                 |    1 +
> > >   drivers/ntb/hw/Makefile                |    1 +
> > >   drivers/ntb/hw/mscc/Kconfig            |    9 +
> > >   drivers/ntb/hw/mscc/Makefile           |    1 +
> > >   drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 1216
> > > ++++++++++++++++++++++++++++++++
> > >   drivers/ntb/ntb_transport.c            |   20 +-
> > >   drivers/ntb/test/ntb_perf.c            |   18 +-
> > >   drivers/ntb/test/ntb_tool.c            |    6 +-
> > >   drivers/pci/switch/switchtec.c         |  316 ++-------
> > >   include/linux/ntb.h                    |   11 +-
> > >   include/linux/switchtec.h              |  373 ++++++++++
> > >   13 files changed, 1703 insertions(+), 283 deletions(-)
> > >   create mode 100644 drivers/ntb/hw/mscc/Kconfig
> > >   create mode 100644 drivers/ntb/hw/mscc/Makefile
> > >   create mode 100644 drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > >   create mode 100644 include/linux/switchtec.h
> > > 
> > > -- 
> > > 2.11.0
> > > 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/50ba7618-b5c3-1779-ad79-0f32254ebbaf%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
