Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56491 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbbLVSTh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Dec 2015 13:19:37 -0500
MIME-Version: 1.0
In-Reply-To: <56769A1F.3060607@ti.com>
References: <1450170968-11282-1-git-send-email-kishon@ti.com>
 <1450170968-11282-10-git-send-email-kishon@ti.com> <20151220033901.GI9883@rob-hp-laptop>
 <56769A1F.3060607@ti.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 22 Dec 2015 12:19:14 -0600
Message-ID: <CAL_JsqKEfUihk6kO+_KukNPGz4ZwT4S6v+coYqL+ZdQHpe5WSg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] phy: omap-usb2: use *syscon* framework API to
 power on/off the PHY
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Roger Quadros <rogerq@ti.com>, Sekhar Nori <nsekhar@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux USB List <linux-usb@vger.kernel.org>,
	Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Dec 20, 2015 at 6:07 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi Rob,
>
> On Sunday 20 December 2015 09:09 AM, Rob Herring wrote:
>> On Tue, Dec 15, 2015 at 02:46:08PM +0530, Kishon Vijay Abraham I wrote:
>>> Deprecate using phy-omap-control driver to power on/off the PHY,
>>> and use *syscon* framework to do the same. This handles
>>> powering on/off the PHY for the USB2 PHYs used in various TI SoCs.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/phy/ti-phy.txt |    8 +-
>>>  drivers/phy/phy-omap-usb2.c                      |   94 ++++++++++++++++++----
>>>  include/linux/phy/omap_usb.h                     |   23 ++++++
>>>  3 files changed, 107 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
>>> index 49e5b0c..a3b3945 100644
>>> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
>>> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
>>> @@ -31,6 +31,8 @@ OMAP USB2 PHY
>>>
>>>  Required properties:
>>>   - compatible: Should be "ti,omap-usb2"
>>> +           Should be "ti,dra7x-usb2-phy2" for the 2nd instance of USB2 PHY
>>> +           in DRA7x
>>
>> The 2nd instance is different somehow?
>
> yeah, the bit fields are slightly different.

Okay,

Acked-by: Rob Herring <robh@kernel.org>

Rob
