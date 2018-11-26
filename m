Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4FFC43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 22:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1337521104
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 22:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5AGo0my"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1337521104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeK0Jgd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:36:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbeK0Jgd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 04:36:33 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF80120873;
        Mon, 26 Nov 2018 22:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543272054;
        bh=j1341Bnqcyu9+IAaBiJqesu635sM195DdGOEjlubsMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5AGo0myT1q2mGxo7GLSHmvbPVcnVBOqsi7Hk56zYHQYVO7L5D1lMOHKIEoImmPO9
         ioNVaBhOaiTZ5W94ZLgG4WZv/7nTeqGI039q6xPtR4j5qqOSW4HgAfbGiWK3dyuRzY
         pST56hK28d1xDlDCvN2aCQl19xQ5AzOK4Z1KOovM=
Date:   Mon, 26 Nov 2018 16:40:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-pci@vger.kernel.org, Tal Gilboa <talgi@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] pci: fix incorrect value returned from pcie_get_speed_cap
Message-ID: <20181126224051.GB212532@google.com>
References: <alpine.LRH.2.02.1810301232310.23106@file01.intranet.prod.int.rdu2.redhat.com>
 <20181120004704.GA191199@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120004704.GA191199@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 19, 2018 at 06:47:04PM -0600, Bjorn Helgaas wrote:
> On Tue, Oct 30, 2018 at 12:36:08PM -0400, Mikulas Patocka wrote:
> > The macros PCI_EXP_LNKCAP_SLS_*GB are values, not bit masks. We must mask
> > the register and compare it against them.
> > 
> > This patch fixes errors "amdgpu: [powerplay] failed to send message 261
> > ret is 0" errors when PCIe-v3 card is plugged into PCIe-v1 slot, because
> > the slot is being incorrectly reported as PCIe-v3 capable.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > Fixes: 6cf57be0f78e ("PCI: Add pcie_get_speed_cap() to find max supported link speed")
> > Cc: stable@vger.kernel.org	# v4.17+
> > 
> > ---
> >  drivers/pci/pci.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > Index: linux-4.19/drivers/pci/pci.c
> > ===================================================================
> > --- linux-4.19.orig/drivers/pci/pci.c	2018-10-30 16:58:58.000000000 +0100
> > +++ linux-4.19/drivers/pci/pci.c	2018-10-30 16:58:58.000000000 +0100
> > @@ -5492,13 +5492,13 @@ enum pci_bus_speed pcie_get_speed_cap(st
> >  
> >  	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
> >  	if (lnkcap) {
> > -		if (lnkcap & PCI_EXP_LNKCAP_SLS_16_0GB)
> > +		if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_16_0GB)
> >  			return PCIE_SPEED_16_0GT;
> > -		else if (lnkcap & PCI_EXP_LNKCAP_SLS_8_0GB)
> > +		else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_8_0GB)
> >  			return PCIE_SPEED_8_0GT;
> > -		else if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
> > +		else if ((lnkcap & PCI_EXP_LNKCAP_SLS) ==PCI_EXP_LNKCAP_SLS_5_0GB)
> >  			return PCIE_SPEED_5_0GT;
> > -		else if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
> > +		else if ((lnkcap & PCI_EXP_LNKCAP_SLS) == PCI_EXP_LNKCAP_SLS_2_5GB)
> >  			return PCIE_SPEED_2_5GT;
> >  	}

> We also need similar fixes in pci_set_bus_speed(), pcie_speeds()
> (hfi1), cobalt_pcie_status_show(), hba_ioctl_callback(),
> qla24xx_pci_info_str(), and maybe a couple other places.

Does anybody want to volunteer to fix the places above as well?  I
found them by grepping for PCI_EXP_LNKCAP, and they're all broken in
ways similar to pcie_get_speed_cap().  Possibly some of these places
could use pcie_get_speed_cap() directly.

Bjorn
