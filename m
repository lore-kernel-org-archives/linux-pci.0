Return-Path: <SRS0=EWQp=EI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B2FC00A89
	for <linux-pci@archiver.kernel.org>; Mon,  2 Nov 2020 16:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A9A223AC
	for <linux-pci@archiver.kernel.org>; Mon,  2 Nov 2020 16:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HgFPoOIB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rklClo0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgKBQRC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 Nov 2020 11:17:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59864 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgKBQRC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 11:17:02 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604333820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gXzFcVSwJFFqoLLrujA4jAJHEyHNXRFQIhN+VNXicmY=;
        b=HgFPoOIBRNuVPGoUUvmvGsB8VJpKWZHeOHnLdsqKkgkM9BEq3bNVME4kfP61Je/O0ys40b
        VXtncmqLgwsFFjUKkdPdgyY1pTB31mSudl5mr1cJfKpQauOGCDBHnyiLcEx5qlCRpMSgh3
        WMBnlHm4gSrK4uDK5r2lgncrTO+ilUuaZSc4trHGUot/O4R/S32+2d0E4fP2F25T08EgXf
        3rCDoHC3rsBnEJyWhDNYfMZ++gvV9suuiYCbHHqgQSvweiGwXkeE898UjRMFsAlEYI/U+U
        HxszQRUC1f7/L5IuBgr7Fl+nb9t7+oWDXuV24SgnVL1u+nmhRS6NC8gQU2R2Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604333820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gXzFcVSwJFFqoLLrujA4jAJHEyHNXRFQIhN+VNXicmY=;
        b=rklClo0HDFR6EFdKXRKNqGCBmRVN66dhW9Qv73+dH+3iL1s7TLKWhiiS8HQjwiunOfNlnD
        OzxplicRw7W41uDg==
To:     Marc Zyngier <maz@kernel.org>
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <linux@fw-web.de>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Aw: Re: [PATCH] pci: mediatek: fix warning in msi.h
In-Reply-To: <df5565a2f1e821041c7c531ad52a3344@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de> <878sbm9icl.fsf@nanos.tec.linutronix.de> <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de> <87lfflti8q.wl-maz@kernel.org> <1604253261.22363.0.camel@mtkswgap22> <trinity-9eb2a213-f877-4af3-87df-f76a9c093073-1604255233122@3c-app-gmx-bap08> <87k0v4u4uq.wl-maz@kernel.org> <87pn4w90hm.fsf@nanos.tec.linutronix.de> <df5565a2f1e821041c7c531ad52a3344@kernel.org>
Date:   Mon, 02 Nov 2020 17:16:59 +0100
Message-ID: <87h7q791j8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 02 2020 at 11:30, Marc Zyngier wrote:
> On 2020-11-01 22:27, Thomas Gleixner wrote:
> The following patch makes it work for me (GICv3 guest without an ITS)by
> checking for the presence of an MSI domain at the point where we 
> actually
> perform this association, and before starting to scan for endpoints.
>
> I *think* this should work for the MTK thingy, but someone needs to
> go and check.
>
> Thanks,
>
>          M.
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4289030b0fff..bb363eb103a2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -871,6 +871,8 @@ static void pci_set_bus_msi_domain(struct pci_bus 
> *bus)
>   		d = pci_host_bridge_msi_domain(b);
>
>   	dev_set_msi_domain(&bus->dev, d);
> +	if (!d)
> +		bus->bus_flags |= PCI_BUS_FLAGS_NO_MSI;

Hrm, that might break legacy setups (no irqdomain support). I'd rather
prefer to explicitly tell the pci core at host registration time.

Bjorn?

Thanks,

        tglx
