Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50851 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbcFAMYa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2016 08:24:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
	Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] pci: Add PCIe driver for Rockchip Soc
Date: Wed, 01 Jun 2016 14:24:19 +0200
Message-ID: <4741248.3AsB27IYfk@wuerfel>
In-Reply-To: <edd7ae48-fb73-41dd-51b7-6d61d1e92ae7@rock-chips.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com> <4816755.yFEaWXVu6I@wuerfel> <edd7ae48-fb73-41dd-51b7-6d61d1e92ae7@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, June 1, 2016 5:57:25 PM CEST Shawn Lin wrote:
> yes, that is what we need and we believe other host bridges have
> this requirements.  With your patch applied, we only need to
> implement our map0 callback here. Thanks for improving it.
> 
> BTW, would you mind that we pack your patch into my patchset for
> the next version if possible, or maybe you wanna upstream it
> by yourself? 

I think the patch still needs a little improvement and discussion.
I've just done a second version, and tried out converting two
of the existing drivers to it, with good results.

We might want to add another set of callbacks for the first indirect
level, as that could help designware, mvebu and rcar at the minimum.
We then end up with 'root' config, 'port type 1' config and
'device type 0' config, with the first two falling back on the third
when unavailable.

I'm sending out what I have now.

	Arnd
