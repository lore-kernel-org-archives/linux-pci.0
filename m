Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43039 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811AbbJPOLi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Oct 2015 10:11:38 -0400
Message-ID: <56210572.6020405@ti.com>
Date: Fri, 16 Oct 2015 10:10:58 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Rob Herring <robh+dt@kernel.org>
CC: WingMan Kwok <w-kwok2@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Roger Quadros <rogerq@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 0/2] Common SerDes driver for TI's Keystone Platforms
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com> <20151015165105.GE32532@n2100.arm.linux.org.uk> <CAL_JsqJTjCT8D-3OryFPEF8nnaPtrai7Mvf-gJRkh60aDixx-g@mail.gmail.com> <20151016080222.GH32532@n2100.arm.linux.org.uk>
In-Reply-To: <20151016080222.GH32532@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/16/2015 04:02 AM, Russell King - ARM Linux wrote:
> On Thu, Oct 15, 2015 at 08:00:41PM -0500, Rob Herring wrote:
>> On Thu, Oct 15, 2015 at 11:51 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Thu, Oct 15, 2015 at 10:25:43AM -0400, WingMan Kwok wrote:
>>>> On TI's Keystone platforms, several peripherals such as the
>>>> gbe ethernet switch, 10gbe ethether switch and PCIe controller
>>>> require the use of a SerDes for converting SoC parallel data into
>>>> serialized data that can be output over a high-speed electrical
>>>> interface, and also converting high-speed serial input data
>>>> into parallel data that can be processed by the SoC.  The
>>>> SerDeses used by those peripherals, though they may be different,
>>>> are largely similar in functionality and setup.
>>>
>>> Given that serdes is not specific to TI, should this be specific to
>>> TI, or should there be an effort to come up with something which
>>> everyone who has serdes links can make use of?
>>>
Russell,

The serdes on K2 are re-used on multiple hardware blocks as already 
indicated in this thread. It has got multiple lanes, each lane can be 
enabled/disabled, shutdown etc. Isn't generic phy framework added to 
support this type of hardware block? I see some enhancements needed for 
K2 serdes to support monitoring the serdes link and providing a status 
to the higher layer device. So I am not clear what different way you 
would like to handle serdes drivers? Why do you need a new framework?

Murali
>>> Serdes comes in multiple different forms: PCIe, 1G SGMII ethernet,
>>> 1000base-X ethernet, 10g ethernet, SATA... I'd hate to see a
>>> plethora of SoC specific stuff for this.
>>
>> The licensed IP I've seen doesn't provide a standard register
>> interface, but just signals to the IP block. Same with PLL IP. So
>> we'll probably get to see vendors continue to differentiate on PHY
>> register design. :)
>
> So what?  Network drivers differ radically in register design, yet we
> still have a standardised interface to network drivers.
>


-- 
Murali Karicheri
Linux Kernel, Keystone
