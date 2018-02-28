Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:36329 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeB1Bkn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Feb 2018 20:40:43 -0500
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 5/6] PCI: rockchip: Add Endpoint controller driver for
 Rockchip PCIe controller
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1519348503-243259-1-git-send-email-shawn.lin@rock-chips.com>
 <1519348654-243597-1-git-send-email-shawn.lin@rock-chips.com>
 <20180227153202.GB7184@e107981-ln.cambridge.arm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <8244c52c-73d3-5b20-eb39-ddc37968163a@rock-chips.com>
Date: Wed, 28 Feb 2018 09:40:36 +0800
MIME-Version: 1.0
In-Reply-To: <20180227153202.GB7184@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Lorenzo,

On 2018/2/27 23:32, Lorenzo Pieralisi wrote:
> On Fri, Feb 23, 2018 at 09:17:33AM +0800, Shawn Lin wrote:
>> This patch adds support to the Rockchip PCIe controller in endpoint mode
>> which currently supports up to 32 regions, and each regions should at
>> least be 1MB per TRM.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>

> 
> I reviewed this patch and I then realized that it is not bits, it is
> that the drivers are almost identical. Are we talking about the same IP
> (possibly with some HW wrapper of sorts) ?
> 

Nope, I would seriouly say they are not the same IP legally :)
If we take about IP, it's referred to a functional entity designed
and licensed by the provider, but it's not the case here since

(1) There is nothing about cadence throughout the TRM when upstreamed
it in 2016, and actually it was designed much earlier than 2016.
(2) Much of the flow was different, and even some of the bit offset is
different per my reading of cadence's driver, though most registers
looks much similar.

So my best guess was HW guys referenced to cadence's register layout(or
the reverse), so they are much partially compatible from the
register level POV, but the backend design are different leading to the
quite different control flow and also rockchip controller have lots of
HW bugs that I didn't see them when reviewing cadence's driver which do
the same flow using similar register. That's very common if you search
drivers/mmc/host/sdhci*, which means all of them share the *same*
register layout and control flow, so it makes software guys' life easy,
but still they are different IPs. But it's sightly different here as
the pcie registers aren't the totally same and the flow control is
different.

Also historically that happened for other controllers designed from 
rockchip, for instance, SPI controller looks much like designware one,
but the flow control was totally differnt preventing SW guys to
refactor the designware driver to fit for rockchip one.

This is all I could guess here, hope that help for you.


> 
> 
> 
