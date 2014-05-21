Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56084 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaEUHxF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 May 2014 03:53:05 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Srikanth Thokala <sthokal@xilinx.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, will.deacon@arm.com,
	michals@xilinx.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Generic Configuration Access Mechanism support
Date: Wed, 21 May 2014 09:52:57 +0200
Message-ID: <4459842.TR2Vcq3XUx@wuerfel>
In-Reply-To: <CA+mB=1KsxjJR0Yswmo2y_Gej64OPZLddXxJ+qn8YOx7=_EsqeA@mail.gmail.com>
References: <1400422125-2209-1-git-send-email-sthokal@xilinx.com> <4223392.yrWc3QAXY9@wuerfel> <CA+mB=1KsxjJR0Yswmo2y_Gej64OPZLddXxJ+qn8YOx7=_EsqeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 20 May 2014 20:01:01 Srikanth Thokala wrote:
> On Mon, May 19, 2014 at 10:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sunday 18 May 2014 19:38:45 Srikanth Thokala wrote:
> >> +
> >> +     if (cfg->ops->is_valid_cfg_access) {
> >> +             if (!cfg->ops->is_valid_cfg_access(bus, devfn)) {
> >> +                     *val = PCI_CFG_INVALID_DEVFN;
> >> +                     return PCIBIOS_DEVICE_NOT_FOUND;
> >> +             }
> >> +     }
> >
> > Can you explain why this callback is needed? If the space for the
> > bus is mapped, any access should just work.
> 
> As I was explaining to Will, there are some controllers which doesn't
> return FF's
> when a device is not found on the bus (as per the PCI specification) and
> accessing such a device address from the kernel results in an external abort.
> So, I added this additional logic in my driver to bypass this and
> return FF's. Our IP
> and even other controllers like Tegra, Renesas have similar implementation.
> We cant think of a better solution and please let you us know if you
> have any inputs.

Does your hardware need this? My first response would otherwise be to
treat that as noncompliant and not handle this case in the generic implementation.

	Arnd
