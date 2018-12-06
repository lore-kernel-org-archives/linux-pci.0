Return-Path: <SRS0=KO/x=OP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AB5C04EB8
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE022082B
	for <linux-pci@archiver.kernel.org>; Thu,  6 Dec 2018 20:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r0R4F5Lr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE022082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbeLFUu1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:50:27 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46920 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFUu1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Dec 2018 15:50:27 -0500
Received: by mail-io1-f65.google.com with SMTP id v10so1472157ios.13;
        Thu, 06 Dec 2018 12:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MxkfNPeZcrG8EjRvaPrQ+4BMehoT7MX1k7wo0sIAPv4=;
        b=r0R4F5LrmXFDW5CH/dXCUHQKjmWyXPq2bFsse/o84D63gjkNAELkP37HI2STm2DqK7
         HSScYwYOSC+oIoi0eQr3V5GQjYA97gfdUsE92tOfY4Ch8PVU15EPIZHbUePs/l4yfT/U
         18SZheUwRA36aIFPJcpCa33MotK+oMsmU4OfVcZlbwXbpMXD29Yueml0bdzzxPAPZU69
         8HlouKw8TZGIqFq7VRtOkvoD/YJVAYpE8xCRSP/0u8yNwc/YZCY6MNHZeWifBAE1gnN+
         Kb3hIvKsZDDCg+zVvfWAIndgtGnJvcpEUpluowKT6sohb0G5X84MPVvjnvcKLwBcSjId
         rnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxkfNPeZcrG8EjRvaPrQ+4BMehoT7MX1k7wo0sIAPv4=;
        b=MKMFmj6hnHIXWFPJ/ipdknltK40AM/BkZQrkfSvEMroxju/qEfh6r8StAwERgeuG0d
         x3rCXjFGv9lQYZWZRkQn98x/0PzqcybH2dgaNCTPYsGSUtMCYPqF16g6Y2bfa1V7+x22
         5Xfvpn9C57VWt8kpgTLXekmUGDi+5bKOgX02YkK4m7c0pKybaEtQ+Nt12uEBt5ty5H2U
         h9Dw2UpyVhyyPFy5zsSaz2xMVdfPhp58CMaddsRZh5MC6EbE1GfysW2BmmTCwT//PK6J
         Jal0+vuaEvCAmA6Ibhf+TXSQ1e8Ld2CEmNwEnK7zKMXXbGZP0JgxpIF+GYJEDzvFI1Y3
         TwfA==
X-Gm-Message-State: AA+aEWbqJhxfvdBotVa4Inoxy1uBycFUM1rqfxA5ZipDSZoNGKggSGgY
        XmdrTI3CGq6iS0js5QET7d1QqQ1YijQ0czAFtKJazA==
X-Google-Smtp-Source: AFSGD/Urq3dddLWB7mI/R6BaIw5WKhTWrjl4n1H3cZckfVtVUWJjwLjRX/2YfiwpB/pZWwupwpwZQe/4CL5nLdx1Fh0=
X-Received: by 2002:a6b:d318:: with SMTP id s24mr25690628iob.6.1544129425994;
 Thu, 06 Dec 2018 12:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20181201160711.GA21373@ycd-dell-ltp> <20181206204407.GB247703@google.com>
In-Reply-To: <20181206204407.GB247703@google.com>
From:   Benjamin Young <youngcdev@gmail.com>
Date:   Thu, 6 Dec 2018 12:50:14 -0800
Message-ID: <CAKDnngEo9Yo8j9pNrJNEdzK2du3bzWA87+rqBX+T1OaTNZ_cDA@mail.gmail.com>
Subject: Re: [PATCH] pcie: portdrv: Fix Unnecessary space before function
 pointer arguments
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks, I will do that next time :)

On Thu, Dec 6, 2018 at 12:44 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Dec 01, 2018 at 08:07:11AM -0800, Benjamin Young wrote:
> > Made spacing more consistent in the code for function pointer
> > declarations based on checkpatch.pl
> >
> > Signed-off-by: Benjamin Young <youngcdev@gmail.com>
>
> Applied to pci/misc for v4.21, thanks!
>
> I also made similar changes to include/linux/pci.h.  For trivial changes
> like this I like to fix similar issues in all of PCI at the same time.
>
> > ---
> >  drivers/pci/pcie/portdrv.h | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> > index e495f04..fbbf00b0 100644
> > --- a/drivers/pci/pcie/portdrv.h
> > +++ b/drivers/pci/pcie/portdrv.h
> > @@ -71,19 +71,19 @@ static inline void *get_service_data(struct pcie_device *dev)
> >
> >  struct pcie_port_service_driver {
> >       const char *name;
> > -     int (*probe) (struct pcie_device *dev);
> > -     void (*remove) (struct pcie_device *dev);
> > -     int (*suspend) (struct pcie_device *dev);
> > -     int (*resume_noirq) (struct pcie_device *dev);
> > -     int (*resume) (struct pcie_device *dev);
> > -     int (*runtime_suspend) (struct pcie_device *dev);
> > -     int (*runtime_resume) (struct pcie_device *dev);
> > +     int (*probe)(struct pcie_device *dev);
> > +     void (*remove)(struct pcie_device *dev);
> > +     int (*suspend)(struct pcie_device *dev);
> > +     int (*resume_noirq)(struct pcie_device *dev);
> > +     int (*resume)(struct pcie_device *dev);
> > +     int (*runtime_suspend)(struct pcie_device *dev);
> > +     int (*runtime_resume)(struct pcie_device *dev);
> >
> >       /* Device driver may resume normal operations */
> >       void (*error_resume)(struct pci_dev *dev);
> >
> >       /* Link Reset Capability - AER service driver specific */
> > -     pci_ers_result_t (*reset_link) (struct pci_dev *dev);
> > +     pci_ers_result_t (*reset_link)(struct pci_dev *dev);
> >
> >       int port_type;  /* Type of the port this driver can handle */
> >       u32 service;    /* Port service this device represents */
> > --
> > 2.5.0
> >
