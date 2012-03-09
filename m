Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:39984 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab2CIQp1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Mar 2012 11:45:27 -0500
Message-ID: <4F5A33A2.4000305@wwwdotorg.org>
Date: Fri, 09 Mar 2012 09:45:22 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 10/11] ARM: tegra: pcie: Add MSI support
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de> <1331218291-16119-11-git-send-email-thierry.reding@avionic-design.de> <4F59213F.6070107@wwwdotorg.org> <20120309065004.GD25208@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120309065004.GD25208@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/08/2012 11:50 PM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 03/08/2012 07:51 AM, Thierry Reding wrote:
>>> This commit adds support for message signaled interrupts to the Tegra
>>> PCIe controller.
>>>
>>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>>> ---
>>> This code is taken from the NVIDIA Vibrante kernel and therefore has no
>>> appropriate Signed-off-by from the original author. Maybe someone at
>>> NVIDIA can find out who wrote this code and maybe provide a proper
>>> Signed-off-by that I can add?
>>
>> I think if you look in:
>> git://nv-tegra.nvidia.com/linux-2.6.git android-tegra-2.6.36
>>
>> the following commits are what you're after:
>>
>> de7fd8768b32da66eaf4eaf58473c65f7a76808d
>> arm: tegra: pcie: enabling MSI support for pcie
>>
>> ac1f8310811c64a084511d2afc27f66334b31a81
>> ARM: tegra: pcie: fix return value from MSI irq routine
>>
>> Although the patch below only partially resembles those patches, I guess
>> because you've rewritten the code a lot to conform to the current kernel
>> APIs, clean stuff up, etc. Perhaps just saying "based on code by Krishna
>> Kishore <kthota@nvidia.com>" is enough...
> 
> Yes, it is indeed a major rewrite because the original code had some
> peculiarities and FIXME that I thought wouldn't make it through the review
> anyway so I fixed them up.
> 
> I'll add some comment about the original authorship. There is no official
> Signed-off-by in the original commit. Do I still need one or is it enough to
> mention the original authors in the commit message and add keep my own
> Signed-off-by?

Yes, I think just mentioning the original code author in free-form text,
and including only your S-o-b sounds good to me.
