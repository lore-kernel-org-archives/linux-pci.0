Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.140]:40223 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbcFPIBY (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2016 04:01:24 -0400
Subject: Re: [PATCH v3 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
To: Arnd Bergmann <arnd@arndb.de>, Shawn Lin <shawn.lin@rock-chips.com>
References: <1466041821-1649-1-git-send-email-shawn.lin@rock-chips.com>
 <5811436.gqkV56Lax5@wuerfel>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
From: Wenrui Li <wenrui.li@rock-chips.com>
Message-ID: <da207bdc-738f-f2b1-7026-e368355936e9@rock-chips.com>
Date: Thu, 16 Jun 2016 16:01:12 +0800
MIME-Version: 1.0
In-Reply-To: <5811436.gqkV56Lax5@wuerfel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



在 2016/6/16 15:00, Arnd Bergmann 写道:
> On Thursday, June 16, 2016 9:50:21 AM CEST Shawn Lin wrote:
>
>> +	reset-names = "core", "mgmt", "mgmt-sticky", "pipe";
>> +	phys = <&pcie_phy>;
>> +	phy-names = "pcie-phy";
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pcie_clkreq>;
>> +	#interrupt-cells = <1>;
>> +	interrupt-controller;
>> +	interrupt-map-mask = <0 0 0 7>;
>> +	interrupt-map = <0 0 0 1 &pcie0 1>,
>> +			<0 0 0 2 &pcie0 2>,
>> +			<0 0 0 3 &pcie0 3>,
>> +			<0 0 0 4 &pcie0 4>;
>> +};
>>
>
> One thing that came up in the review of the new Marvell PCIe driver is that it's
> most likely invalid for a device node to have both "interrupt-controller"
> and "interrupt-map" properties. I originally thought this was a nice way to
> handle embedded irqchips within the PCIe host, but it only really works
> by coincidence with the current kernel, and only as long as the hwirq number
> of the irqchip matches the integer representation of the irq line in the root
> bridge (which it does in the example above).
>
> For that driver we concluded that it would be less of a hack to have the
> irqchip as a child node of the PCIe host after all (just not with
> device_type="pci" of course), and that makes the translation work as
> expected.
>
> 	Arnd
>

Original driver have an irqchip as child node. But Marc suggested don't 
need an intermediate node here.
Now the conclusion is to retain the child node?

>
>

