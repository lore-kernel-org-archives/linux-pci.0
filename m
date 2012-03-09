Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:40012 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab2CIQrP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Mar 2012 11:47:15 -0500
Message-ID: <4F5A340F.6080303@wwwdotorg.org>
Date: Fri, 09 Mar 2012 09:47:11 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 11/11] ARM: tegra: pcie: Add device tree support
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de> <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de> <4F59253D.7070100@wwwdotorg.org> <20120309063115.GA25208@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120309063115.GA25208@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/08/2012 11:31 PM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 03/08/2012 07:51 AM, Thierry Reding wrote:
>>> This commit adds support for instantiating the Tegra PCIe controller
>>> from a device tree.
>>>
>>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>>
>>> diff --git a/Documentation/devicetree/bindings/pci/tegra-pcie.txt b/Documentation/devicetree/bindings/pci/tegra-pcie.txt
>>
>>> +NVIDIA Tegra PCIe controller
>>> +
>>> +Required properties:
>>> +- compatible: "nvidia,tegra20-pcie"
>>> +- reg: physical base address and length of the controller's registers
>>> +- interrupts: the interrupt outputs of the controller
>>> +
>>> +Optional properties:
>>> +- pex-clk-supply: supply voltage for internal reference clock
>>> +- vdd-supply: power supply for controller (1.05V)
>>
>> Mark, Liam,
>>
>> Should those *-supply properties really be optional? I got the
>> impression talking to Mark in a different thread that all regulators
>> should exist, although their implementation may be via a fixed
>> regulator, with no GPIO, as determined by the board design.
> 
> If I read the TrimSlice code correctly, there is no regulator setup required
> to make PCIe work there presumably because they hardwire the proper voltages.

Yes. I believe that's exactly what the fixed regulator is for.

> On the other hand, maybe a better solution in this case would be to use the
> dummy regulator in those cases.

Mark indicated dummy regulators weren't the preferred mechanism:

http://lkml.org/lkml/2012/2/25/30
