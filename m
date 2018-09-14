Return-Path: <SRS0=PQBU=L4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FBEC070C3
	for <linux-pci@archiver.kernel.org>; Fri, 14 Sep 2018 08:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D11B20853
	for <linux-pci@archiver.kernel.org>; Fri, 14 Sep 2018 08:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D11B20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeINNY4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:24:56 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33523 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeINNY4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Sep 2018 09:24:56 -0400
Received: by mail-oi0-f66.google.com with SMTP id 8-v6so12110566oip.0;
        Fri, 14 Sep 2018 01:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXl8482wLpJwt7Y9L/YIW443gX1ZSAlSeS9aedz08RM=;
        b=S+2WpEH9BpMPZcUB98ugWUR/o3c9pO/k8Pg8e9SfbBWvNz9NSwN15ciDv7XZpffjrw
         mnk80Lzbp65X6Vl+YGQV4wStDwTDqOPi8oCPWB12cBcOgFktT5JRee3MU1bypGVgavBn
         4oR3UN8laG+6b2xdTagLqI5anrDv02BrkalzjSHmYIjXfasqXd0F92bXKtWkoh1gmxhz
         Gk+XtXXIy0XGeDbDhZvOAJkGIj5uocWaik6maKx1F1q2TWnbdO/28gz9jAxE34UAkDOp
         k0P5x/xWom+m1uV9ja8KABU+YWlmGMBwN7AdHAueYOGbZVFvd+5Dl/THJvHUt/htIal0
         CQzw==
X-Gm-Message-State: APzg51AKuNLrnrlOUROMNkxp/7/FeyY3arH03S9G7Kpbm0yP7oVZLV06
        CT12kMoeEbiqUOKPQa1307kGBHF1MAwB0ph1snN3ww==
X-Google-Smtp-Source: ANB0VdYW/2nAPgsMf743YskJi+p4w0B+eZufxQc9jyq4kdy9ZlPVytm7M1YJ16FgUc46jq4ryxamQvDa9NZIO2zpcv0=
X-Received: by 2002:aca:d098:: with SMTP id j24-v6mr8989086oiy.72.1536912697117;
 Fri, 14 Sep 2018 01:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180913143322.77953-1-mika.westerberg@linux.intel.com>
 <20180913143322.77953-2-mika.westerberg@linux.intel.com> <153688100.j3IOAyprJL@aspire.rjw.lan>
 <20180914080621.GT14465@lahna.fi.intel.com>
In-Reply-To: <20180914080621.GT14465@lahna.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Sep 2018 10:11:25 +0200
Message-ID:
 <CAJZ5v0gzacxkV+6gbY+paq6=h71KWpRM4pG5ko-Fu3ROdJ2AXQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] PCI: Do not skip power managed bridges in pci_enable_wake()
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180914081125.HXwy5V7dZrlJTXutkz7cpjyNSgQ8TdAk8o8dsxflDpo@z>

On Fri, Sep 14, 2018 at 10:07 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Sep 13, 2018 at 04:33:39PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, September 13, 2018 4:33:13 PM CEST Mika Westerberg wrote:
> > > Commit baecc470d5fd ("PCI / PM: Skip bridges in pci_enable_wake()")
> > > changed pci_enable_wake() so that all bridges are skipped when wakeup is
> > > enabled (or disabled) with the reasoning that bridges can only signal
> > > wakeup on behalf of their subordinate devices.
> > >
> > > However, there are bridges that can signal wakeup itself. For example
> > > PCIe downstream and root ports supporting hotplug may signal wakeup upon
> > > hotplug event.
> > >
> > > For this reason change pci_enable_wake() so that it skips all bridges
> > > except those that we power manage (->bridge_d3 is set). Those are the
> > > ones that can go into low power states and may need to signal wakeup.
> > >
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> > >  drivers/pci/pci.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 29ff9619b5fa..1af6f1887986 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -2133,10 +2133,13 @@ static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable
> > >     int ret = 0;
> > >
> > >     /*
> > > -    * Bridges can only signal wakeup on behalf of subordinate devices,
> > > -    * but that is set up elsewhere, so skip them.
> > > +    * Bridges that are not power-manageable directly only signal
> > > +    * wakeup on behalf of subordinate devices which is set up
> > > +    * elsewhere, so skip them. However, bridges that are
> > > +    * power-manageable may signal wakeup for themselves (for example,
> > > +    * on a hotplug event) and they need to be covered here.
> > >      */
> > > -   if (pci_has_subordinate(dev))
> > > +   if (!pci_power_manageable(dev))
> > >             return 0;
> > >
> > >     /* Don't do the same thing twice in a row for one device. */
> > >
> >
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thanks!
>
> For some reason this patch never hit the mailing lists (others did).
> Since you kept the whole context people should still be able to review
> it. I can resend this patch as well.

You may need to resend for Patchwork to pick it up, though.  Depends
on Bjorn I suppose.
