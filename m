Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56360 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758213AbcAKIJX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Jan 2016 03:09:23 -0500
Subject: Re: [PATCH 0/2] DRA72/DRA74: Add 2 lane support
To: Tony Lindgren <tony@atomide.com>,
	Bjorn Helgaas <helgaas@kernel.org>
References: <1452077393-25880-1-git-send-email-kishon@ti.com>
 <20160107174126.GB14105@localhost> <20160107181320.GO12777@atomide.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nsekhar@ti.com>, Richard Cochran <richardcochran@gmail.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5693631E.2050807@ti.com>
Date: Mon, 11 Jan 2016 13:39:02 +0530
MIME-Version: 1.0
In-Reply-To: <20160107181320.GO12777@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tony,

On Thursday 07 January 2016 11:43 PM, Tony Lindgren wrote:
> * Bjorn Helgaas <helgaas@kernel.org> [160107 09:42]:
>> [+cc Richard]
>>
>> Hi Kishon,
>>
>> On Wed, Jan 06, 2016 at 04:19:51PM +0530, Kishon Vijay Abraham I wrote:
>>> Add driver modifications in pci-dra7xx to get x2 mode working in
>>> DRA72 and DRA74. Certain modifications is needed in PHY driver also
>>> which will be sent as a separate series.
>>>
>>> Certain board modifications has to be done in order to test
>>> x2 mode in dra72-evm.
>>>
>>> These patches were created on pci next.
>>>
>>> Changes from RFC:
>>> *) .b1co_mode_sel_mask is now set with the correct value.
>>> *) cleanup the patch
>>>
>>> Kishon Vijay Abraham I (2):
>>>   pci: host: pci-dra7xx: use "num-lanes" property to find phy count
>>>   pci: host: pci-dra7xx: Enable x2 mode support
>>>
>>>  Documentation/devicetree/bindings/pci/ti-pci.txt |    8 +-
>>>  drivers/pci/host/pci-dra7xx.c                    |  104 +++++++++++++++++++---
>>>  2 files changed, 97 insertions(+), 15 deletions(-)
>>
>> Apparently dra7xx in mainline doesn't work [1].  Until that's
>> resolved, I'm going to ignore dra7xx patches.
> 
> Agreed. Guys, please do the development _and_ testing on the mainline
> kernel. We do have the mainline kernel usable for probably a few
> tens of omap SoC variants. If you have issues using dra7 with mainline,
> please fix those issues ASAP.

Here Bjorn meant pci-dra7xx is broken in mainline and not the dra7xx boot
as such. (which is due to the absence of reset controller driver).
All the patches to pci-dra7xx were tested on mainline kernel (having
out-of-tree reset patches since the reset controller driver is not merged).
> 
> Ideally of course please also use the device you're working on to
> send out the patches :)

dra7x is the only device that use this pci driver and all the patches to
pci-dra7xx have been tested on both dra7 and dra72 boards.

Thanks
Kishon
