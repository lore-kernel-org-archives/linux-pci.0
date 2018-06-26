Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751634AbeFZQus (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jun 2018 12:50:48 -0400
MIME-Version: 1.0
References: <20180619112105.14457-1-lorenzo.pieralisi@arm.com> <20180626155928.GA7233@red-moon>
In-Reply-To: <20180626155928.GA7233@red-moon>
From: Rob Herring <robh@kernel.org>
Date: Tue, 26 Jun 2018 10:50:36 -0600
Message-ID: <CAL_JsqLbXFxemR+1gLuE-Wj=jfhoyhnXoXBK4JZS7NsiU=eYCg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: controller: Move PCI_DOMAINS selection to arch Kconfig
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 26, 2018 at 9:58 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Jun 19, 2018 at 12:21:05PM +0100, Lorenzo Pieralisi wrote:
> > Commit 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
> > added configuration options to allow PCI host controller drivers to be
> > compile tested on all architectures.
> >
> > Some host controller drivers (eg PCIE_ALTERA) config entries select
> > the PCI_DOMAINS config option to enable PCI domains management in
> > the kernel. Now that host controller drivers can be compiled on
> > all architectures, this triggers build regressions on arches that
> > do not implement the PCI_DOMAINS required API (ie pci_domain_nr()):
> >
> > drivers/ata/pata_ali.c: In function 'ali_init_chipset':
> > drivers/ata/pata_ali.c:469:38: error:
> >         implicit declaration of function 'pci_domain_nr';
> >                                           did you mean 'pci_iomap_wc'?
> >
> > Furthemore, some software configurations (ie Jailhouse) require a
> > PCI_DOMAINS enabled kernel to configure multiple host controllers
> > without having an explicit dependency on the ARM platform on which
> > they run.
> >
> > Make PCI_DOMAINS a visible configuration option on ARM so that software
> > configurations that need it can manually select it and move the
> > PCI_DOMAINS selection from PCI controllers configuration file to ARM
> > sub-arch config entries that currently require it, fixing the issue.
> >
> > Fixes: 51bc085d6454 ("PCI: Improve host drivers compile test coverage")
> > Link: https://lkml.kernel.org/r/20180612170229.GA10141@roeck-us.net
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Scott Branden <scott.branden@broadcom.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Ley Foon Tan <lftan@altera.com>
> > ---
>
> Bjorn, Rob,
>
> if you are OK with this patch I think it is ready to go, hopefully for
> -rc3 since currently sparc allmodconfig is still broken as Guenter
> reported in the Link I embedded in the patch itself, please let me
> know, thanks.

LGTM

Acked-by: Rob Herring <robh@kernel.org>
