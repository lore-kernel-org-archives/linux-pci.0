Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82858C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 09:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D7120C0A
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 09:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K2JqaKP7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D7120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeIYPxY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:53:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36474 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbeIYPxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 11:53:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id v17-v6so15503299lfe.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Sep 2018 02:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NrOVCwlU7+7r3eDStJITmlj6uViTBWR8FQtqOC2V8rM=;
        b=K2JqaKP7ff8CtmscoonCg2j5np/AHDie3CA0Z1+w+Kp+u3Emrn3UzTATYOoj1Moi+U
         477lRgTXqlL6FsmKsPogqlosHnHfro8flHr43rpFh5oraFqPbsRcMF9A7+u37egg/7zf
         KqIHrflfZi/WACmq5UyTSV9veaV+zOk8V81U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NrOVCwlU7+7r3eDStJITmlj6uViTBWR8FQtqOC2V8rM=;
        b=arnrg3SAg6zTHVOuisAp1XbSv9AEMLMnoC8cJxcJKVjWaRFzZIMsedBk1mvpc5lgDT
         SGu04RQ3iapSlOU/HrDjIkXeO74BcM30StRBI/qOiH6TGqWEEAONKyExYiQXtr4MzRMv
         YbI2hgUN29ElDKJWORYhDbdoE7lWuXjvyfHLZwfeqG76D53yt3Fz8QOrYoveP6gEUgko
         MBE2RtYmaooiyGgg3y6KMNiK1s+1a0ztx2GQl9XDES1R1T3zEUbEti7mSwLHfWYxYg87
         tm4rtuXy0BPekIbDyA32FoAylIu1SFpSv23o+LZbQqkPyQXNvqoJ/LrzhzDleg271Dyg
         cScA==
X-Gm-Message-State: ABuFfojWK7QCEjmsmAJQzi1eXHP1xmmfvoUjn21SIMEADAAqajTEIYJy
        7tecUJ76hyDd/y6Cy+RE3XhL74RC823SSNSncp27nQ==
X-Google-Smtp-Source: ACcGV60Kdzznh6soVCZRBkq5Ru1MwwqZi117OtOfaC9GmxRooKnfgXJ6jS81CADB8jY9NZX9C7LIvc+SlMo1cArMvsw=
X-Received: by 2002:a19:8d11:: with SMTP id p17-v6mr183392lfd.116.1537868799092;
 Tue, 25 Sep 2018 02:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <1537770916-16337-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1537770916-16337-2-git-send-email-suganath-prabu.subramani@broadcom.com> <CAHp75Vd7eLgK59DdmVCE7jZgnkpGq0+21DqU=f6PghdvpUEzuA@mail.gmail.com>
In-Reply-To: <CAHp75Vd7eLgK59DdmVCE7jZgnkpGq0+21DqU=f6PghdvpUEzuA@mail.gmail.com>
From:   Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Date:   Tue, 25 Sep 2018 15:16:58 +0530
Message-ID: <CA+RiK64ExuUXKHk8tRAoYT7aSCqX4T4hofWrpkD4KysG0WrhyQ@mail.gmail.com>
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

Hi Andy,

I forgot to add Lukas in last patch CC list, But i have sent a note
regarding the updated patch to him.
 Also added linux-pci

On Tue, Sep 25, 2018 at 2:10 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Sep 24, 2018 at 9:36 AM Suganath Prabu S
> <suganath-prabu.subramani@broadcom.com> wrote:
> >
> > * Driver uses "pci_device_is_present" to check whether
> > If Hot unplugged:
> > the outstanding IOs with 'DID_NO_CONNECT' before removing the drives
> > attached to the HBA.
> > "DID_NO_CONNECT" status and free the smid, if driver detects that
> > HBA is hot unplugged.
> >
> > * In the hard reset flush out all the outstanding IOs even if diag reset
> > fails and also if driver detects that HBA is hot unplugged.
>
> > +       if (!mpt3sas_base_pci_device_is_available(ioc)) {
>
> > +               pr_err(MPT3SAS_FMT
> > +                   "%s: pci error recovery reset or"
> > +                   " pci device unplug occurred\n",
>
> This should be just one line.
Above line crosses over 80 characters, so it is in two lines.
>
> > +                   ioc->name, __func__);
> > +               return;
> > +       }
>
> --
> With Best Regards,
> Andy Shevchenko
