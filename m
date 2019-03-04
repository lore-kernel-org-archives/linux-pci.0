Return-Path: <SRS0=xyCL=RH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15B4C43381
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 20:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3C2206B6
	for <linux-pci@archiver.kernel.org>; Mon,  4 Mar 2019 20:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUS+6dr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCDUML (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:12:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54210 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCDUML (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Mar 2019 15:12:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id e74so406951wmg.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2019 12:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orUr5BvfCKB7i1FwqzkBRn2hZ0CZ+lVkuWSEFMZY3X8=;
        b=YUS+6dr6rT2opHsgSYNMBV7gU3TUTXpDi3RCKy56mgjrzgKuu9qdfWvFVvfp0A+uQ3
         1smzXLLXV2Dqhfti7tzArXOti7ne6nEDo5Bk7ZLUEsG51EDonhru5wFzsulNRNLi4dnN
         YbKlkyJsqA3tRcxAdgPJ4u7MeHHexPi7UhzJFmOQiqdydOn4i22hRdbYkruTP84Z1yK/
         uXvhQIMqjuxIDdfP8RoQCDw8ibS34cV+W6N/M4Jed3iBHVKOWSH1Ai3z2co1gvDXVevS
         P2segjgQ7+IYgyepl923zbE+BdSFOBlYjkDVjhcuV6cvIfAiUnwYZPerMrB3XJcac2n5
         Lg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orUr5BvfCKB7i1FwqzkBRn2hZ0CZ+lVkuWSEFMZY3X8=;
        b=JGMfH7g2fhEpbtPmzwoeSvHdxbyi8XxG8yPqRWkvX13NPkOwA9iDub5qvKVGfqOabS
         Ld0VsVb8MGDzEVUO3jqjsTOSx0A+/+1nIe6w3G5w2KH8yjZdWqFFcNlLr4HXsknC7l//
         BhenBEqn1pVfE2M7Bh70UHwm/Uf1qlT9bCdw1qAe9Hx987dn+lLY9gY9uQqd7t5TaUj3
         KqQME+xS758g5hsJq3LdXNmKMA/zZ2Bjj3AlrozMcSYbry0JoT01fZJLTLhM5jNMl+EW
         vMP4gCMkcLdJJpwJ9b3yDqXNsrUyNHuih/9HCDRUcK2IKoir2oYh7AwK9qIxvsRp9ocJ
         Y/AA==
X-Gm-Message-State: APjAAAWp9ZEZJZnfYUDty87wkgWU+uI8l6cbCtUtf5QKV8FmZtkp/A7r
        ZaohcR1O934EbsZNJAj9h/gfJBH2BG7jKdM1yYoP
X-Google-Smtp-Source: APXvYqyv72bg1OXBmDYAsONKat9lZv2iToBu+KLbl7eihVoODf0kySbPEu3DVLOrtogPSnDjUJW2nph2VepTigaRcFU=
X-Received: by 2002:a1c:7dd7:: with SMTP id y206mr465100wmc.123.1551730329649;
 Mon, 04 Mar 2019 12:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20190214170028.27862-1-logang@deltatee.com> <20190304002351.GA26569@google.com>
 <3e45b4ab-e848-cf3b-624f-121ad58b0250@deltatee.com>
In-Reply-To: <3e45b4ab-e848-cf3b-624f-121ad58b0250@deltatee.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 4 Mar 2019 14:11:57 -0600
Message-ID: <CAErSpo4U6Kys5OzPwfyFdbnJWfTZ-y0P830okf11BwfNv9Y82A@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Prevent 64-bit resources from being counted in
 32-bit bridge region
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 4, 2019 at 1:21 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> On 2019-03-03 5:23 p.m., Bjorn Helgaas wrote:
> > Sorry for the delay.  This code gives a headache.  I still remember
> > my headache from the last time we touched it.  Help me understand
> > what's going on here.
>
> Yes, this code gave me a headache debugging it too. And it's not the
> first time I've tried to figure out what's going on with it because it
> often just prints noisy messages that look like errors. I think I
> understand it better now but it's something that's a bit fleeting and
> easy to forget the details of. There may also be other solutions to this
> problem.

Thanks for the explanation below.  I haven't worked through it yet, but I will.

Obviously it would be far better than an explanation if we could
simplify the code (and the noisy messages) such that it didn't
*require* so much explanation.

Bjorn
