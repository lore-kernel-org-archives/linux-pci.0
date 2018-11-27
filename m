Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CF6C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 16:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42715208E4
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 16:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42715208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeK1DsO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:48:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729321AbeK1DsO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 22:48:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C026AA048A;
        Tue, 27 Nov 2018 16:49:44 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 937175C1B2;
        Tue, 27 Nov 2018 16:49:44 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id wARGniZo029271;
        Tue, 27 Nov 2018 11:49:44 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id wARGnhKn029267;
        Tue, 27 Nov 2018 11:49:43 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 27 Nov 2018 11:49:43 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     linux-pci@vger.kernel.org, Tal Gilboa <talgi@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] pci: fix incorrect value returned from
 pcie_get_speed_cap
In-Reply-To: <20181126224051.GB212532@google.com>
Message-ID: <alpine.LRH.2.02.1811271144420.27588@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1810301232310.23106@file01.intranet.prod.int.rdu2.redhat.com> <20181120004704.GA191199@google.com> <20181126224051.GB212532@google.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 27 Nov 2018 16:49:44 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Mon, 26 Nov 2018, Bjorn Helgaas wrote:

> On Mon, Nov 19, 2018 at 06:47:04PM -0600, Bjorn Helgaas wrote:
> > On Tue, Oct 30, 2018 at 12:36:08PM -0400, Mikulas Patocka wrote:
> > > The macros PCI_EXP_LNKCAP_SLS_*GB are values, not bit masks. We must mask
> > > the register and compare it against them.
> > > 
> > > This patch fixes errors "amdgpu: [powerplay] failed to send message 261
> > > ret is 0" errors when PCIe-v3 card is plugged into PCIe-v1 slot, because
> > > the slot is being incorrectly reported as PCIe-v3 capable.
> > > 
> > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > Fixes: 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link speed")
> > > Cc: stable@vger.kernel.org	# v4.17+
> > > 
> > > ---
> > >  drivers/pci/pci.c |    8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > Index: linux-4.19/drivers/pci/pci.c
> > > ===================================================================
> > > --- linux-4.19.orig/drivers/pci/pci.c	2018-10-30 16:58:58.000000000 +0100
> > > +++ linux-4.19/drivers/pci/pci.c	2018-10-30 16:58:58.000000000 +0100
> > > @@ -5492,13 +5492,13 @@ enum pci_bus_speed pcie_get_speed_cap(st
> > >  
> > >  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> > >  	if (lnkcap) {
> > > -		if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
> > > +		if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_16_0GB)
> > >  			return PCIE_SPEED_16_0GT;
> > > -		else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
> > > +		else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_8_0GB)
> > >  			return PCIE_SPEED_8_0GT;
> > > -		else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
> > > +		else if ((lnkcap & PCI_EXP_LNKCAP_SLS) ==PCI_EXP_LNKCAP_SLS_5_0GB)
> > >  			return PCIE_SPEED_5_0GT;
> > > -		else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
> > > +		else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
> > >  			return PCIE_SPEED_2_5GT;
> > >  	}
> 
> > We also need similar fixes in pci_set_bus_speed(), pcie_speeds()
> > (hfi1), cobalt_pcie_status_show(), hba_ioctl_callback(),
> > qla24xx_pci_info_str(), and maybe a couple other places.
> 
> Does anybody want to volunteer to fix the places above as well?  I
> found them by grepping for PCI_EXP_LNKCAP, and they're all broken in
> ways similar to pcie_get_speed_cap().  Possibly some of these places
> could use pcie_get_speed_cap() directly.
> 
> Bjorn
> 

They are not broken, they are masking the value with PCI_EXP_LNKCAP_SLS - 
that is correct.

pci_set_bus_speed:
                pcie_capability_read_dword(bridge, PCI_EXP_LNKCAP, &linkcap);
                bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];

pcie_speeds:
	if ((linkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_8_0GB)

cobalt_pcie_status_show:
	just prints the values without doing anything with them

hba_ioctl_callback:
	gai->pci.link_speed_max = (u8)(caps & PCI_EXP_LNKCAP_SLS);

	gai->pci.link_width_max = (u8)((caps & PCI_EXP_LNKCAP_MLW) >> 4);

qla24xx_pci_info_str:
	lspeed = lstat & PCI_EXP_LNKCAP_SLS;
	lwidth = (lstat & PCI_EXP_LNKCAP_MLW) >> 4;

Mikulas
