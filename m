Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFDCC282D7
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 23:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6697B20881
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 23:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfA3XHz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:07:55 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45629 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3XHy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2019 18:07:54 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so1476190qtr.12;
        Wed, 30 Jan 2019 15:07:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t01+gCS+WM+qXgR1rsy2UEMvM9ugzvk9Cf0i9QDT+Wc=;
        b=CzE6P2RfOr8dlEvDz/MWk+zEPe5ReEnQ/62hg+N47RVYjwG+r6dWM8ZUsNStI7n8eP
         o5y1B3LsiUYhJ9ua/4aMYjTvcDArORYU9lisSsmFwfMiqH8MmHbNaPFOuDc9PLmlUnV1
         jQ6ZvhMvR9OXYEh/iwPKSVpke/tONSuC+sbeGGjA5RfmakCvuF2vfgog+JsRYpGuYfXl
         g2EwuMRUtE0MbDUT0yHKc+j3gmPlD0nimChV6at0AaTlHXw7cQuBR7ivpzL3gmMjrcRl
         hqxojOm3VdSTkOnKYJLa0ONp2ciEWvI6PyRHrE6g/EXwZ9JT6Yj5G4eVhq+a9Vg0pdym
         VzPQ==
X-Gm-Message-State: AJcUukfhK6MuryXpX7HqiuAkDpU1RiLOb9Vqu8umtvInsT0mGjHeI6mh
        Axegx4cA+3imKO9R/hND1SEcgbXYs+UUQg2fMiDROQ==
X-Google-Smtp-Source: ALg8bN5MRWCZierZp/fuwUKclMqrrOKdqyazVCd14yj20c7KbOUCV+z4GySg+Y7u5gN6CptrfDJcSZo9RqX+52g9YsA=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr29550044qvk.40.1548886100579;
 Wed, 30 Jan 2019 14:08:20 -0800 (PST)
MIME-Version: 1.0
References: <20190107134510.32494-1-koen.vandeputte@ncentric.com>
 <20190124115656.GA23362@e107981-ln.cambridge.arm.com> <47437c58-d7b3-f77c-7bc7-973373f1e78e@ncentric.com>
 <20190124162759.GA28871@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190124162759.GA28871@e107981-ln.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Jan 2019 23:08:04 +0100
Message-ID: <CAK8P3a2ftPvdBnVacbGcxDpCW6CvBj3ZGBXuVQE46JocXewvgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm: cns3xxx: fix writing to wrong PCI registers
 after alignment
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>,
        Robin Leblon <robin.leblon@ncentric.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 5:29 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Thu, Jan 24, 2019 at 04:23:05PM +0100, Koen Vandeputte wrote:
> > On 24.01.19 12:56, Lorenzo Pieralisi wrote:
> > >On Mon, Jan 07, 2019 at 02:45:09PM +0100, Koen Vandeputte wrote:

> >
> > Thank you for taking care of the wrappings etc.?? it seems my auto-wrap was
> > disabled in my git tooling ..
> > Your adaptions look more than fine.
> >
> >
> > Purely for my information:
> >
> > Testing on a lot of devices here shows a huge improvement towards stability.
> > Is it possible to get it merged sooner?
> > Does "queued for 5.1" also mean that backporting to stables only will happen
> > at 5.1_rc1 release?
>
> Yes, I will ask Bjorn if we can send them for one of the upcoming -rc*
> (so effectively you will get them in v5.0 and propagated to stable
> earlier), I do not think it is that urgent either though, let me handle
> that.

We can take them through the soc tree if that's easier, but
going through Bjorn's tree is also fine.

      Arnd
