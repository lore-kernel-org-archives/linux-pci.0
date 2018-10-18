Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3EAC5ACCC
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 07:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F49C208E4
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 07:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7a9sL6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F49C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbeJRPVv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:21:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44221 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbeJRPVv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Oct 2018 11:21:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id x24-v6so1559064qtx.11;
        Thu, 18 Oct 2018 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hW70wPM5B1kwnKSHRgQ7+ugmG/Kth6DHltt08mOUgrk=;
        b=U7a9sL6F1De6iqcemhWxikuybdlr+gsnPAOSjrnsAS9qqnUiLfSR7ZdNzfaqpkKu2j
         HCkQ/6ofazu7QYyVaKLsrV1LEibi1bn94rEEFGZ25KIvg3WMLRgBRur/vWdkunEni7l1
         6+rGw+wjjlzP/ig4CBKjVekfyeJOsrCPIp6RHF7GzAhqGZMY224RYRfDzXEWQCZUO4N3
         6U4k1FI9zggjsM1gaz1JrZfHlINq2JvKSxisMWOdjvxvzbP0aDXWcbncty4Szd9HPNJ6
         DDsLIDqBWQ1PuEj3Vy/BMikfVAFMSt8pJBGBlhMwZKvbs0WvPpH5NbragQ606QFvXmkz
         yNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hW70wPM5B1kwnKSHRgQ7+ugmG/Kth6DHltt08mOUgrk=;
        b=ZPdXgzCauF/ItJdzkj+VJQfSqbPU5jV+L+IWAElFqsVVpr2ahicIX4RXjkHfcnI80B
         ULQGYhUd43BJvCzSM5j4F9e34wYOkjJvcWaSebFiEk8cWlQYJl3N8vjR5h0/Yot1Q9jg
         1fqhWpYdt5sZpYzhuInijlx2WOYTdetw9+0o4H3nVUxwgBwEkwvJX7LU0oWCgMtxHWh7
         lu8LyyvjQfVZJMrKtevAux+6oJ7ifxe5sw2Ywf7s3F255kK0LYpmbYRgSNNG+q62RXi0
         d0IpIA3cyF7Fs4tZvLAHWUzZlyck36lq5/bHHrsUck3nvietreKs9bmvQEbaipnL7a5I
         9psA==
X-Gm-Message-State: ABuFfojN3Y6N1Z4A51Ud/guEgTpbTUug4MCB7GIXzlZ3USPgPG/Du6Pw
        cqx216TAAYriq7N7cBbsY11IAeNKq/dDbrBxsKI=
X-Google-Smtp-Source: ACcGV63SaNabP/WirmTt7GWoE/S7yyTZ+TgFo7oAS4ORoPDq8PAXXxBEaeXhySN7n5ycKfK1TYPtCsSeMJJ5vRZGEBA=
X-Received: by 2002:aed:2de3:: with SMTP id i90-v6mr9194791qtd.229.1539847332291;
 Thu, 18 Oct 2018 00:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <1539755947-27014-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1539755947-27014-2-git-send-email-suganath-prabu.subramani@broadcom.com>
 <CAHp75Veh=CkhD67jb+Qjps-UqtcCBUsA8bWco6kqppm0Q+tcvg@mail.gmail.com>
 <CAHp75VfPok+x4U_CmP91eG8KtOUvFYkavrw0Wg5Q9m2ZNbcVZg@mail.gmail.com> <CA+RiK66_gpLvzFyztdQ3BdX11wn2uRfxoF6hhRg1TXoERe7z3Q@mail.gmail.com>
In-Reply-To: <CA+RiK66_gpLvzFyztdQ3BdX11wn2uRfxoF6hhRg1TXoERe7z3Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Oct 2018 10:22:00 +0300
Message-ID: <CAHp75Vd63Ss3WBuAA0euutGboUuOzS0EJ3J-365b5QOTz98NqQ@mail.gmail.com>
Subject: Re: [v5 1/4] mpt3sas: Separate out mpt3sas_wait_for_ioc_to_operational
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

On Thu, Oct 18, 2018 at 10:10 AM Suganath Prabu Subramani
<suganath-prabu.subramani@broadcom.com> wrote:
> On Wed, Oct 17, 2018 at 1:49 PM Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> On Wed, Oct 17, 2018 at 11:17 AM Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:

>> > I understand this is part of existing code, but can you consider to
>> > modify it to something like
>> >
>> > do {
>> >     ioc_state = mpt3sas_base_get_iocstate(ioc, 1);
>> >     if (ioc_state == MPI2_IOC_STATE_OPERATIONAL)
>> >       break;
>>
>> Forgot ssleep(1); here.
>>
>> >     ioc_info(ioc, "%s: waiting for operational state(count=%d)\n",
>> > __func__, ++wait_state_count);

>> > while (timeout--);

Just noticed this should be --timeout.

>> > if (!timeout) {
>> >     ioc_err(ioc, "%s: failed due to ioc not operational\n", __func__);
>> >     return -EFAULT;
>> > }
>> > Less lines, more understandable in my view.
>
> Yes, We 'll take this change and resend.


-- 
With Best Regards,
Andy Shevchenko
