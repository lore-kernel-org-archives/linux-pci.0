Return-Path: <SRS0=eYAu=NK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D47C2BC61
	for <linux-pci@archiver.kernel.org>; Tue, 30 Oct 2018 13:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC6C20831
	for <linux-pci@archiver.kernel.org>; Tue, 30 Oct 2018 13:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2rjFdvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC6C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeJ3V7A (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:59:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40755 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeJ3V7A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2018 17:59:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id k12so7410566qtf.7;
        Tue, 30 Oct 2018 06:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NHRHjwDRCgnJAFXkyLVDSfRknR6+fivwcsoAsTXEb4=;
        b=l2rjFdvEH+9vm6N8jJ8fBQhw2Sg1hUDr+KW5semJP0Oz393c36BvopLvh3LGLqnmHU
         hxbWRYzZy8TeL/wPek4hQux/Qg7+aw/ILr1nsklzx7x8QPWi5ImYPnHugAdfUClheqf2
         aMPcpKLjUt0+UwP7ehroXZYR+HxrlRVSFtcTlBXhLvnTdotZi9HJSE2btkW/lwei+ZS0
         S9TZgpc4SG6zhtFHXFJXpWIlbpR9iym0rXzUQ7elyy+IP3tu8oj4Rr1LW8H32fk/gFYl
         CQdxMGs/CvaOWGQZmP6USt9WQ4+WrtsfTuHPxp5RTa28nPb2BaEJNfgmUiIOhNqLczAJ
         TPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NHRHjwDRCgnJAFXkyLVDSfRknR6+fivwcsoAsTXEb4=;
        b=ced4pO72sa/h5wFnbAtgXFYt7h0zNgn+PPK20fau6fjFz8OmTQ4Dmvv/xLOMqCU0tY
         V4NofRSamshqum4SOkz4hpT8jLufWBqJsU5o/+pG6+Gvj6rOPdz3uFQNyLI7FwIOQokZ
         EGLpB9xjQph7S/ny17UfbANU+kYs6MkAr6JN22qHCZc3ApG2iNzB+PaziKzx0G7O7wO0
         LXMjAuHFh0N08b4NsZs0qxXXQRBTjeJZqYBFG3F2Zt6mF+LNQkPBXV+O+tmB6EgoBcIW
         nY3MVZP0T9+HqjgW8fOSWIGbuoSypNTAK5aWWARIbWr3wIHxOlkubiZ2UzxYscInmDO5
         nDMg==
X-Gm-Message-State: AGRZ1gLPxcQNBkNm49qy3sJkn0rlWD4zJJ/4X4ogXPJNSC0MfLq2rUEh
        YNRWCaiiHfFktW+EzncVzTCbqEWMpJ7XbJ3/WYk=
X-Google-Smtp-Source: AJdET5cOsKE1pHbAxzqwZAYzhNc3f0Dd7bhiFXI8/c1D4l9jDERGx9iEnalC0iyECY/9YlAzdzdyS4a0SorsmxTX/EE=
X-Received: by 2002:a0c:b60a:: with SMTP id f10-v6mr17184835qve.7.1540904734929;
 Tue, 30 Oct 2018 06:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <1540290081-15827-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CA+RiK64Y=FLr=SZmxEoCvWCvZq8ppqFsL=q2L1Q7T5sZfDQfkQ@mail.gmail.com>
In-Reply-To: <CA+RiK64Y=FLr=SZmxEoCvWCvZq8ppqFsL=q2L1Q7T5sZfDQfkQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Oct 2018 15:05:23 +0200
Message-ID: <CAHp75VeNSG7=79pQ=9zFkp0mSSSoFnjacbQQa=kQu2+hKWvMwQ@mail.gmail.com>
Subject: Re: [v6 0/4] mpt3sas: Hot-Plug Surprise removal support on IOC.
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        ruscur@russell.cc, sbobroff@linux.ibm.com,
        Oliver <oohall@gmail.com>,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 30, 2018 at 8:41 AM Suganath Prabu Subramani
<suganath-prabu.subramani@broadcom.com> wrote:
>
> Any update on this ?
> In V6, I have posted has only defect fixes (Other than HBA Hot-Plug
> Surprise remove support).
>
> We are reworking and incorporating the suggestions from Bjorn.
> And after covering tests, we ll post Hot-Plug Surprise removal patches.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

P.S. We are in the middle of merge window, so, this week is a little
chance anyone will look at it.

> Thanks,
> Suganath Prabu
> On Tue, Oct 23, 2018 at 3:51 PM Suganath Prabu
> <suganath-prabu.subramani@broadcom.com> wrote:
> >
> > v6 Change set:
> > Incorporated changes as suggested by Andy.
> > In Patch 1 converted while loop to do while in
> > function mpt3sas_wait_for_ioc_to_operational().
> > And in patch 3 removed parentheses.
> >
> > V5 Change set:
> > V5 post has only defect fixes.
> > We are reworking and incorporating the suggestions from Bjorn.
> > And after covering tests, we ll be post Hot-Plug Surprise
> >  removal patches.
> >
> > V4 Change set:
> > Reframe split strings in print statement, to avoid
> >
> > V3 Change Set:
> > Simplified function "mpt3sas_base_pci_device_is_available" and
> > made inline
> >
> > V2 changes:
> > Replaced mpt3sas_base_pci_device_is_unplugged with
> > pci_device_is_present.
> >
> > V1 changes:
> > In Patch 0001 - unlock mutex, if active reset is in progress.
> > Suganath Prabu (4):
> >   mpt3sas: Separate out mpt3sas_wait_for_ioc_to_operational
> >   mpt3sas: Fix Sync cache command failure during driver unload
> >   mpt3sas:Fix driver modifying persistent data.
> >   mpt3sas: Bump driver version to 27.100.00.00.
> >
> >  drivers/scsi/mpt3sas/mpt3sas_base.c      | 75 ++++++++++++++++++--------------
> >  drivers/scsi/mpt3sas/mpt3sas_base.h      |  8 +++-
> >  drivers/scsi/mpt3sas/mpt3sas_config.c    | 28 +++---------
> >  drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 21 ++-------
> >  drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 38 +++++++++++++++-
> >  drivers/scsi/mpt3sas/mpt3sas_transport.c | 70 ++++++-----------------------
> >  6 files changed, 106 insertions(+), 134 deletions(-)
> >
> > --
> > 1.8.3.1
> >



-- 
With Best Regards,
Andy Shevchenko
