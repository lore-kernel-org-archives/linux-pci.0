Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2022BC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 13:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B823B20880
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 13:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1uKFZFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B823B20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbeIYTmL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:42:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46523 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbeIYTmL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 15:42:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id h22-v6so5335174qtr.13;
        Tue, 25 Sep 2018 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrnGc4K2jWA7w4O1buKLsEbU96/6FO7Sfu+kgrsSOjY=;
        b=o1uKFZFBwhkYc322upru5cpsClcyCQJVPqm4IEzESgfb7ov/lOq8YzHxIqCA7TZ/sQ
         X7xNSWwHrXAYk95vYZcHeoGGDNVdkUqhU9AMSpn3Qv9t9yfVm7E13S7MB9bqwIMd55NA
         DeweRZTDXcI26xLzLixD2ZswAh5yGzrWhVYSunIs64Ga/tX+0Sm8kx0tm/0SplDFT6zy
         PiBs4H6H5C8eTROAMHte75GUloU9r9caoB4PC9+iDWiPA/dFL1RFjYeXHP4Ikp8MmG/u
         8jYcyfipndRCC2tQGCAR+RGJYYWQ95y9VlSA/3f4drihaXgJxXjFAlMoCvR0l/VsRnQV
         09pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrnGc4K2jWA7w4O1buKLsEbU96/6FO7Sfu+kgrsSOjY=;
        b=J9jGwMTgxK4P1ZKgPLNSS7PaSMdireRz7sSIEVYQ4QVgiOK3kyr/mJ7XGJe/foV1Bv
         7KzIhDLtAwT8kVtATtz4MEqq9qae3KCX60ISCy7Sckp53J8ewaxN8opIValra5+1DAjW
         Uy+Pz8zFNvMR1ovfXceTtG8nzo30lZXkxQwOm1n0LYhhPlOZ1W2nzSFcSfcI1Whengq8
         7Zvt/2nZ2mtbhxNliuBRfNvrOIRzaOd1HzizWJDGhchHBv6iQZCpymwj2JxdxdKnfxFO
         7rKREvAncq5eC7G4DemTx0lw8djRfezfmIen5GVDQurjkXHt0tEkP4mRJVJHcCgrolWY
         k3eg==
X-Gm-Message-State: ABuFfog01bSMT2XMIOD0Q7j7eWgbNp6dkm9hXwvTpJvUsTDzeJi5/w/Q
        Gd2itzaTjEyVl7gdT2Cav2VtdFUswrPbjiQ0fI4=
X-Google-Smtp-Source: ACcGV60trgGvXcGiQVYNncC3Ss5Lhs3yE6qSAExuQs/x7SKd/+IsHT18BgNlEWemo0NkTa6MJ/Vv0s5cuVWsR+a2Rvg=
X-Received: by 2002:ac8:16c5:: with SMTP id y5-v6mr790647qtk.187.1537882475969;
 Tue, 25 Sep 2018 06:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <1537770916-16337-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537770916-16337-2-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CAHp75Vd7eLgK59DdmVCE7jZgnkpGq0+21DqU=f6PghdvpUEzuA@mail.gmail.com>
 <CA+RiK64ExuUXKHk8tRAoYT7aSCqX4T4hofWrpkD4KysG0WrhyQ@mail.gmail.com>
 <CAHp75VdiGrBR1cVKDKo=kNJpzLY7YyFtTwTWva5uo1R1R5833Q@mail.gmail.com> <CA+RiK66KRK8+=To8W+o_V4HV3Xa=v3P1t_9tcKnrSOWrb6aCTA@mail.gmail.com>
In-Reply-To: <CA+RiK66KRK8+=To8W+o_V4HV3Xa=v3P1t_9tcKnrSOWrb6aCTA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Sep 2018 16:34:24 +0300
Message-ID: <CAHp75Vc1WqedjwH3QNc_0Gd9pmeeBJYJFBk_n_F1Mpire3waqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mpt3sas: Introduce mpt3sas_base_pci_device_is_available
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 1:29 PM Suganath Prabu Subramani
<suganath-prabu.subramani@broadcom.com> wrote:
>
> On Tue, Sep 25, 2018 at 3:22 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, Sep 25, 2018 at 12:46 PM Suganath Prabu Subramani
> > <suganath-prabu.subramani@broadcom.com> wrote:
> >
> > > > > +               pr_err(MPT3SAS_FMT
> > > > > +                   "%s: pci error recovery reset or"
> > > > > +                   " pci device unplug occurred\n",
> > > >
> > > > This should be just one line.
> > > Above line crosses over 80 characters, so it is in two lines.
> >
> > For years there is no such requirement for string literals.
> Below is the one i was mentioning,
> WARNING: line over 80 characters
> #30: FILE: drivers/scsi/mpt3sas/mpt3sas_base.c:6861:
> + pr_err(MPT3SAS_FMT "%s: pci error recovery reset or pci device
> unplug occurred\n", ioc->name, __func__);
>
> Warning comes for both characters over 80 chars and string split.
> Do you want us to ignore warning and repost like above in single line ?
> > Please, don't split string literals in ugly way like this.

I didn't tell anything about other parameters to be on the same line.
So, please, try again.

-- 
With Best Regards,
Andy Shevchenko
