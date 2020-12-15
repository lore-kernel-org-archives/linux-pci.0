Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A45BC2BB48
	for <linux-pci@archiver.kernel.org>; Tue, 15 Dec 2020 21:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3370A22CF8
	for <linux-pci@archiver.kernel.org>; Tue, 15 Dec 2020 21:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgLOVOi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:14:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:46028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbgLOVOP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 16:14:15 -0500
Date:   Tue, 15 Dec 2020 15:13:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608066804;
        bh=Tl+AHAiEloV2RzE/T/ArXnmAjvP/8CPsglA6SAsufUM=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=WohLkzyQ/s7yo82La2BLMPQ5y1pdwpTEvj/j8o8ZUlP+CXrlgJJM9qyHgfeLbTYLV
         MRuBi1FYCLDUsmL45tLxF2aLSyT4p/8NZg74orynMrfhT2aRWya1X0/Kd5AY5Ndndt
         JuVAimemjxQ0YHqr9dhn4rKiKE/6gjtWKU7vgps3l1zlbdEm1Fn3b0FLPN+66KL4oZ
         52u2tjjXgWcUFH1ym5BqHWwcD5yihlD2s9Fv6s0Oe4Ov//gbuGj2ghYSykep1FeB0z
         2bFqnhVaT1kZdGP7yexJgAZIKLbwUPo/2+RU4U/VE9rCNWVnJNThuqaeI460pVQnwl
         0YIv6qsG1k/SQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     John Smith <LK7S2ED64JHGLKj75shg9klejHWG49h5hk@protonmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Add function 1 DMA alias quirk for Marvell 9215
 SATA controller
Message-ID: <20201215211323.GA328545@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113204859.GA1134115@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 13, 2020 at 02:49:00PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 10, 2020 at 04:05:16PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Add function 1 DMA alias quirk for Marvell 88SS9215 PCIe SSD Controller.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=42679#c135
> > Reported-by: John Smith <LK7S2ED64JHGLKj75shg9klejHWG49h5hk@protonmail.com>
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Applied to for-linus for v5.10.

Oops, I blew it and forgot to ask Linus to pull this, so it didn't
make v5.10.  I will include it in the pull request for v5.11.

> > ---
> >  drivers/pci/quirks.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index f70692ac79c5..4d683a28b29f 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3998,6 +3998,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9183,
> >  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c46 */
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x91a0,
> >  			 quirk_dma_func1_alias);
> > +/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c135 */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9215,
> > +			 quirk_dma_func1_alias);
> >  /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c127 */
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9220,
> >  			 quirk_dma_func1_alias);
> > -- 
> > 2.25.1
> > 
