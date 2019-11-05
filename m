Return-Path: <SRS0=Ym/o=Y5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407B6C5DF60
	for <linux-pci@archiver.kernel.org>; Tue,  5 Nov 2019 22:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D743B206BA
	for <linux-pci@archiver.kernel.org>; Tue,  5 Nov 2019 22:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572994143;
	bh=G1ACn2ptpgGeVfl/U59mpFFJs8lztM+KR8W5mF/1k+k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KfXA+wYuI7BipIPMb1v0kT6/Mwgd1SuvZMJdfFcYrA4yBglE69vv3Pnsd4/5CLhh6
	 OdDaITultUeVuhLcd68CtCymMBD8hwr253v0lPaU1pQX+XXpVlbNRqfAkbVSJuf+CX
	 XssxgRqQNsbe8c3M2Fd8fjOjwt0a8SLSuQj+UIF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfKEWtA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:49:00 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37235 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbfKEWtA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 17:49:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id y194so19198723oie.4;
        Tue, 05 Nov 2019 14:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GM1jm2cNcrjl3y3RDdX2JWn1WUw2Dw4x55GxoNuL9wc=;
        b=sveWCiwPZvi8fImz/79HgSKZSsfoaqHTI1lZK2ep1XY+O76T1+H0w4AnohKkJHZ9Hh
         t2TimBj9D/zTvhIKQRiCOoe0pgtVRreEvZDGU7EUWCVYVXwrMJ9t10kjR2sqR0Qqvu/R
         shRgi9yYqWeuUdNmfIcq9K1/oFX/ewcCUsxys8Y+t9aTBKGzLJuynmNj22ViG/NArtFH
         eNz9ea9R1i5itsMl0OTYDRhaimLJljGBcMG83vFZPqnZxHX3mLaT835T52A79OWeyHFN
         8Br/oK/V3LNluWN4thQHCozRrXhDEy92LRrU7Kr+/uuHtGPsoma+jZbvrwLePmGD86JF
         wedQ==
X-Gm-Message-State: APjAAAUnBVXDroJsVhhjP1N4JR4hOxIdV6dnTZyqJfDkUsmUgV0Xd/9U
        eHFOP9Ty2AGoPpAcaBFDtPmDDozwrNT0ny7sGRB2zA==
X-Google-Smtp-Source: APXvYqw2yN1NleQ/hjDjqay4Ch1kFxl+QWttqGc7nxbJAJb982dnpQnHy/lxA1YrI0mD7AhubtukYf7lRTzJV4IzqWE=
X-Received: by 2002:aca:fdd8:: with SMTP id b207mr1293430oii.57.1572994138853;
 Tue, 05 Nov 2019 14:48:58 -0800 (PST)
MIME-Version: 1.0
References: <3568330.mzdaIbGaoM@kreacher> <20191105223521.GA42216@google.com>
In-Reply-To: <20191105223521.GA42216@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Nov 2019 23:48:47 +0100
Message-ID: <CAJZ5v0hdHsP-sWB4ZAXOqwq7cwduZi2yanxPBoZm75G7gcWkdQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] PCI: PM: Cleanups related to power state changes
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 5, 2019 at 11:35 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Nov 05, 2019 at 12:28:47PM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, November 5, 2019 11:11:57 AM CET Rafael J. Wysocki wrote:
> > > Hi,
> > >
> > > This series rearranges some PCI power management code to make it somewhat
> > > easier to follow and explicitly consolidate the power-up (transitions to
> > > D0) code path.
> > >
> > > It is not intended to change the functionality of the code.
> >
> > This series applies on top of 5.4-rc6 with your pci/pm-2 branch from today
> > merged on top of it.
> >
> > I guess I can make it apply on top of pci/pm-2, but there were some PCI PM
> > changes in 5.4-rc later than -rc1 in that area and they need to be taken
> > into account anyway.
>
> I applied the commits from pci/pm-2 to pci/pm (pci/pm-2 was really
> just to get the 0-day robot to build test it).
>
> pci/pm is based on v5.4-rc1, which doesn't have 45144d42f299 ("PCI:
> PM: Fix pci_power_up()"), which appeared in -rc4.
>
> All my branches are based on -rc1.  I *could* rebase them all to -rc4,
> but that's quite a bit of work and affects Lorenzo as well, so I'd
> rather not.  What's the git expert's way of doing this?

It is not necessary to rebase.

I would just merge the current pci/pm on top of v5.4-rc4 (or any later
-rc), commit my patches on top of that and push the result as the new
pci/pm.  That should be a fast-forward update.
