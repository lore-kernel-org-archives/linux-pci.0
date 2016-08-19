Return-Path: <shawn.lin@rock-chips.com>
Return-Path: <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v9 2/2] PCI: Rockchip: Add Rockchip PCIe controller
 support
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1470297128-6213-1-git-send-email-shawn.lin@rock-chips.com>
 <1470297128-6213-2-git-send-email-shawn.lin@rock-chips.com>
 <20160818212444.GQ27353@localhost>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>,
 Doug Anderson <dianders@chromium.org>, Wenrui Li <wenrui.li@rock-chips.com>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 Brian Norris <briannorris@chromium.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <4a09c742-053b-7a16-efd1-a3c972d7c9a8@rock-chips.com>
Date: Fri, 19 Aug 2016 09:20:42 +0800
MIME-Version: 1.0
In-Reply-To: <20160818212444.GQ27353@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

在 2016/8/19 5:24, Bjorn Helgaas 写道:
> Hi Shawn,
>
> On Thu, Aug 04, 2016 at 03:52:08PM +0800, Shawn Lin wrote:
>> This patch adds Rockchip PCIe controller support found
>> on RK3399 Soc platform.
>
>> --- a/drivers/pci/host/Kconfig
>> +++ b/drivers/pci/host/Kconfig
>> @@ -264,4 +264,15 @@ config PCIE_ARTPEC6
>>  	  Say Y here to enable PCIe controller support on Axis ARTPEC-6
>>  	  SoCs.  This PCIe controller uses the DesignWare core.
>>
>> +config PCIE_ROCKCHIP
>> +	bool "Rockchip PCIe controller"
>> +	depends on ARM64 && ARCH_ROCKCHIP
>
> I don't see any actual ARM64 dependencies in the code (which is a very
> good thing!).  Can we remove the "depends on ARM64" part?

sure, we could. Actually we are going to use this controller for
arm32 as well, so yes, I will remove it.

>
>> +	depends on OF
>> +	depends on PCI_MSI_IRQ_DOMAIN
>> +	select MFD_SYSCON
>> +	help
>> +	  Say Y here if you want internal PCI support on Rockchip SoC.
>> +	  There is 1 internal PCIe port available to support GEN2 with
>> +	  4 slots.
>
>
>


-- 
Best Regards
Shawn Lin
