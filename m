Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46031 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbbJTUrw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 20 Oct 2015 16:47:52 -0400
MIME-Version: 1.0
In-Reply-To: <20151020153942.GE8224@localhost>
References: <20151020153942.GE8224@localhost>
From: Rob Herring <robh@kernel.org>
Date: Tue, 20 Oct 2015 15:47:29 -0500
Message-ID: <CAL_Jsq+URYS5HSxLRuq7bhOtwGj_rySx2VqojivcoX0LproyoQ@mail.gmail.com>
Subject: Re: PCI Device Tree binding documentation links broken
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 20, 2015 at 10:39 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> Hi Linus,
>
> 301d2d87cb4f ("Documentation/devicetree: add a small note on PCI")
> added some useful links:
>
>   +PCI Bus Binding to: IEEE Std 1275-1994
>   +http://www.openfirmware.org/ofwg/bindings/pci/pci2_1.pdf

http://www.firmware.org/1275/bindings/pci/pci2_1.pdf

>
>   +Open Firmware Recommended Practice: Interrupt Mapping
>   +http://www.openfirmware.org/1275/practice/imap/imap0_9d.pdf

http://www.firmware.org/1275/practice/imap/imap0_9d.pdf

> But both links are now broken.  I looked a little bit, but didn't find
> anything that looked like a reliable source.  Do you know of anything
> better?

Here's the top level:

http://www.firmware.org/1275/home.html

There used to be several mirrors, but seems we're down to only this
one. I've at least archived it myself now:

wget -r http://www.firmware.org/1275/home.html

Rob
