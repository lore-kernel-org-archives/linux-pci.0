Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A700BC433E9
	for <linux-pci@archiver.kernel.org>; Tue, 19 Jan 2021 22:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C73C230FE
	for <linux-pci@archiver.kernel.org>; Tue, 19 Jan 2021 22:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbhASWIt (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:08:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729645AbhASWIp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 17:08:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A443722E01;
        Tue, 19 Jan 2021 22:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611094085;
        bh=eW1/wXmaqahGEv5kWJWMoABKmMH5EpcvibsdR+tOxb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YcbHOMQu/OfKXtKwaNsArp/rnK1zUlAk2eGCOkNBZc5v/WN6RWRX7SiZ2i+7LWjMn
         M0e9sCiMwH/88PEt1EwsEESqSbjKd6GjwzrmP6Tx1feZ32dePd3w6PoaRc2WyDTasb
         +OrcFcs6S1J2c1fHXqN2hkA4mxQIOZ/o24Tl1/+DPCzLTissqqGBx059XM+wOAgOJc
         mhI2QEHOG4mJWPfOr/0ODutYCsDa+VhF9Bhx3tngEsuWPpYFjfd28U8ohkFcoZWveG
         Twrwd+iVUl9hGzp+7AUhEvSFQhcimATyCHoyjK/ORRJX6zljKTucqW55XBDZ/oLsL0
         6uk1v6vwooVmA==
Date:   Tue, 19 Jan 2021 16:08:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniele Palmas <dnlplm@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH 1/1] PCI: add Telit Vendor ID
Message-ID: <20210119220803.GA2510309@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119220619.GA2510101@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 19, 2021 at 04:06:21PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 19, 2021 at 11:27:57AM +0100, Daniele Palmas wrote:
> > Add Telit Vendor ID to pci_ids.h
> 
> From the top of the file:
> 
>  *      Do not add new entries to this file unless the definitions
>  *      are shared between multiple drivers.
> 
> If this is the case, include this patch in a series that adds multiple
> uses or mention the uses in this commit log.

Also, when you do, follow the subject convention (run "git log
--oneline include/linux/pci_ids.h" to see it).

> > Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
> > ---
> > Reference: https://pcisig.com/membership/member-companies?combine=telit
> > ---
> >  include/linux/pci_ids.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index d8156a5dbee8..b10a04783287 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2590,6 +2590,8 @@
> >  
> >  #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
> >  
> > +#define PCI_VENDOR_ID_TELIT		0x1c5d
> > +
> >  #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
> >  #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD	0x0001
> >  
> > -- 
> > 2.17.1
> > 
