Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57E0ECDE43
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 07:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796EB208E4
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 07:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jr9P8hsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796EB208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJRPXJ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:23:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44357 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbeJRPXJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Oct 2018 11:23:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id x24-v6so1561765qtx.11;
        Thu, 18 Oct 2018 00:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O7kIxwq2qKHcExhNfWzmcsriRPxkNspejgUxQxEv01Y=;
        b=jr9P8hsOVn+LrrHJMQESCTGZakg+cJlWvuVArNccQja+NdHig6POM0QkIDNuj6ggv8
         nyQ5cWw2aXCqpPM0Mo2QdU+2R2JP28LUpgbrAlKXi9eBQ+0D03Z4OjXQdzTRgxkQNkyY
         WhxUDzYizChbQDM3KYxEcqWG2s5G8JQZbiQwnoKg74W0C2vAhBv0anXHv9nEXVT3N+JA
         TaZGecbJqW/cg756u1gx++UqpXWQd2nR9i+q5ej+hRKGmmlnwfx+YmtClpaImYxbgbWz
         MxUbhCuz+ei6BfVZieJD2ARy2q8UtxR1Q+lsy+jJwkw5D452aOsJowMJEbxTJmscPbI7
         zs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O7kIxwq2qKHcExhNfWzmcsriRPxkNspejgUxQxEv01Y=;
        b=XsC/eUNsSLOxKjwAytTthFlDDsSPZGksSaQ3n62rsHXXtCADb7XD9CCnHWlcpqL2Tw
         TB/6X1G8ocf2lprHOS3bYrjXDlTOqbKXAFURN2eJV+TgXgZto35UTF3j85x/aLacB0xA
         ZdPS4Daqxvs2MPgjvb4C7b9HpCiZt2jkfutYpyt5hd97lbbMD23p1tp9CZ8FRYMbUjHG
         LYRRAlvnQ54c9HLCh67FtcsD9Vu/sDfYgmUllvinlxyt2TN74Ui3/d10ZIVj7uZP4mLu
         oOydlA/PxD/3iue+LMc/US4byLiBeZbt0VGP6d3CtsTJJRu99ZlrsyjKvvhWn2co6+wv
         OdzA==
X-Gm-Message-State: ABuFfojzS5RtJFCBNpMNicviklmJV1uALNP5lpcyjN2JPxvEada5+V99
        CEyUG2colGASdQuZxsNqdkzox9WkCZzUmTZTFNfINgVZ+6o=
X-Google-Smtp-Source: ACcGV62KVYxg4rjUnT1EREW/DiVAF+aXR+k46NOswC01dj3RKOlrmvV0bF4eAuH2MybFoPnL5Y23UiY8ys536jPbvFE=
X-Received: by 2002:ac8:6784:: with SMTP id b4-v6mr28081655qtp.373.1539847410128;
 Thu, 18 Oct 2018 00:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1539755947-27014-3-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CAHp75Ve=X9X6xG5FpuZrmRKfSpcLwFQYE_A8vhUzNn92KSoc4w@mail.gmail.com> <CA+RiK67067aV9Ky5m8uCGLGcvjbBRxqFVeyB0CsYcvSw7rgqJg@mail.gmail.com>
In-Reply-To: <CA+RiK67067aV9Ky5m8uCGLGcvjbBRxqFVeyB0CsYcvSw7rgqJg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Oct 2018 10:23:18 +0300
Message-ID: <CAHp75VfENTJjJVMyQ1wnD4GXYKjhgr6h+wocPOfk16p9nWrpeg@mail.gmail.com>
Subject: Re: [v5 2/4] mpt3sas: Fix Sync cache command failure during driver unload
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

On Thu, Oct 18, 2018 at 10:11 AM Suganath Prabu Subramani
<suganath-prabu.subramani@broadcom.com> wrote:
>
>
>
> On Wed, Oct 17, 2018 at 2:02 PM Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>> On Wed, Oct 17, 2018 at 8:59 AM Suganath Prabu
>> <suganath-prabu.subramani@broadcom.com> wrote:
>> >
>> > This is to fix Sync cache and start stop command
>> >  failures with DID_NO_CONNECT during driver unload.
>> >
>> > 1) Release drives first from SML, then remove internally
>> > in driver.
>> > 2) And allow sync cache and Start stop commands to firmware,
>> > even when remove_host flag is set.
>>
>> > +       if (ioc->hba_mpi_version_belonged == MPI2_VERSION) {
>> > +               if (ioc->remove_host)
>> > +                       return false;
>> > +
>> > +               return true;
>> > +       }
>> > +
>> > +       if (ioc->remove_host) {
>> > +
>> > +               switch (scmd->cmnd[0]) {
>> > +               case SYNCHRONIZE_CACHE:
>> > +               case START_STOP:
>> > +                       return true;
>> > +               default:
>> > +                       return false;
>> > +               }
>> > +       }
>> > +
>> > +       return true;
>>
>> Wouldn't be the same as

>> Yes it is same, but i feel original code is more readable.

OK (I didn't compare assembly, but I assume this is slow path).

>> if (!ioc->remove_host || ioc->hba_mpi_version_belonged == MPI2_VERSION)
>>    return !ioc->remove_host;
>>
>>  switch (scmd->cmnd[0]) {
>>  case SYNCHRONIZE_CACHE:
>>  case START_STOP:
>>    return true;
>>  default:
>>    return false;
>>  }
>>
>> ?
>>
>> --
>> With Best Regards,
>> Andy Shevchenko



-- 
With Best Regards,
Andy Shevchenko
