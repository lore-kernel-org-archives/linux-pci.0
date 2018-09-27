Return-Path: <SRS0=vBCh=MJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEC0C43382
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 10:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5942150B
	for <linux-pci@archiver.kernel.org>; Thu, 27 Sep 2018 10:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F7cxZ+x8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5942150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeI0QsU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:48:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39220 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbeI0QsU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Sep 2018 12:48:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id b19-v6so1219445qkc.6
        for <linux-pci@vger.kernel.org>; Thu, 27 Sep 2018 03:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrkD/liiJcZE8DGmvB8WlwgsEZAdq2wIyZuChbqDJX8=;
        b=F7cxZ+x8Oud/Xb+1BKr5ZqQRJzNjeQH0yJu8qK8SkSiQXHcxmQCIp0uB+M1R8WpMhS
         qjkNcg+NbTL6doHZaxVRlYu6q38WM01ieYlmcsLblqUd9q2L0P7ohkkLYb9LhE/ZpVNk
         Vv+3pafsTwZYBvOpsGzDa66Sg0poMWmQGbcIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrkD/liiJcZE8DGmvB8WlwgsEZAdq2wIyZuChbqDJX8=;
        b=kCg09O15mD/Y6iYxXD/iRAUQCPCRCJuHaCV7RVml8NsMM/NMuLYIHEoUtauHJMD3x3
         Au7aKtmCf4IFAuXcrVQOYIoGrX5XozVgctOxUNO44puo3+4kODBye6JhX4oPFRW+JRQx
         LYSMYtiHJT4/kyoyKTDua6S74FmIqyzG/eWHGCmDUmSnpIMWNZNKrfBxlSPuzYjLFRTd
         7HHQPO2E0oLvtCNF10rqamOG/7hFNUEiLdvLAf/lFu67+wwY8aPFrCOeFAlNeYwA9lt4
         xjV8z9jHw6d8WR0u/jZ+hdZf06XlPQwwRmAclfjW5fLZ57E0drYIGn6cd0r+PgBjwYWR
         aZ6g==
X-Gm-Message-State: ABuFfoi6aJXrV78adArZG+Xi0++63Q44C9nHqOpXlPGIQrZJh35b0ejN
        bWHkr8hXKbDxo9I/K7ur1oLGxj4muFI5awoKvRm0CJ6V
X-Google-Smtp-Source: ACcGV61ew4hQ3xJBCsJ/gudWhfekCM443S6zBlyIQYqswHelJOviBlh8LCRxMcv/e/uCxLziOv8OYwnVlgyFxFozQi8=
X-Received: by 2002:ae9:ed82:: with SMTP id c124-v6mr7446232qkg.264.1538044243170;
 Thu, 27 Sep 2018 03:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <1537935759-14754-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537935759-14754-3-git-send-email-suganath-prabu.subramani@broadcom.com> <20180926210345.GG28024@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180926210345.GG28024@bhelgaas-glaptop.roam.corp.google.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Thu, 27 Sep 2018 16:01:03 +0530
Message-ID: <CA+RiK66=yDUL8J_UxcAGCDnZd6eHrxz7E=AUF_thhdiEGJRZUA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] mpt3sas: Separate out mpt3sas_wait_for_ioc_to_operational
To:     helgaas@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
        lukas@wunner.de, Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for reviewing.

On Thu, Sep 27, 2018 at 2:33 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Sep 26, 2018 at 09:52:35AM +0530, Suganath Prabu S wrote:
> > Introduce mpt3sas_wait_for_ioc_to_operational.
> >
> > This section of code "wait for IOC to be operational"
> > is used in many places across the driver,
> > and hence moved this section of code in to the function
> > "mpt3sas_wait_for_ioc_to_operational".
> >
> > Also added HBA hot unplug checks, and this returns with
> > error code EFAULT, if it detects HBA is hot unplugged
> > or IOC is not in operational state.
>
> This should be two patches:
>
>   1) Factor out the "wait for IOC" code.  This should not cause any
>      functional changes (I didn't verify in your code, but this is the
>      objective).
>
>   2) Add the hot unplug checks.
>
> This makes the patches much easier to review.
> Will move hot unplug check to separate patch.
> > V2 change set:
> > used pci_device_is_present instead of
> > mpt3sas_base_pci_device_is_unplugged
> >
> > v4 Change set:
> > Dont split strings in print statement
>
> I don't know the convention in drivers/scsi, but in driver/pci, I
> remove this sort of v2/v3 commentary from the changelog because it's
> really not of interest after the patch is merged.  It's nice to have
> it in the email, but I think if you put it after a line containing
> only "--" it will be in the email but not the changelog.
>Thanks, Will add change sets after --
> > Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
> > ---
> >  drivers/scsi/mpt3sas/mpt3sas_base.c      | 92 +++++++++++++++++++-------------
> >  drivers/scsi/mpt3sas/mpt3sas_base.h      |  4 ++
> >  drivers/scsi/mpt3sas/mpt3sas_config.c    | 28 +++-------
> >  drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 26 ++-------
> >  drivers/scsi/mpt3sas/mpt3sas_transport.c | 75 +++++---------------------
> >  5 files changed, 81 insertions(+), 144 deletions(-)
> >
> > diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
> > index c880e72..9f1d8fb 100644
> > --- a/drivers/scsi/mpt3sas/mpt3sas_base.c
> > +++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
> > @@ -5176,6 +5176,53 @@ _base_send_ioc_reset(struct MPT3SAS_ADAPTER *ioc, u8 reset_type, int timeout)
> >  }
> >
> >  /**
> > + * mpt3sas_wait_for_ioc_to_operational - IOC's operational
> > + *           state and HBA hot unplug status are checked here.
> > + * @ioc: per adapter object
> > + * @wait_count: timeout in seconds
>
> "wait_count" is really a timeout and maybe should be named "timeout".
>Yes, wait_count is timeout, will rename wait_count to timeout
> > + * Return:  Returns EFAULT, if HBA is hot unplugged or IOC is
> > + * not in operational state, within the wait_count.
> > + * And returns 0, If not hot unplugged Or ioc is in
> > + * operational state.
>
> I think you mean something like:
>
>   Waits up to wait_count seconds for the IOC to become operational.
>   Returns 0 if IOC is present and operational; otherwise returns
>   -EFAULT.
> Yes.
> > + */
> > +
> > +int
> > +mpt3sas_wait_for_ioc_to_operational(struct MPT3SAS_ADAPTER *ioc,
> > +     int wait_count)
