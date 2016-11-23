Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34476 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbcKWC3J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2016 21:29:09 -0500
Received: by mail-pg0-f45.google.com with SMTP id x23so18929pgx.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Nov 2016 18:29:09 -0800 (PST)
Date: Tue, 22 Nov 2016 18:29:06 -0800
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH 1/3] PCI: rockchip: split out rockchip_cfg_atu
Message-ID: <20161123022905.GA122654@google.com>
References: <1479863953-123874-1-git-send-email-shawn.lin@rock-chips.com>
 <20161123015914.GA119441@google.com>
 <30d37e0c-73df-5bae-f489-3d9b56cc7b02@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <30d37e0c-73df-5bae-f489-3d9b56cc7b02@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 23, 2016 at 10:15:16AM +0800, Shawn Lin wrote:
> 在 2016/11/23 9:59, Brian Norris 写道:
> >On Wed, Nov 23, 2016 at 09:19:11AM +0800, Shawn Lin wrote:
> >>diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> >>index b55037a..19399fc 100644
> >>--- a/drivers/pci/host/pcie-rockchip.c
> >>+++ b/drivers/pci/host/pcie-rockchip.c

...

> >>+	rockchip->msg_region = ioremap(rockchip->mem_bus_addr +
> >>+				       ((reg_no - 1) << 20), SZ_1M);
> >
> >(And here.)
> >
> >ioremap() can fail; check for NULL.
> >
> 
> Sure.
> 
> >Also, when you start reusing rockchip_cfg_atu() in patch 3, you'll be
> >leaking virtual address space, as you'll keep remapping this every time.
> 
> How about just check if rockchip->msg_region was already mapped?
> Otherwise we don't remap it again when calling rockchip_cfg_atu.

That'd work, even if it's a little awkward. That's basically one of my
suggestions below.

> >You should straighten that out. Either some kind of check for
> >'if (!rockchip->msg_region)', or just do the map/unmap where it's
> >actually used (in patch 3).
> 
> Should we really need to unmap it? As this driver won't be a module and
> I think it's okay to keep the rockchip->msg_region always.

No, I guess we don't really need to unmap it. I just meant, you could
map/unmap every time you use it, or make sure you just map it once (and
only once).

Also (if it helps), you could use devm_ioremap(), in case you ever do
make it removable.

Brian
