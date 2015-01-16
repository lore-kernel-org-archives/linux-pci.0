Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:22448 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbbAPKif convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jan 2015 05:38:35 -0500
Message-ID: <54B8EA1C.7070700@kosagi.com>
Date: Fri, 16 Jan 2015 18:38:20 +0800
From: Sean Cross <xobs@kosagi.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawn.guo@freescale.com>,
	devicetree@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Grant Likely <grant.likely@linaro.org>,
	linux-pci@vger.kernel.org, bunnie@kosagi.com
Subject: Re: [PATCH v2 0/4] Add support for kosagi novena
References: <1419237127-21763-1-git-send-email-xobs@kosagi.com> <20150116004615.GF29776@google.com>
In-Reply-To: <20150116004615.GF29776@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 16/01/2015 08:46, Bjorn Helgaas wrote:
> On Mon, Dec 22, 2014 at 04:32:03PM +0800, Sean Cross wrote:
>> The Kosagi Novena mainboard contains an i.MX6, along with a PCI Express slot.
>> This patchset adds regulator support to the PCI Express slot, and adds
>> device tree support for the Novena mainboard.
>>
>> Changes since v1:
>>     - Add 'kosagi' to vendor prefixes
>>     - Add LCD panel to simple-panel
>>     - Renamed power-supply to bus-supply
>>     - Replaced devm_regulator_get() with devm_regulator_get_optional()
>>     - Moved regulator_enable to imx6_add_pcie_port()
>>     - Removed fpga@1 from spi definition in dts -- will use overlays instead
>>
>> Sean Cross (4):
>>   drm/panel: simple: Add Innolux N133HSE panel support
>>   devicetree: bindings: Add vendor prefix for Kosagi
>>   PCI: imx6: Add power-supply support
> I guess we're waiting on a response to Arnd's question about making this
> more generic, so I'm dropping these from my queue pending that.
>
> Then we need a strategy for merging it since it crosses PCI/ARM/GPU.
> Please propose a strategy; it looks like the PCI part doesn't technically
> depend on the preceeding patches, but it's fine with me if you want to keep
> it all together.
>
The PCI part was there because without it, the system hard-locks during
boot without it.

However, I'm not sure that the power-supply is the correct approach,
because I can still see lockups even with the switch in place. I still
haven't found out the root cause of that problem.

One workaround is to simply enable that GPIO in the bootloader and leave
it on permanently.  Doing this mimics behavior on other platforms where
PCIe is permanently powered up, and since the patches are decoupled the
PCI patch can be applied at a later time.

I'd prefer to drop the PCI patch for now.  Would you like me to submit a
v3 with simply the drm/panel and devicetree patches?

>>   ARM: dts: imx6q: add Novena board
>>
>>  .../devicetree/bindings/pci/fsl,imx6q-pcie.txt     |   3 +
>>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>>  arch/arm/boot/dts/Makefile                         |   1 +
>>  arch/arm/boot/dts/imx6q-novena.dts                 | 856 +++++++++++++++++++++
>>  drivers/gpu/drm/panel/panel-simple.c               |  26 +
>>  drivers/pci/host/pci-imx6.c                        |  27 +
>>  6 files changed, 914 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/imx6q-novena.dts
>>
>> -- 
>> 2.1.3
>>


