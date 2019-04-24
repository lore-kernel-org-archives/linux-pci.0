Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD0AC282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B495C218D3
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 19:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfDXTQk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:16:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39187 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfDXTQj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 15:16:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id h16so11335155qtk.6
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2019 12:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=h3UCdJ71shBFcDh8pFld19FMfNKPZ7BcOMwrQjVSd5E=;
        b=WwPXcviljqWlj4oc4kSEA5IRYKv6Q8luDoEJPMkS8WfhjoPWVVWTLAMxI2lp3dw0/9
         QOYz/oU3d2e/ixRoUG2Ltvejfe5cLiyFfy7DX076thvdKfQ8N5OA6nl8r37NBy3P+vj1
         8vmgwYlTTOE/T+DdDYEBm9XvwNLus4cV6gZZbtf9L94PokovdpjxKfCwkvKaYEPgbbTo
         nT08xzpl6dOFfpE56PjfeCRIGNDYK3Na4J5PyudaF33Rntsrkuk2qDiz8rq294M0zQTy
         P1NHv575YLS5D11J6mcJwCNAEnK0AMa1b1hkDX7728O9zk865nEUm6aNcFiy7loYYmr/
         nXWQ==
X-Gm-Message-State: APjAAAUY2HAAfgbdg6fzylZO72gRSlDw25UMcf9VaeVxnfwl41MP5pld
        FElu3VGBhHg61H7HmwAGKRVkzw==
X-Google-Smtp-Source: APXvYqxRFGHV2FEnhMrNbybPeC7FKi6RZfvms8xgILp/aL/gfqQZRF6hJaaSudodjNhFcsCcf87UFQ==
X-Received: by 2002:ac8:3427:: with SMTP id u36mr26833230qtb.104.1556133398955;
        Wed, 24 Apr 2019 12:16:38 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id d17sm9237720qko.93.2019.04.24.12.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 12:16:38 -0700 (PDT)
Message-ID: <4e45b65b2151293d91dfc5811f64f3453f591f9d.camel@redhat.com>
Subject: Re: [PATCH] pci/quirks: Add quirk to reset nvgpu at boot for the
 Lenovo ThinkPad P50
From:   Lyude Paul <lyude@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Ober <dober@lenovo.com>, linux-pci@vger.kernel.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <skeggsb@gmail.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Wed, 24 Apr 2019 15:16:37 -0400
In-Reply-To: <20190424185937.GB11428@google.com>
References: <20190212220230.1568-1-lyude@redhat.com>
         <20190215004329.GR96272@google.com>
         <2fca9a9feafcd17b27bc71994a71ebc241a93e9a.camel@redhat.com>
         <52b17f8cb24e179e9661d75548d193843ae87b4c.camel@redhat.com>
         <20190321224819.GK251185@google.com> <20190322113015.GM251185@google.com>
         <20190404141724.GJ141706@google.com>
         <3987ad435bfdb2d92e5e42648174634814b1646d.camel@redhat.com>
         <20190424185937.GB11428@google.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2019-04-24 at 13:59 -0500, Bjorn Helgaas wrote:
> Not being a scheduled work expert, I was unsure if this experiment was
> equivalent to what I proposed.
> 
> I'm always suspicious of singleton solutions like this (using
> schedule_work() in runtime_resume()) because usually they seem to be
> solving a generic problem that should happen on many kinds of
> hardware.  The 0b2fe6594fa2 ("drm/nouveau: Queue hpd_work on (runtime)
> resume") commit log says:
> 
>   We need to call drm_helper_hpd_irq_event() on resume to properly
>   detect monitor connection / disconnection on some laptops, use
>   hpd_work for this to avoid deadlocks.
> 
> The situation of a monitor being connected or disconnected during
> suspend can happen to *any* GPU, but the commit only changes nouveau,
> which of course raises the question of how we deal with that in other
> drivers.  If the Nvidia GPU has some unique behavior related to
> monitor connection, that would explain special-case code there, but
> the commit doesn't mention anything like that.
> 
> It should be simple to revert 0b2fe6594fa2 and see whether it changes
> the behavior at all (well, simple except for the fact that this
> problem isn't 100% reproducible in the first place).

It's not 100% reproducible, but it's at least 90% so it's not difficult for me
to test at all.

Also, reverting this commit makes no difference either. Note that while that
commit only changed nouveau, scheduled_work() is exactly how a number of other
drivers (i915 for instance) handle reprobing like this as well. The reason
being that we can't do full connector reprobing in our runtime resume thread
because we could deadlock if someone else is holding a modesetting lock we
need and waiting on us to resume at the same time (there's a number of other
bug fixes in nouveau for other issues caused by the same deadlock scenario). 

I'm confused here though, it sounds like you're running under the assumption
that PCI devices like this aren't reset into a clean state during a system
reboot, is that correct?

> 
> > Do we want to have this discussion on the bz btw, or is this email
> > thread fine?
> 
> Email is fine.
-- 
Cheers,
	Lyude Paul

