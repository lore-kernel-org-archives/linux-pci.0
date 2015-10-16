Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20151015165105.GE32532@n2100.arm.linux.org.uk>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com> <20151015165105.GE32532@n2100.arm.linux.org.uk>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 15 Oct 2015 20:00:41 -0500
Message-ID: <CAL_JsqJTjCT8D-3OryFPEF8nnaPtrai7Mvf-gJRkh60aDixx-g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Common SerDes driver for TI's Keystone Platforms
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: WingMan Kwok <w-kwok2@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Roger Quadros <rogerq@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 15, 2015 at 11:51 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Oct 15, 2015 at 10:25:43AM -0400, WingMan Kwok wrote:
>> On TI's Keystone platforms, several peripherals such as the
>> gbe ethernet switch, 10gbe ethether switch and PCIe controller
>> require the use of a SerDes for converting SoC parallel data into
>> serialized data that can be output over a high-speed electrical
>> interface, and also converting high-speed serial input data
>> into parallel data that can be processed by the SoC.  The
>> SerDeses used by those peripherals, though they may be different,
>> are largely similar in functionality and setup.
>
> Given that serdes is not specific to TI, should this be specific to
> TI, or should there be an effort to come up with something which
> everyone who has serdes links can make use of?
>
> Serdes comes in multiple different forms: PCIe, 1G SGMII ethernet,
> 1000base-X ethernet, 10g ethernet, SATA... I'd hate to see a
> plethora of SoC specific stuff for this.

The licensed IP I've seen doesn't provide a standard register
interface, but just signals to the IP block. Same with PLL IP. So
we'll probably get to see vendors continue to differentiate on PHY
register design. :)

Rob
