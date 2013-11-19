Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:42160 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab3KSWLo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 17:11:44 -0500
From: Marek Vasut <marex@denx.de>
To: =?iso-8859-1?q?Bj=F8rn_Erik_Nilsen?= <ben@datarespons.no>
Subject: Re: Kernel oops from pci_disable_msi
Date: Tue, 19 Nov 2013 23:01:54 +0100
Cc: Jingoo Han <jg1.han@samsung.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"'Mohit KUMAR DCG'" <Mohit.KUMAR@st.com>,
	"'Ajay KHANDELWAL'" <ajay.khandelwal@st.com>,
	"'Tim Harvey'" <tharvey@gateworks.com>,
	Eric Nelson <Eric.Nelson@boundarydevices.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>
References: <528a1bb6.6a88700a.28c9.ffff824aSMTPIN_ADDED_MISSING@mx.google.com> <1384861142.3682.1.camel@bnilsen-HP-EliteBook-8760w> <cmu-lmtpd-19155-1384861370-13@frontend1.mail.m-online.net>
In-Reply-To: <cmu-lmtpd-19155-1384861370-13@frontend1.mail.m-online.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201311192301.54249.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjørn Erik Nilsen,

> On Tue, 2013-11-19 at 12:39 +0100, Bjørn Erik Nilsen wrote:
> > On Tue, 2013-11-19 at 12:24 +0100, Marek Vasut wrote:
> > > Dear Jingoo Han,
> > > 
> > > > On Tuesday, November 19, 2013 6:03 AM, Bjorn Helgaas wrote:
> > > > > On Mon, Nov 18, 2013 at 2:01 PM, Bjorn Helgaas <bhelgaas@google.com> 
wrote:
> > > > >> On Mon, Nov 18, 2013 at 6:53 AM, Bjørn Erik Nilsen
> > > > >> <ben@datarespons.no>
> > > 
> > > wrote:
> > > > >>> I just hit an kernel oops related to PCI (in
> > > > >>> dw_msi_teardown_irq()/clear_irq() (pcie-designware))
> > > > >>> 
> > > > >>> Linux version 3.12.0-next-20131105 (bnilsen@bnilsen) (gcc version
> > > > >>> 4.7.2 (GCC) )
> > > > >>> 
> > > > >>> Problem seem to be dereferencing a null pointer returned from
> > > > >>> irq_desc_get_msi_desc(desc) (see attached backtrace).
> > > > >> 
> > > > >> Included oops inline for ease of viewing/searching.  Jingooo, I
> > > > >> assume you'll investigate this.  Let me know if otherwise.
> > > > 
> > > > (+cc Marek Vasut, Pratyush Anand, Kishon Vijay Abraham I,
> > > > 
> > > >        Mohit KUMAR DCG, Ajay KHANDELWAL, Tim Harvey)
> > > > 
> > > > Sorry, I will not investigate this.
> > > > 
> > > > Bjørn Erik Nilsen,
> > > > 
> > > > Would you let us know the ARM platform and LAN card?
> > > > If you let us know them, one of these pcie-designware related
> > > > people would reproduce and look at the issue.
> > > > 
> > > > Best regards,
> > > > Jingoo Han
> > > > 
> > > > >> Unable to handle kernel NULL pointer dereference at virtual
> > > > >> address 00000020 pgd = 80004000
> > > > >> [00000020] *pgd=00000000
> > > > >> Internal error: Oops: 17 [#1] SMP ARM
> > > > >> Modules linked in: sxdma(O)
> > > > >> CPU: 1 PID: 569 Comm: i2cipc.B3 Tainted: G           O
> > > > >> 3.12.0-next-20131105 #8 task: 9efcb600 ti: 9ec8c000 task.ti:
> > > > >> 9ec8c000 PC is at dw_msi_teardown_irq+0x40/0x118
> > > 
> > > see drivers/pci/host/pcie-designware.c :
> > > 
> > > 336 static void dw_msi_teardown_irq(struct msi_chip *chip, unsigned int
> > > irq) 337 {
> > > 338         clear_irq(irq);
> > > 339 }
> > > 
> > > So, add such a print before the clear_irq() call:
> > > 
> > > pr_err("%i %i\n", chip != NULL, irq);
> > > 
> > > And let us know the result please.
> > 
> > Here's what I get:
> > 
> > 1 391
> > 1 392
> 
> Also worth to mention is that I trigger this behavior by removing the
> device:
> 
> echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove

Just for completeness, is this pure next or something else, like the 
boundarydevices's kernel ?

Best regards,
Marek Vasut
