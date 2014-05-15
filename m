Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53971 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754254AbaEONdX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 May 2014 09:33:23 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robherring2@gmail.com>,
	Will Deacon <will.deacon@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	srikanth t <sthokal@xilinx.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 1/3] ARM: kconfig: allow PCI support to be selected with ARCH_MULTIPLATFORM
Date: Thu, 15 May 2014 15:32:46 +0200
Message-ID: <10281549.JzWby2ApEY@wuerfel>
In-Reply-To: <CAL_JsqLbWL136=dGZZfzPbPdF5HjhktYwLaVfbkOoo7Tr+g9Pg@mail.gmail.com>
References: <1399478839-3564-1-git-send-email-will.deacon@arm.com> <20140515123948.GD27594@arm.com> <CAL_JsqLbWL136=dGZZfzPbPdF5HjhktYwLaVfbkOoo7Tr+g9Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 15 May 2014 08:16:16 Rob Herring wrote:
> On Thu, May 15, 2014 at 7:39 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, May 14, 2014 at 03:01:35PM +0100, Rob Herring wrote:
> >> On Wed, May 7, 2014 at 11:07 AM, Will Deacon <will.deacon@arm.com> wrote:
> >> > When targetting ARCH_MULTIPLATFORM, we may include support for SoCs with
> >> > PCI-capable devices (e.g. mach-virt with virtio-pci).
> >> >
> >> > This patch allows PCI support to be selected for these SoCs by selecting
> >> > CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_MULTIPLATFORM=y.
> >>
> >> I generally think we should select all options for multi-platform that
> >> only serve to hide other options like this.
> >>
> >> You should remove the MIGHT_HAVE_PCI selections from all the
> >> multi-platform enabled platforms as well.
> >
> > Something like the diff below?
> 
> Yes, but that raises another question as to what do we do with
> PCI_DOMAINS? Probably should be a PCI host driver select, or given how
> little code it controls it could just be removed. Anyway, that's a
> problem for another day (or patch).
> 
> So with the below part added:
> 
> Acked-by: Rob Herring <robh@kernel.org>

I think we should also 'select PCI_DOMAINS if PCI' for multiplatform, but
I agree it doesn't have to be in this patch.

	Arnd
