Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:36519 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeIMPTk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Sep 2018 11:19:40 -0400
Date: Thu, 13 Sep 2018 12:10:50 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [Patch v1 0/7] mpt3sas: Hot-Plug Surprise removal support on IOC.
Message-ID: <20180913101050.h4nkjhtxj4jwfh2h@wunner.de>
References: <1535690081-16116-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CAHp75VfC8GN3oEzSFJYfMr0iqBTYUJ=WPoLS9Oh5NgVcFmnBkw@mail.gmail.com>
 <20180831085534.n6eikj5cw522ihhe@wunner.de>
 <CAK=zhgrzNYDeUFN0YWVJLdGR0nA443su0xydwSHFQzhouhZBuw@mail.gmail.com>
 <20180904094234.jm5je5sfpagdf6dz@wunner.de>
 <CAK=zhgprkzcF-UZeeqg_qN0xFLR=BfzkRNRZKA=DJyf7aMPmeg@mail.gmail.com>
 <20180905073816.jcrct2xcpucb6bkn@wunner.de>
 <CAK=zhgoy8qfKmjM+ypAmbZ1aXALdGwHSS5ND1G9HBt6h4hTheg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK=zhgoy8qfKmjM+ypAmbZ1aXALdGwHSS5ND1G9HBt6h4hTheg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 12, 2018 at 03:31:07PM +0530, Sreekanth Reddy wrote:
> On Wed, Sep 5, 2018 at 1:08 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Wed, Sep 05, 2018 at 11:45:45AM +0530, Sreekanth Reddy wrote:
> > > I have one more instance where still we need this poll kthread, i.e
> > > during the device probe time we have some commands which has more
> > > timeout value (e.g. 300 seconds), so if user has unplugged this device
> > > just after sending this more time-out valued command then driver has
> > > to wait until this time-out value expires. i.e. this device is still
> > > visible in lspci output until this 300 seconds timeout value expires
> > > even though device is unplugged. if we have a poll kthread (which will
> > > poll for every one second) then driver can early detect the unplugged
> > > state and can terminate the outstanding commands and hence probe
> > > operation can be completed quickly.
> >
> > The only instances I can see in your driver where it waits for 300 s
> > is in _base_diag_reset(), which does an msleep(256) in a loop for up
> > to 300 s, and scsih_scan_finished(), which is called in a loop with an
> > msleep(10) by do_scsi_scan_host().
> >
> > Any harm in simply checking for removal of the device in those loops
> > and bailing out if so?  Instead of the poll kthread to achieve the same?
> 
> we can do for this port enable request but still we have other
> requests where we don't have this type of loops and used
> wait_for_completion_timeout () API where we can't bailout the request
> in-between and we have to wait until the timeout value expires. For
> these types of request terminating it though watchdog thread will be
> simple.

When the HBA is hot-removed, its driver's ->remove callback is invoked.
You could just check at the beginning of the ->remove callback whether
the device is no longer present, and if it isn't, complete() any
completions that may be pending.

I think that would obviate the need for a watchdog.

Thanks,

Lukas
