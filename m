Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:40465
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754522Ab3KYTAM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Nov 2013 14:00:12 -0500
From: Rajat Jain <rajatjain@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Subject: RE: pciehp LinkState
Date: Mon, 25 Nov 2013 19:00:01 +0000
Message-ID: <01b89ce965ed454fb9f0e0cf52ba622e@BLUPR05MB118.namprd05.prod.outlook.com>
References: <528D4739.80700@fold.natur.cuni.cz>
 <CAErSpo7LcyL+K5rg+aNaaNzLXKyxvfAgeOPidb_3LqU3B2LXzA@mail.gmail.com>
In-Reply-To: <CAErSpo7LcyL+K5rg+aNaaNzLXKyxvfAgeOPidb_3LqU3B2LXzA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Martin,

> >
> > Below is the overview since cold boot with no card inserted with all
> those hotplug events. You see,
> > pciehp never sets LinkState back to minus once the slot is empty:
> >
> > vostro ~ # grep LinkState
> pciehp/3.12/cold_boot_no_card_in_slot/lspci_vvv_initial__inserted__eject
> ed_but_not_realized__inserted__ejected.txt
> >                         Changed: MRL- PresDet- LinkState-
> >                         Changed: MRL- PresDet- LinkState+
> >                         Changed: MRL- PresDet- LinkState+
> >                         Changed: MRL- PresDet- LinkState+
> >                         Changed: MRL- PresDet- LinkState+
> 
> I opened https://bugzilla.kernel.org/show_bug.cgi?id=65521 for this
> issue.  I agree that pciehp should probably clear this bit.  Rajat
> recently posted some patches [1] that add support for link state
> changes.  I haven't look at them in detail yet, but I wouldn't be
> surprised if they will fix this issue.  If you wanted to test them,
> that would be awesome!
> 
> Bjorn
> 
> [1] http://lkml.kernel.org/r/528BE8B6.9080007@gmail.com
> --

Yes, this issue should be fixed by the following 2 patches:

https://lkml.org/lkml/2013/11/19/542
https://lkml.org/lkml/2013/11/19/543

The particular hunk you want to be looking at is this:

@@ -661,7 +669,7 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 
 		detected &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
 			     PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC |
-			     PCI_EXP_SLTSTA_CC);
+			     PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC);
 		detected &= ~intr_loc;
 		intr_loc |= detected;
 		if (!intr_loc)


Would you be please kind enough to test the patch out? No need to pass any module parameter (Just apply patch and build & boot normally like you would).

Thanks,

Rajat

