Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:58667 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab2FTRrn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jun 2012 13:47:43 -0400
Message-ID: <4FE20CBB.7040500@wwwdotorg.org>
Date: Wed, 20 Jun 2012 11:47:39 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Mitch Bradley <wmb@firmworks.com>
CC: Thierry Reding <thierry.reding@avionic-design.de>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
References: <4FD84133.4060401@firmworks.com> <20120613075232.GA6139@avionic-0098.mockup.avionic-design.de> <4FD849CF.4030009@firmworks.com> <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de> <4FD85127.8050301@firmworks.com> <20120614091905.GA9081@avionic-0098.mockup.avionic-design.de> <4FDA2DDA.1030704@wwwdotorg.org> <20120614192903.GA2212@avionic-0098.mockup.avionic-design.de> <4FDA40A0.4030206@wwwdotorg.org> <20120615061236.GA4081@avionic-0098.mockup.avionic-design.de> <20120619133001.GB24138@avionic-0098.mockup.avionic-design.de> <4FE0EFBB.6090206@firmworks.com> <4FE1FB28.3080901@wwwdotorg.org> <4FE20B34.2090305@firmworks.com>
In-Reply-To: <4FE20B34.2090305@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/20/2012 11:41 AM, Mitch Bradley wrote:
> On 6/20/2012 6:32 AM, Stephen Warren wrote:
>> On 06/19/2012 03:31 PM, Mitch Bradley wrote:
>> ...
>>
>>
>> The third cell "offset" is necessary so that the size field has a number
>> space that can include it.
>>
>> Can you expand on that sentence a bit more; I don't quite understand
>> that aspect. Thanks.
> 
> The meaning of "size"(in the context of "reg" which is phys,size) is
> "the device occupies a
> contiguous sequence of addresses beginning at phys and continuing to
> phys+size-1". The
> implicit addition occurs on the last #size-cells cells of the phys.

Ah right of course - that makes perfect sense. Thanks.
