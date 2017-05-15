Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34326 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbdEOVvM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2017 17:51:12 -0400
Received: by mail-pg0-f49.google.com with SMTP id u28so66221872pgn.1
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2017 14:51:12 -0700 (PDT)
Date: Mon, 15 May 2017 14:51:09 -0700
From: Brian Norris <briannorris@chromium.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] pci: Disable master abort while waiting for an FLR to
 complete
Message-ID: <20170515215109.GA100668@google.com>
References: <20170512181107.13853.34680.stgit@localhost.localdomain>
 <20170515163623.GA15237@google.com>
 <CAKgT0UfNBhHSK9yvt7rZFMb+aZ9OF-Y7O4H8Axsr4NF99w9phQ@mail.gmail.com>
 <20170515210033.GA58785@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170515210033.GA58785@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 15, 2017 at 02:00:33PM -0700, Brian Norris wrote:
> On Mon, May 15, 2017 at 12:48:30PM -0700, Alexander Duyck wrote:
> > On Mon, May 15, 2017 at 9:36 AM, Brian Norris <briannorris@chromium.org> wrote:
> > > So there may be several implementation bugs with RK3399. I don't know
> > > how much can be fixed on Rockchip's side, vs. how much can be
> > > accomodated in the PCI core.
> > 
> > This is the kind of thing we have PCIe quirks for if nothing else.
> > Odds are we should be able to work around it, it is just a matter of
> > knowing what all the quirks are.
> 
> Maybe your imagination for "quirks" isn't creative enough :)

BTW, I meant to note that people have gone to some extreme lengths to
handle buggy / quirky RCs. Look at drivers/pci/dwc/pci-imx6.c, which
hooks all the way into the core ARM exception handling just to mask
aborts! (See imx6q_pcie_abort_handler.) And they have some patches
intended to fix crashes in 4.12-rc1 to hook synchronous aborts to return
"all 1's". But that's extremely invasive and not very precise (I don't
think that even checks the difference between PCI-induced aborts and
other system aborts?). Probably not gonna fly on ARM64 either...

Brian

[1] [PATCH] PCI: imx6: fix downstream bus scanning
https://patchwork.ozlabs.org/patch/760748/
