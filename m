Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7558C10F07
	for <linux-pci@archiver.kernel.org>; Wed, 20 Jan 2021 11:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F63523159
	for <linux-pci@archiver.kernel.org>; Wed, 20 Jan 2021 11:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbhATLMK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Jan 2021 06:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbhATJkL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2021 04:40:11 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5A7C061757
        for <linux-pci@vger.kernel.org>; Wed, 20 Jan 2021 01:39:30 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j13so663190edp.2
        for <linux-pci@vger.kernel.org>; Wed, 20 Jan 2021 01:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M02M4vY/73I1o0pHPZPaDHowhdEnpk4jaG+nDUhmK0Q=;
        b=Sv51ODuHZp+gbzZ475xDvy7TK+pCmrNxsAmue7LbBis9z6OrfvX7dONJFdZuONZlc5
         6aRQHxmXP7/H5K/Imq2SM7/GabnVOLrDbe1xsYp/XNnFn69XShzzJ91id6m2EeS4Y3Kz
         rbtp9GSfGBCe8AChDt4s7qPYvu4i6TQzmDoDQl7XTswKX45UscoXXUVlP/DdGk//oewf
         HkO/V2/27pFoeaZDdncn+9nWxc2kpBwB9EJBhOxrtirtGJfzEeKxAkVRVy5+cl21FeUt
         N2YDE44k+SlQ+JefAx1CJ4cIm9UaCFEjfke+q8HzImeb+oeen2G+H17cCxSiRFQLI5/P
         5Ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M02M4vY/73I1o0pHPZPaDHowhdEnpk4jaG+nDUhmK0Q=;
        b=ef1oSP4LjENpo7VCO4RoH5uvHaoQPxystzaMphW1bSiVLWq0ACjZ8L9hqUKeUPdzxI
         cADuTCHS9btLJXCqo0FG6afMXMUtTCldrzw/tOIBwVPtqAQXyR4wan0gbzppRkn3HMca
         au3ogUzLu/E0LL8w6b4DnACVJA3hN55CXW292oO4QvBziuZBOKsUEBNPMDGIFfIWx9iE
         6GFbt7zPbafRhn3ouBueht7YlFhwvSw9gec8HslZY5UUnoXibsd5zZXadSnCmWJiV9zr
         bl8Gam/K6PTTMwAi/4KMC1WztbqTo7PoLn8hd9HcOyAxYUMMw+pnX029iXHgfwxSyLzz
         o6aA==
X-Gm-Message-State: AOAM530Eau7qy/NnIVNDVMw7XQYqLQqzP+2zAiZ/jxpSkoAy/NYjkfaS
        ajl2/gbePGoLWaADw2fk79aWU4yqGgCZqp2ipr/QPw==
X-Google-Smtp-Source: ABdhPJzLurKwE2+XAnKXso4/n6qvcwtwwSCLDad7Ih+sHBjY9o5r59BNkd4F8KylyYHvgvU0+edqSEGg2e9PdtkIK0s=
X-Received: by 2002:aa7:c3d3:: with SMTP id l19mr6863124edr.366.1611135568961;
 Wed, 20 Jan 2021 01:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20210119102757.2395-1-dnlplm@gmail.com> <20210119220619.GA2510101@bjorn-Precision-5520>
In-Reply-To: <20210119220619.GA2510101@bjorn-Precision-5520>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Wed, 20 Jan 2021 10:46:34 +0100
Message-ID: <CAMZdPi9mNOb4w-Q2MH9dt9cuCFPiiJ2PUWczSdtG-LE8Qp8xvg@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI: add Telit Vendor ID
To:     Daniele Palmas <dnlplm@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Daniele,

On Tue, 19 Jan 2021 at 23:06, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
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

Ok, in that case, you can add this define directly in mhi_pci_generic
along with a new entry for matching the sub-vendor/device IDs of your
module.

Regards,
Loic

>
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
> >  #define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS  0x1c36
> >
> > +#define PCI_VENDOR_ID_TELIT          0x1c5d
> > +
> >  #define PCI_VENDOR_ID_CIRCUITCO              0x1cc8
> >  #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD       0x0001
> >
> > --
> > 2.17.1
> >
