Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53271 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbbJOTfE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2015 15:35:04 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: linux-arm-kernel@lists.infradead.org,
	WingMan Kwok <w-kwok2@ti.com>, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org, kishon@ti.com,
	rogerq@ti.com, bhelgaas@google.com, ssantosh@kernel.org,
	linux@arm.linux.org.uk, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and pcie
Date: Thu, 15 Oct 2015 21:34:51 +0200
Message-ID: <6215485.RTPqreMEMX@wuerfel>
In-Reply-To: <561FCDC0.3080109@ti.com>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com> <5192855.p6QLDWTiVi@wuerfel> <561FCDC0.3080109@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 15 October 2015 12:01:04 Murali Karicheri wrote:
> 
> >> + * Redistributions in binary form must reproduce the above copyright
> >> + * notice, this list of conditions and the following disclaimer in the
> >> + * documentation and/or other materials provided with the
> >> + * distribution.
> >
> > The current code does not do this when compiled, which might be a
> > problem for distributors. Can you clarify the license?
> >
> Arnd,
> 
> Can you elaborate on this? I did a grep on the string "Redistributions 
> in binary form must reproduce the above copyright" and I could find 
> several instance of this. So I am not sure what you mean by "The current 
> code does not do this when compiled".

You write that the binary form of the code must produce the copyright
notice. I don't see any code that does this. If I was looking in the
wrong place, let me know.

	Arnd
