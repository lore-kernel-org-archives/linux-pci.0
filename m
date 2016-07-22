Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] ARM: DRA7: select PCI_DOMAINS config
To: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
References: <1469102276-14777-1-git-send-email-kishon@ti.com>
 <1469102276-14777-3-git-send-email-kishon@ti.com>
 <8047226.VhgpLo8JQu@wuerfel> <20160722071644.GZ28140@atomide.com>
CC: <bcousson@baylibre.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <linux@armlinux.org.uk>,
	<linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5791D8C7.5020303@ti.com>
Date: Fri, 22 Jul 2016 13:56:47 +0530
MIME-Version: 1.0
In-Reply-To: <20160722071644.GZ28140@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 22 July 2016 12:46 PM, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [160721 05:08]:
>> On Thursday, July 21, 2016 5:27:56 PM CEST Kishon Vijay Abraham I wrote:
>>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>>> index 1a648e9..8e6e2c0 100644
>>> --- a/arch/arm/mach-omap2/Kconfig
>>> +++ b/arch/arm/mach-omap2/Kconfig
>>> @@ -86,6 +86,7 @@ config SOC_DRA7XX
>>>         select OMAP_INTERCONNECT_BARRIER
>>>         select PM_OPP if PM
>>>         select ZONE_DMA if ARM_LPAE
>>> +       select PCI_DOMAINS if PCI
>>>  
>>>  config ARCH_OMAP2PLUS
>>>         bool
>>>
>>
>> Should we just set this unconditionally for ARCH_MULTIPLATFORM maybe?
> 
> Makes sense to me if many SoCs need this.

since it doesn't harm even if a platform has a single PCIe port, it should be
okay to set PCI_DOMAINS. I'll resend the following as a separate patch if it's
okay.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 90542db..0cccb50 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -338,6 +338,7 @@ config ARCH_MULTIPLATFORM
        select MULTI_IRQ_HANDLER
        select SPARSE_IRQ
        select USE_OF
+       select PCI_DOMAINS if PCI

 config ARM_SINGLE_ARMV7M
        bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"

Thanks
Kishon
