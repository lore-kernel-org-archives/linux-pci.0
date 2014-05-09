Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:55984 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbaEIG7m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 May 2014 02:59:42 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Magnus Damm <damm@opensource.se>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pci: rcar host needs OF
Date: Fri, 09 May 2014 08:59:12 +0200
Message-ID: <13437915.HeCZ0zGaLk@wuerfel>
In-Reply-To: <9614403.Lyniq7F3TJ@wuerfel>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de> <CAMuHMdWBzBneDqyDxK5HU3Bt_5CyRfTM_f_6YGJHokG_v17_sw@mail.gmail.com> <9614403.Lyniq7F3TJ@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 08 May 2014 17:21:54 Arnd Bergmann wrote:
> On Thursday 08 May 2014 17:16:32 Geert Uytterhoeven wrote:
> > On Thu, May 8, 2014 at 5:06 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > >> @@ -27,7 +27,7 @@ config PCI_TEGRA
> > >>
> > >>   config PCI_RCAR_GEN2
> > >>         bool "Renesas R-Car Gen2 Internal PCI controller"
> > >> -       depends on ARCH_SHMOBILE || (ARM && COMPILE_TEST)
> > >> +       depends on ARCH_SHMOBILE || (ARM && OF && COMPILE_TEST)
> > >>         help
> > >>           Say Y here if you want internal PCI support on R-Car Gen2 SoC.
> > >>           There are 3 internal PCI controllers available with a single
> > >>
> > >
> > > This driver /should/ be able to be built for just the platform case
> > > so it sounds like f8f2fe7355fb stopped this but no-one has yet to
> > > notice.
> > 
> > You mean include/linux/of_pci.h should provide a dummy version of
> > of_irq_parse_and_map_pci() returning 0 in case OF=n?
> 
> Good idea, I'll give this patch some testing in the randconfig builder,
> replacing the one above.

The first version was flawed, I submitted a new patch "[PATCH] of/irq:
provide int of_irq_parse_and_map_pci wrapper" now.

	Arnd
