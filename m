Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DFBC32789
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 12:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8DC20825
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 12:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5dcgvQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8DC20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbeKHVyi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:54:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46091 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeKHVyi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2018 16:54:38 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so25935821qkf.13;
        Thu, 08 Nov 2018 04:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m7swSWtNShO9i3P/CEEBFYSk1B4dBrgZU/HlWhtMzGs=;
        b=G5dcgvQxDXKET9OX1fAJuta1JaVXBfieRR1t2B4vYSzJ9vNfVXpGYrqe/MO5h/K/Rm
         Q1FZtKykRIsHKz7TuibYGE+h3NKRwj/ThFS+yNf4Ive4jzgVlAWv1Hs+iGie9SEOaFit
         jQDMYXjt4Pn6CYn8Mv9zIMC/J0PlDyDOfreeorK4itf47MLY7zkPfAL8xj9snUBOL35V
         wQpjfKAWq7Jrqi2am3Ci5ltO3VkZqgDDjDCuYHlhjndEuEVkKDtSe6T3pSOnqX9vq/U9
         hCqnCRTAjUhqLsdGavdAlp7ixTYNsUNC+IYVnGmXAYPc8zfUmXALzh7XTH3wOl7hUooL
         gH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m7swSWtNShO9i3P/CEEBFYSk1B4dBrgZU/HlWhtMzGs=;
        b=rKjLhEEEZTUgPzscTJJnifx/qIEuaFu2fg3zEoJF29nQZSl63w4EWieeA4gZCOaxzz
         Ov3oSqMU/TUFk7MXTArji5MSgq1ZSxCtOYuB9R03/LDhHnqnamr2j8R1KEfwSkgNDeuX
         wSECOA0fPqBqo6v5PLyUHd7C8KvH3usmZiKxH4PGUaOeCl27D0lQBvZ9uq7JswgSCoAy
         Pff6+KHjunUtVOZVwRjPRTQh/Sin2gT7cjWY8qUS4b1wV555aOmsQ30z8jVZdh8xlfue
         k5WLWg0QG5SBdByoPAu5x7V1c7Hd5PWrO7RdG5l6c5SRnU7QkacbkAxhS6twTfI76Pvg
         KTMA==
X-Gm-Message-State: AGRZ1gJJpKjy8jyiUnpOptc70aOV678Lcpf1HX3w7/AB5iB1o870DOci
        tBBSLOhufT5MDktf0td9Q41B0RVdUxejC41bSs4=
X-Google-Smtp-Source: AJdET5dlo7PmXo909695Y1DUdGvqSMt2DsDsMoSSig9ufUAVmiyR2FQQ2GSfZdLcYA7PTN1JoawTa2BiGa3RTMsMtxQ=
X-Received: by 2002:a37:7983:: with SMTP id u125-v6mr3633804qkc.219.1541679564011;
 Thu, 08 Nov 2018 04:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20181107195856.43223-1-andriy.shevchenko@linux.intel.com> <20181108100555.GB27328@kroah.com>
In-Reply-To: <20181108100555.GB27328@kroah.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Nov 2018 14:19:12 +0200
Message-ID: <CAHp75Vf7YJ=Yzo51yw1J+K2irshqve0rr6RN0UqneXCo7aRVCA@mail.gmail.com>
Subject: Re: [PATCH v1] PCI: Move Rohm vendor ID to generic list
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 8, 2018 at 12:10 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Nov 07, 2018 at 09:58:56PM +0200, Andy Shevchenko wrote:
> > Move the Rohm vendor ID to pci_ids.h from dozen of drivers.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >
> > I believe the best chance to get it merged and be less intrusive to ong=
oing
> > work is through PCI subsystem as a _fix_ for v4.20.
>
> What?  Why?  Who cares?

> This can trickle in over the next year or never, as it isn't a bugfix,
> or "necessary" at all.  Just add it to pci_ids.h and when that gets
> merged, you can try to remove it from the individual drivers if it
> really is annoying to you.
>

> But this is _NOT_ a fix for anything, don't try to mask it as one, that
> feels like "crying wolf" here :(

It doesn't fix anything, indeed. But since it touches 9 drivers
simultaneously, it might be easier to push it earlier, or other way
around =E2=80=94 at the end of the cycle.
OTOH, I don't think there would be conflicts if it goes normal way
through PCI subsystem.

--=20
With Best Regards,
Andy Shevchenko
