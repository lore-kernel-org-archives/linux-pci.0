Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:49335 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbJTIZG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Oct 2015 04:25:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: "Kwok, WingMan" <w-kwok2@ti.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	KISHON VIJAY ABRAHAM <kishon@ti.com>,
	"Quadros, Roger" <rogerq@ti.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"ssantosh@kernel.org" <ssantosh@kernel.org>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and pcie
Date: Tue, 20 Oct 2015 10:24:18 +0200
Message-ID: <4661946.mPHVFLWuan@wuerfel>
In-Reply-To: <56253B91.5040807@ti.com>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com> <230CBA6E4B6B6B418E8730AC28E6FC7E04229363@DFLE11.ent.ti.com> <56253B91.5040807@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday 19 October 2015 14:50:57 Murali Karicheri wrote:
> Arnd, by your statement 'I don't see any code that does this' do you 
> expect a piece of code that embed the license in the binary image? If 
> so, that seems weired to me.
> 
> Many of the drivers including this patch has the following statement in 
> the license that is additional company specific license such as BSD that 
> is applicable.
> 
> ==== Cut and pasted from drivers/crypto/fcrypt.c =======================
>   * 2. Redistributions in binary form must reproduce the above copyright
>   *    notice, this list of conditions and the following disclaimer in the
>   *    documentation and/or other materials provided with the distribution.
> =========================================================================
> I read this as if the source is compiled and distributed as a binary 
> either a kernel module ko file or as part of the kernel binary, this 
> term must apply. Usually this is part of documentation that goes with 
> the product AFAIK.

Sorry, my fault. This is indeed the standard BSD license, and
I misread this as having to produce the copyright statement
from the binary itself. Please ignore whatever I said on the
subject.

	Arnd
