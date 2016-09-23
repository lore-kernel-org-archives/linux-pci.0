Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34162 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758614AbcIWBPW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 21:15:22 -0400
Received: by mail-pa0-f41.google.com with SMTP id wk8so34468202pab.1
        for <linux-pci@vger.kernel.org>; Thu, 22 Sep 2016 18:15:22 -0700 (PDT)
Date: Thu, 22 Sep 2016 18:15:19 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip: Support quirk to disable 5 GT/s (PCIe
 2.x) link rate
Message-ID: <20160923011518.GA97876@google.com>
References: <1474565478-27242-1-git-send-email-briannorris@chromium.org>
 <b9527acf-e3cf-19d2-b8fc-0a59637e9598@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <b9527acf-e3cf-19d2-b8fc-0a59637e9598@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Shawn,

On Fri, Sep 23, 2016 at 08:27:35AM +0800, Shawn Lin wrote:
> 在 2016/9/23 1:31, Brian Norris 写道:
> >rk3399 supports PCIe 2.x link speeds marginally at best, and on some
> >boards, the link won't train at 5 GT/s at all. Rather than sacrifice 500
> >ms waiting for training that will never happen, let's support a device
> >tree quirk flag to disable generation 2 speeds entirely.
> 
> I was thinking about could we get target link speed [TLS] from the
> end-point when finishing Gen1 training, but it seems that the location
> of ep's TLS is not fixed.

Indeed it's not, but we could probably handle that if absolutely needed
(get a reference to the root port pci_dev somehow, then use the existing
helpers to walk children and get the computed ->pcie_cap offset). But
that's not the problem here; we have 5 GT/s devices, but they are not
running at 5 GT/s because link training can't pass. We have been told
there are still SI issues, and so you wouldn't really be able to turn
this out at runtime anyway.

But sure, I suppose that'd be a way to (for chips/boards that don't have
SI issues) determine whether or not to attempt gen2 training at all.
That does sound better than just timing out after 500ms...

> Anyway, your patch looks sane to me as we leave gen2 as default and
> people could drop that feature by adding rockchip,disable-gen2 to
> their dts if they are sure the board would never supoort Gen2 devices.
> 
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks.

Brian
