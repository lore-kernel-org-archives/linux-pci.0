Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4D5C5519F
	for <linux-pci@archiver.kernel.org>; Mon, 16 Nov 2020 15:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0212076E
	for <linux-pci@archiver.kernel.org>; Mon, 16 Nov 2020 15:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o536oL+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgKPPhX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 16 Nov 2020 10:37:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbgKPPhX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 10:37:23 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B9522265;
        Mon, 16 Nov 2020 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605541042;
        bh=E8sdLeoXIzuGmOa5OnMrHgj2yXn2UCzO0W2afC9rPuk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o536oL+2jBT8rxRsfC+tXAjv5gHqLzcLVB31sbOHhgsVNlS+Geq0O1pZzwyVYAlX4
         GcZhqkXekHID+qw9bCtRwibJo7SFgfT6j9ItPu+Fa1fhCIF5rtMtt7ew3966SBrfZm
         m5K3fr6EQlAfSWBq4AZpKRR5x+KLsMvCxrsC9Ots=
Received: by mail-oo1-f41.google.com with SMTP id l10so3989210oom.6;
        Mon, 16 Nov 2020 07:37:22 -0800 (PST)
X-Gm-Message-State: AOAM531TRRKbqJjhGfBD9H0VB0Ksuk0lNNuP9cISV0ejm7vWjTjyKjMm
        SqnQvXEnG3ZQbVHavpnusNzh9qudSMII0mUPVZM=
X-Google-Smtp-Source: ABdhPJwM0C/5+mYGkprp6MGo45Jg+Y4cMg6i4Udv3mmMRAH/nnzs8rxK08SMGeEcf0ooEr/jW8gZH1jSiUBbnEh2gOI=
X-Received: by 2002:a4a:a217:: with SMTP id m23mr10462852ool.26.1605541041921;
 Mon, 16 Nov 2020 07:37:21 -0800 (PST)
MIME-Version: 1.0
References: <20200930153519.7282-16-kishon@ti.com> <VI1PR04MB496061EAB6F249F1C394F01092EA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <d6d27475-3464-6772-2122-cc194b8ae022@ti.com> <VI1PR04MB49602D24F65E11FF1F14294F92E90@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <30c8f7a1-baa5-1eb4-d2c2-9a13be896f0f@ti.com> <CAK8P3a38vBXbAWE09H+TSoZUTkFdYDcQmXX97foT4qXQc8t5ZQ@mail.gmail.com>
 <5a9115c8-322e-ffd4-6274-ae98c375b21d@ti.com> <CAK8P3a33XSvenqBhuQpGmtLbYydyzY2OQh73150TJtpzW24DTw@mail.gmail.com>
 <c720de5b-bf76-162f-24cb-07f6fe670bd2@ti.com>
In-Reply-To: <c720de5b-bf76-162f-24cb-07f6fe670bd2@ti.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 16 Nov 2020 16:37:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0nTdtADPa_5jduDm5MpBiwBNgs7cYokK5qBZ=RkL1Ktg@mail.gmail.com>
Message-ID: <CAK8P3a0nTdtADPa_5jduDm5MpBiwBNgs7cYokK5qBZ=RkL1Ktg@mail.gmail.com>
Subject: Re: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Sherry Sun <sherry.sun@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 6:19 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On 12/11/20 6:54 pm, Arnd Bergmann wrote:
> >
> > This looks very  promising indeed, I need to read up on the whole
> > discussion there. I also see your slides at [1]  that help do explain some
> > of it. I have one fundamental question that I can't figure out from
> > the description, maybe you can help me here:
> >
> > How is the configuration managed, taking the EP case as an
> > example? Your UseCase1 example sounds like the system that owns
> > the EP hardware is the one that turns the EP into a vhost device,
> > and creates a vhost-rpmsg device on top, while the RC side would
> > probe the pci-vhost and then detect a virtio-rpmsg device to talk to.
>
> That's correct. Slide no 9 in [1] should give the layering details.
>
> > Can it also do the opposite, so you end up with e.g. a virtio-net
> > device on the EP side and vhost-net on the RC?
>
> Unfortunately no. Again referring slide 9 in [1], we only have
> vhost-pci-epf on the EP side which only creates a "vhost_dev" to deal
> with vhost side of things. For doing the opposite, we'd need to create
> virtio-pci-epf for EP side that interacts with core virtio (and also the
> corresponding vhost back end on PCI host).

Ok, I see. So I think this is the opposite of drivers/misc/mic and
the bluefield driver were using, so we would probably end up
needing both.

Then again, I guess the NTB driver would give us the functionality
for free, if it shows a symmetric link?

      Arnd
