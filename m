Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16444C433DB
	for <linux-pci@archiver.kernel.org>; Wed, 17 Feb 2021 21:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D497464E58
	for <linux-pci@archiver.kernel.org>; Wed, 17 Feb 2021 21:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhBQVTB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:19:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232949AbhBQVS7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Feb 2021 16:18:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3356164E4B;
        Wed, 17 Feb 2021 21:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613596698;
        bh=pkmZzDM0o+Q8ug092G5wDu/oWkG8+4OHqf+YvLIFwk4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e9c+nKfQzioYPmIvmLlOftUtpqt9QiJeaRu3owKX2bfboDCERP7uYecb3ESEQzCgN
         3IRb6pw2o4ITRQqaYE1Czo5AigFxzjzoGSRTSeHSXkgyLZF/5pZHku9aQ0WYUhp857
         ICRcTFkH08/0J9iob3VQKDVFiJApxUcK0UyoyAiIbp5KCRyJWgZIOgmuFzXXoZ+Uax
         ZU3iaNCBJQKaO5n8rnK12OLNwd06rZDKdg3nuk1gHWHus5JaAALZ46C+oSV3AELRW9
         eBOjHWfU+aUbr9m5gOTEgwOTCt4T21NSFJwOaqQMDNlpbfDL7ggEPt+C35Pvmx3fjm
         2X4J5DLrrdpGQ==
Date:   Wed, 17 Feb 2021 15:18:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Antti =?iso-8859-1?Q?J=E4rvinen?= <antti.jarvinen@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] PCI: quirk for preventing bus reset on TI C667X
Message-ID: <20210217211817.GA914074@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210121235547.GA2705432@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 21, 2021 at 05:55:47PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 12, 2021 at 03:36:43PM +0000, Antti Järvinen wrote:
> > TI C667X does not support bus/hot reset.
> > See https://e2e.ti.com/support/processors/f/791/t/954382
> 
> You can cite the URL as the source, but the URL will eventually become
> stale, so let's include the relevant details here directly.  

Thanks for trying the experiment below.  I'll look for a repost that
includes details from the URL directly in the commit log.

> From the forum, it looks like the device doesn't respond after a
> reset (config accesses return ~0).  It seems somewhat surprising that
> something as basic as a reset would be completely broken.  I wonder if
> we're not doing the reset correctly.
> 
> It looks like we would probably be trying a Secondary Bus Reset using
> the bridge leading to the C667X.  Can you confirm?  Wonder if you
> could try doing what pci_reset_secondary_bus() does by hand:
> 
>   # BRIDGE=...                              # PCI address, e.g., 00:1c.0
>   # C667X=...
>   # setpci -s$C667X VENDOR_ID.w
>   # setpci -s$BRIDGE BRIDGE_CONTROL.w       # prints "val"
>   # setpci -s$BRIDGE BRIDGE_CONTROL.w=      # val | 0x40 (set SBR)
>   # sleep 1
>   # setpci -s$BRIDGE BRIDGE_CONTROL.w=      # val (clear SBR)
>   # sleep 1
>   # setpci -s$C667X VENDOR_ID.w=0
>   # setpci -s$C667X VENDOR_ID.w
> 
> If we use this quirk and avoid the reset, I assume that means
> assigning the device to VMs with VFIO will leak state between VMs?
> 
> > Signed-off-by: Antti Järvinen <antti.jarvinen@gmail.com>
> > ---
> >  drivers/pci/quirks.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 653660e3ba9e..c8fcf24c5bd0 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3578,6 +3578,12 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
> >   */
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
> >  
> > +/*
> > + * Some TI keystone C667X devices do no support bus/hot reset.
> > + * https://e2e.ti.com/support/processors/f/791/t/954382
> > + */
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
> > +
> >  static void quirk_no_pm_reset(struct pci_dev *dev)
> >  {
> >  	/*
> > -- 
> > 2.17.1
> > 
