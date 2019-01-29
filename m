Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7BAC169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 21:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5983C21473
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 21:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE9/o/N5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfA2V3M (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:29:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37158 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfA2V3M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2019 16:29:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so23746856wrt.4;
        Tue, 29 Jan 2019 13:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z3ULGENtuqL5tguf/8dKX/9QWEPMLkVQYxE/Khek8q0=;
        b=BE9/o/N5/jPw61vFbCALWK6WGrmrDJnuNbyw+0eBRu9kl8/mJdGZbhnoC519Q6v0vN
         pfouBi1cLQPNO4tlcu51UrzZ/cG65MblzRN8snO+yQNiq6Kt0dgdwK6rPLEg6gGIavD9
         RSe85gbDSyA7AWnhpbuo76EL5wJQIiSFZV6AScHhbk5kX/F7ZsS7U8IP1lT3pG+Wcpmb
         FqicFEYoajuKenDYi4jlHLwMJoss9n47tcIES5sRFnlRMT+GelIJzjtNeIgUUpO49Lgp
         K4nhu+OtQ9H9/Wi9pK6hPEnW8Z+0ZYgIljy/BsHoYjz4AsBp6I48/ljOQObddstEENGc
         eUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z3ULGENtuqL5tguf/8dKX/9QWEPMLkVQYxE/Khek8q0=;
        b=af8Sa3e0jQ3xkKzsYGim/h2shBXe6jTAuDkjFZ/Of5h/bHB/odox9W0nLvdNFrxtI0
         xe4wWRlYLneUAMVSwonTh8vere1G0FkTdfdJ6GgEjHSIbsS5LQMg9uQPgzmfZrnPlE8k
         r0BGnHE/5WoLcGujMz0aZ75ZaxI5iur66s3kK+iahsEpp1mtT9/Sk8NQerys25QtHE1a
         y+QcEoN5x/BxE1q27YnBJX1uEpg7/3YDAnAgLAL9voBUD3OzJ7TwrgWpsdbEMQN+JPIB
         VSB4h25Eqq1EzDVwyu28VyeUNJB3kpiMK+SVWo05nwFd5Jh24dxmj3y2HEXe1ot1iX5Q
         8/rg==
X-Gm-Message-State: AJcUukejWszMFaUOEI1ZSiyz4RCr1qAMuFrTJcQcbL1bm4VidtgFKOe4
        m+2/o6cjpfQ57NSC5v4K5RCg4whz6vNmT+dQhRQ=
X-Google-Smtp-Source: ALg8bN4oqlozqvBx62ZOKCap1Q/HPcNNVezF3INCpbFnWNa8lhuzX+yfDeJxf3h2fdiUfk76PHTMpUi7jABP0nz7gLo=
X-Received: by 2002:adf:d0c9:: with SMTP id z9mr26313114wrh.317.1548797350317;
 Tue, 29 Jan 2019 13:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20190129174728.6430-1-jglisse@redhat.com> <20190129174728.6430-2-jglisse@redhat.com>
 <CADnq5_N8QLA_80j+iCtMHvSZhc-WFpzdZhpk6jR9yhoNoUDFZA@mail.gmail.com> <83acb590-25a5-f8ae-1616-bdb8b069fa0f@deltatee.com>
In-Reply-To: <83acb590-25a5-f8ae-1616-bdb8b069fa0f@deltatee.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 29 Jan 2019 16:28:57 -0500
Message-ID: <CADnq5_NOm8DkHWCw-s9B4+n=9qezS8kg9TXDK0fz9nP1vFB+mw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] pci/p2p: add a function to test peer to peer capability
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, linux-mm <linux-mm@kvack.org>,
        Joerg Roedel <jroedel@suse.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 29, 2019 at 3:25 PM Logan Gunthorpe <logang@deltatee.com> wrote=
:
>
>
>
> On 2019-01-29 12:56 p.m., Alex Deucher wrote:
> > On Tue, Jan 29, 2019 at 12:47 PM <jglisse@redhat.com> wrote:
> >>
> >> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> >>
> >> device_test_p2p() return true if two devices can peer to peer to
> >> each other. We add a generic function as different inter-connect
> >> can support peer to peer and we want to genericaly test this no
> >> matter what the inter-connect might be. However this version only
> >> support PCIE for now.
> >>
> >
> > What about something like these patches:
> > https://cgit.freedesktop.org/~deathsimple/linux/commit/?h=3Dp2p&id=3D4f=
ab9ff69cb968183f717551441b475fabce6c1c
> > https://cgit.freedesktop.org/~deathsimple/linux/commit/?h=3Dp2p&id=3Df9=
0b12d41c277335d08c9dab62433f27c0fadbe5
> > They are a bit more thorough.
>
> Those new functions seem to have a lot of overlap with the code that is
> already upstream in p2pdma.... Perhaps you should be improving the
> p2pdma functions if they aren't suitable for what you want already
> instead of creating new ones.

Could be.  Those patches are pretty old.  They probably need to be
rebased on the latest upstream p2p stuff.

Alex
