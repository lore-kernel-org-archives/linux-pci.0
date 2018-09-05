Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:35003 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeIEMHL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Sep 2018 08:07:11 -0400
Date: Wed, 5 Sep 2018 09:38:16 +0200
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
Message-ID: <20180905073816.jcrct2xcpucb6bkn@wunner.de>
References: <1535690081-16116-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CAHp75VfC8GN3oEzSFJYfMr0iqBTYUJ=WPoLS9Oh5NgVcFmnBkw@mail.gmail.com>
 <20180831085534.n6eikj5cw522ihhe@wunner.de>
 <CAK=zhgrzNYDeUFN0YWVJLdGR0nA443su0xydwSHFQzhouhZBuw@mail.gmail.com>
 <20180904094234.jm5je5sfpagdf6dz@wunner.de>
 <CAK=zhgprkzcF-UZeeqg_qN0xFLR=BfzkRNRZKA=DJyf7aMPmeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK=zhgprkzcF-UZeeqg_qN0xFLR=BfzkRNRZKA=DJyf7aMPmeg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2018 at 11:45:45AM +0530, Sreekanth Reddy wrote:
> On Tue, Sep 4, 2018 at 3:12 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > Many scsi drivers call pci_channel_offline() to detect inaccessibility
> > of the device due to a PCI error:
> > https://elixir.bootlin.com/linux/v4.19-rc2/ident/pci_channel_offline
> >
> > A patch is pending such that surprise removal can also be queried
> > with that same function:
> > https://www.spinics.net/lists/linux-pci/msg75722.html
> 
> Lukas, thanks for pointing to this pci_dev_is_disconnected() API. So
> we can use this API directly instead of reading the vendor Id and
> checking for all one's once this patch get accepted?

Yes, except pci_dev_is_disconnected() is private to the PCI core,
but dev->error_state and pci_channel_offline() is public.


> I have one more instance where still we need this poll kthread, i.e
> during the device probe time we have some commands which has more
> timeout value (e.g. 300 seconds), so if user has unplugged this device
> just after sending this more time-out valued command then driver has
> to wait until this time-out value expires. i.e. this device is still
> visible in lspci output until this 300 seconds timeout value expires
> even though device is unplugged. if we have a poll kthread (which will
> poll for every one second) then driver can early detect the unplugged
> state and can terminate the outstanding commands and hence probe
> operation can be completed quickly.

The only instances I can see in your driver where it waits for 300 s
is in _base_diag_reset(), which does an msleep(256) in a loop for up
to 300 s, and scsih_scan_finished(), which is called in a loop with an
msleep(10) by do_scsi_scan_host().

Any harm in simply checking for removal of the device in those loops
and bailing out if so?  Instead of the poll kthread to achieve the same?


> Also whether we need to wait for below patches get accepted? so that
> we can post the new set of patches accommodating according to your
> suggestions,
> https://www.spinics.net/lists/linux-pci/msg75722.html
> https://www.spinics.net/lists/linux-pci/msg75438.html

I can't tell you whether and when those patches get accepted, that's
for Bjorn Helgaas to decide.  Also, what does get accepted might differ.
E.g. the first patch uses the existing pci_channel_io_perm_failure
state for removal.  There was debate whether to introduce a new state
for removed devices to avoid overloading the existing state, which is
used for error recovery.

All I can recommend is to follow linux-pci, test the patches that have
already been brought forward to ascertain they fulfil your needs,
and generally participate in the debate so that your use cases are
covered.

Thanks,

Lukas
