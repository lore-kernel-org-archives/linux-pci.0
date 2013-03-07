Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from sabertooth01.qualcomm.com ([65.197.215.72]:12142 "EHLO
	sabertooth01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756060Ab3CGSIH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Mar 2013 13:08:07 -0500
From: "Huang, Xiong" <xiong@qca.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Wei Yang <weiyang@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"unified-drivers@lists.infradead.org"
	<unified-drivers@lists.infradead.org>,
	nic-devel <nic-devel@qca.qualcomm.com>
Subject: RE: [PATCH] PCI: add MSI INTX_DISABLE quirks for
 AR8161/AR8162/AR8171/AR8172
Date: Thu, 7 Mar 2013 18:08:04 +0000
Message-ID: <157393863283F442885425D2C4542856489D6E24@nasanexd02f.na.qualcomm.com>
References: <1362549547-2160-1-git-send-email-xiong@qca.qualcomm.com>
 <157393863283F442885425D2C4542856489D6DA2@nasanexd02f.na.qualcomm.com>
 <CAErSpo4BEiL6+0LJo0_yavVv4gTBanJnp39FUX8eNL9Lqbmtfg@mail.gmail.com>
In-Reply-To: <CAErSpo4BEiL6+0LJo0_yavVv4gTBanJnp39FUX8eNL9Lqbmtfg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > Wei, thanks for you feedback, this patch is just follow the function
> > 'quirk_msi_intx_disable_ati_bug' in quirks.c Is it ok if I revise code as:
> >         static void quirk_msi_intx_disable_qca_bug(struct pci_dev *dev)
> >         {
> >                 If (dev->revision < 0x18)
> >                         dev->dev_flags |=  PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG;
> >         }
> 
> Per the comment in pci_ids.h, you should not add #defines there unless they
> are used in more than one place.  So in this case, you would just use the hex
> constants directly in quirks.c, as we already do for the existing ATTANSIC
> quirks.
> 
> As far as the loop with pci_get_device(), the revised patch is probably what
> you want, but it is not functionally equivalent to the original.  Let's say you
> have two devices:
> 
>   1) 8161 rev 0x18
>   2) 8171 rev 0x17
> 
> The original patch will disable MSI for the 8161 because there is
> *another* device (the 8171) with rev < 0x18.  I doubt that's what you want.
> 
> I'd like to see a dev_info() saying that you're disabling MSI for this device so
> that when somebody complains "my device should be using MSI but isn't,"
> it's easy to figure out why not.
> 

Bjorn, your example is very clear for me. I made a bug for the original patch :)

BTW. The flag of PCI_DEV_FLAGS_MSI_INTX_DISABLE_BUG isn't disable MSI on such devices,
But not enable PCI INT_DISABLE bit for PCI_COMMAND register when enable MSI function.
Some devices like AR8161 with revision lower than 0x18 will not issue MSI interrupt if INT_DISABLE bit is set.

Thanks
Xiong
