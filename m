Return-Path: <SRS0=eKEb=D4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB1AC4363D
	for <linux-pci@archiver.kernel.org>; Wed, 21 Oct 2020 02:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7704F2242E
	for <linux-pci@archiver.kernel.org>; Wed, 21 Oct 2020 02:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603246894;
	bh=jBI/vfiH0/foZeRbssb+AfO/KpFBjMPIAtNkj04lZZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=T7FpPQArlioBWV5qHgmuSpK7Nl3NUQE44TomWXZ42zEyS8dTl9n+zq6BQwwNlu4FZ
	 zF12fRRbRp8Ixay7Ebu+lv9kxv+85uwuUKqCpsgdjcFZg1cKrgJ3Pi6k45LYNo/v3V
	 Awi8u/kMINahEFgR7/AOhouT0oBgk1Ti1qEqMLN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411205AbgJUCVd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Oct 2020 22:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411203AbgJUCVd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Oct 2020 22:21:33 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8509D21707;
        Wed, 21 Oct 2020 02:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603246892;
        bh=jBI/vfiH0/foZeRbssb+AfO/KpFBjMPIAtNkj04lZZQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CHVOEEBRb8+GY22fpajxW5NweaXT0tYmlYif03Tszyj1iEniEIA/oDsty8AM36hOj
         NI5W4wNuJtIyN1A6VsxRnu32TaaEj2nFBbPx5/a5fnCcjKZQz3iznuMvzfOatqqH0X
         hIbFS2m9N2KElQKmPMZJKFk3LG0q5AYyhVTLb/TA=
Date:   Tue, 20 Oct 2020 21:21:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Kalakota, SushmaX" <sushmax.kalakota@intel.com>
Subject: Re: [PATCH 5/6] x86/apic/msi: Use Real PCI DMA device when
 configuring IRTE
Message-ID: <20201021022131.GA409218@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7862c6f4ee5ccad035037473b211366e29436ba.camel@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 21, 2020 at 01:20:24AM +0000, Derrick, Jonathan wrote:
> On Tue, 2020-10-20 at 15:26 -0500, Bjorn Helgaas wrote:
> > On Tue, Jul 28, 2020 at 01:49:44PM -0600, Jon Derrick wrote:
> > > VMD retransmits child device MSI/X with the VMD endpoint's requester-id.
> > > In order to support direct interrupt remapping of VMD child devices,
> > > ensure that the IRTE is programmed with the VMD endpoint's requester-id
> > > using pci_real_dma_dev().
> > > 
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > 
> > As Thomas (and Stephen) pointed out, this conflicts with 7ca435cf857d
> > ("x86/irq: Cleanup the arch_*_msi_irqs() leftovers"), which removes
> > native_setup_msi_irqs().
> > 
> > Stephen resolved the conflict by dropping this hunk.  I would rather
> > just drop this patch completely from the PCI tree.  If I keep the
> > patch, (1) Linus will have to resolve the conflict, and worse, (2)
> > it's not clear what happened to the use of pci_real_dma_dev() here.
> > It will just vanish into the ether with no explanation other than
> > "this function was removed."
> > 
> > Is dropping this patch the correct thing to do?  Or do you need to add
> > pci_real_dma_dev() elsewhere to compensate?
>
> It would still need the pci_real_dma_dev() for IRTE programming.
> 
> I think at this point I would rather see 5+6 dropped and this included
> for TGL enablement:
> https://patchwork.kernel.org/project/linux-pci/patch/20200914190128.5114-1-jonathan.derrick@intel.com/

It's too late to add new things for v5.10.  I'll drop 5 and I'll be
happy to drop 6, too, if you want.  I have several comments/questions
on 6 anyway that I haven't finished writing up.

But if you'd rather have 1-4 + 6 in v5.10 instead of just 1-4, let me
know.

Bjorn
