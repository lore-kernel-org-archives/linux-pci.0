Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:40232 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab3KSLdf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2013 06:33:35 -0500
From: Marek Vasut <marex@denx.de>
To: Jingoo Han <jg1.han@samsung.com>
Subject: Re: Kernel oops from pci_disable_msi
Date: Tue, 19 Nov 2013 12:24:57 +0100
Cc: "'Bjorn Helgaas'" <bhelgaas@google.com>,
	" =?iso-8859-1?q?=27Bj=F8rn_Erik?= Nilsen'" <ben@datarespons.no>,
	linux-pci@vger.kernel.org,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"'Mohit KUMAR DCG'" <Mohit.KUMAR@st.com>,
	"'Ajay KHANDELWAL'" <ajay.khandelwal@st.com>,
	"'Tim Harvey'" <tharvey@gateworks.com>
References: <528a1bb6.6a88700a.28c9.ffff824aSMTPIN_ADDED_MISSING@mx.google.com> <CAErSpo6Om_qa2AhXSfwYtMctohpVmqbvFHBqhaWk860+zPQdGA@mail.gmail.com> <001601cee4b3$7649f3c0$62dddb40$%han@samsung.com>
In-Reply-To: <001601cee4b3$7649f3c0$62dddb40$%han@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201311191224.57918.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Jingoo Han,

> On Tuesday, November 19, 2013 6:03 AM, Bjorn Helgaas wrote:
> > On Mon, Nov 18, 2013 at 2:01 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> On Mon, Nov 18, 2013 at 6:53 AM, Bjørn Erik Nilsen <ben@datarespons.no> 
wrote:
> >>> I just hit an kernel oops related to PCI (in
> >>> dw_msi_teardown_irq()/clear_irq() (pcie-designware))
> >>> 
> >>> Linux version 3.12.0-next-20131105 (bnilsen@bnilsen) (gcc version 4.7.2
> >>> (GCC) )
> >>> 
> >>> Problem seem to be dereferencing a null pointer returned from
> >>> irq_desc_get_msi_desc(desc) (see attached backtrace).
> >> 
> >> Included oops inline for ease of viewing/searching.  Jingooo, I assume
> >> you'll investigate this.  Let me know if otherwise.
> 
> (+cc Marek Vasut, Pratyush Anand, Kishon Vijay Abraham I,
>        Mohit KUMAR DCG, Ajay KHANDELWAL, Tim Harvey)
> 
> Sorry, I will not investigate this.
> 
> Bjørn Erik Nilsen,
> 
> Would you let us know the ARM platform and LAN card?
> If you let us know them, one of these pcie-designware related
> people would reproduce and look at the issue.
> 
> Best regards,
> Jingoo Han
> 
> >> Unable to handle kernel NULL pointer dereference at virtual address
> >> 00000020 pgd = 80004000
> >> [00000020] *pgd=00000000
> >> Internal error: Oops: 17 [#1] SMP ARM
> >> Modules linked in: sxdma(O)
> >> CPU: 1 PID: 569 Comm: i2cipc.B3 Tainted: G           O
> >> 3.12.0-next-20131105 #8 task: 9efcb600 ti: 9ec8c000 task.ti: 9ec8c000
> >> PC is at dw_msi_teardown_irq+0x40/0x118

see drivers/pci/host/pcie-designware.c :

336 static void dw_msi_teardown_irq(struct msi_chip *chip, unsigned int irq)
337 {
338         clear_irq(irq);
339 }

So, add such a print before the clear_irq() call:

pr_err("%i %i\n", chip != NULL, irq);

And let us know the result please.

Best regards,
Marek Vasut
