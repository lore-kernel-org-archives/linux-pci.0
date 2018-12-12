Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB9BC65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 03:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38C420851
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 03:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSBgd6YA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38C420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeLLDFA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 22:05:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37841 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLDEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Dec 2018 22:04:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so4316574wmd.2
        for <linux-pci@vger.kernel.org>; Tue, 11 Dec 2018 19:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xa6KCEdb9vp66HZWrqn/Rv4w1V6eaK3nMdHX+gjSeX4=;
        b=pSBgd6YALlonWcS42xIY6xbTPL7zgiyvKhGlxMKklGeFSWS3KGhCrtmZTYBuJyYCRb
         ObIcWMMPXLQauzj9tNFmZl8oMAxDubuQuuodJh8UcDcUPlcIG4Qm/zVtO3TPlEsUz5Os
         16eT/w5arG3MIKDhhxELp2vyhXzkz8ARPAjgQ2NvaFNPLmfmrHSqjOA8JMyGDJ2w68pn
         73s7ke/IUVrFGoOwj5mBsYo4sQgxkWRwLI7zyT4o4vz+IDPDycgskuBm5i5ZT1KdpN5k
         Ebkd6lWak/scXbremeMiF1vKi3VaYSP0UlPjftzpVneRpjR3ubQwr2n+Qb3izZPKShBQ
         b4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xa6KCEdb9vp66HZWrqn/Rv4w1V6eaK3nMdHX+gjSeX4=;
        b=ELRPpDw+mw6CJrahr0H8NMHhntf9etJHYStEg39FU6vUEx5piEJgjFPvRccN1tfPwn
         EYL8D4rSISF2+8PtqC71DM9XYLyF6YSnuaP64MtsIzh5qUNt7RaRUpTEZ2ut6sRgz2J9
         mJZrvcMmFDDtfDLPHydfxm/beI1jVkfkofGOuWs2KOKhnqfvW/fdzX0euLeDc2QlZzym
         09djFRFDSH0X3Fj1jikJrUbduukcmQEZccNHxzfi4RSlCwQPY7MsS1k9piKXH/2QGLp7
         rn/FwxiCLTQDYeTKpwKcVtqCWJhzrdZtSDjUFW61loDwtbQP9GBEqxJ4TOEiUUvgI2ng
         gphg==
X-Gm-Message-State: AA+aEWZ9L8Fl2OXRv79DYCBhlh4o3pyXCae5H6+ZWSUykgxYyq6SlQT1
        hGTZVfUz4YB91tjhWnVzOPo2DkZG9ls8BZi0ESCs
X-Google-Smtp-Source: AFSGD/U9bFlRuiLKLpj2pNZhoDkyTHfdjBiYD3R1XrAPDfbe+wRg861ZU4V8hkZdcibbHmHAgtH3DbCsFttdtx/dn0g=
X-Received: by 2002:a1c:8d49:: with SMTP id p70mr4884817wmd.68.1544583893038;
 Tue, 11 Dec 2018 19:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20181206041951.22413-1-david@gibson.dropbear.id.au>
 <20181211140143.GD99796@google.com> <20181212002234.GC2719@umbus.fritz.box>
In-Reply-To: <20181212002234.GC2719@umbus.fritz.box>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Tue, 11 Dec 2018 21:04:41 -0600
Message-ID: <CAErSpo5skJK0vkQp3t+-YJ-Fw_vpo2f9GUsU9DnnhtO6X+v0mw@mail.gmail.com>
Subject: Re: [PATCH] PCI: Add no-D3 quirk for Mellanox ConnectX-[45]
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        David Miller <davem@davemloft.net>, saeedm@mellanox.com,
        Or Gerlitz <ogerlitz@mellanox.com>, tariqt@mellanox.com,
        leon@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        netdev <netdev@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        sbest@redhat.com, paulus@samba.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 11, 2018 at 6:38 PM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> On Tue, Dec 11, 2018 at 08:01:43AM -0600, Bjorn Helgaas wrote:
> > Hi David,
> >
> > I see you're still working on this, but if you do end up going this
> > direction eventually, would you mind splitting this into two patches:
> > 1) rename the quirk to make it more generic (but not changing any
> > behavior), and 2) add the ConnectX devices to the quirk.  That way
> > the ConnectX change is smaller and more easily
> > understood/reverted/etc.
>
> Sure.  Would it make sense to send (1) as an independent cleanup,
> while I'm still working out exactly what (if anything) we need for
> (2)?

You could, but I don't think there's really much benefit in doing the
first without the second, and I think there is some value in handling
both patches at the same time.
