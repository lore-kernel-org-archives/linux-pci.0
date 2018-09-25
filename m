Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB5CC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 10:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7A520676
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 10:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f79m1ICo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7A520676
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeIYQgF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 12:36:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40992 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeIYQgF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 12:36:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id y17-v6so21157135ljy.8
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2018 03:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSBxAxsbi2/N/SNsHT+Tjoxbpy5AfEssp3DzJjhs0Ik=;
        b=f79m1ICo5SCjnt7dKVBGdcSv0VQAKVFfhL1FcAEQOA8qdunFIF8WHNsh7CHl1ygqGF
         cneVjJJllrCX9AdJ9iaFgk9heWFvwKZmei8cM7kgofaSFoCyMv5ftb8vMWobPq97Hc6K
         tZgRSCtT1JMxDaSy9J4itiiMMDpG2mCY7dtxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSBxAxsbi2/N/SNsHT+Tjoxbpy5AfEssp3DzJjhs0Ik=;
        b=KFg7/z8Ns082MgOVgU6/0LDUA/qpNukGfB4I8aVoeAFdbOKgYaW5q+PeLU7BEqi7CD
         nvrxcDqxRH4cL8Mp5w0FEKJYEudDGPdTAP4a6zED6vlwoKNKan/I//0PonrHgprD19Y/
         +sdwWuLF9qHFfvVD/gTFtEjmLup9YUtIR6eNw6IH8gPmias5Jirp8KDyqEXjLP43IEqK
         /9qc3ycgcjAZP4SSX8rLAMHR07qcxWiyzj6LN7btac26U7owQoQBERr2p84G8tAUvwog
         m383HG2Fa07ifmWXcejRCh79wwrmtwXfdeR5G8sJ/G59cOrpfZyCcim91yluw/uCMo/K
         ZdXg==
X-Gm-Message-State: ABuFfohvFLrn5uQ2nK51KLiJiwJIq2m626k3gWNeY5xFLywQHlgXZof4
        6aXT6zTKxIDPatPDVm6GEcJgYQK4g8nTIGC7aC3+XA==
X-Google-Smtp-Source: ACcGV60J5KWbSHarYNtu12dVbKfwxqUEXl3ajLnSsVcE+lpMkiMWLHH5xvQ5FJRKVYKdiLenALvkHO0W9pgsQ10lWy0=
X-Received: by 2002:a2e:99c1:: with SMTP id l1-v6mr321811ljj.132.1537871350334;
 Tue, 25 Sep 2018 03:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <1537770916-16337-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537770916-16337-2-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CAHp75Vd7eLgK59DdmVCE7jZgnkpGq0+21DqU=f6PghdvpUEzuA@mail.gmail.com>
 <CA+RiK64ExuUXKHk8tRAoYT7aSCqX4T4hofWrpkD4KysG0WrhyQ@mail.gmail.com> <CAHp75VdiGrBR1cVKDKo=kNJpzLY7YyFtTwTWva5uo1R1R5833Q@mail.gmail.com>
In-Reply-To: <CAHp75VdiGrBR1cVKDKo=kNJpzLY7YyFtTwTWva5uo1R1R5833Q@mail.gmail.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Tue, 25 Sep 2018 15:59:29 +0530
Message-ID: <CA+RiK66KRK8+=To8W+o_V4HV3Xa=v3P1t_9tcKnrSOWrb6aCTA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mpt3sas: Introduce mpt3sas_base_pci_device_is_available
To:     andy.shevchenko@gmail.com
Cc:     linux-scsi@vger.kernel.org,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Christoph Hellwig <hch@infradead.org>, lukas@wunner.de,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 3:22 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Sep 25, 2018 at 12:46 PM Suganath Prabu Subramani
> <suganath-prabu.subramani@broadcom.com> wrote:
>
> > > > +               pr_err(MPT3SAS_FMT
> > > > +                   "%s: pci error recovery reset or"
> > > > +                   " pci device unplug occurred\n",
> > >
> > > This should be just one line.
> > Above line crosses over 80 characters, so it is in two lines.
>
> For years there is no such requirement for string literals.
Below is the one i was mentioning,
WARNING: line over 80 characters
#30: FILE: drivers/scsi/mpt3sas/mpt3sas_base.c:6861:
+ pr_err(MPT3SAS_FMT "%s: pci error recovery reset or pci device
unplug occurred\n", ioc->name, __func__);

Warning comes for both characters over 80 chars and string split.
Do you want us to ignore warning and repost like above in single line ?
> Please, don't split string literals in ugly way like this.
>
> --
> With Best Regards,
> Andy Shevchenko
