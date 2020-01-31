Return-Path: <SRS0=9tGp=3U=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF06CC2D0DB
	for <linux-pci@archiver.kernel.org>; Fri, 31 Jan 2020 22:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FB8214D8
	for <linux-pci@archiver.kernel.org>; Fri, 31 Jan 2020 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580511012;
	bh=oXpOaVGOS6SDp8q39m6kpslzFKXiI2MK/hsfwK+pcmc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rgRulRBgSxteRn0zuWP7t/YBwfF9LQsLeI4KSFw94WLBqrjTqnbVqjeA0ESpFhTES
	 EcOEx9OCd7fHRlDU80ypjXurJjoYUXneSfp/lj/Iggtq+cjPBuLo70T6ay+CNCd2/8
	 +jhj8/5qSrsHVMVsGVJK5Jk6ad1bEOv4zQ94ypfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgAaWuM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:50:12 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37609 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgAaWuL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2020 17:50:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id v17so8754507ljg.4
        for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2020 14:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsjAu+tfEvoLC3dwMkCioXx0hC7IWMGyAJfLYgWB1b4=;
        b=IiZNGX+wDwmdzlBYBzzF8bFUmBUM/q2ECPUku4aCyw6YGltT7EaaLe+x+mvNda/0w1
         T17XRoUioyvD69g8aQiIpyBZs9gP/DiZ7FJSstZ33pf9E7vEke9Lw6vK0P6D71JAKJcI
         J/hamojyIzV/uvQu7is+4L6nFhpHXab2nnwQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsjAu+tfEvoLC3dwMkCioXx0hC7IWMGyAJfLYgWB1b4=;
        b=oXAYdCdUc5ZgUX5CMwGY/O8By6a4eEpkjqQkm/Add65XWXAHF8k3kL3yc6DML01F8a
         98H4domADUgICwTAkxfPUnutd12bUqt5Fv7NoBkM7kL0tk+700KboFjNSRMWeOtCm3kr
         /1m/SkrelfAeAUdH5cECA4eBGrHpFupIuthkmOA7BYHLZ/emGgML2drY9kTgfovaJJRX
         QmP8K9MfD06b5q05dA9rkzj2QnuFvcgWxWM4WhmXjEQT++y9JujaIWKFRwkgvYDp+ie9
         vwSN4P9ehU5+6RxE0LrpmybTfOjBkf+8hoGtKF+U/xgwX7h0EBclEXmX9eVz9sp5w/G4
         zpTg==
X-Gm-Message-State: APjAAAXa89Mdw8W4Wf1x4uf3dM9L1si2/N1G66RfokFDGGTJzY3kQQaA
        2v0K3e/onGzSKx1X0PDo9ezAjH2cN78=
X-Google-Smtp-Source: APXvYqyNCZasy8+5/wAWyo43AyHpw6W0kH2LFwYDId73oqEBiwTo+3ZbVNAHizBB3Qo9h2le4Xk+Jw==
X-Received: by 2002:a05:651c:3c4:: with SMTP id f4mr6918947ljp.5.1580511009474;
        Fri, 31 Jan 2020 14:50:09 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id f9sm5228296ljp.62.2020.01.31.14.50.08
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 14:50:08 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id t23so5984993lfk.6
        for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2020 14:50:08 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr6569338lfm.152.1580511008060;
 Fri, 31 Jan 2020 14:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20200131223407.GA105848@google.com>
In-Reply-To: <20200131223407.GA105848@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Jan 2020 14:49:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjxMB3UYR5iUHB6+NXT7awOF4DD5=QQrskJ8yocyO+Ebw@mail.gmail.com>
Message-ID: <CAHk-=wjxMB3UYR5iUHB6+NXT7awOF4DD5=QQrskJ8yocyO+Ebw@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v5.6
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 31, 2020 at 2:34 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git 01b810ed7187

You must have screwed up your git request-pull somehow.

Yes, yes, the above works, and a branch is just a named SHA1. You can
give the SHA1 directly.

But it's not what you meant to do, I'm sure. Especially since you
pointed to the SHA1 of the top commit, not the tag that you have that
points to it.

I can see what you _meant_ to ask me to pull with "git ls-remote". I
clearly should - and will - pull the 'pci-v5.6-changes' tag, which
points to that commit.

But can you check what in your workflow went wrong for the above to happen?

               Linus
