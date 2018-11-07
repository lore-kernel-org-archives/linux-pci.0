Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F48C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 06:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D63920862
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 06:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mobiveil.co.in header.i=@mobiveil.co.in header.b="Y7L+bCd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D63920862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mobiveil.co.in
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeKGPiy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 10:38:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54101 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeKGPiy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Nov 2018 10:38:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id f10-v6so633616wme.3
        for <linux-pci@vger.kernel.org>; Tue, 06 Nov 2018 22:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mobiveil.co.in; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTqGwtBW9h3SDOdUQZ5pzprK2nMgrfWWhGmNrdZ31gU=;
        b=Y7L+bCd6qLivY1MC0ct11aPypZo5E2Lo68ohhZ7g0ns9QFiaFCPnPQO2AncsaSE/oE
         EAcjsF8hP8aQ+CPEa/LWZ9P0lJxvWfKeJPiDgLU2Qe3CumZf5cGN7GscbX2cKxHXtI+H
         BZr/AqMRJEPBQZ/Y+RxdlaYUZyEvm0oXBReUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTqGwtBW9h3SDOdUQZ5pzprK2nMgrfWWhGmNrdZ31gU=;
        b=tHp9q3AsUkbmN1AYr07spHYmbTWn7Hf9uJox/4acSs7QPjxIUTqHF+uz8FzsXbGZyo
         agb7xy4Fp99ZowqeY4byOUM+L37bMW2/jvB2fcwDEqLDS2yOuLQiAX2eAxS6Qdi1e5zQ
         H7xSGuNHmQwjKnlkDspB1/v8rP7qcIprE6i3yt+9AafvpcIbVl0WJSbmoFqQGDKT9BY3
         2/wHFVp91mYiqTHZhWg9qaZ81TOafg1wDTnVmI0lO6uaUtmx0q4K2v8i+tANcCppkW5k
         4tmeZN8F+lJrH0Jabi+OT32hV3+nMZGrEImbyu3qqfFekaAJr+H3OuWrGRb/9xItn5FP
         Jg2Q==
X-Gm-Message-State: AGRZ1gIWH0WfBfkyD4M3TjS2FqkhPioPqxgB8UZkqaaZJlthMVUcVzG6
        JTQe3G81G3dnmWxsMUnlvG47mk0nzgyiiFIef0QB5IvT3cw=
X-Google-Smtp-Source: AJdET5cnk10wjLsiKq5SfAW9CzFmCxbE4BZIWiXHP3mIYksTTZohp1yc/T+qquJUlH7YMAi/jiWxbeg699yiXmUQw3M=
X-Received: by 2002:a1c:d181:: with SMTP id i123-v6mr714798wmg.124.1541571000420;
 Tue, 06 Nov 2018 22:10:00 -0800 (PST)
MIME-Version: 1.0
References: <1541422301-29176-1-git-send-email-l.subrahmanya@mobiveil.co.in>
 <1541422301-29176-2-git-send-email-l.subrahmanya@mobiveil.co.in> <20181106142449.GA19060@e107981-ln.cambridge.arm.com>
In-Reply-To: <20181106142449.GA19060@e107981-ln.cambridge.arm.com>
From:   Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date:   Wed, 7 Nov 2018 11:40:04 +0530
Message-ID: <CAFZiPx38EuAFfqA0mK2SoZXoVB5VuKgb1P-qu5Z=J2WBRXdmvg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: mobiveil: fix multi function endpoint failures
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lorenzo,
Will do, thanks!

Yes please ignore the patch v1.

Thanks.

On Tue, Nov 6, 2018 at 7:54 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Nov 05, 2018 at 07:51:41AM -0500, Subrahmanya Lingappa wrote:
> > The fix enables mobiveil pcie controller to detect more than one
> > functions per device. Also increases the MSI interrupts.
>
> 1 patch, 1 logical change, you are making 1 patch 2 logical changes,
> split the patch in two and repost them please.
>
> I will consider patch v1 obsolete too, no idea why it was posted.
>
> Lorenzo
>
> > Fixes: 1e913e58335f ("PCI: mobiveil: Add MSI support")
> > Fixes: 9af6bcb11e12 ("PCI: mobiveil: Add Mobiveil PCIe Host Bridge IP
> > driver")
> > Signed-off-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> > ---
> >  drivers/pci/controller/pcie-mobiveil.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
> > index 4d6c20e..113d56a 100644
> > --- a/drivers/pci/controller/pcie-mobiveil.c
> > +++ b/drivers/pci/controller/pcie-mobiveil.c
> > @@ -89,7 +89,7 @@
> >  #define PAB_INTX_START       5
> >
> >  /* supported number of MSI interrupts */
> > -#define PCI_NUM_MSI  16
> > +#define PCI_NUM_MSI  256
> >
> >  /* MSI registers */
> >  #define MSI_BASE_LO_OFFSET   0x04
> > @@ -172,7 +172,7 @@ static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
> >        * Do not read more than one device on the bus directly
> >        * attached to RC
> >        */
> > -     if ((bus->primary == pcie->root_bus_nr) && (devfn > 0))
> > +     if ((bus->number == pcie->root_bus_nr) && (devfn > 0))
> >               return false;
> >
> >       return true;
> > --
> > 1.8.3.1
> >
