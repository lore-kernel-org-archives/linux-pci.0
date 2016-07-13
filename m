Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35077 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750912AbcGMCG3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2016 22:06:29 -0400
Received: by mail-pa0-f41.google.com with SMTP id dx3so12426786pab.2
        for <linux-pci@vger.kernel.org>; Tue, 12 Jul 2016 19:06:23 -0700 (PDT)
Date: Tue, 12 Jul 2016 19:05:31 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Wenrui Li <wenrui.li@rock-chips.com>,
	linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-rockchip@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
Message-ID: <20160713020531.GA14833@google.com>
References: <1467789398-13501-1-git-send-email-shawn.lin@rock-chips.com>
 <20160707003912.GB100467@google.com>
 <59b328c9-3a21-36fa-7f28-4ba24d77fef0@rock-chips.com>
 <20160713013117.GA130126@google.com>
 <95a7ffdd-becc-bb3f-c026-d07c691b7a53@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <95a7ffdd-becc-bb3f-c026-d07c691b7a53@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wed, Jul 13, 2016 at 09:45:43AM +0800, Shawn Lin wrote:
> 在 2016/7/13 9:31, Brian Norris 写道:
> >On Wed, Jul 13, 2016 at 09:10:15AM +0800, Shawn Lin wrote:
> >At some level, it's a matter of preference. But when you're talking
> >about the rk3399 PCIe "interrupt controller" domain, it seems that you
> >should be talking about HW bits in the controller -- i.e., you have a
> >4-bit interrupt status bitfield, that we typically call [0:3]. If you
> >use [1:4], then you have to remember to subtract 1 mentally when mapping
> >to the actual HW bit. I believe that confusion (since bitfields normally
> >count from 0) might have helped cause the infinite loop bug I noticed
> >too. And I also think that counting from 0 helps clarify the fact that
> >your interrupt controller indexing is an independent numbering from the
> >PCI interrupt numbering, even though they happen to map 1:1.
> 
> If that's the fact of how we should numbering our index base, we should
> probably start if from 5 as the layout of INTx is
> PCIE_CLIENT_INT_STATUS[5:8]... ?

Possibly better than starting from 1, but IMO also doesn't make sense,
because the other bits aren't interrupts you want to translate on behalf
of other devices (are they?) -- they're interrupt bits consumed by the
host controller itself. (If they are possibly needed for translation,
then sure, index the entire status register and handle it in the driver,
and start the INTx mapping from 5 here.)

[...]

> >If you still think it makes more sense to count from 1, then I won't
> >stop you.
> 
> I don't have a hard opinion for the index base as I think it's trivial.

It's simple, but I think it influenced code understanding and bugginess.

> So if it's more sensible to you, I will apply your suggestion.

Well, I was just offering my opinion. I think it makes more sense, but
maybe it doesn't to you.

Brian
