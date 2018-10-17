Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C8FECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502762151D
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 08:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNknPWLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502762151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbeJQQOQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:14:16 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39494 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbeJQQOQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Oct 2018 12:14:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id e22-v6so28998190qto.6;
        Wed, 17 Oct 2018 01:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITYBumtyQSVcI5lpSjOMZ+QBiPxS/jBpGoItslSkJAU=;
        b=XNknPWLRAuHN/vT80bAKT5MdZLrm0vlFT60EkGSCkKXfUKXb+IhdKgu/FzYcGGOjB8
         ar0gQi1A+IxicWvUU1dcAHl/s+OLbnvsBKD1WAohmJ+EGwgdBpOU1Q/A06x/HIDXdmd9
         Wl87Qj1fhUWeplLiul8l+QAqTog6K3YxcrdVzaZlBzw+vxOhcVyrVPWdYHoOraSbIBEy
         zFfx3LVigPhRoLmDQ898UGAjyvwJ1GV0INgWmXrX8D98BcYAhblkAgLtn7Pw0hjHJGf7
         6hJhpLkTx/hRQKJEm3gEj7sajavHb/gwqyE9OTIpkfKOUjJY3d8xz2TCmb2MvZKEZsEq
         2fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITYBumtyQSVcI5lpSjOMZ+QBiPxS/jBpGoItslSkJAU=;
        b=R9w4o04TyFFJzlImAkRZBtIaeU3MKMQZ/8GXe2Zq5Tm5iMuIfKaT9+pda1qwImATQy
         7K61RjLQmcr8e69yytGaZ9ZeP+9pTcczVOeDDp+8EAoaS6MEYKgORnHEmob2aXDl7JnX
         TcuDp73ACPDzVW83Jmjjb21uQAuGa4iMO3x9SiCWSHX+cdpF5HBjAyOyp0i/l0pPYbpL
         Ak6NnIhsRdp2vL7xYQ51fuPUrW/0QPX3Cgbe14JhlQlSkJt9ibwUp94eTg7/EjkdY9jF
         7lLCDs8LjqhZXwsTs5EzepvFRr84J+4CgQXC5MkzYAd+9zKKMy+gAkDQIVVusMf3Yh3A
         +uQA==
X-Gm-Message-State: ABuFfoih0IWqv3SYZi3h0VaO1vA841nSWHdzyqcH4OyR8YpnvqlAes21
        q1x2XeF6Wdjeo47dMX33kxAGyuk6dAZN4kwJdMg=
X-Google-Smtp-Source: ACcGV60mhb1Zitj7qxxH593aM+vPlqpiryoHNVPpPaaZwpiTHK/3xZGyuXakGC8gQTm5gZZDTC2seJgmMv6UNUfGbxQ=
X-Received: by 2002:ac8:190e:: with SMTP id t14-v6mr22803027qtj.327.1539764383022;
 Wed, 17 Oct 2018 01:19:43 -0700 (PDT)
MIME-Version: 1.0
References: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1539755947-27014-2-git-send-email-suganath-prabu.subramani@broadcom.com> <CAHp75Veh=CkhD67jb+Qjps-UqtcCBUsA8bWco6kqppm0Q+tcvg@mail.gmail.com>
In-Reply-To: <CAHp75Veh=CkhD67jb+Qjps-UqtcCBUsA8bWco6kqppm0Q+tcvg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 Oct 2018 11:19:32 +0300
Message-ID: <CAHp75VfPok+x4U_CmP91eG8KtOUvFYkavrw0Wg5Q9m2ZNbcVZg@mail.gmail.com>
Subject: Re: [v5 1/4] mpt3sas: Separate out mpt3sas_wait_for_ioc_to_operational
To:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com,
        Sathya Prakash <Sathya.Prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 17, 2018 at 11:17 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Oct 17, 2018 at 8:59 AM Suganath Prabu
> <suganath-prabu.subramani@broadcom.com> wrote:
> >
> > No functional changes. This section of code
> >  "wait for IOC to be operational" is used in many places
> >  across the driver, and hence moved this code in to
> >  a function "mpt3sas_wait_for_ioc_to_operational()"
>
> > +       ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
> > +       while (ioc_state != MPI2_IOC_STATE_OPERATIONAL) {
> > +
>
> Do we need this blank line?
>
> > +               if (wait_state_count++ == timeout) {
> > +                       ioc_err(ioc, "%s: failed due to ioc not operational\n",
> > +                               __func__);
> > +                       return -EFAULT;
> > +               }
> > +               ssleep(1);
> > +               ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
> > +               ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
> > +                        __func__, wait_state_count);
> > +       }
>
> I understand this is part of existing code, but can you consider to
> modify it to something like
>
> do {
>     ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
>     if (ioc_state == MPI2_IOC_STATE_OPERATIONAL)
>       break;

Forgot ssleep(1); here.

>     ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
> __func__, ++wait_state_count);
> while (timeout--);
> if (!timeout) {
>     ioc_err(ioc, "%s: failed due to ioc not operational\n", __func__);
>     return -EFAULT;
> }
> Less lines, more understandable in my view.

-- 
With Best Regards,
Andy Shevchenko
