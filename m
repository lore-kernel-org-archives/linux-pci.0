Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35957 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbdFPQdF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2017 12:33:05 -0400
Date: Fri, 16 Jun 2017 19:33:24 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Jon Mason' <jdmason@kudzu.us>,
        'Dave Jiang' <dave.jiang@intel.com>,
        'Bjorn Helgaas' <bhelgaas@google.com>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>,
        'Stephen Bates' <sbates@raithlin.com>,
        Sergey.Semin@t-platforms.ru
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
Message-ID: <20170616163324.GA15472@mobilestation>
References: <20170615203729.9009-1-logang@deltatee.com>
 <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
 <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Logan.
Thanks for the new hardware driver. It's really great to see NTB subsystem
being developed.

New NTB API is going to be merged to mainline kernel within next features
merge window, so it's really recommended to use that API for new hardware.
Could you please rabase your driver on top of the tree?
https://github.com/jonmason/ntb.git

> See what is staged in https://github.com/jonmason/ntb.git ntb-next, with
> the addition of multi-peer support by Serge.  It would be good at this
> stage to understand whether the api changes there would also support the
> Switchtec driver, and what if anything must change, or be planned to change,
> to support the Switchtec driver.

My impression is that, there is no need for new NTB API changes, since it
was specifically designed for new type of multi-port switches with
additional message registers, which is exactly supported by switchtec
device.

> The Switchtec hardware supports doorbells, memory windows and messages.
> Seeing there is no native scratchpad support, 128 spads are emulated
> through the use of a pre-setup memory window.

According to the NTB philosophy, it's not good to have any hardware
emulation within hardware driver. Hardware driver must reflect the only
hardware abilities, nothing else. Could you please get rid of Scratchpad
emulation and add messaging as new NTB API has got a proper callback
functions for it?
Hmmm, I haven't seen the actual code (see my last comment), but
according to my impression of API, it's impossible to have memory window
accessed while NTB link is down, but Scratchpads still can be used.
In this case, if you got Scratchpads emulated over memory windows,
you must have got NTB link enabled before NTB device is registered, which
makes ntb_link_* methods kind of being useless unless Switchtec hardware
supports NTB link getting up/down for individual memory windows...

> configurable set of memory windows. While the hardware supports more
> than 2 partitions, this driver only supports the first two seeing
> the current NTB API only supports two hosts.

New NTB API is updated so to have access to any of peer ports. IDT driver
has got a special translation table to access peer functionality just by
providing an index to corresponding API callback. You can use it as
reference to have Switchtec driver accordingly altered. It would be vastly
useful to have one more multi-port hardware driver in the tree.

> switchtec: move structure definitions into a common header
> switchtec: export class symbol for use in upper layer driver
> switchtec: add ntb hardware register definitions
> switchtec: add link event notifier block
> switchtec_ntb: introduce initial ntb driver
> switchtec_ntb: initialize hardware for memory windows
> switchtec_ntb: initialize hardware for doorbells and messages
> switchtec_ntb: add skeleton ntb driver
> switchtec_ntb: add link management
> switchtec_ntb: implement doorbell registers
> switchtec_ntb: implement scratchpad registers
> switchtec_ntb: add memory window support
> switchtec_ntb: update switchtec documentation with notes for ntb

If I'm not mistaken, these patches can be combined the way so to have
just two big functionally split patches:
1) NTB: Microsemt Switchtec switch management driver alterations for NTB
2) NTB: Add Microsemi Switchtec PCIe-switches support
It would really simplify the review. Could you please combine them?


Thanks for submitting the patches. We really appreciate this and looking
forward to have it completely reviewed and added to the kernel tree.

Regards
-Sergey

On Fri, Jun 16, 2017 at 08:09:55AM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> 
> 
> On 16/06/17 07:53 AM, Allen Hubbe wrote:
> > See what is staged in https://github.com/jonmason/ntb.git ntb-next, with the addition of multi-peer support by Serge.  It would be good at this stage to understand whether the api changes there would also support the Switchtec driver, and what if anything must change, or be planned to change, to support the Switchtec driver.
> 
> Ah, yes I had seen that patchset some time ago but I wasn't aware of
> it's status or that it was queued up in ntb-next. I think it will be no
> problem to reconcile with the switchtec driver and I'll rebase onto
> ntb-next for the next posting of the patch set. However, I *may* save
> full multi-host switchtec support for a follow up submission. My initial
> impression is the new API will support the switchtec hardware well.
> 
> Thanks,
> 
> Logan
