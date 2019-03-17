Return-Path: <SRS0=Lify=RU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28783C43381
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 21:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E978A2082F
	for <linux-pci@archiver.kernel.org>; Sun, 17 Mar 2019 21:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552857539;
	bh=iQWObzdMd+1G2mscRi6fwTjrskVAsPtEXZDVMOusDiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nW+0SSNHLUwKA/6WPFoVD7flAoUSMXA+TcUNr0EnZWB5zvOJitCf7tm4RvP57wc7y
	 sLrb3OJlXUR0SQvpjDFGbxsTt5fvipYRPscT6zUkuQs/pIjnXFGWhQafkz5ppk/R3c
	 ySCeGvXrG7/yu6HPUpSWgFXDFfX58xtpGlP8oHmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfCQVS4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 17 Mar 2019 17:18:56 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:36823 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfCQVSz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 17 Mar 2019 17:18:55 -0400
Received: by mail-lj1-f175.google.com with SMTP id v10so12242241lji.3
        for <linux-pci@vger.kernel.org>; Sun, 17 Mar 2019 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lShswvubGaKX5BMzNtg5olzzP5MwYelMRVbMqFijlp8=;
        b=BpcjAw8JGf8o735Yrl4XLXeA8pGNqD9kcJ18fPgtqfbcrDZvl9nd6s7Q9cuckI9mFb
         0ZDI6MZzODBJJt/Lk59D4eSWzWqKvMnHx3dpvMbj4kWglY/ygHW4p30oYQiEfAPv9Wtd
         vM+Ho2a768aQJFYfSYovamVx5cISB1/hn5mn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lShswvubGaKX5BMzNtg5olzzP5MwYelMRVbMqFijlp8=;
        b=HKdjqXOcneK7fVOpVjcwqJxXlmOXHGiOqYW8DUIDA5wyXUUMy67oQLwLhcAzbESOKf
         tqI89dX1H28f7Ge8Qqbsv3uqnfzvsR17WftYLeHHTih9dgYMemtAutr/zLtLIsjTO3H0
         rVygPiMybz9u2GfrK3tfZUD6vFUas0OSNtenQksG1PQpxqslmEAHDhYQaC7NVaoEgKcE
         V4Upf1BP8CU2D+qObTZOzVvJevSgT3/JRAxopIrXt/UpkJz9T8V7Z24TtAxHlYB2eG0D
         yZRZy3d/sVZFN1C1z/SJGE1GBuH2QogCe9qdlhOh0n9gbvqP1xUuqCWO6FlyNgh5clGs
         ezog==
X-Gm-Message-State: APjAAAV5EcdjRiFIoR2fBYTGna0Q2NeSVMs16EizT8HQzhdB5Fxyf0Cz
        74FM+Vb4hc1yzVntECAG7gDT5qehBo8=
X-Google-Smtp-Source: APXvYqz4ZvpSbJZ9KBTnISChQYIncOpamhIsIXjOZl74YSgcKkaWJa2NiHYDjPD7qKt+rrQRqfteKA==
X-Received: by 2002:a2e:9d99:: with SMTP id c25mr1312307ljj.159.1552857532898;
        Sun, 17 Mar 2019 14:18:52 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id j7sm1758564ljb.1.2019.03.17.14.18.51
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 14:18:51 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id x9so8209304ljc.7
        for <linux-pci@vger.kernel.org>; Sun, 17 Mar 2019 14:18:51 -0700 (PDT)
X-Received: by 2002:a2e:208a:: with SMTP id g10mr8605983lji.135.1552857531301;
 Sun, 17 Mar 2019 14:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190308173154.GC214730@google.com>
In-Reply-To: <20190308173154.GC214730@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Mar 2019 14:18:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
Message-ID: <CAHk-=wgM-5WfPW9LNHGfc1RxjVbDvHZqNfxyLVRSPP0R4jetDg@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v5.1
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 8, 2019 at 9:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
>   - Report PCIe links that become degraded at run-time (Alexandru Gagniuc)

Gaah. Only now as I'm about to do the rc1 release am I looking at new
runtime warnings, and noticing that this causes

  genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
  pcie_bw_notification: probe of 0000:00:1b.0:pcie010 failed with error -22

because you can't have a NULL handler for a level-triggered interrupt
(you need something to shut the interrupt off so that it doesn't keep
screaming!).

Happens on both my desktop and my laptop, regular intel CPU and
chipset, nothing odd in either case.

Everything else works, but the new BW notification obviously will
never work this way.

This is not holding up rc1, obviously, but I thought I'd mention it
since I noticed it as part of my "let's see that nothing regressed"
checks..

                    Linus
