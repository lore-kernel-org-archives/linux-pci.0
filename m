Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0241.outbound.protection.outlook.com ([207.46.163.241]:3316
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751919AbaEUIzo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 May 2014 04:55:44 -0400
From: Srikanth Thokala <srikanth.thokala@xilinx.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"will.deacon@arm.com" <will.deacon@arm.com>,
	Michal Simek <michals@xilinx.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: Generic Configuration Access Mechanism support
Date: Wed, 21 May 2014 08:54:02 +0000
References: <1400422125-2209-1-git-send-email-sthokal@xilinx.com>
 <4223392.yrWc3QAXY9@wuerfel>
 <CA+mB=1KsxjJR0Yswmo2y_Gej64OPZLddXxJ+qn8YOx7=_EsqeA@mail.gmail.com>
 <4459842.TR2Vcq3XUx@wuerfel>
In-Reply-To: <4459842.TR2Vcq3XUx@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Message-ID: <3cbd2d6c-20ba-49c2-af73-898ba28b5c9e@BN1BFFO11FD052.protection.gbl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Wednesday, May 21, 2014 1:23 PM
> To: Srikanth Thokala
> Cc: Bjorn Helgaas; will.deacon@arm.com; Michal Simek; linux-
> kernel@vger.kernel.org; linux-pci@vger.kernel.org
> Subject: Re: [PATCH] PCI: Generic Configuration Access Mechanism support
>
> On Tuesday 20 May 2014 20:01:01 Srikanth Thokala wrote:
> > On Mon, May 19, 2014 at 10:33 PM, Arnd Bergmann <arnd@arndb.de>
> wrote:
> > > On Sunday 18 May 2014 19:38:45 Srikanth Thokala wrote:
> > >> +
> > >> +     if (cfg->ops->is_valid_cfg_access) {
> > >> +             if (!cfg->ops->is_valid_cfg_access(bus, devfn)) {
> > >> +                     *val = PCI_CFG_INVALID_DEVFN;
> > >> +                     return PCIBIOS_DEVICE_NOT_FOUND;
> > >> +             }
> > >> +     }
> > >
> > > Can you explain why this callback is needed? If the space for the
> > > bus is mapped, any access should just work.
> >
> > As I was explaining to Will, there are some controllers which doesn't
> > return FF's when a device is not found on the bus (as per the PCI
> > specification) and accessing such a device address from the kernel
> > results in an external abort.
> > So, I added this additional logic in my driver to bypass this and
> > return FF's. Our IP and even other controllers like Tegra, Renesas
> > have similar implementation.
> > We cant think of a better solution and please let you us know if you
> > have any inputs.
>
> Does your hardware need this? My first response would otherwise be to
> treat that as noncompliant and not handle this case in the generic
> implementation.

Yes, my hardware needs this additional logic.

Srikanth

>
>       Arnd


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

