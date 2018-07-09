Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout2.hostsharing.net ([83.223.90.240]:48293 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932902AbeGIQAK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jul 2018 12:00:10 -0400
Date: Mon, 9 Jul 2018 18:00:08 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <Okaya@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
Message-ID: <20180709160008.GA1490@wunner.de>
References: <CAK9iUCM=zWexWow9TwkRfO186Hwr5WyGy0NHZF1vtXn3wbbZGQ@mail.gmail.com>
 <12fc8de5-ff03-cb00-52cb-25a43c71d03a@codeaurora.org>
 <20180708171418.GA11476@wunner.de>
 <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK9iUCMcic5mzGiT20KNxgwPo6AuajHFsoj7GOjSht5SwrQevg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 09, 2018 at 08:48:44AM -0600, Sinan Kaya wrote:
> On 7/8/18, Lukas Wunner <lukas@wunner.de> wrote:
> > On Tue, Jul 03, 2018 at 11:43:26AM -0400, Sinan Kaya wrote:
> > > My solution doesn't help if link down interrupt is observed before the
> > > AER
> > > or DPC services.
> >
> > If pciehp gets an interrupt quicker than dpc/aer, it will (at least with
> > my patches) remove all devices, check if the presence bit is set,
> > and if so, try to bring the slot up again.
> 
> Hotplug driver should only observe a link down interrupt. Link would
> come up in response to a secondary bus reset initiated by the AER
> driver.

PCIe hotplug doesn't have separate Link Down and Link Up interrupts,
there is only a Link State *Changed* event.

> Can you point me to the code that would bring up the link in hp code?

I was referring to the situation with my recently posted pciehp patches
applied, in particular patch [21/32] ("PCI: pciehp: Become resilient to
missed events"):
https://patchwork.ozlabs.org/patch/930389/

When I get a presence or link changed event, I turn the slot off.  That
includes removing all devices in the slot.  Because even if the slot is
still occupied or link is up, there was definitely a change and the safe
behavior is to assume that the card in the slot is now a different one
than before.

Afterwards, I check if the slot is occupied or link is up.  If either
of those conditions is true, I try to bring the slot up again.

Thanks,

Lukas
