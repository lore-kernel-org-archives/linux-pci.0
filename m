Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5453 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIESsZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Sep 2018 14:48:25 -0400
Date: Wed, 5 Sep 2018 08:17:13 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Patch v1 0/7] mpt3sas: Hot-Plug Surprise removal support on IOC.
Message-ID: <20180905141712.GA19005@localhost.localdomain>
References: <1535690081-16116-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CAHp75VfC8GN3oEzSFJYfMr0iqBTYUJ=WPoLS9Oh5NgVcFmnBkw@mail.gmail.com>
 <20180831085534.n6eikj5cw522ihhe@wunner.de>
 <CAK=zhgrzNYDeUFN0YWVJLdGR0nA443su0xydwSHFQzhouhZBuw@mail.gmail.com>
 <20180904094234.jm5je5sfpagdf6dz@wunner.de>
 <CAK=zhgprkzcF-UZeeqg_qN0xFLR=BfzkRNRZKA=DJyf7aMPmeg@mail.gmail.com>
 <20180905073816.jcrct2xcpucb6bkn@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180905073816.jcrct2xcpucb6bkn@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 05, 2018 at 09:38:16AM +0200, Lukas Wunner wrote:
> On Wed, Sep 05, 2018 at 11:45:45AM +0530, Sreekanth Reddy wrote:
> > On Tue, Sep 4, 2018 at 3:12 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > > Many scsi drivers call pci_channel_offline() to detect inaccessibility
> > > of the device due to a PCI error:
> > > https://elixir.bootlin.com/linux/v4.19-rc2/ident/pci_channel_offline
> > >
> > > A patch is pending such that surprise removal can also be queried
> > > with that same function:
> > > https://www.spinics.net/lists/linux-pci/msg75722.html
> > 
> > Lukas, thanks for pointing to this pci_dev_is_disconnected() API. So
> > we can use this API directly instead of reading the vendor Id and
> > checking for all one's once this patch get accepted?
> 
> Yes, except pci_dev_is_disconnected() is private to the PCI core,
> but dev->error_state and pci_channel_offline() is public.

The exported function to call is pci_device_is_present().
