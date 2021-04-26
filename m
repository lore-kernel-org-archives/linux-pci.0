Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EBBC433ED
	for <linux-pci@archiver.kernel.org>; Mon, 26 Apr 2021 19:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7BE61185
	for <linux-pci@archiver.kernel.org>; Mon, 26 Apr 2021 19:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241955AbhDZTtj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Apr 2021 15:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbhDZTtT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Apr 2021 15:49:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC27C061756
        for <linux-pci@vger.kernel.org>; Mon, 26 Apr 2021 12:48:36 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 124so9034202lff.5
        for <linux-pci@vger.kernel.org>; Mon, 26 Apr 2021 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hu/O6kjV+ayX6H+srxTD5OhjR3joShOstPqgPMhXlRY=;
        b=O+nxianCcFegGRK1s69+e+erwUh5FFbkPGGe/FuY2GqsZJKR/Oge7ZOlZDxaTMsw6A
         C1kuarMhKrcAOyYngCsa24OF+gAzv8uoy28yfMflStTHSYJWB7+MfqEHUWDFN1pQcwEE
         2lpPONUV85ttYNP9UWMQgp7j+UqzzQ7xYq43cPw9zFqdnJKoYa0cKU3gtnGe50ZlW2Fg
         wbm6ywMFnTuB3+sUQitug6l+m6FAnouemjIBnwqGtf6ngDiFZMtEeVigxSvIniyNeNQR
         TOQuzZYT6Efly/9FdFXdU2j1aMJ9rC8kpfplYqSL0E2V5iSoF0R1zA+ORo3PGC/qahf2
         BGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hu/O6kjV+ayX6H+srxTD5OhjR3joShOstPqgPMhXlRY=;
        b=lDv1+Ouh1MvNg5eQrUrsd8z3MpJq8LVvvxZESw6rZVd9tLqSfpl2v9TNEB78bQkMYY
         k5TicWzgSm8e5zeEZHDbPYCtZ18AWdS4jYiGGpB+ZI05q94Frgc+ZxGjyG4reJbhk0tZ
         HNVFwL0naKPrDklKHfQ69QRzn9m6OuQqpgzhxODEb13YciHxxexM03N7mA5g7eqFgBFM
         YiefMqvIdsz3UyPp/OSE1vEeRe5nqT+ikK0OPPzQJRRACx2nz31DijK+TL7k7qCDrTNf
         Y0qpu/Knq/H+zMaSvXk8jXdEkGsycKBpQFWoBxbM5QNuNv71RANNWnzvoVxP1TkYekEs
         23lw==
X-Gm-Message-State: AOAM5300CWaW7pQ/+Jrc8N2X+3SEzPQfb5q7chR/jscVvwt5tXOg+tmo
        jX9Ug7XdTTVNHaqb8aRJSgGVsM4sDPmrhn5WbLVJvw==
X-Google-Smtp-Source: ABdhPJzQqSictmcpMxegywuWj1tXbz1nnVcZqr9VC5hCAv9/toUwrlDZVb0ijgerD80Y1Y0Pz84x/oxXoSrYAvmY/WY=
X-Received: by 2002:a19:354:: with SMTP id 81mr7756832lfd.174.1619466515188;
 Mon, 26 Apr 2021 12:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210424021631.1972022-1-rajatja@google.com> <20210424021631.1972022-2-rajatja@google.com>
 <d53c72949d81db9f092a9aecb49bf56b47727738.camel@suse.com> <CAJZ5v0iNrSFjhmTE8K-JrO07kJon3ikhatbg0Jg2hs+x-frDJg@mail.gmail.com>
 <79b994f2476249498797e1784f735fd7@AcuMS.aculab.com>
In-Reply-To: <79b994f2476249498797e1784f735fd7@AcuMS.aculab.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 26 Apr 2021 12:47:59 -0700
Message-ID: <CACK8Z6E=JwkzyF8Ph=F_ATzVAxNWB5TL-xKfS12Y87nmaQTbFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pci: Support "removable" attribute for PCI devices
To:     David Laight <David.Laight@aculab.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 26, 2021 at 6:01 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Rafael J. Wysocki
> > Sent: 26 April 2021 12:49
> >
> > On Mon, Apr 26, 2021 at 11:17 AM Oliver Neukum <oneukum@suse.com> wrote:
> > >
> > > Am Freitag, den 23.04.2021, 19:16 -0700 schrieb Rajat Jain:
> > > > Export the already available info, to the userspace via the
> > > > device core, so that userspace can implement whatever policies it
> > > > wants to, for external removable devices.
> > >
> > > Hi,
> > >
> > > is there a way to tell apart whether a device can undergo regular
> > > surprise removal?
> >
> > PCI devices located under a removable parent can undergo surprise
> > removal.  The ones on a Thunderbolt chain too.
> >
> > > Do we want that?
> >
> > Do you mean surprise removal?  Yes, we do.
>
> Always been true - think of cardbus (PCI pcmcia) cards with
> PCI bridges to external PCI expansion chassis containing
> additional PCI slots.
> The cardbus card is hot removable.

Hi Oliver / Folks, please let me know if there is a suggestion for me
here, or if there is still a question for me to answer.

Thanks,

Rajat

PS: To give some background about this change, we'd like to implement
some policies around disabling user plugged devices when a user logs
out, and collect statistics around use of such devices.

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
