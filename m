Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34160 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbdFSUHL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2017 16:07:11 -0400
Received: by mail-qk0-f195.google.com with SMTP id d14so8300661qkb.1
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2017 13:07:11 -0700 (PDT)
Date: Mon, 19 Jun 2017 16:07:02 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
Message-ID: <20170619200659.GA20437@kudzu.us>
References: <20170615203729.9009-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170615203729.9009-1-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 15, 2017 at 02:37:16PM -0600, Logan Gunthorpe wrote:
> Hi,
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
> This patchset is based off of v4.12-rc5 and can be found in this
> git repo:
> 
> https://github.com/sbates130272/linux-p2pmem.git switchtec_ntb

I think this code is of quality enough to go from an RFC to a standard
patch, and we can nit pick it to death there ;-)

Please rebase on ntb-next (which I believe you are already doing), and
resbutmit.

Also, we'll need to decide how to handle the patches to
drivers/pci/switches
We have 2 options here.
1.  We can split it up into 2 separate series, and have Bjorn take the
drivers/pci/switches in his, and I'll take the NTB portions.  The down
side of this is that I'll have to wait for his to get pulled in first,
which will push this back a full kernel release (which based on your
comment above doesn't seem your prefered choice)
2.  I can pull in the drivers/pci/switches patches into my NTB tree,
but I'll want Bjorn's ack on those patches before I'll pull them in.  

I'm thinking that we'll want to keep this series all in one place.
So, #2 sounds like the best option.  But, I need Bjorns $0.02 on this.


FYI, I ran smatch on the patches and got this.  Please correct them in
v2 (or v1 of the non-RFC...however you want to think of it).
drivers/pci/switch/switchtec.c:484 switchtec_dev_read() error: double unlock 'mutex:&stdev->mrpc_mutex'
drivers/pci/switch/switchtec.c:506 switchtec_dev_read() error: double unlock 'mutex:&stdev->mrpc_mutex'
drivers/pci/switch/switchtec.c:513 switchtec_dev_read() warn: inconsistent returns 'mutex:&stdev->mrpc_mutex'.


Thanks,
Jon


> 
> Thanks,
> 
> Logan
> 
> 
> Logan Gunthorpe (13):
>   switchtec: move structure definitions into a common header
>   switchtec: export class symbol for use in upper layer driver
>   switchtec: add ntb hardware register definitions
>   switchtec: add link event notifier block
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
>  Documentation/switchtec.txt         |   12 +
>  MAINTAINERS                         |    2 +
>  drivers/ntb/hw/Kconfig              |    1 +
>  drivers/ntb/hw/Makefile             |    1 +
>  drivers/ntb/hw/mscc/Kconfig         |    9 +
>  drivers/ntb/hw/mscc/Makefile        |    1 +
>  drivers/ntb/hw/mscc/switchtec_ntb.c | 1144 +++++++++++++++++++++++++++++++++++
>  drivers/pci/switch/switchtec.c      |  319 ++--------
>  include/linux/ntb.h                 |    3 +
>  include/linux/switchtec.h           |  365 +++++++++++
>  10 files changed, 1601 insertions(+), 256 deletions(-)
>  create mode 100644 drivers/ntb/hw/mscc/Kconfig
>  create mode 100644 drivers/ntb/hw/mscc/Makefile
>  create mode 100644 drivers/ntb/hw/mscc/switchtec_ntb.c
>  create mode 100644 include/linux/switchtec.h
> 
> --
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20170615203729.9009-1-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
