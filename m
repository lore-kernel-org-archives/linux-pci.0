Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:39393 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934063AbeFZLx6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jun 2018 07:53:58 -0400
Date: Tue, 26 Jun 2018 13:53:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hari Vyas <hari.vyas@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Subject: Re: [PATCH] PCI: Data corruption happening due to race condition
Message-ID: <20180626115356.GA24588@wunner.de>
References: <1529921446-20452-1-git-send-email-hari.vyas@broadcom.com>
 <20180625103742.GA20292@wunner.de>
 <3fa3c29e023abf67fa74d6e94a27645f@mail.gmail.com>
 <20180625111525.GA30242@wunner.de>
 <CAM5rFu-Bo_prR5R2w2XfM6JkUWo8URiL6i=4tWjOpDuMkcNn-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAM5rFu-Bo_prR5R2w2XfM6JkUWo8URiL6i=4tWjOpDuMkcNn-w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 26, 2018 at 03:47:43PM +0530, Hari Vyas wrote:
> On Mon, Jun 25, 2018 at 4:45 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Mon, Jun 25, 2018 at 04:27:37PM +0530, Hari Vyas wrote:
> >>       This issue is happening  with multiple times device removal and
> >> rescan from sysfs. Card is not removed physically.
> >>       Is_added bit is set after device attach which probe nvme driver.
> >> NVMe driver starts one workqueue and that one is calling pci_set_master()
> >> to set is_busmaster bit.
> >>       With multiple times device removal and rescan from sysfs,  race
> >> condition is observed and is_added bit is over-written to 0 from workqueue
> >> started by NVMe driver.
> >
> > Could you add a dump_stack() to pci_bus_add_device() and pci_stop_dev()
> > where the is_added bit is modified, reproduce the issue and attach the
> > resulting dmesg output to a newly opened bug on bugzilla.kernel.org?
> >
> 
> I have raised a Bug 200283 - PCI: Data corruption happening due to a
> race condition.

Thanks for taking the time to open the bug and provide more detailed
information.

So the upshot seems to be that is_added and is_busmaster end up in
the same word and two CPUs perform a read-modify-write wherein one
CPU clobbers the result of the other CPU.

While a spinlock may do the job, I think a better solution would be
to move is_added to the priv_flags bitmap in struct pci_dev.  The
is_added flag is internal to the PCI core and anything outside has
no business dealing with it.

(Assuming arch/powerpc/kernel/pci-common.c can also be considered
part of the PCI core.)

The flags in priv_flags are defined in drivers/pci/pci.h, so far
there's only one for PCI_DEV_DISCONNECTED which was introduced by
89ee9f768.  That commit also introduced accessors, personally I
don't think that's necessary for the few places in the PCI core
that the new PCI_DEV_ADDED flag would be used and I'd just update
those sites to set or test the bit directly.

Moving the is_added flag should already fix the race with is_busmaster.
It may be worth making is_busmaster a bitmap flag as well, but
priv_flags might not be suitable because the flag is also queried
by various drivers.  I'll defer that decision to Bjorn.

HTH,

Lukas
